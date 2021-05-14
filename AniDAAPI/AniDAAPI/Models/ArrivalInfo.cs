using System;
using System.Collections.Generic;

#nullable disable

namespace AniDAAPI.Models
{
    public partial class ArrivalInfo
    {
        public int ArrInfoId { get; set; }
        public int CustQuoteMasterId { get; set; }
        public string VslCallCondtn { get; set; }
        public decimal? Hforob { get; set; }
        public decimal? Mdorob { get; set; }
        public decimal? LubRob { get; set; }
        public decimal? GasOilRob { get; set; }
        public decimal? Fwrob { get; set; }
        public bool? MsgSent { get; set; }
        public int? LastUpdatedBy { get; set; }
        public DateTime? LastUpdatedDt { get; set; }
    }
}
