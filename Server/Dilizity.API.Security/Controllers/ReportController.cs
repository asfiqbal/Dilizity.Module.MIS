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
    public class ReportController : ApiController
    {
        [ActionName("GetReportMetaData")]
        [HttpPost]
        public IHttpActionResult GetReportMetaData(ReportMetaDataRequest reportMetaDataObject)
        {
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap(reportMetaDataObject))
                {
                    BusService dataBasService = new BusService();

                    dataBasService.Add(GlobalConstants.IN_PARAM, reportMetaDataObject);
                    dataBasService.Add(GlobalConstants.LOGIN_ID, reportMetaDataObject.LoginId);
                    dataBasService.Add(GlobalConstants.PERMISSIONS, Utility.Param2List(reportMetaDataObject.PermissionId));

                    IAbstractBusiness menuManager = new ReportMetaDataBusinessManager();
                    menuManager.Do(dataBasService);

                    string result = (string)dataBasService.Get(GlobalConstants.OUT_FUNCTION_STATUS);
                    if (result == GlobalConstants.SUCCESS)
                    {
                        ReportMetaData reportMetaData = (ReportMetaData)dataBasService.Get(GlobalConstants.OUT_RESULT);
                        return Ok(reportMetaData);
                    }
                    else
                    {
                        return Content(HttpStatusCode.BadRequest, "Menu Execution Failed!");
                    }

                }
            }
            catch (Exception e)
            {
                Log.Debug(typeof(ReportController), "{0}", e.Message);
                return Content(HttpStatusCode.InternalServerError, "Menu Execution Failed!");
            }
        }

        public IHttpActionResult ExecuteReport(JObject metaReportExecutionRequestObject)
        {
            try
            {
                using (FnTraceWrap tracer = new FnTraceWrap(metaReportExecutionRequestObject))
                {
                    BusService dataBasService = new BusService();

                    dataBasService.Add(GlobalConstants.IN_PARAM, metaReportExecutionRequestObject);
                    dataBasService.Add(GlobalConstants.LOGIN_ID, metaReportExecutionRequestObject["LoginId"].ToString());
                    string permissionId = metaReportExecutionRequestObject["PermissionId"].ToString();
                    dataBasService.Add(GlobalConstants.PERMISSIONS, Utility.Param2List(permissionId));

                    WorkFlowActionManager workFlowManager = new WorkFlowActionManager();
                    workFlowManager.Do(dataBasService);


                    string result = (string)dataBasService.Get(GlobalConstants.OUT_FUNCTION_STATUS);
                    if (result == GlobalConstants.SUCCESS)
                    {
                        List<dynamic> outputDataList = (List<dynamic>)dataBasService.Get(GlobalConstants.OUT_RESULT);
                        return Ok(outputDataList);
                    }
                    else
                    {
                        return Content(HttpStatusCode.BadRequest, "Report Execution Failed!");
                    }
                }
            }
            catch (Exception e)
            {
                Log.Debug(typeof(ReportController), "{0}", e.Message);
                return Content(HttpStatusCode.InternalServerError, "Report Execution Failed!");
            }
        }

    }
}
