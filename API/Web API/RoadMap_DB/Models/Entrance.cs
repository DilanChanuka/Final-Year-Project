using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace RoadMap_DB.Models
{
    public class Entrance
    {
        [Column(Order =0)]
        public int entrance_id { get; set; }

        public int e_location_id { get; set; }

        [Column(Order =2)]
        public int e_dept_id { get; set; }

        public Location Location { get; set; }
        public Department department { get; set; }
    }
}
