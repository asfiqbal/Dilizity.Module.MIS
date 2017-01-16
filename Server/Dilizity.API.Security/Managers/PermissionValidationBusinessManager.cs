
using Dilizity.Business.Common;
using Dilizity.Business.Common.Model;
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
            Operation childOperation = null;
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap())
                {
                    childOperation = new Operation(parameterBusService);
                    childOperation.PermissionClass = typeof(PermissionValidationBusinessManager).ToString();
                    childOperation.saveToDB();

                    string loginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);


                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                    {
                        if (parameterBusService.IsKeyPresent(GlobalConstants.PERMISSION))
                        {
                            string permission = (string)parameterBusService.Get(GlobalConstants.PERMISSION);

                            int? isSuccess = (int?)dataLayer.ExecuteScalarUsingKey(CHECK_PERMISSION, GlobalConstants.LOGIN_PARAM, loginId, "Permission", permission);
                            if (isSuccess != 1)
                                throw new ApplicationBusinessException(GlobalErrorCodes.UserDoNothavePermission);
                        }
                    }
                    childOperation.ErrorCode = GlobalErrorCodes.Success;
                    childOperation.Status = GlobalConstants.SUCCESS;
                    childOperation.saveToDB();
                }
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
