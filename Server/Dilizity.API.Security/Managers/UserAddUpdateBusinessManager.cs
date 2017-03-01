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
        private const string GET_PASSWORD_POLICY_BY_ID = "GetPasswordPolicyById";
        


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

                    childOperation.InputParams = data;
                    childOperation.saveToDB();

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
                    string mobileNumber = model["MobileNumber"].ToString();
                    dynamic passwordPolicy = null;

                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                    {
                        passwordPolicy = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_PASSWORD_POLICY_BY_ID, "Id", selectedPasswordPolicy);
                    }

                    string password = System.Web.Security.Membership.GeneratePassword(passwordPolicy.LengthRule, passwordPolicy.ComplexityRule);
                    string encryptedPassword = Utility.Encrypt(password, false);

                    if (Id > 0)
                        Success = UpdateUser(loginId, name, Id, userLoginId, email, mobileNumber, passwordPolicy.DefaultPasswordAttempts, selectedPasswordPolicy, accountLocked, selectedManager, selectedDepartment, picture, assignedRoles);
                    else
                        Success = InsertUser(loginId, name, Id, userLoginId, encryptedPassword, email, mobileNumber, passwordPolicy.FirstLoginChangePassword, passwordAttempts, selectedPasswordPolicy, accountLocked, selectedManager, selectedDepartment, picture, assignedRoles);


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

        private static int? InsertUser(string loginId, string name, int Id, string userLoginId, string password, string email, string mobileNumber, int changePasswordOnLogon, int passwordAttempts, int passwordPolicy, int accountLocked, int managerId, int departmentId, string picture, JArray assignedRoles)
        {
            int? Success;
            using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA, true, true))
            {
                dataLayer.DelayExecuteNonQueryUsingKey(INSERT_USER, "LoginId", loginId, "Name", name, "Picture", picture, "UserLoginId", userLoginId, "Password", password, "Email", email, "MobileNumber", mobileNumber, "PasswordPolicyId", passwordPolicy, "PasswordAttempts", passwordAttempts, "ChangePasswordOnLogon", changePasswordOnLogon, "AccountLocked", accountLocked, "ManagerId", managerId, "DepartmentId", departmentId);

                int[] roles = assignedRoles.Select(jv => (int)jv).ToArray();

                foreach (int roleId in roles)
                {
                    dataLayer.DelayExecuteNonQueryUsingKey(INSERT_USER_ROLE, "UserLoginId", userLoginId, "RoleId", roleId, "LoginId", loginId);
                }

                Success = dataLayer.DelayExecuteBulk();
                dataLayer.CommitTransaction();

                if (Success <= 0)
                    throw new ApplicationBusinessException(GlobalErrorCodes.SQLError);
            }

            return Success;
        }

        private static int? UpdateUser(string loginId, string name, int Id, string userLoginId, string email, string mobileNumber, int passwordAttempts, int passwordPolicy, int accountLocked, int managerId, int departmentId, string picture, JArray assignedRoles)
        {
            int? Success;
            using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA, true, true))
            {
                dataLayer.DelayExecuteNonQueryUsingKey(UPDATE_USER, "Id", Id, "LoginId", loginId, "Name", name, "Picture", picture, "Email", email, "MobileNumber", mobileNumber, "PasswordPolicyId", passwordPolicy, "PasswordAttempts", passwordAttempts, "AccountLocked", accountLocked, "ManagerId", managerId, "DepartmentId", departmentId);
                dataLayer.DelayExecuteNonQueryUsingKey(DELETE_USER_ROLE, "Id", Id);

                int[] roles = assignedRoles.Select(jv => (int)jv).ToArray();

                foreach (int roleId in roles)
                {
                    dataLayer.DelayExecuteNonQueryUsingKey(INSERT_USER_ROLE, "Id", Id, "RoleId", roleId, "LoginId", loginId);
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