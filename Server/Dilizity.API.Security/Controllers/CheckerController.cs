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
    public class CheckerController : ApiController
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

        //            IAbstractBusiness businessManager = new CheckerScreenManager();
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

        [ActionName("Approve")]
        [HttpPost]
        public IHttpActionResult Approve(JObject jobject)
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

                    //IAbstractBusiness businessManager = new RoleAddUpdateBusinessManager();
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

        [ActionName("Reject")]
        [HttpPost]
        public IHttpActionResult Reject(JObject jobject)
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

                    IAbstractBusiness businessManager = new CheckerRejectBusinessManager();
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

        [ActionName("CorrectionRequired")]
        [HttpPost]
        public IHttpActionResult CorrectionRequired(JObject jobject)
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

                    IAbstractBusiness businessManager = new CheckerCorrectionBusinessManager();
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
