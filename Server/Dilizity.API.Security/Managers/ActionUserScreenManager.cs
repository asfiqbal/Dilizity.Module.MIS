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
using Dilizity.Business.Common.Managers;

namespace Dilizity.API.Security.Managers
{
    class ActionUserScreenManager : IAbstractBusiness
    {
        private const string GET_PASSWORD_POLICIES = "GetPasswordPolicies";
        private const string GET_MANAGERS = "GetManagers";
        private const string GET_ALL_ROLES = "GetAllRoles";
        private const string GET_USER_ROLE_BY_ID = "GetUserRoleById";
        private const string GET_USER_BY_ID = "GetUserById";
        private const string GET_ALL_DEPARTMENTS = "GetAllDepartments";
        
        private const string GET_MAKER = "GetMaker";


        /// <summary>
        /// OutObject {
        ///     passwordPolicies:[
        ///         {id:1, name:'Dilizity'}
        ///     ],
        ///     managers:[
        ///        { department: 'PIT', value: 1, name: "Zia" },
        ///        { department: 'Support', value: 2, name: "Razi" },
        ///        { department: 'Operations', value: 3, name: "Danish" }
        ///      ]
        ///     roles:[
        ///        { value: 1, text: "Admin" },
        ///        { value: 2, text: "Secure" }
        ///     ]        
        ///     assignedRoles:[
        ///        { value: 1, text: "Admin" },
        ///        { value: 2, name: "Secure" }
        ///     ]        
        /// }
        /// </summary>
        /// <param name = "parameterBusService" ></ param >
        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                string LoginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);
                string permissionId = (string)parameterBusService.Get(GlobalConstants.PERMISSION);

                JObject model = (JObject)parameterBusService.Get(GlobalConstants.MODEL);

                int Id = Utility.ConvertStringToInt(model["Id"].ToString());
                int makerId = Utility.ConvertStringToInt(model["MakerId"].ToString());

                dynamic outObject = null;

                if (makerId > 0)
                {
                    outObject = ReadMakerObject(makerId);
                }
                else
                {
                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                    {
                        outObject = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_USER_BY_ID, GlobalConstants.ID, Id);

                        if (outObject == null) { 
                            outObject = new ExpandoObject();
                            outObject.Id = 0;
                            outObject.Name = string.Empty;
                            outObject.Picture = string.Empty;
                            outObject.LoginId = string.Empty;
                            outObject.PasswordPolicyId = 0;
                            outObject.PasswordAttempts = 0;
                            outObject.AccountLocked = 0;
                            outObject.Email = string.Empty;
                            outObject.MobileNumber = string.Empty;
                            outObject.ManagerId = 0;
                            outObject.DepartmentId = 0;
                        }

                        List<dynamic> passwordPolicies = new List<dynamic>();
                        foreach (dynamic permission in dataLayer.ExecuteUsingKey(GET_PASSWORD_POLICIES))
                        {
                            passwordPolicies.Add(permission);
                        }

                        outObject.PasswordPolicies = passwordPolicies;

                        List<dynamic> managerList = new List<dynamic>();
                        foreach (dynamic manager in dataLayer.ExecuteUsingKey(GET_MANAGERS, GlobalConstants.ID, Id))
                        {
                            managerList.Add(manager);
                        }
                        outObject.Managers = managerList;

                        List<dynamic> roles = new List<dynamic>();
                        foreach (dynamic role in dataLayer.ExecuteUsingKey(GET_ALL_ROLES))
                        {
                            roles.Add(role);
                        }
                        outObject.Roles = roles;

                        List<dynamic> departments = new List<dynamic>();
                        foreach (dynamic dept in dataLayer.ExecuteUsingKey(GET_ALL_DEPARTMENTS))
                        {
                            departments.Add(dept);
                        }
                        outObject.Departments = departments;

                        List<dynamic> assignedRoles = new List<dynamic>();
                        foreach (dynamic role in dataLayer.ExecuteUsingKey(GET_USER_ROLE_BY_ID, GlobalConstants.ID, Id))
                        {
                            assignedRoles.Add(role);
                        }

                        outObject.AssignedRoles = assignedRoles;

                        ScreenPermissionManager screenManager = new ScreenPermissionManager();
                        screenManager.Do(parameterBusService);

                        outObject.UserPermission = parameterBusService[GlobalConstants.OUT_RESULT];

                    }
                }
                parameterBusService[GlobalConstants.OUT_RESULT] = outObject;
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


    }
}
