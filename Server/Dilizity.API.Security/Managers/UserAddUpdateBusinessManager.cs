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

    public class UserAddUpdateBusinessManager : IAbstractBusiness
    {
        private const string INSERT_USER = "InsertUser";
        private const string INSERT_USER_ROLE = "InsertUserRole";
        private const string UPDATE_USER = "UpdateUser";
        private const string DELETE_USER_ROLE = "DeleteUserRole";
        private const string DELETE_USER = "DeleteUser";


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
                    int Id = Utility.ConvertObjectToInt(model["Id"]);
                    string name = model["Name"].ToString();
                    string userLoginId = model["LoginId"].ToString();
                    string email = model["Email"].ToString();
                    int passwordAttempts = Utility.ConvertObjectToInt(model["PasswordAttempts"]);
                    int selectedPasswordPolicy = Utility.ConvertObjectToInt(model["SelectedPasswordPolicy"]);
                    int accountLocked = Utility.ConvertObjectToInt(model["AccountLocked"]);
                    int selectedManager = Utility.ConvertObjectToInt(model["SelectedManager"]);
                    int selectedDepartment = Utility.ConvertObjectToInt(model["SelectedDepartment"]);
                    JArray assignedRoles = (JArray)model["AssignedRoles"];
                    string picture = model["Picture"].ToString();

                    childOperation.InputParams = data;
                    childOperation.saveToDB();


                    if (Id > 0)
                        Success = UpdateUser(loginId, name, Id, userLoginId, email, passwordAttempts, selectedPasswordPolicy, accountLocked, selectedManager, picture, assignedRoles);
                    else
                        Success = InsertUser(loginId, name, Id, userLoginId, email, passwordAttempts, selectedPasswordPolicy, accountLocked, selectedManager, picture, assignedRoles);


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

        private static int? InsertUser(string loginId, string name, int Id, string userLoginId, string email, int passwordAttempts, int selectedPasswordPolicy, int accountLocked, int selectedManager, string picture, JArray assignedRoles)
        {
            int? Success;
            using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA, true, true))
            {
                dataLayer.DelayExecuteNonQueryUsingKey(INSERT_USER, "UserName", name, "LoginId", loginId);

                foreach (JToken token in assignedRoles.FindTokens("Id"))
                {
                    Console.WriteLine(token.Path + ": " + token.ToString());
                    dataLayer.DelayExecuteNonQueryUsingKey(INSERT_USER_ROLE, "PermissionId", token.ToString(), "RoleName", roleName, "LoginId", loginId);
                }

                Success = dataLayer.DelayExecuteBulk();
                dataLayer.CommitTransaction();

                if (Success <= 0)
                    throw new ApplicationBusinessException(GlobalErrorCodes.SQLError);
            }

            return Success;
        }

        private static int? UpdateUser(string loginId, string name, int Id, string userLoginId, string email, int passwordAttempts, int selectedPasswordPolicy, int accountLocked, int selectedManager, string picture, JArray assignedRoles)
        {
            int? Success;
            using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA, true, true))
            {
                dataLayer.DelayExecuteNonQueryUsingKey(UPDATE_USER, "RoleName", name, "LoginId", loginId, "RoleId", Id);
                dataLayer.DelayExecuteNonQueryUsingKey(DELETE_USER_ROLE, "RoleId", Id);

                foreach (JToken token in assignedRoles.FindTokens("Id"))
                {
                    Console.WriteLine(token.Path + ": " + token.ToString());
                    dataLayer.DelayExecuteNonQueryUsingKey(INSERT_USER_ROLE, "PermissionId", token.ToString(), "RoleName", name, "LoginId", loginId);
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