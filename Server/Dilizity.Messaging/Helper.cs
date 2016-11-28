using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace Dilizity.Messaging
{
    public class Helper
    {
        private static volatile Helper instance;

        private Helper() { }

        public static Helper Instance
        {
            get
            {
                if (instance == null)
                {
                    if (instance == null)
                        instance = new Helper();
                }

                return instance;
            }
        }

        public string FormatXPath(string sourceXPath, string parameter)
        {
            return string.Format(sourceXPath, parameter);
        }

        public string ReplaceTag(string tagName, string source, string dataToBeReplaced)
        {
            IMetaDataReader reader = MetaDataAgent.Instance;
            TemplateCode code = reader.getTag(tagName);
            string pattern = string.Empty;
            string outString = string.Empty;

            if (code.MultipleResult.ToUpper() == "TRUE")
            {
                pattern = string.Format(@"<{0}>(.*\s)*<\/{0}>", tagName);
                Regex regEx = new Regex(pattern, RegexOptions.IgnoreCase | RegexOptions.Multiline);
                outString = regEx.Replace(source, dataToBeReplaced);
            }
            else
            {
                pattern = string.Format(@"<{0} />", tagName);
                outString = source.Replace(pattern, dataToBeReplaced);
            }

            return outString;
        }


    }
}
