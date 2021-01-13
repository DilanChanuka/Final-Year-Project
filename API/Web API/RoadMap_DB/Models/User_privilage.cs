using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace RoadMap_DB.Models
{
    public class User_privilage
    {
        [Key]
        public int id { get; set; }

        [ForeignKey("user1")]
        public int user1_id { get; set; }
        public User user1 { get; set; }

        [ForeignKey("user2")]
        public int user2_id { get; set; }
        public User user2 { get; set; }

        public string status { get; set; }
    }
}
