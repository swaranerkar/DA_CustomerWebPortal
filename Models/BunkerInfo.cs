using System;
using System.Collections.Generic;

#nullable disable

namespace AniDAAPI.Models
{
    public partial class BunkerInfo
    {
        public int BunkerInfoId { get; set; }
        public int CustQuoteMasterId { get; set; }
        public decimal? Hforecd { get; set; }
        public decimal? Mdorecd { get; set; }
        public decimal? GasOilRecd { get; set; }
        public decimal? Fwrecd { get; set; }
        public bool? MsgSent { get; set; }
        public int? LastUpdatedBy { get; set; }
        public DateTime? LastUpdatedDt { get; set; }
    }
}
