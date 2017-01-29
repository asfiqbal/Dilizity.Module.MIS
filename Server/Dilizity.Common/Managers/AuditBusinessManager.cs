using Dilizity.Business.Common.Services;
using Dilizity.Core.DAL;
using Dilizity.Core.Util;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dilizity.Business.Common.Managers
{
    public class AuditBusinessManager : IAbstractBusiness
    {
        private const string INSERT_AUDIT = "InsertAudit";
        private const string AUDIT_PERMISSION = ".Audit";
        private const string CHECK_PERMISSION = "CheckPermission";

        public void Do(BusService parameterBusService)
        {
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap())
                {
                    if (parameterBusService.IsKeyPresent(GlobalConstants.PERMISSION))
                    {
                        string permission = (string)parameterBusService.Get(GlobalConstants.PERMISSION);
                        string loginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);

                        using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                        {
                            int haveAuditPermission = (int)dataLayer.ExecuteScalarUsingKey(CHECK_PERMISSION, "LoginId", loginId, "Permission", permission);
                            if (haveAuditPermission == 1)
                            {
                                string success = (string)parameterBusService.Get(GlobalConstants.OUT_FUNCTION_ERROR_CODE);
                                object data = parameterBusService.Get(GlobalConstants.IN_PARAM);
                                AuditHelper.Register(parameterBusService, loginId, permission, success, data.ToString());

                                List<dynamic> audits = (List<dynamic>)parameterBusService.Get(GlobalConstants.AUDIT);
                                dataLayer.ExecuteBulkNonQueryUsingKey(INSERT_AUDIT, audits);
                            }
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                Log.Error(this.GetType(), ex.Message, ex);
            }
        }
    }
}
