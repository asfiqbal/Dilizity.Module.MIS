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
    public class MakerController : ApiController
    {
        //[ActionName("LoadSearchScreen")]
        //[HttpPost]
        //public IHttpActionResult LoadSearchScreen(JObject jobject)
        //{
        //    try
        //    {
        //        using (FnTraceWrap tracer = new FnTraceWrap(jobject))
        //        {
        //            BusService dataBasService = new BusService();

        //            dataBasService.Add(GlobalConstants.IN_PARAM, jobject);
        //            dataBasService.Add(GlobalConstants.LOGIN_ID, jobject[GlobalConstants.LOGIN_PARAM].ToString());
        //            string permissionId = jobject[GlobalConstants.PERMISSION_PARAM].ToString();
        //            dataBasService.Add(GlobalConstants.PERMISSION, permissionId);

        //            IAbstractBusiness businessManager = new RoleScreenManager();

        //            businessManager.Do(dataBasService);
        //            dynamic outObject = dataBasService.Get(GlobalConstants.OUT_RESULT);
        //            return Ok(outObject);
        //        }
        //    }
        //    catch (Exception e)
        //    {
        //        Log.Debug(typeof(RoleController), "{0}", e.Message);
        //        return Content(HttpStatusCode.InternalServerError, "AuthenticationException Occured! Check Server Logs");
        //    }
        //}

        //[ActionName("Search")]
        //[HttpPost]
        //public IHttpActionResult Search(JObject jobject)
        //{
        //    try
        //    {
        //        using (FnTraceWrap tracer = new FnTraceWrap(jobject))
        //        {
        //            BusService dataBasService = new BusService();

        //            dataBasService.Add(GlobalConstants.IN_PARAM, jobject);
        //            dataBasService.Add(GlobalConstants.LOGIN_ID, jobject[GlobalConstants.LOGIN_PARAM].ToString());
        //            string permissionId = jobject[GlobalConstants.PERMISSION_PARAM].ToString();
        //            dataBasService.Add(GlobalConstants.PERMISSION, permissionId);
        //            dataBasService.Add("MakerId", jobject["MakerId"].ToString());
        //            dataBasService.Add("SelectedPermissionId", jobject["SelectedPermissionId"].ToString());
        //            dataBasService.Add("Sort", jobject["Sort"]);
        //            dataBasService.Add("PageSize", jobject["PageSize"].ToString());
        //            dataBasService.Add("PageNumber", jobject["PageNumber"].ToString());

        //            WorkFlowActionManager workFlowManager = new WorkFlowActionManager();
        //            workFlowManager.Do(dataBasService);

        //            dynamic outObject = dataBasService.Get(GlobalConstants.OUT_RESULT);
        //            return Ok(outObject);
        //        }
        //    }
        //    catch (Exception e)
        //    {
        //        Log.Debug(typeof(RoleController), "{0}", e.Message);
        //        return Content(HttpStatusCode.InternalServerError, "AuthenticationException Occured! Check Server Logs");
        //    }
        //}

        [ActionName("Delete")]
        [HttpPost]
        public IHttpActionResult Delete(JObject jobject)
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
                    dataBasService.Add("Roles", jobject["Roles"]);

                    //IAbstractBusiness businessManager = new DeleteRoleBusinessManager();
                    //businessManager.Do(dataBasService);

                    WorkFlowActionManager workFlowManager = new WorkFlowActionManager();
                    workFlowManager.Do(dataBasService);


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

        [ActionName("SaveAsDraft")]
        [HttpPost]
        public IHttpActionResult SaveAsDraft(JObject jobject)
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
                    dataBasService.Add("Model", jobject["Model"]);

                    IAbstractBusiness businessManager = new MakerSaveAsDraftBusinessManager();
                    businessManager.Do(dataBasService);

                    //WorkFlowActionManager workFlowManager = new WorkFlowActionManager();
                    //workFlowManager.Do(dataBasService);


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

        [ActionName("CheckerApprovalReady")]
        [HttpPost]
        public IHttpActionResult CheckerApprovalReady(JObject jobject)
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
                    //string Status = jobject["Status"].ToString();
                    //dataBasService.Add("Status", Status);
                    JObject model = (JObject)jobject["Model"];
                    dataBasService.Add("Model", model);

                    IAbstractBusiness businessManager = new MakerApprovalReadyBusinessManager();
                    businessManager.Do(dataBasService);

                    //WorkFlowActionManager workFlowManager = new WorkFlowActionManager();
                    //workFlowManager.Do(dataBasService);


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
