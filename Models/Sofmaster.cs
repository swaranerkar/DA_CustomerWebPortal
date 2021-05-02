using System;
using System.Collections.Generic;

#nullable disable

namespace AniDAAPI.Models
{
    public partial class Sofmaster
    {
        public Sofmaster()
        {
            Softrans = new HashSet<Softran>();
        }

        public int SofmasterId { get; set; }
        public string Softype { get; set; }

        public virtual ICollection<Softran> Softrans { get; set; }
    }
}
