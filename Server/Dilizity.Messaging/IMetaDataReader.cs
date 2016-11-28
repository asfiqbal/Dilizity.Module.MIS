using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Dilizity.Messaging
{
    public interface IMetaDataReader
    {
        bool Read();
        TemplateCode getTag(string code);
        string getTagName(string code);
        string getTagDescription(string code);
        string getTagMultipleResult(string code);
        string getTagContextAware(string code);
        string getTagDataFunction(string code);
        bool isValidTag(string tag);
    }
}
