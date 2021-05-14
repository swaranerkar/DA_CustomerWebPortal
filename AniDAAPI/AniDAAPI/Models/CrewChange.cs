using System;
using System.Collections.Generic;

#nullable disable

namespace AniDAAPI.Models
{
    public partial class CrewChange
    {
        public int CrewChangeId { get; set; }
        public int CustQuoteMasterId { get; set; }
        public int? SignOn { get; set; }
        public int? SignOff { get; set; }
        public string Remarks { get; set; }
        public int? LastUpdatedBy { get; set; }
        public DateTime? LastUpdatedDt { get; set; }
    }
}
