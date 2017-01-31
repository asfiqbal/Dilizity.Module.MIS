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

    public class BulkDeleteRoleBusinessManager : IAbstractBusiness
    {
        private const string DELETE_ROLE = "DeleteRole";
        private const string GET_REPORT_META_FILTERS_INFO = "GetReportMetaFiltersInfo";

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
                    JArray tmpRoleList = (JArray)model["Roles"];

                    childOperation.InputParams = tmpRoleList.ToString();
                    childOperation.saveToDB();

                    List<dynamic> dynamicObject = new List<dynamic>();

                    foreach (int role in tmpRoleList)
                    {
                        dynamic tmpObject = new ExpandoObject();
                        tmpObject.RoleId = role;
                        dynamicObject.Add(tmpObject);
                    }

                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                    {
                        Success = dataLayer.ExecuteBulkNonQueryUsingKey(DELETE_ROLE, dynamicObject);
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