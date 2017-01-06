using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dilizity.API.Security.Models
{
    class PermissionTree
    {
        public PermissionTree()
        {
            children = new List<PermissionTree>();
        }

        [JsonProperty]
        public string label { get; set; }


        [JsonProperty]
        public int Id { get; set; }

        [JsonIgnore]
        public int ParentId { get; set; }


        [JsonProperty]
        public List<PermissionTree> children { get; set; }
    }
}
