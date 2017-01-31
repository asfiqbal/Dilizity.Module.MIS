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
using Dilizity.Business.Common.Model;

namespace Dilizity.API.Security.Managers
{
    class ActionRoleScreenManager : IAbstractBusiness
    {
        private const string GET_ROLE_AVAILABLE_PERMISSIONS = "GetRoleAvailablePermissions";
        private const string GET_ROLE_ASSIGNED_PERMISSIONS = "GetRoleAssignedPermissions";
        private const string GET_MAKER = "GetMaker";
        private const string GET_ROLE = "GetRole";
        

        /// <summary>
        /// OutObject {
        ///     AvailablePermissionList:[
        ///     {PermissionId:1, PermissionName:'Dilizity'}
        ///     ],
        ///     AssignedPermissionList:[
        ///     {PermissionId:1, PermissionName:'Dilizity'}
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

                JObject model = (JObject)parameterBusService.Get(GlobalConstants.MODEL);

                int roleId = Utility.ConvertStringToInt(model["RoleId"].ToString());
                int makerId = Utility.ConvertStringToInt(model["MakerId"].ToString());

                dynamic outObject = new ExpandoObject();

                if (makerId > 0)
                {
                    outObject = ReadMakerObject(makerId);
                }
                else
                {
                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                    {
                        List<PermissionTree> permissionTreeList = new List<PermissionTree>();

                        dynamic roleObject = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_ROLE, GlobalConstants.ROLE_ID_PARAM, roleId);

                        if (roleObject == null)
                            throw new ApplicationBusinessException(GlobalErrorCodes.InvalidRoleId);

                        outObject.Id = roleObject.RoleId;
                        outObject.Name = roleObject.RoleName;

                        foreach (dynamic permission in dataLayer.ExecuteUsingKey(GET_ROLE_AVAILABLE_PERMISSIONS, GlobalConstants.ROLE_ID_PARAM, roleId))
                        {
                            PermissionTree permissionTree = new PermissionTree();
                            permissionTree.Id = permission.PermissionId;
                            permissionTree.ParentId = permission.ParentPermissionId;
                            permissionTree.label = permission.PermissionName;
                            permissionTreeList.Add(permissionTree);
                        }

                        Generate(permissionTreeList);
                        outObject.AvailablePermissions = permissionTreeList;
                        List<PermissionTree> PermissionList = new List<PermissionTree>();
                        foreach (dynamic permission in dataLayer.ExecuteUsingKey(GET_ROLE_ASSIGNED_PERMISSIONS, GlobalConstants.ROLE_ID_PARAM, roleId))
                        {
                            PermissionTree permissionTree = new PermissionTree();
                            permissionTree.Id = permission.PermissionId;
                            permissionTree.ParentId = permission.ParentPermissionId;
                            permissionTree.label = permission.PermissionName;
                            PermissionList.Add(permissionTree);
                        }

                        Generate(PermissionList);

                        outObject.AssignedPermissions = PermissionList;
                    }
                }
                parameterBusService.Add(GlobalConstants.OUT_RESULT, outObject);
                parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = GlobalErrorCodes.Success;
            }
        }

        private dynamic ReadMakerObject(int makerId)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            { 
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                {
                    dynamic _t = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_MAKER, GlobalConstants.MAKER_ID_PARAM, makerId);
                    JObject tObject = JObject.Parse(_t.Data);
                    return tObject;
                }
            }
        }

        private void Generate(List<PermissionTree> tree)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Dictionary<int, PermissionTree> dict = tree.ToDictionary(permission => permission.Id);

                foreach (PermissionTree permission in dict.Values)
                {
                    if (permission.ParentId != permission.Id)
                    {
                        if (permission.ParentId != 0)
                        {
                            PermissionTree parent = dict[permission.ParentId];
                            if (parent.children == null)
                            {
                                parent.children = new List<PermissionTree>();
                            }
                            parent.children.Add(permission);
                            parent.collapsed = true;
                            tree.Remove(permission);
                        }
                    }
                }
            }
        }

    }
}
