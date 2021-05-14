using System;
using System.Collections.Generic;

#nullable disable

namespace AniDAAPI.Models
{
    public partial class Softran
    {
        public int SoftransId { get; set; }
        public int? CustQuoteMasterId { get; set; }
        public int? SofmasterId { get; set; }
        public DateTime? SoftransDate { get; set; }
        public string SoftransRemarks { get; set; }
        public int? LastUpdatedBy { get; set; }
        public DateTime? LastUpdatedDt { get; set; }
        public bool? IsActive { get; set; }

        public virtual Sofmaster Sofmaster { get; set; }
    }
}
