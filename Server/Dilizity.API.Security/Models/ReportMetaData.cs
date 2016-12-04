using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dilizity.API.Security.Models
{
    public class ReportSelectionControlData
    {
        public string name;
        public string value;
    }

    public class ReportTemplateOptions
    {
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public string type;
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public string label;
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public string placeholder;
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public bool required;
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public string datepickerPopup;
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public string defaultValue;
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public List<ReportSelectionControlData> options;
    }

    public class ReportMetaFiltersData
    {
        [JsonIgnore]
        public int FilterId;
        public string className;
        public string key;
        //public string DisplayName;
        public string type;
        //public string FilterDataType;
        public ReportTemplateOptions templateOptions;

        public ReportMetaFiltersData()
        {
            templateOptions = new ReportTemplateOptions();
        }  

    }
    public class ReportMetaFields
    {
        public string className;
        public List<ReportMetaFiltersData> fieldGroup;
    }

    public class ReportMetaData
    {
        public int ReportId;
        public string PermissionName;
        public string DisplayName;
        public List<ReportMetaFields> fieldCollection;
    }
}
