using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;


namespace AniDAAPI.Models
{
    public partial class ListBillActTrans
    {

       // [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity), Key()]
        public int CqmtransId { get; set; }
        public int? CqmtransTypeId { get; set; }
        public int CustQuoteMasterId { get; set; }
        public bool? StatusId { get; set; }
        public string CqmtransTypeDesc { get; set; }
        public string Cqmpurpose { get; set; }
        public DateTime? CqmtransDate { get; set; }
        public int? Qty { get; set; }
        public string UnitsDesc { get; set; }
        public int VendorId { get; set; }
        public string VendorName { get; set; }
        public string VendRef { get; set; }
        public string TransStatus { get; set; }
        public bool? IsActive { get; set; }
        public virtual ListDAActType ListDAActType { get; set; }

    }

}
