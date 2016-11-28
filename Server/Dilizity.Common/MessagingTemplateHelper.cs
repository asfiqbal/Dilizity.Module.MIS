using Dilizity.Core.Util;
using Dilizity.Messaging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Dilizity.Business.Common
{
    public class MessagingTemplateHelper
    {
        public string Resolve(string templateBody, string dataContext)
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {

                IMessagingDataAgent dataAgent = new DBDataAgent();
                IMetaDataReader reader = MetaDataAgent.Instance;
                string outMessage = string.Empty;
                if (dataAgent.Load(GlobalConstants.REPORT_SCHEMA))
                {
                    IMessagingAgent stringAgent = new TextMessagingAgent(reader);
                    outMessage = stringAgent.Resolve(templateBody, dataAgent, dataContext);
                }
                return outMessage;
            }
        }
    }
}

