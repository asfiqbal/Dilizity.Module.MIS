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

    public class RoleAddUpdateBusinessManager : IAbstractBusiness
    {
        private const string INSERT_ROLE = "InsertRole";
        private const string INSERT_ROLE_PERMISSION = "InsertRolePermission";
        private const string UPDATE_ROLE = "UpdateRole";
        private const string DELETE_ROLE_PERMISSION = "DeleteRolePermission";


        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                Operation childOperation = null;

                try
                {
                    int? Success = -1;

                    childOperation = new Operation(parameterBusService);
                    childOperation.PermissionClass = this.GetType().ToString();
                    childOperation.saveToDB();

                    JObject model = (JObject)parameterBusService.Get("Model");
                    string data = model.ToString();
                    string loginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);
                    string permissionId = (string)parameterBusService.Get(GlobalConstants.PERMISSION);
                    string status = model["Status"].ToString();
                    string id = model["Id"].ToString();
                    string roleName = model["Name"].ToString();

                    childOperation.InputParams = data;
                    childOperation.saveToDB();

                    int roleId = -1;

                    int.TryParse(id, out roleId);

                    JArray AssignedPermissions = (JArray)model["AssignedPermissions"];

                    if (roleId > 0)
                        Success = UpdateRole(loginId, roleName, roleId, AssignedPermissions);
                    else
                        Success = InsertRole(loginId, roleName, AssignedPermissions);


                    parameterBusService[GlobalConstants.OUT_RESULT] = Success;
                    parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = GlobalErrorCodes.Success;

                    childOperation.ErrorCode = GlobalErrorCodes.Success;
                    childOperation.Status = GlobalConstants.SUCCESS;
                    childOperation.saveToDB();
                }
                catch (ApplicationBusinessException ex)
                {
                    Log.Error(this.GetType(), ex.Message, ex);
                    parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = ex.ErrorCode;
                    childOperation.ErrorCode = ex.ErrorCode;
                    childOperation.Status = GlobalConstants.FAILURE;
                    childOperation.saveToDB();
                    throw;
                }
                catch (Exception ex)
                {
                    Log.Error(this.GetType(), ex.Message, ex);
                    parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = GlobalConstants.FAILURE;
                    childOperation.ErrorCode = GlobalErrorCodes.SystemError;
                    childOperation.Status = GlobalConstants.FAILURE;
                    childOperation.saveToDB();
                    throw;
                }
            }
        }

        private static int? InsertRole(string loginId, string roleName, JArray AssignedPermissions)
        {
            int? Success;
            using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA, true, true))
            {
                dataLayer.DelayExecuteNonQueryUsingKey(INSERT_ROLE, "RoleName", roleName, "LoginId", loginId);

                foreach (JToken token in AssignedPermissions.FindTokens("Id"))
                {
                    Console.WriteLine(token.Path + ": " + token.ToString());
                    dataLayer.DelayExecuteNonQueryUsingKey(INSERT_ROLE_PERMISSION, "PermissionId", token.ToString(), "RoleName", roleName, "LoginId", loginId);
                }

                Success = dataLayer.DelayExecuteBulk();
                dataLayer.CommitTransaction();

                if (Success <= 0)
                    throw new ApplicationBusinessException(GlobalErrorCodes.SQLError);
            }

            return Success;
        }

        private static int? UpdateRole(string loginId, string roleName, int roleId, JArray AssignedPermissions)
        {
            int? Success;
            using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA, true, true))
            {
                dataLayer.DelayExecuteNonQueryUsingKey(UPDATE_ROLE, "RoleName", roleName, "LoginId", loginId, "RoleId", roleId);
                dataLayer.DelayExecuteNonQueryUsingKey(DELETE_ROLE_PERMISSION, "RoleId", roleId);

                foreach (JToken token in AssignedPermissions.FindTokens("Id"))
                {
                    Console.WriteLine(token.Path + ": " + token.ToString());
                    dataLayer.DelayExecuteNonQueryUsingKey(INSERT_ROLE_PERMISSION, "PermissionId", token.ToString(), "RoleName", roleName, "LoginId", loginId);
                }

                Success = dataLayer.DelayExecuteBulk();
                dataLayer.CommitTransaction();

                if (Success <= 0)
                    throw new ApplicationBusinessException(GlobalErrorCodes.SQLError);
            }

            return Success;
        }
    }
}