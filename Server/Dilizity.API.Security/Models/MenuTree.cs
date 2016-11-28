using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dilizity.API.Security.Models
{
    //[{
    //name: "Report",
    //link: "#",
    //subtree: [{
    //    name: "MIS Report",
    //    link: "#",
    //    subtree: [{
    //        name: "Report1",
    //        link: "index.Report1"
    //    }, {
    //        name: "Metal Gear 2: Solid Snake",
    //        link: "metal-gear2"
    //    }, {
    //        name: "Metal Gear Solid: The Twin Snakes",
    //        link: "metal-gear-solid"
    //    }]
    //}]
    class MenuTree
    {
        //public MenuTree()
        //{
        //    subtree = new List<MenuTree>();
        //}

        [JsonIgnore]
        public int Id { get; set; }

        [JsonIgnore]
        public int ParentId { get; set; }

        [JsonProperty]
        public string name { get; set; }
        [JsonProperty]
        public string link { get; set; }
        [JsonProperty]
        public List<MenuTree> subtree { get; set; }
    }
}
