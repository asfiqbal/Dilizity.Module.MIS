
using Dilizity.Business.Common.Services;
using Dilizity.Core.Util;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Text;

namespace Dilizity.Business.Common
{
    public static class AuditHelper
    {
        public static void Register(BusService paramBasService, string loginId, string permission, string isSuccess, string data)
        {
            using (FnTraceWrap tracer = new FnTraceWrap(loginId, permission, isSuccess, data))
            {

                List<dynamic> auditList = null;
                dynamic tmpObject = new ExpandoObject();
                tmpObject.LoginId = loginId;
                tmpObject.PermissionName = permission;
                tmpObject.Data = data;
                tmpObject.IsSuccess = isSuccess;
                tmpObject.CreatedBy = loginId;
                if (!paramBasService.IsKeyPresent(GlobalConstants.AUDIT))
                {
                    auditList = new List<dynamic>();
                    auditList.Add(tmpObject);
                    paramBasService.Add(GlobalConstants.AUDIT, auditList);
                }
                else
                {
                    auditList = (List<dynamic>)paramBasService.Get(GlobalConstants.AUDIT);
                    auditList.Add(tmpObject);
                }
            }
        }
    }
}
