using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Dilizity.Messaging
{
    public interface IMessagingAgent
    {
        string Resolve(string sourceMessaging, IMessagingDataAgent dataAgent, string dataContext);
    }
}
