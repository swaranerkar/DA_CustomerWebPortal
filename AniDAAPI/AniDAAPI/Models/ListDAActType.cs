using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AniDAAPI.Models
{
    public partial class ListDAActType
    {
        
        public int CqmtransTypeId { get; set; }
        public string CqmtransTypeDesc { get; set; }
        public int ZQuoteItemId { get; set; }
        public int NUnitId { get; set; }
        public string UnitsDesc { get; set; }
        public int ZVendTypeId { get; set; }

        public ListDAActType()
        {
            ListBillActTrans = new HashSet<ListBillActTrans>();
        }

        public virtual ICollection<ListBillActTrans> ListBillActTrans { get; set; }
    }
}
