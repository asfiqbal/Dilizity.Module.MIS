using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Dilizity.Messaging
{
    class DBTagAgent : ITagAgent
    {
        private const string YES = "YES";
        public string Resolve(string tag, IDataContext dataContext, IMessagingDataAgent dataAgent, IMetaDataReader reader)
        {
//            IMetaDataReader reader = MetaDataAgent.Instance;
            TemplateCode tempCode = reader.getTag(tag);
            string outString = string.Empty;
            string innerXml = string.Empty;
            List<string> contextList = new List<string>();

            
            while (dataContext.Count > 0)
                contextList.Add(dataContext.Pop());

            if (tempCode != null)
            {
                string xPath = tempCode.DataFunction;
                if (contextList.Count > 0)
                {
                    xPath = Helper.Instance.FormatXPath(xPath, contextList[0]);
                }
                List<string> nodeData = dataAgent.GetData(xPath);

                if (nodeData.Count > 0 )
                {
                    if (nodeData.Count == 1)
                        outString = nodeData[0];
                    else
                    {
                        outString = ResolveRecursive(nodeData, 0, contextList[1], dataAgent, reader);
                    }
                }
            }

            return outString;
        }

        private string ResolveRecursive(List<string> nodeData, int index, string contextData, IMessagingDataAgent dataAgent, IMetaDataReader reader)
        {
            string outstring = string.Empty;
            if (index < nodeData.Count)
            {
                IMessagingAgent textMessagingAgent = new TextMessagingAgent(reader);
                outstring = textMessagingAgent.Resolve(contextData, dataAgent, nodeData[index]);
                outstring = outstring + ResolveRecursive(nodeData, index + 1, contextData, dataAgent, reader);
            }
            
            return outstring;
        }

    }
}
