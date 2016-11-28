using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Dilizity.Core.DAL
{
    public class QueryDTO
    {
        public string ID = string.Empty;
        public string Sql = string.Empty;
        public string DataSource = string.Empty;
        public string Provider = string.Empty;
        public Dictionary<string, SqlParamDTO> ParamCollection = new Dictionary<string, SqlParamDTO>();

        public SqlParamDTO this[string Name]
        {
            get
            {
                return ParamCollection[Name];
            }
        }
    }
}
