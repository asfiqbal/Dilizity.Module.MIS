using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dilizity.Core.DAL
{
    public class ReportColumnDTO
    {
        public string columnName;
        public string displayName;
        public string columnPermissionName;
        public int maskingFilter;

        public ReportColumnDTO(string tColumnName, string tDisplayName, string tcolumnPermission, int tmaskingFilter)
        {
            columnName = tColumnName;
            displayName = tDisplayName;
            columnPermissionName = tcolumnPermission;
            maskingFilter = tmaskingFilter;
        }
    }
}
