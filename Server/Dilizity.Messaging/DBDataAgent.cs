using Dilizity.Core.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;

namespace Dilizity.Messaging
{
    public class DBDataAgent : IMessagingDataAgent
    {
        private string schema = string.Empty;
        //private XmlDocument xDoc = null;

        public DBDataAgent()
        {
        }

        public List<string> GetData(string query)
        {
            List<string> outArray = new List<string>();
            using (DynamicDataLayer dataLayer = new DynamicDataLayer(schema))
            {
                foreach (dynamic result in dataLayer.ExecuteText(query))
                {
                    foreach (var property in (IDictionary<String, Object>)result)
                    {
                        Console.WriteLine(property.Key + ": " + property.Value);
                        outArray.Add(property.Value.ToString());
                    }
                }
            }
            return outArray;
        }

        public List<string> GetData(string dataSource, string query)
        {
            schema = dataSource;
            return GetData(query);
        }

        public bool Load(string dataSource)
        {
            schema = dataSource;
            return true;
        }

        public bool IsValidTag(string tag)
        {
            using (DynamicDataLayer dataLayer = new DynamicDataLayer(schema))
            {
                string validTag = (string)dataLayer.ExecuteScalarUsingKey("IsValidMessageTag", "Tag", tag);
                return validTag.Length > 0;
            }
        }

    }
}
