using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace RoadMap_DB.Models
{
   
    public class f_route
    {     
        [Key,Column(Order =0)]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id { get; set; }
        public int f_route_id { get; set; }

        [Column(Order = 2)]
        public double lat { get; set; }

        [Column(Order = 3)]
        public double lng { get; set; }
    }
}
