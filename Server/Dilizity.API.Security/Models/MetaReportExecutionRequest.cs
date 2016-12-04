using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dilizity.API.Security.Models
{
    public class MetaReportExecutionRequest
    {
        public string PermissionId;
        public string LoginId;
        public int ReportId;
        public string JSONfieldCollection;

        public override string ToString()
        {
            return "PermissionId:" + PermissionId + "LoginId:" + LoginId + "|ReportId:" + ReportId.ToString() + JSONfieldCollection;
        }
    }

}
