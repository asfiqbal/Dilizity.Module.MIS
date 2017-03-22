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
using Dilizity.Business.Common.Model;
using Newtonsoft.Json.Linq;

namespace Dilizity.API.Security.Managers
{

    public class AuthenticationBusinessManager : IAbstractBusiness
    {
        private const string USER_CREDENTIAL = "USER_CREDENTIAL";
        private const string GET_USER = "GetUser";
        private const string GET_USER_PASSWORD_POLICY = "GetUserPasswordPolicy";
        private const string PASSOWRD_MATCHED = "Passowrd Matched";
        private const string UPDATE_USER_PASSWORD_ATTEMPT = "UpdateUserPasswordAttempt";
        private const int CHANGE_PASSWORD = 1;
        private const int TWO_FA = 2;

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

                    string permissionId = (string)parameterBusService.Get(GlobalConstants.PERMISSION);
                    string loginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);
                    JObject model = (JObject)parameterBusService.Get(GlobalConstants.MODEL);
                    string password = model["Password"].ToString();

                    //UserCredential userCredentials = (UserCredential)parameterBusService.Get(GlobalConstants.IN_PARAM);
                    dynamic secUser = null;
                    dynamic passwordPolicy = null;
                    int actionCode = -1;
                    string encodedToken = string.Empty;

                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                    {
                        passwordPolicy = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_USER_PASSWORD_POLICY, GlobalConstants.LOGIN_PARAM, loginId);

                        secUser = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_USER, GlobalConstants.LOGIN_PARAM, loginId);
                    }

                    CheckIsAccountLocked(passwordPolicy.AccountLockOnFailedAttempts, secUser.AccountLocked);

                    string dbPassword = secUser.Password;
                    string decodePassword = System.Text.ASCIIEncoding.ASCII.GetString(System.Convert.FromBase64String(password));
                    string encryptedPassword = Utility.Encrypt(decodePassword, false);
                    if (dbPassword == encryptedPassword)
                    {
                        success = GlobalConstants.SUCCESS;
                        Log.Info(typeof(AuthenticationBusinessManager), PASSOWRD_MATCHED);

                        if (passwordPolicy.Is2FAEnabled > 0)
                        {
                            Log.Info(typeof(AuthenticationBusinessManager), "Two Factor Authentication enabled");
                            actionCode = TWO_FA;
                        }
                        else
                        {
                            using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                            {
                                dataLayer.ExecuteNonQueryUsingKey(UPDATE_USER_PASSWORD_ATTEMPT, GlobalConstants.LOGIN_PARAM, loginId, "PasswordAttempt", passwordPolicy.DefaultPasswordAttempts, "AccountLocked", secUser.AccountLocked);
                            }

                            if (passwordPolicy.FirstLoginChangePassword > 0)
                            {
                                Log.Info(typeof(AuthenticationBusinessManager), "Checking Password Policy for First Time login");
                                if (secUser.ChangePasswordOnLogon > 0)
                                {
                                    Log.Info(typeof(AuthenticationBusinessManager), "User has logged in for the first time");
                                    actionCode = CHANGE_PASSWORD;
                                }
                            }

                            if (CheckPasswordExpiry(passwordPolicy.ExpiryRule, secUser.LastPasswordChangeDateTime))
                            {
                                Log.Info(typeof(AuthenticationBusinessManager), "User Password Expired");
                                actionCode = CHANGE_PASSWORD;
                            }
                        }

                        encodedToken = TokenManager.Generate(parameterBusService);
                    }
                    else
                    {
                        Log.Debug(typeof(AuthenticationBusinessManager), "Password Mismatched!");
                        success = GlobalConstants.FAILURE;
                        if (passwordPolicy.AccountLockOnFailedAttempts > 0)
                        {
                            int passwordAttempts = secUser.PasswordAttempts;
                            int accountLock = (passwordAttempts > 0) ? 0 : 1;
                            passwordAttempts--;

                            using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                            {
                                dataLayer.ExecuteNonQueryUsingKey(UPDATE_USER_PASSWORD_ATTEMPT, GlobalConstants.LOGIN_PARAM, loginId, "PasswordAttempt", passwordAttempts, "AccountLocked", accountLock);
                            }
                        }
                        throw new ApplicationBusinessException(GlobalErrorCodes.IncorrectPassword);
                    }
                        //AuditHelper.Register(parameterBusService, userCredentials.LoginId, userCredentials.PermissionId, success, userCredentials.ToString());
                    parameterBusService.Add(GlobalConstants.OUT_RESULT, encodedToken);
                    parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = GlobalErrorCodes.Success;
                    parameterBusService[GlobalConstants.ACTION_CODE] = actionCode;

                    childOperation.ErrorCode = GlobalErrorCodes.Success;
                    childOperation.Status = success;
                    childOperation.saveToDB();
                   // }
                }
                catch (ApplicationBusinessException ex)
                {
                    Log.Error(this.GetType(), ex.Message, ex);
                    parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = ex.ErrorCode;
                    childOperation.ErrorCode = ex.ErrorCode;
                    childOperation.Status = GlobalConstants.FAILURE;
                    childOperation.saveToDB();
                    throw;
                }
                catch (Exception ex)
                {
                    Log.Error(this.GetType(), ex.Message, ex);
                    parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = GlobalErrorCodes.SystemError;
                    childOperation.ErrorCode = GlobalErrorCodes.SystemError;
                    childOperation.Status = GlobalConstants.FAILURE;
                    childOperation.saveToDB();
                    throw;
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
                        throw new ApplicationBusinessException(GlobalErrorCodes.AccountIsLocked);
                    }
                }
            }
        }
    }
}