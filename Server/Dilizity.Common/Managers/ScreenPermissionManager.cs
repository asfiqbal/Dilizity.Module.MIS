using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Dilizity.Core.Util;
using Dilizity.Core.DAL;
using Dilizity.Business.Common.Services;
using ilizity.Business.Common.Model;
using System.Dynamic;

namespace Dilizity.Business.Common.Managers
{
    public class ScreenPermissionManager : IAbstractBusiness
    {
        private const string GET_SCREEN_PERMISSION = "GetScreenPermission";

        /// <summary>
        /// OutObject {
        ///     UserPermission:[
        ///     {Add: 'Dilizity.Backoffice.Role.Add'},
        ///     {Edit: 'Dilizity.Backoffice.Role.Edit'}
        ///     ]
        /// }
        /// </summary>
        /// <param name="parameterBusService"></param>
        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                string LoginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);
                string permissionId = (string)parameterBusService.Get(GlobalConstants.PERMISSION);
                dynamic outObject = new ExpandoObject();
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                {
                    var recordMembers = (IDictionary<string, object>)outObject;

                    foreach (dynamic permission in dataLayer.ExecuteUsingKey(GET_SCREEN_PERMISSION, GlobalConstants.LOGIN_PARAM, LoginId, GlobalConstants.PERMISSION_PARAM, permissionId))
                    {
                        if (!recordMembers.ContainsKey(permission.FieldKey))
                            recordMembers[permission.FieldKey] = permission.PermissionName;
                    }
                }
                parameterBusService.Add(GlobalConstants.OUT_RESULT, outObject);
                parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = GlobalErrorCodes.Success;
            }
        }

    }
}
