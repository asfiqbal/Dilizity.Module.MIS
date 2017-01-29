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
        public const int UserDoNothavePermission = 2;
        public const int SQLError = 3;

        public const int IncorrectPassword = 101;
        public const int AccountIsLocked = 102;
        public const int PasswordCantReuse = 103;

        public const int ActivityAlreadyPending = 2001;
        
    }
    
}
