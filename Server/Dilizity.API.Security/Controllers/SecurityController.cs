using Dilizity.Core.DAL;
using Dilizity.Core.Util;
using Dilizity.API.Security.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using Dilizity.API.Security.Managers;
using System.Text;
using Dilizity.Business.Common;
using Dilizity.Business.Common.Services;
using Dilizity.Business.Common.Managers;

namespace Security.Controllers
{
    //[EnableCors(origins: "*", headers: "*", methods: "*")]
    public class SecurityController : ApiController
    {
        private const string USER_CREDENTIAL = "USER_CREDENTIAL";
        private const string DILIZITY_LOGIN = "Dilizity.Login";
        private const string DILIZITY_CHANGEPASSWORD = "Dilizity.ChangePassword";
        private const string USER_ID = "USER_ID";
        private const string GET_ALL_USERS = "GetAllUsers";

        [ActionName("GetAll")]
        [HttpGet]
        public IHttpActionResult GetAll()
        {
            using (FnTraceWrap tracer = new FnTraceWrap(GlobalConstants.SECURITY_SCHEMA))
            {
                List<dynamic> outputDataList = new List<dynamic>();
                try
                {
                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                    {
                        foreach (dynamic record in dataLayer.ExecuteUsingKey(GET_ALL_USERS))
                        {
                            dynamic recordTmp = new ExpandoObject();
                            var recordMembers = (IDictionary<string, object>)recordTmp;
                            recordMembers.Add("UserId", record.UserId);
                            recordMembers.Add("LoginId", record.LoginId);
                            recordMembers.Add("IsSystem", record.IsSystem);
                            recordMembers.Add("UpdatedBy", record.UpdatedBy);
                            outputDataList.Add(recordTmp);
                        }
                    }   
                }
                catch(Exception e)
                {
                    Log.Debug(typeof(SecurityController), "{0}", e.Message);
                }
                return Ok(outputDataList);
            }
        }

        [ActionName("Authenticate")]
        [HttpPost]
        public IHttpActionResult Authenticate(UserCredential userCredentials)
        {
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap(userCredentials))
                {
                    BusService dataBasService = new BusService();

                    dataBasService.Add(GlobalConstants.IN_PARAM, userCredentials);
                    dataBasService.Add(GlobalConstants.LOGIN_ID, userCredentials.LoginId);
                    dataBasService.Add(GlobalConstants.PERMISSIONS, Utility.Param2List(userCredentials.PermissionId));

                    WorkFlowActionManager workFlowManager = new WorkFlowActionManager();
                    workFlowManager.Do(dataBasService);

                    //IAbstractBusiness businessManager = new PermissionValidationBusinessManager();
                    //businessManager.Do(dataBasService);
                    //businessManager = new AuthenticationBusinessManager();
                    //businessManager.Do(dataBasService);
                    //businessManager = new EmailBusinessManager();
                    //businessManager.Do(dataBasService);
                    //businessManager = new AuditBusinessManager();
                    //businessManager.Do(dataBasService);
                    string result = (string)dataBasService.Get(GlobalConstants.OUT_RESULT);
                    if (result == GlobalConstants.SUCCESS)
                    {
                        return Ok("Login Success!");
                    }
                    else if (result == "ChangePassword")
                    {
                        return Content(HttpStatusCode.PartialContent, "Force Change Password!");
                    }
                    else
                    {
                        return Content(HttpStatusCode.Unauthorized, "UnAuthorized Access!");
                    }

                }
            }
            catch (Exception e)
            {
                Log.Debug(typeof(SecurityController), e.Message);
                return Content(HttpStatusCode.InternalServerError, "AuthenticationException Occured! Check Server Logs");
            }
        }

        [ActionName("ChangePassword")]
        [HttpPost]
        public IHttpActionResult ChangePassword(ChangePasswordModel modelChangePassword)
        {
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap(modelChangePassword))
                {
                    BusService dataBasService = new BusService();
                    dataBasService.Add(GlobalConstants.IN_PARAM, modelChangePassword);
                    dataBasService.Add(GlobalConstants.LOGIN_ID, modelChangePassword.LoginId);
                    dataBasService.Add(GlobalConstants.PERMISSIONS, Utility.Param2List(modelChangePassword.PermissionId));

                    WorkFlowActionManager workFlowManager = new WorkFlowActionManager();
                    workFlowManager.Do(dataBasService);
                    //IAbstractBusiness businessManager = new PermissionValidationBusinessManager();
                    //businessManager.Do(dataBasService);
                    //businessManager = new ChangePasswordBusinessManager();
                    //businessManager.Do(dataBasService);
                    //businessManager = new EmailBusinessManager();
                    //businessManager.Do(dataBasService);
                    //businessManager = new AuditBusinessManager();
                    //businessManager.Do(dataBasService);

                    //IAbstractBusiness changePasswordManager = new ChangePasswordBusinessManager();
                    //changePasswordManager.Do(dataBasService);
                    string result = (string)dataBasService.Get(GlobalConstants.OUT_RESULT);
                    if (result == GlobalConstants.SUCCESS)
                    {
                        return Ok("Change Password Success!");
                    }
                    else
                    {
                        return Content(HttpStatusCode.BadRequest, "Change Password Failed!");
                    }

                }
            }
            catch (Exception e)
            {
                Log.Debug(typeof(SecurityController), "{0}", e.Message);
                return Content(HttpStatusCode.InternalServerError, "AuthenticationException Occured! Check Server Logs");
            }
        }

        [HttpGet]
        [ActionName("GetMenus")]
        public IHttpActionResult GetMenus(string Id)
        {
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap(Id))
                {
                    BusService dataBasService = new BusService();

                    dataBasService.Add(GlobalConstants.LOGIN_ID, Id);

                    IAbstractBusiness menuManager = new MenuBusinessManager();

                    menuManager.Do(dataBasService);
                    List<MenuTree> menuStructure = (List<MenuTree>)dataBasService.Get(GlobalConstants.OUT_RESULT);
                    return Ok(menuStructure);
                }
            }
            catch (Exception e)
            {
                Log.Debug(typeof(SecurityController), "{0}", e.Message);
                return Content(HttpStatusCode.InternalServerError, "AuthenticationException Occured! Check Server Logs");
            }
        }


    }
}
