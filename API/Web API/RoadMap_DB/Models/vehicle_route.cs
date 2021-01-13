using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace RoadMap_DB.Models
{
    public class vehicle_route
    {
        [Key,Column(Order =0)]
        public int v_route_id { get; set; }
        public int v_location_id { get; set; }

        public Location location { get; set; }
   
    }
}
