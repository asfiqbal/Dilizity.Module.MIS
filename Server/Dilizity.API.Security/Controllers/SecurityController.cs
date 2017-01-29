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
using Dilizity.API.Security.Controllers;
using Newtonsoft.Json.Linq;

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

        [ActionName("Authenticate")]
        [HttpPost]
        public IHttpActionResult Authenticate(JObject jobject)
        {
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap(jobject))
                {
                    BusService dataBasService = new BusService();

                    dataBasService.Add(GlobalConstants.IN_PARAM, jobject);
                    dataBasService.Add(GlobalConstants.LOGIN_ID, jobject[GlobalConstants.LOGIN_PARAM].ToString());
                    string permissionId = jobject[GlobalConstants.PERMISSION_PARAM].ToString();
                    JObject model = (JObject)jobject[GlobalConstants.MODEL];

                    dataBasService.Add(GlobalConstants.PERMISSION, permissionId);
                    dataBasService.Add(GlobalConstants.MODEL, model);

                    WorkFlowActionManager workFlowManager = new WorkFlowActionManager();
                    workFlowManager.Do(dataBasService);

                    dynamic apiResponse = dataBasService.Get(GlobalConstants.OUT_RESULT);
                    int errorCode = (int)dataBasService.Get(GlobalConstants.OUT_FUNCTION_ERROR_CODE);
                    int actionCode = Utility.ConvertObjectToInt(dataBasService[GlobalConstants.ACTION_CODE]);

                    dynamic outObject = ControllerHelper.GetDecoratedResponseObject(permissionId, errorCode, actionCode, apiResponse);

                    return Ok(outObject);
                }
            }
            catch (Exception e)
            {
                Log.Debug(typeof(SecurityController), e.Message);
                return Content(HttpStatusCode.InternalServerError, GlobalConstants.GLOBAL_SYSTEM_ERROR_MSG);
            }
        }

        [ActionName("ChangePassword")]
        [HttpPost]
        public IHttpActionResult ChangePassword(JObject jobject)
        {
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap(jobject))
                {
                    BusService dataBasService = new BusService();
                    dataBasService.Add(GlobalConstants.IN_PARAM, jobject);
                    dataBasService.Add(GlobalConstants.LOGIN_ID, jobject[GlobalConstants.LOGIN_PARAM].ToString());
                    string permissionId = jobject[GlobalConstants.PERMISSION_PARAM].ToString();
                    JObject model = (JObject)jobject[GlobalConstants.MODEL];

                    dataBasService.Add(GlobalConstants.PERMISSION, permissionId);
                    dataBasService.Add(GlobalConstants.MODEL, model);

                    WorkFlowActionManager workFlowManager = new WorkFlowActionManager();
                    workFlowManager.Do(dataBasService);

                    dynamic apiResponse = dataBasService.Get(GlobalConstants.OUT_RESULT);
                    int errorCode = (int)dataBasService.Get(GlobalConstants.OUT_FUNCTION_ERROR_CODE);
                    int actionCode = Utility.ConvertObjectToInt(dataBasService[GlobalConstants.ACTION_CODE]);

                    dynamic outObject = ControllerHelper.GetDecoratedResponseObject(permissionId, errorCode, actionCode, apiResponse);

                    return Ok(outObject);

                }
            }
            catch (Exception e)
            {
                Log.Debug(typeof(SecurityController), "{0}", e.Message);
                return Content(HttpStatusCode.InternalServerError, GlobalConstants.GLOBAL_SYSTEM_ERROR_MSG);
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
                return Content(HttpStatusCode.InternalServerError, GlobalConstants.GLOBAL_SYSTEM_ERROR_MSG);
            }

        }

        public IHttpActionResult GetSideMenus(string Id)
        {
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap(Id))
                {
                    BusService dataBasService = new BusService();

                    dataBasService.Add(GlobalConstants.LOGIN_ID, Id);

                    IAbstractBusiness menuManager = new SideMenuManager();

                    menuManager.Do(dataBasService);
                    List<SideMenuTree> menuStructure = (List<SideMenuTree>)dataBasService.Get(GlobalConstants.OUT_RESULT);
                    return Ok(menuStructure);
                }
            }
            catch (Exception e)
            {
                Log.Debug(typeof(SecurityController), "{0}", e.Message);
                return Content(HttpStatusCode.InternalServerError, GlobalConstants.GLOBAL_SYSTEM_ERROR_MSG);
            }

        }


    }
}
