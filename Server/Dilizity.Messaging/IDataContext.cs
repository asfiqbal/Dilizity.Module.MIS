using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Dilizity.Messaging
{
    public interface IDataContext
    {
        bool Push(string data);
        string Pop();
        int Count
        {  
            get; 
        }
    }
}
