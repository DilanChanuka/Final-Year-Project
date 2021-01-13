using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace RoadMap_DB.Models
{
    public class Department
    {
        [Key,Column(Order =0)]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int dept_id { get; set; }
        public string  dept_name{ get; set; }

        public List<Entrance> dentrance { get; set; }
        public List<Place> dplace { get; set; }
        public List<Floor> dfloor { get; set; }
        public List<Inner_route> dinner_routes { get; set; }
    }
}
