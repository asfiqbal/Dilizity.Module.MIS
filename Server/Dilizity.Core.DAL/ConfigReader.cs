using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.Collections;
using System.Xml;
using Dilizity.Core;
using Dilizity.Core.Util;

namespace Dilizity.Core
{
    public class ConfigReader
    {
        private const string DLL_CONFIG = @"\Dilizity.Core.DAL.dll.config";

        private static volatile ConfigReader instance;
        private static XmlDocument document = new XmlDocument();

        private ConfigReader() { }

        public static ConfigReader Instance
        {
            get
            {
                if (instance == null)
                {
                    lock (document)
                    {
                        if (instance == null)
                            instance = new ConfigReader();
                        instance.Load();
                    }
                }

                return instance;
            }
        }

        public bool Load()
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                string path = Utility.AssemblyLoadDirectory;
                string metadataPath = path + DLL_CONFIG;
                document.Load(metadataPath);
                return true;
            }
        }

        public bool Load(string path)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                string metadataPath = path + DLL_CONFIG;
                try
                {
                    document.Load(metadataPath);
                }
                catch (Exception e)
                {
                    Load();
                }

                return true;
            }
        }

        public string Settings(string key)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                string xPath = string.Format(@"/configuration/appSettings/add[@key='{0}']", key);
                XmlNode queryNode = document.SelectSingleNode(xPath);
                return queryNode.Attributes["value"].Value;
            }
        }


    }
}
