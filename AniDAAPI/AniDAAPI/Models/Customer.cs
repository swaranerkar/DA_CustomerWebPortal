using System;
using System.Collections.Generic;

#nullable disable

namespace AniDAAPI.Models
{
    public partial class Customer
    {
        public int CustomerId { get; set; }
        public String CustomerName { get; set; }
        public String CustomerRef { get; set; }
        public bool isActive { get; set; }
        public int LastUpdatedBy { get; set; }
        public DateTime LastUpdatedDt { get; set; }
    }
}
