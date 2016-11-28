using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace Dilizity.Core.Util
{
    public static class ParamEncoder
    {
        public static string Encode(DbType type, object value)
        {
            string outstring = string.Empty;
            switch (type)
            {
                case DbType.Int16:
                case DbType.Int32:
                case DbType.Int64:
                case DbType.Boolean:
                case DbType.Decimal:
                case DbType.Double:
                case DbType.Single:
                case DbType.UInt16:
                case DbType.UInt32:
                case DbType.UInt64:
                    outstring = value.ToString();
                    break;

                default:
                    outstring = "'" + value.ToString() + "'";
                    break;
 
            }
            return outstring;
        }
    }
}
