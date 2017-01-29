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

namespace Dilizity.API.Security.Managers
{

    public class CheckerSearchBusinessManager : IAbstractBusiness
    {
        private const string SEARCH_CHECKER = "SearchChecker";

        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Operation childOperation = null;

                try
                {
                    IEnumerable<dynamic> outList = null;

                    childOperation = new Operation(parameterBusService);
                    childOperation.PermissionClass = this.GetType().ToString();
                    childOperation.saveToDB();
                    JObject model = (JObject)parameterBusService.Get(GlobalConstants.MODEL);

                    int makerId = Utility.ConvertStringToInt(model["MakerId"].ToString());

                    int selectedPermissionId = Utility.ConvertStringToInt(model["SelectedPermissionId"].ToString());
                    int pageSize = Utility.ConvertStringToInt(model["PageSize"].ToString());
                    int pageNumber = Utility.ConvertStringToInt(model["PageNumber"].ToString());
                    JObject sortInfo = (JObject)model["Sort"];
                    string sortOrder = "Maker Id";
                    string sortDirection = "asc";
                    if (sortInfo.HasValues)
                    {
                        sortOrder = sortInfo["fieldName"].ToString();
                        sortDirection = sortInfo["order"].ToString();
                    }

                    string permissionId = (string)parameterBusService.Get(GlobalConstants.PERMISSION);
                    string loginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);

                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.REPORT_SCHEMA))
                    {
                        outList = dataLayer.ExecuteUsingKey(SEARCH_CHECKER, "MakerId", makerId, "LoginId", loginId, "SelectedPermissionId", selectedPermissionId, "PageSize", pageSize, "PageNumber", pageNumber, "SortOrder", sortOrder, "SortDirection", sortDirection);
                        parameterBusService.Add(GlobalConstants.OUT_RESULT, outList.ToList<dynamic>());
                    }

                    parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = GlobalErrorCodes.Success;

                    childOperation.ErrorCode = GlobalErrorCodes.Success;
                    childOperation.Status = GlobalConstants.SUCCESS;
                    childOperation.saveToDB();
                }
                catch (Exception ex)
                {
                    Log.Error(this.GetType(), ex.Message, ex);
                    parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE]= GlobalConstants.FAILURE;
                    childOperation.ErrorCode = GlobalErrorCodes.SystemError;
                    childOperation.Status = GlobalConstants.FAILURE;
                    childOperation.saveToDB();
                    throw;
                }
            }
        }




    }
}