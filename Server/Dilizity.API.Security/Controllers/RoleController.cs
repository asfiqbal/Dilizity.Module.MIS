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
using Newtonsoft.Json.Linq;

namespace Dilizity.API.Security.Controllers
{
    public class RoleController : ApiController
    {
        [ActionName("GetRoleScreenInfo")]
        [HttpPost]
        public IHttpActionResult GetRoleScreenInfo(JObject jobject)
        {
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap(jobject))
                {
                    BusService dataBasService = new BusService();

                    dataBasService.Add(GlobalConstants.IN_PARAM, jobject);
                    dataBasService.Add(GlobalConstants.LOGIN_ID, jobject[GlobalConstants.LOGIN_PARAM].ToString());
                    string permissionId = jobject[GlobalConstants.PERMISSION_PARAM].ToString();
                    dataBasService.Add(GlobalConstants.PERMISSION, permissionId);

                    IAbstractBusiness businessManager = new RoleScreenManager();

                    businessManager.Do(dataBasService);
                    dynamic outObject = dataBasService.Get(GlobalConstants.OUT_RESULT);
                    return Ok(outObject);
                }
            }
            catch (Exception e)
            {
                Log.Debug(typeof(RoleController), "{0}", e.Message);
                return Content(HttpStatusCode.InternalServerError, "AuthenticationException Occured! Check Server Logs");
            }
        }

        [ActionName("GetActionRoleScreenInfo")]
        [HttpPost]
        public IHttpActionResult GetActionRoleScreenInfo(JObject jobject)
        {
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap(jobject))
                {
                    BusService dataBasService = new BusService();

                    dataBasService.Add(GlobalConstants.IN_PARAM, jobject);
                    dataBasService.Add(GlobalConstants.LOGIN_ID, jobject[GlobalConstants.LOGIN_PARAM].ToString());
                    dataBasService.Add(GlobalConstants.ROLE_ID_PARAM, (int)jobject[GlobalConstants.ROLE_ID_PARAM]);

                    string permissionId = jobject[GlobalConstants.PERMISSION_PARAM].ToString();
                    dataBasService.Add(GlobalConstants.PERMISSION, permissionId);

                    IAbstractBusiness businessManager = new ActionRoleScreenManager();

                    businessManager.Do(dataBasService);
                    dynamic outObject = dataBasService.Get(GlobalConstants.OUT_RESULT);
                    return Ok(outObject);
                }
            }
            catch (Exception e)
            {
                Log.Debug(typeof(RoleController), "{0}", e.Message);
                return Content(HttpStatusCode.InternalServerError, "AuthenticationException Occured! Check Server Logs");
            }
        }


        [ActionName("SearchRole")]
        [HttpPost]
        public IHttpActionResult SearchRole(JObject jobject)
        {
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap(jobject))
                {
                    BusService dataBasService = new BusService();

                    dataBasService.Add(GlobalConstants.IN_PARAM, jobject);
                    dataBasService.Add(GlobalConstants.LOGIN_ID, jobject[GlobalConstants.LOGIN_PARAM].ToString());
                    string permissionId = jobject[GlobalConstants.PERMISSION_PARAM].ToString();
                    dataBasService.Add(GlobalConstants.PERMISSION, permissionId);
                    dataBasService.Add("RoleId", jobject["RoleId"].ToString());
                    dataBasService.Add("RoleName", jobject["RoleName"].ToString());
                    dataBasService.Add("RolePermissionId", jobject["RolePermissionId"].ToString());
                    dataBasService.Add("Sort", jobject["Sort"]);
                    dataBasService.Add("PageSize", jobject["PageSize"].ToString());
                    dataBasService.Add("PageNumber", jobject["PageNumber"].ToString());

                    IAbstractBusiness businessManager = new RoleSearchBusinessManager();

                    businessManager.Do(dataBasService);
                    dynamic outObject = dataBasService.Get(GlobalConstants.OUT_RESULT);
                    return Ok(outObject);
                }
            }
            catch (Exception e)
            {
                Log.Debug(typeof(RoleController), "{0}", e.Message);
                return Content(HttpStatusCode.InternalServerError, "AuthenticationException Occured! Check Server Logs");
            }
        }

    }
}
