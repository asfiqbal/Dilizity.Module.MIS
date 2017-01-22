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
                    int makerId = Utility.ConvertStringToInt(parameterBusService.Get("MakerId").ToString());

                    int selectedPermissionId = Utility.ConvertStringToInt(parameterBusService.Get("SelectedPermissionId").ToString());
                    int pageSize = Utility.ConvertStringToInt(parameterBusService.Get("PageSize").ToString());
                    int pageNumber = Utility.ConvertStringToInt(parameterBusService.Get("PageNumber").ToString());
                    JObject sortInfo = (JObject)parameterBusService.Get("Sort");
                    string sortOrder = "Maker Id";
                    string sortDirection = "asc";
                    if (sortInfo.HasValues)
                    {
                        sortOrder = sortInfo["fieldName"].ToString();
                        sortDirection = sortInfo["order"].ToString();
                    }

                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.REPORT_SCHEMA))
                    {
                        outList = dataLayer.ExecuteUsingKey(SEARCH_CHECKER, "MakerId", makerId, "SelectedPermissionId", selectedPermissionId, "PageSize", pageSize, "PageNumber", pageNumber, "SortOrder", sortOrder, "SortDirection", sortDirection);
                        parameterBusService.Add(GlobalConstants.OUT_RESULT, outList.ToList<dynamic>());
                    }

                    parameterBusService.Add(GlobalConstants.OUT_FUNCTION_STATUS, GlobalConstants.SUCCESS);

                    childOperation.ErrorCode = GlobalErrorCodes.Success;
                    childOperation.Status = GlobalConstants.SUCCESS;
                    childOperation.saveToDB();
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