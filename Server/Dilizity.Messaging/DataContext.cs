using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Dilizity.Messaging
{
    public class DataContext : IDataContext
    {
        private Stack<string> _context = new Stack<string>();

        public bool Push(string dataObject)
        {
            _context.Push(dataObject);
            return true;
        }

        public string Pop()
        {
            return _context.Pop();
        }

        public int Count
        {
            get
            {
                return _context.Count;
            }
        }

    }
}
