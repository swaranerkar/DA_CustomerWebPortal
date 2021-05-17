using System;
using System.Collections.Generic;

#nullable disable

namespace AniDAAPI.Models
{
    public partial class CustPerShipLU
    {
        public int CustPersonShipLUId { get; set; }
        public int? CustomerId { get; set; }
        public int? CustPersonId { get; set; }
        public int? VesselId { get; set; }
        public int? LastUpdateBy { get; set; }
        public DateTime? LastUpdatedDt { get; set; }
    }
}

