using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Text.RegularExpressions;
using System.IO;
using System.Diagnostics.Contracts;

namespace Dilizity.Messaging
{
    public class TextMessagingAgent : IMessagingAgent
    {
        string XML_ROOT_STAG = @"<root>";
        string XML_ROOT_ETAG = @"</root>";
        IMetaDataReader metaDataReader = null;
        public TextMessagingAgent(IMetaDataReader reader)
        {
            //if (reader == null)
            //    throw ArgumentNullException("MetaDataReader can't be null");
            //Contract.Requires<ArgumentNullException>(reader != null);
            metaDataReader = reader;
        }

        private string TagReplace(string sourceString, string tag, string replaceString)
        {
            string outString = string.Empty;
            //IMetaDataReader reader = MetaDataAgent.Instance;
            string isMultipleResult = metaDataReader.getTagMultipleResult(tag);
            if (isMultipleResult == "No")
            {
                outString = sourceString.Replace(tag, replaceString);
            }
            return outString;
        }

        //public string Resolve(string sourceMessaging, IMessagingDataAgent dataAgent, string contextData)
        //{
        //    string outMessage = string.Empty;
        //    if (dataAgent != null || sourceMessaging != null || sourceMessaging.Length != 0)
        //    {
        //        string xmlSourceMessage = XML_ROOT_STAG + sourceMessaging + XML_ROOT_ETAG;
        //        XmlDocument dom = new XmlDocument();
        //        dom.PreserveWhitespace = true;
        //        dom.LoadXml(xmlSourceMessage);
        //        outMessage = dom.ChildNodes[0].InnerXml;
        //        XmlNodeList nodeList = dom.SelectNodes(@"/root/*");
        //        IDataContext dataContext = new DataContext();

        //        foreach (XmlNode XNode in nodeList)
        //        {
        //            string codeName = XNode.OuterXml;
        //            //string tag = string.Format(@"<{0}/>",XNode.Name);
        //            ITagAgent tagAgent = new XmlTagAgent();
        //            if (contextData.Length != 0)
        //                dataContext.Push(contextData);
        //            if (XNode.InnerXml.Length != 0)
        //                dataContext.Push(XNode.InnerXml);
        //            string resolvedTagValue = tagAgent.Resolve(XNode.Name, dataContext, dataAgent);
        //            outMessage = outMessage.Replace(codeName, resolvedTagValue);

        //            Console.WriteLine("the current node is - {0}", XNode.Name);
        //        }

        //    }

        //    return outMessage;
        //}

        public string Resolve(string sourceMessaging, IMessagingDataAgent dataAgent, string contextData)
        {
            string outMessage = string.Empty;
            if (dataAgent != null || sourceMessaging != null || sourceMessaging.Length != 0)
            {
                string xmlSourceMessage = XML_ROOT_STAG + sourceMessaging + XML_ROOT_ETAG;
                XmlDocument dom = new XmlDocument();
                dom.PreserveWhitespace = true;
                dom.LoadXml(xmlSourceMessage);
                outMessage = dom.ChildNodes[0].InnerXml;
                //XmlNodeList nodeList = dom.SelectNodes(@"/root/*");
                //XmlNodeList nodeList = dom.SelectNodes(@"//*");
                XmlNode root = dom.SelectSingleNode("*");
                IDataContext dataContext = new DataContext();
                List<XmlNode> tmpList = new List<XmlNode>();

                GetAllRootTags(root, dataAgent, tmpList);

                foreach (XmlNode XNode in tmpList)
                {
                    string codeName = XNode.Name;
                    ITagAgent tagAgent = new DBTagAgent();
                    if (contextData.Length != 0)
                        dataContext.Push(contextData);
                    if (XNode.InnerXml.Length != 0)
                        dataContext.Push(XNode.InnerXml);
                    string resolvedTagValue = tagAgent.Resolve(XNode.Name, dataContext, dataAgent, metaDataReader);
                    //outMessage = outMessage.Replace(codeName, resolvedTagValue);
                    outMessage = Helper.Instance.ReplaceTag(codeName, outMessage, resolvedTagValue);

                    Console.WriteLine("the current node is - {0}", XNode.Name);
                }

            }

            return outMessage;
        }

        private void GetAllRootTags(XmlNode root, IMessagingDataAgent dataAgent, List<XmlNode> tmpList)
        {
            Console.WriteLine(root.Name);

            if (root is XmlElement)
            {

                if (metaDataReader.isValidTag(root.Name))
                {
                    Console.WriteLine(root.Name);
                    tmpList.Add(root);
                }
                else
                {
                    XmlNodeList children = root.ChildNodes;
                    foreach (XmlNode child in children)
                    {
                        GetAllRootTags(child, dataAgent, tmpList);
                    }
                }
            }
        }
    }
}
