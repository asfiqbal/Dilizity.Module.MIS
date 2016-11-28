using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dilizity.Core.Util;

namespace Dilizity.API.Security.Models
{
    public class UserCredential
    {
        public string PermissionId;
        public string LoginId;
        public string Password;

        public override string ToString()
        {
            return "PermissionId:"+ PermissionId+"|LoginId:" + LoginId + "|Password:" + Utility.GetSecureString(Password);
        }
    }
}
