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

    public class CheckerApproveBusinessManager : IAbstractBusiness
    {
        private const string UPDATE_MAKER_LIST = "UpdateMaker";
        private const string INSERT_MAKER_LIST = "InsertMaker";


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
                    string loginId= (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);
                    string permissionId = (string)parameterBusService.Get(GlobalConstants.PERMISSION);
                    string status = model["Status"].ToString();

                    int makerId = -1;
                    string smakerId = model[GlobalConstants.MAKER_ID_PARAM].ToString();

                    int.TryParse(smakerId, out makerId);


                    childOperation.InputParams = data;
                    childOperation.saveToDB();

                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                    {
                        Success = (int?)dataLayer.ExecuteScalarUsingKey(UPDATE_MAKER_LIST, "MakerId", makerId, "PermissionId", permissionId, "Data", data, "Status", status, "UpdatedBy", loginId);

                        if (Success <= 0)
                            throw new ApplicationBusinessException(GlobalErrorCodes.SQLError);
                    }

                    parameterBusService.Add(GlobalConstants.OUT_RESULT, Success);
                    parameterBusService.Add(GlobalConstants.OUT_FUNCTION_STATUS, GlobalConstants.SUCCESS);

                    childOperation.ErrorCode = GlobalErrorCodes.Success;
                    childOperation.Status = GlobalConstants.SUCCESS;
                    childOperation.saveToDB();
                }
                catch (ApplicationBusinessException ex)
                {
                    Log.Error(this.GetType(), ex.Message, ex);
                    parameterBusService.Add(GlobalConstants.OUT_FUNCTION_STATUS, GlobalConstants.FAILURE);
                    childOperation.ErrorCode = ex.ErrorCode;
                    childOperation.Status = GlobalConstants.FAILURE;
                    childOperation.saveToDB();
                    throw;
                }
                catch (Exception ex)
                {
                    Log.Error(this.GetType(), ex.Message, ex);
                    parameterBusService.Add(GlobalConstants.OUT_FUNCTION_STATUS, GlobalConstants.FAILURE);
                    childOperation.ErrorCode = GlobalErrorCodes.SystemError;
                    childOperation.Status = GlobalConstants.FAILURE;
                    childOperation.saveToDB();
                    throw;
                }
            }
        }




    }
}