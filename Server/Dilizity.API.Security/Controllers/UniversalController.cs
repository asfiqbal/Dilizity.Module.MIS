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
    public class UniversalController : ApiController
    {

        [ActionName("Do")]
        [HttpPost]
        public IHttpActionResult Do(JObject jobject)
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


                    JToken modelToken = jobject[GlobalConstants.MODEL];

                    if (modelToken != null && modelToken.Type != JTokenType.Null)
                    {
                        JObject model = (JObject)jobject[GlobalConstants.MODEL];

                        dataBasService.Add(GlobalConstants.MODEL, model);
                    }

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
                Log.Debug(typeof(RoleController), "{0}", e.Message);
                return Content(HttpStatusCode.InternalServerError, "Internal Server Error Occured! Check Server Logs");
            }
        }

    }
}
