using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace RoadMap_DB.Models
{
    public class Inner_route
    {
        [ Column(Order = 0)]
        public int in_route_id { get; set; }
        public int i_location_id { get; set; }
        public int i_dept_id { get; set; }
        public int i_floor_id { get; set; }

        public Location location { get; set; }
        public Department department { get; set; }
       // public Floor floor { get; set; }

    }

   
}
