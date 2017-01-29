using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;

namespace Dilizity.Core.Util
{
    public static class Utility
    {
        public static IDictionary<string, object> Param2Dictionary(params object[] parameters)
        {
            IDictionary<string, object> dictionary = new Dictionary<string, object>();
            if (parameters.Length > 1)
            {
                for (int i = 0; i < parameters.Length; i += 2)
                {
                    dictionary.Add((string)parameters[i], parameters[i + 1]);
                }
            }
            return dictionary;
        }

        public static List<string> Param2List(params object[] parameters)
        {
            List<string> list = new List<string>();

            if (parameters.Length > 0)
            {
                for (int i = 0; i < parameters.Length; i++)
                {
                    list.Add((string)parameters[i]);
                }
            }
            return list;
        }

        static public string AssemblyLoadDirectory
        {
            get
            {
                string codeBase = Assembly.GetCallingAssembly().CodeBase;
                UriBuilder uri = new UriBuilder(codeBase);
                string path = Uri.UnescapeDataString(uri.Path);
                return Path.GetDirectoryName(path);
            }
        }

        static public string GetSecureString(string password)
        {
            return new String('*', password.Length);
        }

        static public int ConvertStringToInt(string value)
        {
            int oReturn = 0;
            int.TryParse(value, out oReturn);
            return oReturn;
        }

        static public int ConvertObjectToInt(object value)
        {
            int oReturn = 0;
            oReturn = Convert.ToInt32(value);
            return oReturn;
        }

        public static string Encrypt(string toEncrypt, bool useHashing)
        {
            byte[] keyArray;
            byte[] toEncryptArray = UTF8Encoding.UTF8.GetBytes(toEncrypt);

            string key = System.Configuration.ConfigurationManager.AppSettings["SecurityKey"];
            // Get the key from config file

            //string key = (string)settingsReader.GetValue("SecurityKey", typeof(String));
            //System.Windows.Forms.MessageBox.Show(key);
            //If hashing use get hashcode regards to your key
            if (useHashing)
            {
                MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
                keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
                //Always release the resources and flush data
                // of the Cryptographic service provide. Best Practice

                hashmd5.Clear();
            }
            else
                keyArray = UTF8Encoding.UTF8.GetBytes(key);

            TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();
            //set the secret key for the tripleDES algorithm
            tdes.Key = keyArray;
            //mode of operation. there are other 4 modes.
            //We choose ECB(Electronic code Book)
            tdes.Mode = CipherMode.ECB;
            //padding mode(if any extra byte added)

            tdes.Padding = PaddingMode.PKCS7;

            ICryptoTransform cTransform = tdes.CreateEncryptor();
            //transform the specified region of bytes array to resultArray
            byte[] resultArray =
              cTransform.TransformFinalBlock(toEncryptArray, 0,
              toEncryptArray.Length);
            //Release resources held by TripleDes Encryptor
            tdes.Clear();
            //Return the encrypted data into unreadable string format
            return Convert.ToBase64String(resultArray, 0, resultArray.Length);
        }

        public static string Decrypt(string cipherString, bool useHashing)
        {
            byte[] keyArray;
            //get the byte code of the string

            byte[] toEncryptArray = Convert.FromBase64String(cipherString);

            System.Configuration.AppSettingsReader settingsReader =
                                                new AppSettingsReader();
            //Get your key from config file to open the lock!
            string key = System.Configuration.ConfigurationManager.AppSettings["SecurityKey"];

            if (useHashing)
            {
                //if hashing was used get the hash code with regards to your key
                MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
                keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
                //release any resource held by the MD5CryptoServiceProvider

                hashmd5.Clear();
            }
            else
            {
                //if hashing was not implemented get the byte code of the key
                keyArray = UTF8Encoding.UTF8.GetBytes(key);
            }

            TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();
            //set the secret key for the tripleDES algorithm
            tdes.Key = keyArray;
            //mode of operation. there are other 4 modes. 
            //We choose ECB(Electronic code Book)

            tdes.Mode = CipherMode.ECB;
            //padding mode(if any extra byte added)
            tdes.Padding = PaddingMode.PKCS7;

            ICryptoTransform cTransform = tdes.CreateDecryptor();
            byte[] resultArray = cTransform.TransformFinalBlock(
                                 toEncryptArray, 0, toEncryptArray.Length);
            //Release resources held by TripleDes Encryptor                
            tdes.Clear();
            //return the Clear decrypted TEXT
            return UTF8Encoding.UTF8.GetString(resultArray);
        }

        public static string List2ComaSeparatedQuoteString(List<string> list)
        {
            return string.Join(",", list);
        }

        public static string AppendStringInStringList(List<string> list, string appendString)
        {
            List<string> newStringList = new List<string>();
            foreach(string s in list)
            {
                newStringList.Add(s + appendString);
            }
            return string.Join(",", newStringList);
        }

        public static T To<T>(this IConvertible obj)
        {
            Type t = typeof(T);
            Type u = Nullable.GetUnderlyingType(t);

            if (u != null)
            {
                return (obj == null) ? default(T) : (T)Convert.ChangeType(obj, u);
            }
            else
            {
                return (T)Convert.ChangeType(obj, t);
            }
        }

        public static string ObjectToString(object tObject, System.Data.DbType dbType)
        {
            string outString = Convert.ChangeType(tObject, TypeCode.String).ToString();
            if (dbType == System.Data.DbType.String)
            {
                outString = string.Format("'{0}'", outString);
            }
            return outString;
        }

        //public static string DeCodeBase64(string base64String)
        //{
        //    string keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

        //    StringBuilder output = new StringBuilder();
            
        //    char chr1;
        //    char chr2;
        //    char chr3;
        //    char enc1;
        //    char enc2;
        //    char enc3;
        //    char enc4;
        //    var i = 0;

        //    // remove all characters that are not A-Z, a-z, 0-9, +, /, or =
        //    var base64test = /[^ A - Za - z0 - 9\+\/\=] / g;
        //    if (base64test.exec(base64String))
        //    {
        //        throw new InvalidDataException("There were invalid base64 characters in the input text.\n" +
        //            "Valid base64 characters are A-Z, a-z, 0-9, '+', '/',and '='\n" +
        //            "Expect errors in decoding.");
        //    }
        //    base64String = base64String.replace(/[^ A - Za - z0 - 9\+\/\=] / g, "");

        //    do
        //    {
        //        enc1 = keyStr[base64String[i++]];
        //        enc2 = keyStr[base64String[i++]];
        //        enc3 = keyStr[base64String[i++]];
        //        enc4 = keyStr[base64String[i++]];

        //        chr1 = (char)((enc1 << 2) | (enc2 >> 4));
        //        chr2 = (char)(((enc2 & 15) << 4) | (enc3 >> 2));
        //        chr3 = (char)(((enc3 & 3) << 6) | enc4);

        //        output.Append(chr1);

        //        if (enc3 != 64)
        //        {
        //            output.Append(chr2);
        //        }
        //        if (enc4 != 64)
        //        {
        //            output.Append(chr3);
        //        }

        //        chr1 = chr2 = chr3 = '\0';
        //        enc1 = enc2 = enc3 = enc4 = '\0';

        //    } while (i < base64String.Length);

        //    return output.ToString();
        //}

    }
}
