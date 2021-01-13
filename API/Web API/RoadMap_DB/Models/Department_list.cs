using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace RoadMap_DB.Models
{
    public class Department_list
    {
        [Key,Column("id",Order =0)]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int dept_id { get; set; }
        public string  name{ get; set; }
    }
}
