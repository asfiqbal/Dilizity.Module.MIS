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
            string passwordToEncrypt = "Server=.;Database=ReportMIS;User Id=sa;Password=Avanza123;Connection Timeout=10;";
            string encryptedString = Utility.Encrypt(passwordToEncrypt, true);
            Console.WriteLine(encryptedString);
        }
    }
}
