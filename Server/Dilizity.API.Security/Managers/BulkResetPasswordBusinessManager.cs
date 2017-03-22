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

    public class BulkResetPasswordBusinessManager : IAbstractBusiness
    {
        private const string RESET_USER_PASSWORD = "ResetUserPassword";
        private const string GET_BULK_PASSWORD_POLICY_BY_USERID = "GetBulkPasswordPolicyByUserId";
        private const string INSERT_CHANGE_PASSWORD_HISTORY = "InsertChangePasswordHistory";


        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Operation childOperation = null;

                try
                {
                    int Success = -1;

                    childOperation = new Operation(parameterBusService);
                    childOperation.PermissionClass = this.GetType().ToString();
                    childOperation.saveToDB();

                    JObject model = (JObject)parameterBusService.Get("Model");
                    JArray tmpList = (JArray)model["Users"];
                    string loginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);


                    string[] UserIds = tmpList.ToObject<string[]>();

                    string csUserIds = string.Join(",", UserIds);

                    childOperation.InputParams = tmpList.ToString();
                    childOperation.saveToDB();

                    List<dynamic> dynamicObjectList = new List<dynamic>();

                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                    {

                        foreach (dynamic dynamicObject in dataLayer.ExecuteUsingKey(GET_BULK_PASSWORD_POLICY_BY_USERID, "UserIds", csUserIds))
                        {
                            dynamicObjectList.Add(dynamicObject);
                        }
                    }



                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA, true, true))
                    {
                        foreach (dynamic tmpObject in dynamicObjectList)
                        {
                            string password = System.Web.Security.Membership.GeneratePassword(tmpObject.LengthRule, tmpObject.ComplexityRule);
                            string encryptedPassword = Utility.Encrypt(password, false);
                            dataLayer.DelayExecuteNonQueryUsingKey(RESET_USER_PASSWORD, "UserId", tmpObject.UserId, "Password", encryptedPassword);
                            dataLayer.DelayExecuteNonQueryUsingKey(INSERT_CHANGE_PASSWORD_HISTORY, "UserId", tmpObject.UserId, "Password", encryptedPassword, GlobalConstants.LOGIN_PARAM, loginId);
                        }
                        dataLayer.DelayExecuteBulk();
                        dataLayer.CommitTransaction();

                       // if (Success <= 0)
                       //     throw new ApplicationBusinessException(GlobalErrorCodes.SQLError);
                    }


                    parameterBusService.Add(GlobalConstants.OUT_RESULT, Success);
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