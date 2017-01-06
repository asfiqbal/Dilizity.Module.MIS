﻿using System;
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
    class ActionRoleScreenManager : IAbstractBusiness
    {
        private const string GET_ROLE_AVAILABLE_PERMISSIONS = "GetRoleAvailablePermissions";
        private const string GET_ROLE_ASSIGNED_PERMISSIONS = "GetRoleAssignedPermissions";

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
                int roleId = (int)parameterBusService.Get(GlobalConstants.ROLE_ID_PARAM);

                dynamic outObject = new ExpandoObject();
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                {
                    dynamic tObject = new ExpandoObject();
                    List<PermissionTree> permissionTreeList = new List<PermissionTree>();

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
                parameterBusService.Add(GlobalConstants.OUT_RESULT, outObject);
                parameterBusService.Add(GlobalConstants.OUT_FUNCTION_STATUS, GlobalConstants.SUCCESS);
            }
        }

        private void Generate(List<PermissionTree> tree)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Dictionary<int, PermissionTree> dict = tree.ToDictionary(menu => menu.Id);

                foreach (PermissionTree menu in dict.Values)
                {
                    if (menu.ParentId != menu.Id)
                    {
                        if (menu.ParentId != 0)
                        {
                            PermissionTree parent = dict[menu.ParentId];
                            if (parent.children == null)
                            {
                                parent.children = new List<PermissionTree>();
                            }
                            parent.children.Add(menu);
                            tree.Remove(menu);
                        }
                    }
                }
            }
        }

    }
}