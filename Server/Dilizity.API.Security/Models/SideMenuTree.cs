using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dilizity.API.Security.Models
{
    //[
    //    {
    //        title: 'Administration',
    //        styleClass: 'fa fa-edit',
    //        content: [
    //            {   
    //                menuTitle:'User',
    //                actionURL: "index.user"
    //            },
    //            {
    //                menuTitle: 'Role',
    //                actionURL: "index.Role"
    //            },
    //            {
    //                menuTitle: 'Maker List',
    //                actionURL: "index.Maker"
    //            },
    //            {
    //                menuTitle: 'Checker List',
    //                actionURL: "index.Checker"
    //            }
    //            ]
    //    },
    //    {
    //        title: 'Report',
    //        styleClass: 'fa fa-desktop',
    //        content: [
    //            {
    //                menuTitle: 'Connection Management',
    //                actionURL: "index.Connection"
    //            },
    //            {
    //                menuTitle: 'Report',
    //                actionURL: "index.Report"
    //            }]
    //    }
    //];
    class SideMenuTree
    {
        //public MenuTree()
        //{
        //    subtree = new List<MenuTree>();
        //}

        [JsonIgnore]
        public int Id { get; set; }

        [JsonIgnore]
        public int ParentId { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public string title { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public string styleClass { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public string menuTitle { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public string actionURL { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public List<SideMenuTree> content { get; set; }
    }

}