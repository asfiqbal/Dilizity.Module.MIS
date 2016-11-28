using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;

namespace Dilizity.Messaging
{
    public class XMLDataAgent : IMessagingDataAgent
    {
        private XmlDocument xDoc = null;

        public XMLDataAgent()
        {
            xDoc = new XmlDocument();
        }

        public List<string> GetData(string xPath)
        {
            List<string> outArray = new List<string>();
            if (xDoc != null || xPath != null || xPath.Length != 0)
            {
                XmlNodeList nodeList = xDoc.SelectNodes(xPath);
                foreach (XmlNode node in nodeList)
                {
                    outArray.Add(node.Value);
                }
            }

            return outArray;
        }

        public List<string> GetData(string dataSource, string query)
        {
            xDoc.LoadXml(dataSource);
            return GetData(query);
        }

        public bool Load(string dataSource)
        {
            xDoc.LoadXml(dataSource);
            return true;
        }

        public bool IsValidTag(string tag)
        {
            return xDoc.GetElementsByTagName(tag).Count > 0;
        }

    }
}
