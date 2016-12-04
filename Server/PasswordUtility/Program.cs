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
            //string passwordToDecrypt = "FujJSM6yJIEqYrdYRenZYQ==";
            string decryptPassword = Decrypt("vtNXgcRYo+6n+kBlsSslfg==");
            string encryptedString = Encrypt("Server=.;Database=ReportMIS;User Id=sa;Password=Avanza123;Connection Timeout=10;");
            Console.WriteLine(decryptPassword);
        }

        private static string Encrypt(string stringToEncrypt)
        {
            return Utility.Encrypt(stringToEncrypt, false);
        }
        private static string Decrypt(string stringToDecrypt)
        {
            return Utility.Decrypt(stringToDecrypt, false);
        }
    }
}
