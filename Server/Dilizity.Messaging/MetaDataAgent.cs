using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using System.Configuration;
using System.Xml;
using Dilizity.Core.DAL;
using Dilizity.Core.Util;

namespace Dilizity.Messaging
{
    public class MetaDataAgent : IMetaDataReader
    {
        private static volatile MetaDataAgent instance;
        private static Hashtable hashTable = new Hashtable();

        private MetaDataAgent() { }

        public static MetaDataAgent Instance
        {
            get
            {
                if (instance == null)
                {
                    lock (hashTable)
                    {
                        if (instance == null)
                            instance = new MetaDataAgent();
                        instance.Read();
                    }
                }

                return instance;
            }
        }

        public bool Read()
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                XmlDocument xmlDocument = new XmlDocument();
                string Source = ConfigurationManager.AppSettings["Schema"];//ConfigReader.Instance.Settings("Source");
                using (DynamicDataLayer dataLayer = new DynamicDataLayer(Source))
                {
                    foreach (dynamic templateCode in dataLayer.ExecuteUsingKey("GetTemplateCodes"))
                    {
                        TemplateCode code = new TemplateCode();
                        code.Name = templateCode.Name;
                        code.Description = templateCode.Description;
                        code.MultipleResult = templateCode.MultipleResult;
                        code.ContextAware = templateCode.ContextAware;
                        code.DataFunction = templateCode.DataFunction;

                        hashTable.Add(code.Name.ToUpper(), code);
                    }

                }
                return true;
            }
        }

        public TemplateCode getTag(string code)
        {
            TemplateCode tmpCode = (TemplateCode)hashTable[code.ToUpper()];
            return tmpCode;
        }


        public string getTagName(string code)
        {
            TemplateCode tmpCode = (TemplateCode)hashTable[code];
            return tmpCode.Name;
        }

        public string getTagDescription(string code)
        {
            TemplateCode tmpCode = (TemplateCode)hashTable[code];
            return tmpCode.Description;
        }

        public string getTagMultipleResult(string code)
        {
            TemplateCode tmpCode = (TemplateCode)hashTable[code];
            return tmpCode.MultipleResult;
        }

        public string getTagContextAware(string code)
        {
            TemplateCode tmpCode = (TemplateCode)hashTable[code];
            return tmpCode.ContextAware;
        }

        public string getTagDataFunction(string code)
        {
            TemplateCode tmpCode = (TemplateCode)hashTable[code];
            return tmpCode.DataFunction;
        }

        public bool isValidTag(string tag)
        {
            TemplateCode tmpCode = (TemplateCode)hashTable[tag];
            return (tmpCode != null);
        }

    }
}
