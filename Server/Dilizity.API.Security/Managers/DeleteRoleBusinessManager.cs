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

    public class DeleteRoleBusinessManager : IAbstractBusiness
    {
        private const string DELETE_ROLE = "DeleteRole";
        private const string GET_REPORT_META_FILTERS_INFO = "GetReportMetaFiltersInfo";

        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                int Success = -1;

                JArray tmpRoleList = (JArray)parameterBusService.Get("Roles");
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
                }

                parameterBusService.Add(GlobalConstants.OUT_RESULT, Success);
                parameterBusService.Add(GlobalConstants.OUT_FUNCTION_STATUS, GlobalConstants.SUCCESS);
            }
        }




    }
}