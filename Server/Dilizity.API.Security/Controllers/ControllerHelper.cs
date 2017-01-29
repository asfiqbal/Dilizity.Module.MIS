using Dilizity.Business.Common;
using Dilizity.Core.Util;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dilizity.API.Security.Controllers
{
    public static class ControllerHelper
    {
        public static object GetDecoratedResponseObject(string permissionName, int errorCode, int actionCode, object apiResponse)
        {
            using (FnTraceWrap tracer = new FnTraceWrap(permissionName, errorCode, actionCode))
            {
                dynamic outObject = new ExpandoObject();

                string message = ErrorMappingManager.Instance.Get(permissionName, errorCode);

                outObject.ErrorCode = errorCode;
                outObject.ActionCode = actionCode;
                outObject.ErrorMessage = message;
                outObject.Data = apiResponse;

                return outObject;
            }
        }
    }
}
