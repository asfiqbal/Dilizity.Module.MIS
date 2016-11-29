using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dilizity.API.Security.Models
{
    public class ReportMetaDataRequest
    {
        public string PermissionId;
        public string LoginId;
        public string ReportId;

        public override string ToString()
        {
            return "PermissionId:" + PermissionId + "LoginId:" + LoginId + "|ReportId:" + ReportId;
        }
    }
}
