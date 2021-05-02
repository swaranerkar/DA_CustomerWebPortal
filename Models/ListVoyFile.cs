using System;
using System.Collections.Generic;

#nullable disable

namespace AniDAAPI.Models
{
    public partial class ListVoyFile
    {
        public int CustQuoteMasterId { get; set; }
        public int? VesselId { get; set; }
        public int? CustomerId { get; set; }
        public int? CallLocId { get; set; }
        public DateTime? VslEta { get; set; }
        public DateTime? VslEtd { get; set; }
        public string Dareference { get; set; }
        public string CustShipName { get; set; }
        public string CustShipImo { get; set; }
        public string CustShipFlag { get; set; }
        public string CustomerName { get; set; }
        public string CustomerRef { get; set; }
        public string PurposeCall { get; set; }
        public int? AssignedTo { get; set; }
        public bool? Ordered { get; set; }
        public bool? ClosedVoyage { get; set; }
        public bool? ApprovedVoyage { get; set; }
        public string EmailAdd { get; set; }
        public string CcemailAdd { get; set; }
        public int? UserSon { get; set; }
        public int? UserSoff { get; set; }
        public string CustVoyLastPort { get; set; }
        public string CustVoyNextPort { get; set; }
        public string AgencyTypeDesc { get; set; }
        public int? LastUpdatedBy { get; set; }
        public DateTime? LastUpdatedDt { get; set; }
    }
}
