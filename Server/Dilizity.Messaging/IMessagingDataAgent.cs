using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;

namespace Dilizity.Messaging
{
    public interface IMessagingDataAgent
    {
        bool Load(string dataSource);
        List<string> GetData(string dataSource, string xPath);
        List<string> GetData(string query);
        bool IsValidTag(string tag);
    }
}
