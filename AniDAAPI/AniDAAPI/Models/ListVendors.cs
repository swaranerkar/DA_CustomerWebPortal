using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AniDAAPI.Models
{
    public class ListVendors
    {
		public int VendorId { get; set; }
		public string VendorName { get; set; }
		public string VendRef { get; set; }
		public bool? IsActive { get; set; }
		public int? VendTypeId { get; set; }
		public int? LastUpdatedBy { get; set; }
		public DateTime? LastUpdatedDT { get; set; }
}
}
