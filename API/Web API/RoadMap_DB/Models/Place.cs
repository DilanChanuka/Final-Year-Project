using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace RoadMap_DB.Models
{
    public class Place
    {

        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int place_id { get; set; }
       
        public int p_location_id { get; set; }

        public int  p_dept_id { get; set; }

        public int p_floor_id { get; set; }

        public Location location { get; set; }
        public Department department { get; set; }
       // public Floor floor { get; set; }


    }
}
