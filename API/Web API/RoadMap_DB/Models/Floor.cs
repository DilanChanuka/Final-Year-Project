using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace RoadMap_DB.Models
{
    public class Floor
    {
        [Column(Order =0)]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id { get; set; }
        public int floor_id { get; set; }
        public int f_location_id { get; set; } 

        [Column(Order =2)]
        public int f_dept_id { get; set; }

       // public List<Place> fplace { get; set; }
       // public List<Inner_route> finner_Routes { get; set; }


        public Location location { get; set; }
        public Department department { get; set; }
 
    }
}
