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
    public class SystemConfigurationManager
    {
        private static volatile SystemConfigurationManager instance;
        private static ConcurrentDictionary<string, string> Configurations = new ConcurrentDictionary<string, string>();
        private const string GET_SYSTEM_CONFIGURATION = "GetSystemConfiguration";

        private SystemConfigurationManager()  {}

        public static SystemConfigurationManager Instance
        {
            get
            {
                if (instance == null)
                {
                    lock (Configurations)
                    {
                        if (instance == null)
                            instance = new SystemConfigurationManager();
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
                    foreach (dynamic templateObject in dataLayer.ExecuteUsingKey(GET_SYSTEM_CONFIGURATION))
                    {
                        Configurations.TryAdd(templateObject.Name, templateObject.Value);
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


    }
}