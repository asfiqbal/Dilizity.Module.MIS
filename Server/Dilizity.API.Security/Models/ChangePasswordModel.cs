using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dilizity.Core.Util;

namespace Dilizity.API.Security.Models
{
    public class ChangePasswordModel
    {
        public string PermissionId;
        public string LoginId;
        public string OldPassword;
        public string NewPassword;

        public override string ToString()
        {
            return "PermissionId:" + PermissionId + "LoginId:" + LoginId + "|OldPassword:" + Utility.GetSecureString(OldPassword) + "|NewPassword:" + Utility.GetSecureString(NewPassword);
        }
    }
}
