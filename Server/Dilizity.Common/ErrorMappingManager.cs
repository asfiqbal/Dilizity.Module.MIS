using Dilizity.Core.DAL;
using Dilizity.Core.Util;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Mail;
using System.Text;

namespace Dilizity.Business.Common
{
    public class ErrorMappingManager
    {
        private static volatile ErrorMappingManager instance;
        private static ConcurrentDictionary<string, string> Configurations = new ConcurrentDictionary<string, string>();
        private const string GET_GLOBAL_ERROR_MAPPING = "GetGlobalErrorMapping";

        private ErrorMappingManager()  {}

        public static ErrorMappingManager Instance
        {
            get
            {
                if (instance == null)
                {
                    lock (Configurations)
                    {
                        if (instance == null)
                            instance = new ErrorMappingManager();
                        instance.Read();
                    }
                }

                return instance;
            }
        }

        private bool Read()
        {
            string schema = ConfigurationManager.AppSettings["Schema"];
            using (FnTraceWrap tracer = new FnTraceWrap(schema))
            {
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(schema))
                {
                    foreach (dynamic errorObject in dataLayer.ExecuteUsingKey(GET_GLOBAL_ERROR_MAPPING))
                    {
                        Configurations.TryAdd(errorObject.ErrorCode, errorObject.Message);
                    }
                }
                return true;
            }
        }

        public string Get(string key)
        {
            using (FnTraceWrap tracer = new FnTraceWrap(key))
            {
                string outValue = string.Empty;
                Configurations.TryGetValue(key, out outValue);
                return outValue;
            }
        }

        public string Get(string permissionId, int errorCode)
        {
            using (FnTraceWrap tracer = new FnTraceWrap(permissionId, errorCode))
            {
                string outValue = string.Empty;
                string key = permissionId + '|' + errorCode.ToString();
                if (!Configurations.TryGetValue(key, out outValue))
                {
                    key = string.Empty + '|' + errorCode.ToString();

                    if (!Configurations.TryGetValue(key, out outValue))
                        outValue = GlobalConstants.GLOBAL_SYSTEM_ERROR;
                }
                return outValue;
            }
        }


    }
}