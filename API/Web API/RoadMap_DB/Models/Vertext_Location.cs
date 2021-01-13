using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace RoadMap_DB.Models
{
    public class Vertext_Location
    {
        [Key,Column(Order =0)]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id { get; set; }
        public int graph_No { get; set; }
        public int vertex_No { get; set; }
        public int location_id { get; set; }
        public Location location { get; set; }
    }
}
