using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dilizity.API.Security.Models
{
    public class ReportSelectionControlData
    {
        public string Id;
        public string value;
    }

    public class ReportMetaFiltersData
    {
        public int FilterId;
        public string FilterName;
        public string DisplayName;
        public string FilterType;
        public string FilterDataType;
        public List<ReportSelectionControlData> FilterData;
    }
    public class ReportMetaData
    {
        public int ReportId;
        public string DisplayName;
        public int PermissionId;
        public List<ReportMetaFiltersData> Filters;
    }
}
