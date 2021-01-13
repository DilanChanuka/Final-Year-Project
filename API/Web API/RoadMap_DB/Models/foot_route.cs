using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace RoadMap_DB.Models
{
   
    public class foot_route
    {     
        [Key,Column(Order =0)]
        public int f_route_id { get; set; }
        public int f_location_id { get; set; }

        public Location location { get; set; }
    }
}
