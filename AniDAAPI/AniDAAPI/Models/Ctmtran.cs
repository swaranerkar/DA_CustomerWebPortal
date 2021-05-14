using System;
using System.Collections.Generic;

#nullable disable

namespace AniDAAPI.Models
{
    public partial class Ctmtran
    {
        public int CtmtransId { get; set; }
        public int CustQuoteMasterId { get; set; }
        public decimal? CtmamtReq { get; set; }
        public string Ctmcurrency { get; set; }
        public DateTime? CtmdeliveryDate { get; set; }
        public bool? Ctmdelivered { get; set; }
        public decimal? CtmdelAmt { get; set; }
        public bool? CtminfOps { get; set; }
        public int? LastUpdatedBy { get; set; }
        public DateTime? LastUpdatedDt { get; set; }
    }
}
