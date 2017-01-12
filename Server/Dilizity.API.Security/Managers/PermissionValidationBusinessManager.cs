
using Dilizity.Business.Common;
using Dilizity.Business.Common.Services;
using Dilizity.Core.DAL;
using Dilizity.Core.Util;
using ilizity.Business.Common.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dilizity.API.Security.Managers
{
    class PermissionValidationBusinessManager : IAbstractBusiness
    {
        private const string CHECK_PERMISSION = "CheckPermission";

        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Operation childOperation = new Operation(parameterBusService);
                childOperation.PermissionClass = typeof(PermissionValidationBusinessManager).ToString();
                childOperation.saveToDB();

                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                {
                    string loginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);
                    if (parameterBusService.IsKeyPresent(GlobalConstants.PERMISSION))
                    {
                        string permission = (string)parameterBusService.Get(GlobalConstants.PERMISSION);

                        int isSuccess = (int)dataLayer.ExecuteScalarUsingKey(CHECK_PERMISSION, "LoginId", loginId, "Permission", permission);
                        if (isSuccess != 1)
                            throw new AccessViolationException("User:" + loginId + " do not have Permission");
                    }
                }
                childOperation.Status = GlobalConstants.SUCCESS;
                childOperation.saveToDB();
            }
        }

    }
}
