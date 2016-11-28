using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Dilizity.Messaging
{
    interface ITagAgent
    {
        string Resolve(string tag, IDataContext dataContext, IMessagingDataAgent dataAgent, IMetaDataReader reader);
    }
}
