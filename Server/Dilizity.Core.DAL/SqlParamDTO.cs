using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Dilizity.Core.DAL
{
    public class SqlParamDTO
    {
        public string Name;
        public System.Data.DbType DBType
        {
            get;
            set;
        }
        public int Size;

        
    }
}
