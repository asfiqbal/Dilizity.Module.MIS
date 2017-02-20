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
    class SearchUserScreenManager : IAbstractBusiness
    {
        private const string SCREEN_USER_PERMISSION = "ScreenUserPermission";
        private const string USER_SPECFIC_ROLES = "UserSpecficRoles";
        private const string GET_USER = "GetUser";

        /// <summary>
        /// OutObject {
        ///     UserPermission:[
        ///     {Add: 'Dilizity.Backoffice.Role.Add'},
        ///     {Edit: 'Dilizity.Backoffice.Role.Edit'}
        ///     ]
        ///     RoleList:[
        ///     {RoleId:1, RoleName:'Admin'}
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
                    dynamic tObject = new ExpandoObject();
                    var recordMembers = (IDictionary<string, object>)tObject;
                    
                    foreach (dynamic permission in dataLayer.ExecuteUsingKey(SCREEN_USER_PERMISSION, GlobalConstants.LOGIN_PARAM, LoginId, GlobalConstants.PERMISSION_PARAM, permissionId))
                    {
                        if (permission.FieldKey == "Maker")
                            ResolvePermission(permission.PermissionName, recordMembers);
                        else
                            recordMembers[permission.FieldKey] = permission.PermissionName;
                    }
                    outObject.UserPermission = tObject;
                    List<dynamic> RoleList = new List<dynamic>();
                    foreach (dynamic role in dataLayer.ExecuteUsingKey(USER_SPECFIC_ROLES, GlobalConstants.LOGIN_PARAM, LoginId))
                    {
                        RoleList.Add(role);
                    }
                    outObject.RoleList = RoleList;
                }
                parameterBusService.Add(GlobalConstants.OUT_RESULT, outObject);
                parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = GlobalErrorCodes.Success;
            }
        }

        private void ResolvePermission(string permissionName, IDictionary<string, object> recordMembers)
        {
            string[] tmp = permissionName.Split('.');
            string operation = tmp[tmp.Length - 2];
            recordMembers[operation] = permissionName;
        }
    }
}
