using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace RoadMap_DB.Models
{
    public class Location
    {
        [Key,Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int location_id { get; set; }
        public string location_name { get; set; }
        public double lat_value { get; set; }
        public double lng_value { get; set; }

       // public List<Place>p_id { get; set; }
       public List<Entrance> lentrance { get; set; }
       public List<Inner_route> linner_Routes { get; set; }
       public List<Floor> lfloors { get; set; }
       public List<Place> lplaces { get; set; }
       public List<vehicle_route> lv_route { get; set; }
       public List<foot_route> lf_route { get; set; }
       public List<Vertext_Location> lvertext_Locations { get; set; }
        
    }
}
