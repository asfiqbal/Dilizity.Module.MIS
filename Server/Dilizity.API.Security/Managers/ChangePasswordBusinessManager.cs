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
using ilizity.Business.Common.Model;

namespace Dilizity.API.Security.Managers
{
    public class ChangePasswordBusinessManager : IAbstractBusiness
    {
        private const string GET_USER_PASSWORD_POLICY = "GetUserPasswordPolicy";
        private const string LOGIN_PARAM = "LoginId";
        private const string PASSWORD_PARAM = "Password";
        private const string GET_USER = "GetUser";
        private const string CHECK_LAST_N_PASSWORDS = "CheckLastNPasswords";
        private const string CHANGE_USER_PASSWORD = "ChangeUserPassword";
        private const string INSERT_CHANGE_PASSWORD_HISTORY = "InsertChangePasswordHistory";
        private const string UPDATE_USER_PASSWORD_ATTEMPT = "UpdateUserPasswordAttempt";
        private const string PASSWORD_ATTEMPT = "PasswordAttempt";
        private const string ACCOUNT_LOCKED = "AccountLocked";
        private const string NUMBER_CANT_REUSE = "NumberCantReuse";

        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Operation childOperation = null;

                try
                {
                    childOperation = new Operation(parameterBusService);
                    childOperation.PermissionClass = this.GetType().ToString();
                    childOperation.saveToDB();

                    string success = GlobalConstants.FAILURE;
                    dynamic passwordPolicy = null;
                    dynamic secUser = null;
                    int? CheckLastNPasswords = -1;
                    ChangePasswordModel changePasswordObject = (ChangePasswordModel)parameterBusService.Get(GlobalConstants.IN_PARAM);

                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                    {
                        passwordPolicy = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_USER_PASSWORD_POLICY, LOGIN_PARAM, changePasswordObject.LoginId);
                        secUser = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_USER, LOGIN_PARAM, changePasswordObject.LoginId);
                        if (passwordPolicy.NumberCantReuse > 0)
                        {
                            CheckLastNPasswords = dataLayer.ExecuteScalarUsingKey(CHECK_LAST_N_PASSWORDS, NUMBER_CANT_REUSE, passwordPolicy.NumberCantReuse, LOGIN_PARAM, changePasswordObject.LoginId, PASSWORD_PARAM, Utility.GetSecureString(changePasswordObject.NewPassword));
                            CheckLastNPasswords = (CheckLastNPasswords == null) ? 0 : CheckLastNPasswords;
                        }
                    }

                    CheckIsAccountLocked(passwordPolicy.AccountLockOnFailedAttempts, secUser.AccountLocked);
                    string dbPassword = secUser.Password;
                    string encryptedPassword = Utility.Encrypt(changePasswordObject.OldPassword, false);
                    if (dbPassword == encryptedPassword)
                    {
                        Log.Debug(typeof(AuthenticationBusinessManager), MessageResource.Dilizity_ChangePassword_PasswordMatch);
                        if (passwordPolicy.NumberCantReuse > 0)
                        {
                            if (CheckLastNPasswords > 0)
                            {
                                throw new Exception(MessageResource.Dilizity_ChangePassword_Exception_Password_Cant_Reuse);
                            }
                        }
                        string newEncryptedPassword = Utility.Encrypt(changePasswordObject.NewPassword, false);
                        using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA, true, true))
                        {
                            dataLayer.DelayExecuteNonQueryUsingKey(CHANGE_USER_PASSWORD, LOGIN_PARAM, changePasswordObject.LoginId, PASSWORD_PARAM, newEncryptedPassword);
                            dataLayer.DelayExecuteNonQueryUsingKey(INSERT_CHANGE_PASSWORD_HISTORY, LOGIN_PARAM, changePasswordObject.LoginId, PASSWORD_PARAM, newEncryptedPassword);
                            dataLayer.DelayExecuteBulk();
                            dataLayer.CommitTransaction();
                        }
                        success = GlobalConstants.SUCCESS;
                    }
                    else
                    {
                        Log.Debug(typeof(ChangePasswordBusinessManager), MessageResource.Dilizity_ChangePassword_Login_Failed);
                        success = GlobalConstants.FAILURE;
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
                                dataLayer.ExecuteNonQueryUsingKey(UPDATE_USER_PASSWORD_ATTEMPT, LOGIN_PARAM, changePasswordObject.LoginId, PASSWORD_ATTEMPT, passwordAttempt, ACCOUNT_LOCKED, accountLocked);
                            }
                            throw new Exception(MessageResource.Dilizity_ChangePassword_Exception_Change_Password_failed);
                        }
                    }
                    //AuditHelper.Register(parameterBusService, changePasswordObject.LoginId, changePasswordObject.PermissionId, success, changePasswordObject.ToString());
                    parameterBusService.Add(GlobalConstants.OUT_RESULT, success);
                    parameterBusService.Add(GlobalConstants.OUT_FUNCTION_STATUS, success);
                    childOperation.Status = GlobalConstants.SUCCESS;
                    childOperation.saveToDB();
                }
                catch (Exception ex)
                {
                    Log.Error(this.GetType(), ex.Message, ex);
                    parameterBusService.Add(GlobalConstants.OUT_FUNCTION_STATUS, GlobalConstants.FAILURE);
                    childOperation.Status = GlobalConstants.FAILURE;
                    childOperation.saveToDB();
                    throw;
                }
            }
        }

        private void CheckIsAccountLocked(int accountLockOnFailedAttempts, int userAccountLocked)
        {
            if (accountLockOnFailedAttempts > 0)
            {
                if (userAccountLocked > 0)
                {
                    Log.Debug(typeof(ChangePasswordBusinessManager), MessageResource.Dilizity_ChangePassword_Account_Locked);
                    throw new AccessViolationException(MessageResource.Dilizity_ChangePassword_Account_Locked);
                }
            }
        }
    }
}