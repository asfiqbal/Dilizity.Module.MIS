using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.Collections;
using System.Xml;

namespace Dilizity.Messaging
{
    public class ConfigReader
    {
        private const string DLL_CONFIG = ".config";

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
            string path = Assembly.GetExecutingAssembly().Location;
            string metadataPath = path + DLL_CONFIG;
            document.Load(metadataPath);
            return true;
        }

        public string Settings(string key)
        {
            string xPath = string.Format(@"/configuration/appSettings/add[@key='{0}']", key);
            XmlNode queryNode = document.SelectSingleNode(xPath);
            return queryNode.Attributes["value"].Value;
        }

      
    }
}
