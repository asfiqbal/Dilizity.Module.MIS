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

    public class AuthenticationBusinessManager : IAbstractBusiness
    {
        private const string USER_CREDENTIAL = "USER_CREDENTIAL";
        private const string GET_USER = "GetUser";

        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                {
                    string success = GlobalConstants.FAILURE;
                    
                    UserCredential userCredentials = (UserCredential)parameterBusService.Get(GlobalConstants.IN_PARAM);
                    dynamic passwordPolicy = dataLayer.ExecuteAndGetSingleRowUsingKey("GetUserPasswordPolicy", "LoginId", userCredentials.LoginId);

                    dynamic secUser = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_USER, "LoginId", userCredentials.LoginId);

                    CheckIsAccountLocked(passwordPolicy.AccountLockOnFailedAttempts, secUser.AccountLocked);
   
                    string dbPassword = secUser.Password;
                    string encryptedPassword = Utility.Encrypt(userCredentials.Password, false);
                    if (dbPassword == encryptedPassword)
                    {
                        success = "Success";
                        Log.Info(typeof(AuthenticationBusinessManager), "Passowrd Matched");
                        dataLayer.ExecuteNonQueryUsingKey("UpdateUserPasswordAttempt", "LoginId", userCredentials.LoginId, "PasswordAttempt", passwordPolicy.DefaultPasswordAttempts, "AccountLocked", secUser.AccountLocked);

                        if (passwordPolicy.FirstLoginChangePassword > 0)
                        {
                            Log.Info(typeof(AuthenticationBusinessManager), "Checking Password Policy for First Time login");
                            if (secUser.ChangePasswordOnLogon > 0)
                            {
                                Log.Info(typeof(AuthenticationBusinessManager), "User has logged in for the first time");
                                success = "ChangePassword";
                            }
                        }

                        if (CheckPasswordExpiry(passwordPolicy.ExpiryRule, secUser.LastPasswordChangeDateTime))
                        {
                            Log.Info(typeof(AuthenticationBusinessManager), "User Password Expired");
                            success = "ChangePassword";
                        }
                    }
                    else
                    {
                        Log.Debug(typeof(AuthenticationBusinessManager), "Login Failed");
                        success = "Failed";
                        if (passwordPolicy.AccountLockOnFailedAttempts > 0)
                        {
                            if (secUser.PasswordAttempts > 1)
                            {
                                //Decrease Password Retry Attempt
                                dataLayer.ExecuteNonQueryUsingKey("UpdateUserPasswordAttempt", "LoginId", userCredentials.LoginId, "PasswordAttempt", secUser.PasswordAttempts-1, "AccountLocked", 0);

                            }
                            else
                            {
                                //Retries Expired, Lock Account
                                dataLayer.ExecuteNonQueryUsingKey("UpdateUserPasswordAttempt", "LoginId", userCredentials.LoginId, "PasswordAttempt", 0, "AccountLocked", 1);
                            }
                        }

                    }
                    AuditHelper.Register(parameterBusService, userCredentials.LoginId, userCredentials.PermissionId, success, userCredentials.ToString());
                    parameterBusService.Add("OUT_RESULT", success);
                }
            }
        }

        private bool CheckPasswordExpiry(int expiryRule, DateTime lastPasswordChangeDate)
        {
            using (FnTraceWrap tracer = new FnTraceWrap(expiryRule, lastPasswordChangeDate))
            {
                TimeSpan timeSpan = new TimeSpan(expiryRule, 0, 0, 0);
                DateTime expiredDate = lastPasswordChangeDate.Add(timeSpan);
                DateTime currentDateTime = DateTime.Now;

                return (expiredDate < currentDateTime);
            }
        }

        private void CheckIsAccountLocked(int accountLockOnFailedAttempts, int userAccountLocked)
        {
            using (FnTraceWrap tracer = new FnTraceWrap(accountLockOnFailedAttempts, userAccountLocked))
            {
                if (accountLockOnFailedAttempts > 0)
                {
                    if (userAccountLocked > 0)
                    {
                        Log.Debug(typeof(AuthenticationBusinessManager), "Account is Locked!");
                        throw new AccessViolationException("Account is Locked!");
                    }
                }
            }
        }
    }
}