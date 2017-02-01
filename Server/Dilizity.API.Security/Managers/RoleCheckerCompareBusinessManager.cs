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
using ilizity.Business.Common.Model;
using Dilizity.Business.Common.Model;

namespace Dilizity.API.Security.Managers
{

    public class RoleCheckerCompareBusinessManager : IAbstractBusiness
    {
        private const string GET_ROLE_ASSIGNED_PERMISSIONS = "GetRoleAssignedPermissions";
        private const string GET_MAKER = "GetMaker";
        private const string GET_ROLE = "GetRole";

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
                dynamic tmpObject = new ExpandoObject();


                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                {
                    dynamic roleObject = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_ROLE, GlobalConstants.ROLE_ID_PARAM, roleId);

                    if (roleObject == null)
                        throw new ApplicationBusinessException(GlobalErrorCodes.InvalidRoleId);

                    tmpObject.Name = roleObject.RoleName;

                    List<dynamic> PermissionList = new List<dynamic>();
                    foreach (dynamic permission in dataLayer.ExecuteUsingKey(GET_ROLE_ASSIGNED_PERMISSIONS, GlobalConstants.ROLE_ID_PARAM, roleId))
                    {
                        dynamic permissionTree = new ExpandoObject();
                        permissionTree.Id = permission.PermissionId;
                        permissionTree.ParentId = permission.ParentPermissionId;
                        permissionTree.Permission = permission.PermissionName;
                        PermissionList.Add(permissionTree);
                    }

                    Generate(PermissionList);

                    foreach (dynamic permission in PermissionList)
                    {
                        var dict = (IDictionary<string, object>)permission;
                        dict.Remove("Id");
                        dict.Remove("ParentId");
                    }


                    tmpObject.AssignedPermissions = PermissionList;

                    outObject.Old = tmpObject;

                    JToken jsonFromMakerObject = ReadMakerObject(makerId);

                    var nodesToDelete = new List<JToken>();
                    var parsed = (JContainer)jsonFromMakerObject;

                    do
                    {
                        nodesToDelete.Clear();

                        ClearEmpty(parsed, nodesToDelete);

                        foreach (var token in nodesToDelete)
                        {
                            token.Remove();
                        }
                    } while (nodesToDelete.Count > 0);

                    outObject.New = JsonHelper.RemoveEmptyChildren(jsonFromMakerObject);
                }



                parameterBusService.Add(GlobalConstants.OUT_RESULT, outObject);
                parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = GlobalErrorCodes.Success;
            }
        }

        private static void ClearEmpty(JContainer container, List<JToken> nodesToDelete)
        {
            if (container == null) return;

            foreach (var child in container.Children())
            {
                var cont = child as JContainer;

                if (child.Type == JTokenType.Property ||
                    child.Type == JTokenType.Object ||
                    child.Type == JTokenType.Array)
                {
                    if (child.HasValues)
                    {
                        ClearEmpty(cont, nodesToDelete);
                    }
                    else
                    {
                        nodesToDelete.Add(child.Parent);
                    }
                }
            }
        }

        private void Generate(List<dynamic> tree)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Dictionary<dynamic, dynamic> dict = tree.ToDictionary(permission => permission.Id);

                foreach (dynamic permission in dict.Values)
                {
                    if (permission.ParentId != permission.Id)
                    {
                        if (permission.ParentId != 0)
                        {
                            dynamic parent = dict[permission.ParentId];
                            if (parent.children == null)
                            {
                                parent.children = new List<dynamic>();
                            }
                            parent.children.Add(permission);
                            tree.Remove(permission);
                        }
                    }
                }
            }
        }

        private JToken ReadMakerObject(int makerId)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                {
                    dynamic _t = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_MAKER, GlobalConstants.MAKER_ID_PARAM, makerId);

                    string jsonString = _t.Data;
                    jsonString = jsonString.Replace("label", "Permission");
                    JToken tObject = JToken.Parse(jsonString);

                    JsonHelper.RemoveFields(tObject, new string[] { "Id", "collapsed", "MakerId", "Status", "AvailablePermissions", "selected" });

                    return tObject;
                }
            }
        }

        //private void removeFields(JToken token, string[] fields)
        //{
        //    JContainer container = token as JContainer;
        //    if (container == null) return;

        //    List<JToken> removeList = new List<JToken>();
        //    foreach (JToken el in container.Children())
        //    {
        //        JProperty p = el as JProperty;
        //        if (p != null && fields.Contains(p.Name))
        //        {
        //            removeList.Add(el);
        //        }
        //        removeFields(el, fields);
        //    }

        //    foreach (JToken el in removeList)
        //    {
        //        el.Remove();
        //    }
        //}


    }
}