using System;
using System.Collections.Generic;

#nullable disable

namespace AniDAAPI.Models
{
    public partial class CustPerson
    {
        public int CustPersonId { get; set; }
        public String CustPersonFullName { get; set; }
        public String CustPersonDesignation { get; set; }
        public String CustPersonTelMob { get; set; }
        public String CustPersonEmail { get; set; }
        public int CustomerId { get; set; }
        public String CPerUName { get; set; }
        public String CPerPwd { get; set; }
        public bool isActive { get; set; }
        public int LastUpdatedBy { get; set; }
        public DateTime? LastUpdatedDt { get; set; }
    }
}