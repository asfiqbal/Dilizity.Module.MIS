using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dilizity.Core.Util;

namespace PasswordUtility
{
    class Program
    {
        static void Main(string[] args)
        {
            string passwordToDecrypt = "FujJSM6yJIEqYrdYRenZYQ==";
            string decryptPassword = Utility.Decrypt(passwordToDecrypt, false);
            Console.WriteLine(decryptPassword);
        }
    }
}
