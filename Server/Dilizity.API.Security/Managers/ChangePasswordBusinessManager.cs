using System;
using Dilizity.Core.DAL;
using Dilizity.Core.Util;
using Dilizity.API.Security.Models;
using System.Collections;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System.IO;
using Dilizity.Business.Common;
using Dilizity.Business.Common.Services;

namespace Dilizity.API.Security.Managers
{

    public class ChangePasswordBusinessManager : IAbstractBusiness
    {
        private const string USER_CREDENTIAL = "USER_CREDENTIAL";
        private const string DILIZITY_LOGIN = "Dilizity.ChangePassword";
        private const string GET_USER = "GetUser";

        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                string success = GlobalConstants.FAILURE;
                dynamic passwordPolicy = null;
                dynamic secUser = null;
                int? CheckLastNPasswords = -1;
                ChangePasswordModel changePasswordObject = (ChangePasswordModel)parameterBusService.Get(GlobalConstants.IN_PARAM);

                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                {
                    passwordPolicy = dataLayer.ExecuteAndGetSingleRowUsingKey("GetUserPasswordPolicy", "LoginId", changePasswordObject.LoginId);
                    secUser = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_USER, "LoginId", changePasswordObject.LoginId);
                    if (passwordPolicy.NumberCantReuse > 0)
                    {
                        CheckLastNPasswords = dataLayer.ExecuteScalarUsingKey("CheckLastNPasswords", "NumberCantReuse", passwordPolicy.NumberCantReuse, "LoginId", changePasswordObject.LoginId, "Password", Utility.GetSecureString(changePasswordObject.NewPassword));
                        CheckLastNPasswords = (CheckLastNPasswords == null) ? 0 : CheckLastNPasswords;
                    }
                }

                CheckIsAccountLocked(passwordPolicy.AccountLockOnFailedAttempts, secUser.AccountLocked);
                string dbPassword = secUser.Password;
                string encryptedPassword = Utility.Encrypt(changePasswordObject.OldPassword, false);
                if (dbPassword == encryptedPassword)
                {
                    Log.Debug(typeof(AuthenticationBusinessManager), "Password matched");
                    if (passwordPolicy.NumberCantReuse > 0)
                    {
                        if (CheckLastNPasswords > 0)
                        {
                            throw new Exception("Password can't reuse");
                        }
                    }
                    string newEncryptedPassword = Utility.Encrypt(changePasswordObject.NewPassword, false);
                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA, true, true))
                    {
                        dataLayer.DelayExecuteNonQueryUsingKey("ChangeUserPassword", "LoginId", changePasswordObject.LoginId, "Password", newEncryptedPassword);
                        dataLayer.DelayExecuteNonQueryUsingKey("InsertChangePasswordHistory", "LoginId", changePasswordObject.LoginId, "Password", newEncryptedPassword);
                        dataLayer.DelayExecuteBulk();
                        dataLayer.CommitTransaction();
                    }
                    success = GlobalConstants.SUCCESS;
                }
                else
                {
                    Log.Debug(typeof(ChangePasswordBusinessManager), "Login Failed");
                    success = "Failed";
                    if (passwordPolicy.AccountLockOnFailedAttempts > 0)
                    {
                        int accountLocked = -1, passwordAttempt = -1;
                        if (secUser.PasswordAttempts > 1)
                        {
                            //Decrease Password Retry Attempt
                            passwordAttempt = secUser.PasswordAttempts - 1;
                            accountLocked = 0;
                        }
                        else
                        {
                            //Retries Expired, Lock Account
                            passwordAttempt = 0;
                            accountLocked = 1;
                        }
                        using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                        {
                            dataLayer.ExecuteNonQueryUsingKey("UpdateUserPasswordAttempt", "LoginId", changePasswordObject.LoginId, "PasswordAttempt", passwordAttempt, "AccountLocked", accountLocked);
                        }
                        throw new Exception("Change Password Failed");
                    }
                }
                AuditHelper.Register(parameterBusService, changePasswordObject.LoginId, changePasswordObject.PermissionId, success, changePasswordObject.ToString());
                parameterBusService.Add("OUT_RESULT", success);
            }
        }

        private void CheckIsAccountLocked(int accountLockOnFailedAttempts, int userAccountLocked)
        {
            if (accountLockOnFailedAttempts > 0)
            {
                if (userAccountLocked > 0)
                {
                    Log.Debug(typeof(ChangePasswordBusinessManager), "Account is Locked!");
                    throw new AccessViolationException("Account is Locked!");
                }
            }
        }
    }
}