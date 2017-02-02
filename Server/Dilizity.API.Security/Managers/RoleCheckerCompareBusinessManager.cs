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
                        permissionTree.children = new List<dynamic>();
                        PermissionList.Add(permissionTree);
                    }

                    Generate(PermissionList);

                    string json = Newtonsoft.Json.JsonConvert.SerializeObject(PermissionList,
                        Newtonsoft.Json.Formatting.None,
                            new JsonSerializerSettings
                            {
                                NullValueHandling = NullValueHandling.Ignore
                            });

                    tmpObject.AssignedPermissions = CleanseData(json);

                    outObject.Old = tmpObject;

                    string jsonString = ReadMakerObject(makerId);

                    outObject.New = CleanseData(jsonString);
                }


                parameterBusService.Add(GlobalConstants.OUT_RESULT, outObject);
                parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = GlobalErrorCodes.Success;
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

        private string ReadMakerObject(int makerId)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                {
                    dynamic _t = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_MAKER, GlobalConstants.MAKER_ID_PARAM, makerId);

                    return _t.Data;
                }
            }
        }

        private JToken CleanseData(string jsonString)
        {
            jsonString = jsonString.Replace("label", "Permission");
            JToken tObject = JToken.Parse(jsonString);

            JsonExtensions.RemoveFields(tObject, new string[] { "Id", "ParentId", "collapsed", "MakerId", "Status", "AvailablePermissions", "selected" });
            JsonExtensions.DeepRemove(tObject);

            return tObject;

        }

    }
}