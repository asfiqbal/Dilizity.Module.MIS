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
using Dilizity.Business.Common.Model;
using Dilizity.Business.Common.Managers;

namespace Dilizity.API.Security.Managers
{
    class ActionPasswordPolicyScreenManager : IAbstractBusiness
    {
        private const string GET_PASSWORD_POLICY_BY_ID = "GetPasswordPolicyById";
        private const string PASSWORD_POLICY_LENGTH_RULE = "PASSWORD_POLICY_LENGTH_RULE";
        private const string PASSWORD_POLICY_COMPLEXITY_RULE = "PASSWORD_POLICY_COMPLEXITY_RULE";
        private const string PASSWORD_POLICY_EXPIRY_RULE = "PASSWORD_POLICY_EXPIRY_RULE";
        private const string PASSWORD_POLICY_NUMBER_CANT_REUSE = "PASSWORD_POLICY_NUMBER_CANT_REUSE";
        private const string PASSWORD_POLICY_DEFAULT_PASSWORD_ATTEMPTS = "PASSWORD_POLICY_DEFAULT_PASSWORD_ATTEMPTS";

        private const string GET_MAKER = "GetMaker";


        /// <summary>
        /// </summary>
        /// <param name = "parameterBusService" ></ param >
        public void Do(BusService parameterBusService)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                string LoginId = (string)parameterBusService.Get(GlobalConstants.LOGIN_ID);
                string permissionId = (string)parameterBusService.Get(GlobalConstants.PERMISSION);

                JObject model = (JObject)parameterBusService.Get(GlobalConstants.MODEL);

                int Id = Utility.ConvertStringToInt(model["Id"].ToString());
                int makerId = Utility.ConvertStringToInt(model["MakerId"].ToString());

                dynamic outObject = null;

                if (makerId > 0)
                {
                    outObject = ReadMakerObject(makerId);
                }
                else
                {

                    using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                    {
                        outObject = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_PASSWORD_POLICY_BY_ID, "Id", Id);

                        if (outObject == null) { 
                            outObject = new ExpandoObject();
                            outObject.Id = 0;
                            outObject.Name = string.Empty;
                            outObject.LengthRule = Utility.ConvertStringToInt(SystemConfigurationManager.Instance.Get(PASSWORD_POLICY_LENGTH_RULE));
                            outObject.ExpiryRule = Utility.ConvertStringToInt(SystemConfigurationManager.Instance.Get(PASSWORD_POLICY_EXPIRY_RULE));
                            outObject.NumberCantReuse = Utility.ConvertStringToInt(SystemConfigurationManager.Instance.Get(PASSWORD_POLICY_NUMBER_CANT_REUSE));
                            outObject.ComplexityRule = Utility.ConvertStringToInt(SystemConfigurationManager.Instance.Get(PASSWORD_POLICY_COMPLEXITY_RULE));
                            outObject.FirstLoginChangePassword = 1;
                            outObject.DefaultPasswordAttempts = string.Empty;
                            outObject.AccountLockOnFailedAttempts = 1;
                            outObject.Is2FAEnabled = 0;
                            outObject.IsCaptchEnabled = 0;
                            outObject.SingleSignon = 0;
                        }

                        ScreenPermissionManager screenManager = new ScreenPermissionManager();
                        screenManager.Do(parameterBusService);

                        outObject.UserPermission = parameterBusService[GlobalConstants.OUT_RESULT];
                    }
                }
                parameterBusService[GlobalConstants.OUT_RESULT] = outObject;
                parameterBusService[GlobalConstants.OUT_FUNCTION_ERROR_CODE] = GlobalErrorCodes.Success;
            }
        }

        private dynamic ReadMakerObject(int makerId)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            { 
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(GlobalConstants.SECURITY_SCHEMA))
                {
                    dynamic _t = dataLayer.ExecuteAndGetSingleRowUsingKey(GET_MAKER, GlobalConstants.MAKER_ID_PARAM, makerId);
                    JObject tObject = JObject.Parse(_t.Data);
                    return tObject;
                }
            }
        }


    }
}
