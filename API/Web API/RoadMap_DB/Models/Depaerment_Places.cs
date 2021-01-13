using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace RoadMap_DB.Models
{
    public class Deparment_Places
    {

        [Key, Column("id", Order = 0)]
        public int d_place_id { get; set; }       
        public int dept_id { get; set; }
        public int d_floor_id { get; set; }
        public string place_name { get; set; }
        
        [Column(Order =4)]
        public double lat { get; set; }

        [Column(Order = 5)]
        public double lng { get; set; }
    }
}
