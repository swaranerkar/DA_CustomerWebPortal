using System;
using System.Collections.Generic;

#nullable disable

namespace AniDAAPI.Models
{
    public partial class UserDetail
    {
        public int UserId { get; set; }
        public string FullName { get; set; }
        public string UserShortName { get; set; }
        public string LogonName { get; set; }
        public string Password { get; set; }
        public string MobileNumber { get; set; }
        public string Imeino { get; set; }
        public string DeviceId { get; set; }
        public string EmailId { get; set; }
        public bool? IsActive { get; set; }
    }
}
