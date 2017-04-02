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

    public class TwoFAVerificationBusinessManager : IAbstractBusiness
    {
        private const string UPDATE_USER_TOKEN = "UpdateUserToken";
        private const string GET_USER = "GetUser";


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

                    dynamic secUser = null;
                    JObject model = (JObject)parameterBusService.Get(GlobalConstants.MODEL);
                    string base64PassCode = model["Code"].ToString();
                    string decodePassCode = System.Text.ASCIIEncoding.ASCII.GetString(System.Convert.FromBase64String(base64PassCode));
                    string encryptedPassCode = Utility.Encrypt(decodePassCode, false);

                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                    {
                        secUser = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_USER, GlobalConstants.LOGIN_PARAM, loginId);
                        if (encryptedPassCode == secUser.TwoFAToken)
                        {
                            dataLayer.ExecuteNonQueryUsingKey(UPDATE_USER_TOKEN, "UserId", secUser.UserId, "PassCode", string.Empty);
                            success = GlobalConstants.SUCCESS;
                        }
                        else {
                            Log.Debug(typeof(AuthenticationBusinessManager), "Passcode Mismatched!");
                            success = GlobalConstants.FAILURE;
                            throw new ApplicationBusinessException(GlobalErrorCodes.IncorrectPassCode);
                        }
                    }

                    parameterBusService.Add(GlobalConstants.OUT_RESULT, GlobalErrorCodes.Success);
                    parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = GlobalErrorCodes.Success;

                    childOperation.ErrorCode = GlobalErrorCodes.Success;
                    childOperation.Status = success;
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
                    parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = GlobalErrorCodes.SystemError;
                    childOperation.ErrorCode = GlobalErrorCodes.SystemError;
                    childOperation.Status = GlobalConstants.FAILURE;
                    childOperation.saveToDB();
                    throw;
                }
            }
        }

    }
}