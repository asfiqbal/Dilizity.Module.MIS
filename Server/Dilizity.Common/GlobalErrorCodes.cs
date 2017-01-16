using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dilizity.Business.Common
{
    public static class GlobalErrorCodes
    {
        public const int Success =0;
        public const int SystemError = 1;
        public const int SQLError = 1000;

        public const int IncorrectPassword = 2;
        public const int AccountIsLocked = 3;
        public const int UserDoNothavePermission = 4;
        public const int PasswordCantReuse = 5;




    }
    
}
