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

namespace Dilizity.API.Security.Managers
{

    public class RoleSearchBusinessManager : IAbstractBusiness
    {
        private const string SEARCH_ROLE = "SearchRole";
        private const string GET_REPORT_META_FILTERS_INFO = "GetReportMetaFiltersInfo";

        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                IEnumerable<dynamic> outList = null;
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.REPORT_SCHEMA))
                {
                    
                    int roleId = Utility.ConvertStringToInt(parameterBusService.Get("RoleId").ToString());
                    string roleName = (string)parameterBusService.Get("RoleName");
                    int rolePermissionId = Utility.ConvertStringToInt(parameterBusService.Get("RolePermissionId").ToString());
                    int pageSize = Utility.ConvertStringToInt(parameterBusService.Get("PageSize").ToString());
                    int pageNumber = Utility.ConvertStringToInt(parameterBusService.Get("PageNumber").ToString());
                    JObject sortInfo = (JObject)parameterBusService.Get("Sort");
                    string sortOrder = sortInfo["fieldName"].ToString();
                    string sortDirection = sortInfo["order"].ToString();

                    outList = dataLayer.ExecuteUsingKey(SEARCH_ROLE, "RoleId", roleId, "RoleName", roleName, "RolePermissionId", rolePermissionId, "PageSize", pageSize, "PageNumber", pageNumber, "SortOrder", sortOrder, "SortDirection", sortDirection);
                    parameterBusService.Add(GlobalConstants.OUT_RESULT, outList.ToList<dynamic>());
                }
                parameterBusService.Add(GlobalConstants.OUT_FUNCTION_STATUS, GlobalConstants.SUCCESS);
            }
        }




    }
}