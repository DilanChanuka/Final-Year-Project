using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Road_Map_Web_API.Models
{
    public class AdminUser
    {        
        [Required]
        public string Username { get; set; }
        [Required]
        public string Password { get; set; }
    }
}
