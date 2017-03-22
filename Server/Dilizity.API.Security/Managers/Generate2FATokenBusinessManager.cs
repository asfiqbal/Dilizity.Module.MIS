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

    public class Generate2FATokenBusinessManager : IAbstractBusiness
    {
        private const string INSERT_TOKEN_HISTORY = "InsertTokenHistory";
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
                    string passCode = Utility.GenerateRandomCode();
                    string encryptedPassCode = Utility.Encrypt(passCode, false);

                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA, true, true))
                    {
                        secUser = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_USER, GlobalConstants.LOGIN_PARAM, loginId);

                        dataLayer.DelayExecuteNonQueryUsingKey(UPDATE_USER_TOKEN, "UserId", secUser.UserId, "PassCode", encryptedPassCode);
                        dataLayer.DelayExecuteNonQueryUsingKey(INSERT_TOKEN_HISTORY, "UserId", secUser.UserId, "PassCode", encryptedPassCode, GlobalConstants.LOGIN_PARAM, loginId);
                        dataLayer.DelayExecuteBulk();
                        dataLayer.CommitTransaction();
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