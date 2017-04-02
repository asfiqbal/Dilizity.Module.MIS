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
using Newtonsoft.Json.Linq;
using ilizity.Business.Common.Model;
using Dilizity.Business.Common.Model;

namespace Dilizity.API.Security.Managers
{

    public class PasswordPolicyAddUpdateBusinessManager : IAbstractBusiness
    {
        private const string INSERT_PASSWORD_POLICY = "InsertPasswordPolicy";
        private const string UPDATE_PASSWORD_POLICY = "UpdatePasswordPolicy";

        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Operation childOperation = null;

                try
                {
                    int? Success = -1;

                    childOperation = new Operation(parameterBusService);
                    childOperation.PermissionClass = this.GetType().ToString();
                    childOperation.saveToDB();

                    JObject model = (JObject)parameterBusService.Get("Model");
                    string data = model.ToString();

                    childOperation.InputParams = data;
                    childOperation.saveToDB();

                    string loginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);
                    string permissionId = (string)parameterBusService.Get(GlobalConstants.PERMISSION);
                    int Id = Utility.ConvertObjectToInt(model["Id"]);
                    string name = model["Name"].ToString();
                    int lengthRule = Utility.ConvertObjectToInt(model["LengthRule"]);
                    int expiryRule = Utility.ConvertObjectToInt(model["ExpiryRule"]);
                    int complexityRule = Utility.ConvertObjectToInt(model["ComplexityRule"]);
                    int passwordCantReuse = Utility.ConvertObjectToInt(model["PasswordCantReuse"]);
                    int firstLoginChangePassword = Utility.ConvertObjectToInt(model["FirstLoginChangePassword"]);
                    int failedPasswordAttempts = Utility.ConvertObjectToInt(model["FailedPasswordAttempts"]);
                    int accountLockOnFailedAttempts = Utility.ConvertObjectToInt(model["AccountLockOnFailedAttempts"]);
                    int twoFA = Utility.ConvertObjectToInt(model["TwoFA"]);
                    int captchEnable = Utility.ConvertObjectToInt(model["CaptchEnable"]);
                    int SSO = Utility.ConvertObjectToInt(model["SSO"]);

                    if (Id > 0)
                        Success = UpdatePasswordPolicy(loginId, name, Id, lengthRule, expiryRule, passwordCantReuse, complexityRule, firstLoginChangePassword, failedPasswordAttempts, accountLockOnFailedAttempts, twoFA, captchEnable, SSO);
                    else
                        Success = InsertPasswordPolicy(loginId, name, lengthRule, expiryRule, passwordCantReuse, complexityRule, firstLoginChangePassword, failedPasswordAttempts, accountLockOnFailedAttempts, twoFA, captchEnable, SSO);

                    parameterBusService[GlobalConstants.OUT_RESULT] = Success;
                    parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = GlobalErrorCodes.Success;

                    childOperation.ErrorCode = GlobalErrorCodes.Success;
                    childOperation.Status = GlobalConstants.SUCCESS;
                    childOperation.saveToDB();
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
                    parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = GlobalConstants.FAILURE;
                    childOperation.ErrorCode = GlobalErrorCodes.SystemError;
                    childOperation.Status = GlobalConstants.FAILURE;
                    childOperation.saveToDB();
                    throw;
                }
            }
        }

        private static int? InsertPasswordPolicy(string loginId, string name, int lengthRule, int expiryRule, int numberCantReuse, int complexityRule, int firstLoginChangePassword, int defaultPasswordAttempts, int accountLockOnFailedAttempts, int is2FAEnabled, int isCaptchEnabled, int singleSignOn)
        {
            int? Success;
            using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
            {
                Success = dataLayer.ExecuteNonQueryUsingKey(INSERT_PASSWORD_POLICY, "LoginId", loginId, "Name", name, "LengthRule", lengthRule, "ExpiryRule", expiryRule, "NumberCantReuse", numberCantReuse, "ComplexityRule", complexityRule, "FirstLoginChangePassword", firstLoginChangePassword, "DefaultPasswordAttempts", defaultPasswordAttempts, "AccountLockOnFailedAttempts", accountLockOnFailedAttempts, "Is2FAEnabled", is2FAEnabled, "IsCaptchEnabled", isCaptchEnabled, "SingleSignOn", singleSignOn);

                if (Success <= 0)
                    throw new ApplicationBusinessException(GlobalErrorCodes.SQLError);
            }

            return Success;
        }

        private static int? UpdatePasswordPolicy(string loginId, string name, int Id, int lengthRule, int expiryRule, int numberCantReuse, int complexityRule, int firstLoginChangePassword, int defaultPasswordAttempts, int accountLockOnFailedAttempts, int is2FAEnabled, int isCaptchEnabled, int singleSignOn)
        {
            int? Success;
            using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA, true, true))
            {
                Success = dataLayer.ExecuteNonQueryUsingKey(UPDATE_PASSWORD_POLICY, "Id", Id, "LoginId", loginId, "Name", name, "LengthRule", lengthRule, "ExpiryRule", expiryRule, "NumberCantReuse", numberCantReuse, "ComplexityRule", complexityRule, "FirstLoginChangePassword", firstLoginChangePassword, "DefaultPasswordAttempts", defaultPasswordAttempts, "AccountLockOnFailedAttempts", accountLockOnFailedAttempts, "Is2FAEnabled", is2FAEnabled, "IsCaptchEnabled", isCaptchEnabled, "SingleSignOn", singleSignOn);

                if (Success <= 0)
                    throw new ApplicationBusinessException(GlobalErrorCodes.SQLError);
            }

            return Success;
        }
    }
}