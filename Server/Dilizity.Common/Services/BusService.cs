using Dilizity.Core.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dilizity.Business.Common.Services
{
    public class BusService
    {
        private Dictionary<string, object> BusObject = new Dictionary<string, object>();

        public void Add(string key, object tmpBusObject)
        {
            using (FnTraceWrap tracer = new FnTraceWrap(key))
            {
                if (key != null && key.Trim().Length > 0 && tmpBusObject != null)
                {
                    BusObject.Add(key, tmpBusObject);
                }
                else
                    throw new FormatException(string.Format("[{0}] Key is either Empty or Null", key));

            }
        }

        public object Get(string key)
        {
            using (FnTraceWrap tracer = new FnTraceWrap(key))
            {
                if (key != null && key.Trim().Length > 0)
                {
                    if (BusObject.ContainsKey(key))
                    {
                        return BusObject[key];
                    }
                    else
                        throw new KeyNotFoundException(string.Format("[{0}] Key not found in BusService", key));
                }
                else
                    throw new FormatException(string.Format("[{0}] Key is either Empty or Null", key));
            }
        }

        public bool IsKeyPresent(string key)
        {
            using (FnTraceWrap tracer = new FnTraceWrap(key))
            {
                if (key != null && key.Trim().Length > 0)
                {
                    return BusObject.ContainsKey(key);
                }
                else
                    throw new FormatException(string.Format("[{0}] Key is either Empty or Null", key));
            }
        }
    }
}
