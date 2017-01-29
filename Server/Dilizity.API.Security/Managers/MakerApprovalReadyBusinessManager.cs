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

    public class MakerApprovalReadyBusinessManager : IAbstractBusiness
    {
        private const string INSERT_MAKER_LIST = "InsertMaker";
        private const string UPDATE_MAKER_LIST = "UpdateMaker";
        private const string CHECK_PENDING_MAKER_ACTIVITY = "CheckPendingMakerActivity";

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
                    string checkerPermissionId = permissionId.Replace(".Maker", ".Checker");
                    checkerPermissionId = checkerPermissionId.Replace(".ApprovalReady", "");

                    string status = model["Status"].ToString();
                    string sId = model["Id"].ToString();

                    int makerId = -1;
                    int Id = -1;
                    string smakerId = model[GlobalConstants.MAKER_ID_PARAM].ToString();

                    int.TryParse(smakerId, out makerId);
                    int.TryParse(sId, out Id);


                    childOperation.InputParams = data;
                    childOperation.saveToDB();

                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                    {
                        if (Id > 0)
                        {
                            int? anyPendingActvtySameObject = (int?)dataLayer.ExecuteScalarUsingKey(CHECK_PENDING_MAKER_ACTIVITY, "ObjectId", Id, "PermissionId", permissionId);

                            if (anyPendingActvtySameObject > 0)
                                throw new ApplicationBusinessException(2001);
                        }
                        if (makerId > 0)
                        {
                            Success = (int?)dataLayer.ExecuteScalarUsingKey(UPDATE_MAKER_LIST, "MakerId", makerId, "PermissionId", checkerPermissionId, "Data", data, "Status", status, "UpdatedBy", loginId);
                        }
                        else
                        {
                            Success = (int?)dataLayer.ExecuteScalarUsingKey(INSERT_MAKER_LIST, "PermissionId", checkerPermissionId, "Data", data, "ObjectId", Id, "Status", status, "CreatedBy", loginId);
                        }

                        if (Success <= 0)
                            throw new ApplicationBusinessException(GlobalErrorCodes.SQLError);
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