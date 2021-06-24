using AniDAAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using System.Web;
using System.Net.Mail;
using System.Net;
using Microsoft.Extensions.Caching.Memory;

namespace AniDAAPI.Controllers
{
    [Route("api/OTPController")]
    [ApiController]
    public class OTPController : ControllerBase
    {

        //   public IActionResult Index()
        //  {
        //    return View();
        //}
        private readonly PAAMRAdbContext _context;
        private Dictionary<String, int> map;
        private readonly IMemoryCache memoryCache;
        public OTPController(IMemoryCache memoryCache,PAAMRAdbContext context)
        {
            this.memoryCache = memoryCache;
            _context = context;
            map = new Dictionary<string, int>();
            System.Diagnostics.Debug.WriteLine("Im here");
        }

        // GET: api/BunkerInfo/5
        [HttpGet("GetOTP/{logonName}/{emailId}")]
        public async Task<ActionResult> GetOTP(String logonName, String emailId)
        {

            var user = await _context.UserDetails.Where(c => c.LogonName.Equals(logonName) && c.EmailId.Equals(emailId))
                .FirstOrDefaultAsync();
            if (user == null)
            {
                return NotFound();
            }

            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("paamra.mailserver@gmail.com");
            msg.To.Add(emailId);
            msg.Subject = "OTP to login to your PAAMRA account";
            msg.Body = "Hello, your OTP is:" + generateOTP(logonName);
            msg.IsBodyHtml = true;

            SmtpClient smt = new SmtpClient();
            smt.Host = "smtp.gmail.com";
            System.Net.NetworkCredential ntwd = new NetworkCredential();
            ntwd.UserName = "paamra.mailserver@gmail.com";
            ntwd.Password = "tester-account";
            smt.UseDefaultCredentials = false;
            smt.Credentials = ntwd;
            smt.Port = 587;
            smt.EnableSsl = true;
            smt.Send(msg);
            return NoContent();
        }
        public int generateOTP(String key)
        {
            Random random = new Random();
            int otp = 100000 + random.Next(900000);
            HttpContext.Session.SetInt32(key, otp);
           
            memoryCache.Set(key, otp);
           
            return otp;
        }
        [HttpGet("ValidateOTP/{logonName}/{otp}")]
        public async Task<ActionResult<UserDetail>> ValidateOTP(String logonName, int otp)
        {


            if (otp >= 0)
            {
                int? serverOTP = HttpContext.Session.GetInt32(logonName);
                

                System.Diagnostics.Debug.WriteLine("Hello",logonName);

                System.Diagnostics.Debug.WriteLine("SERVER OTP");
                    System.Diagnostics.Debug.WriteLine(serverOTP);
                if(serverOTP == null) {
                    System.Diagnostics.Debug.WriteLine("Server OTP NULL",serverOTP);
                }
                     
                if (serverOTP > 0 && otp == serverOTP)
                {
                    HttpContext.Session.Remove(logonName);
                    var user = await _context.UserDetails.Where(c => c.LogonName == logonName).FirstOrDefaultAsync();


                    if (user == null)
                    {
                        System.Diagnostics.Debug.WriteLine("User is NULL");
                        return NotFound();
                    }
                    else
                        return user;
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("OTP not equal to server OTP");
                }
            }
            System.Diagnostics.Debug.WriteLine(otp);
            return NoContent();


        }

        // GET: api/BunkerInfo/5
        [HttpGet("GetWebOTP/{UName}/{emailId}")]
        public async Task<ActionResult> GetUserWebOTP(String UName, String emailId)
        {

            var user1 = await _context.CustPerson.Where(c => c.CPerUName.Equals(UName) && c.CustPersonEmail.Equals(emailId))
                .FirstOrDefaultAsync();
            if (user1 == null)
            {
                return NotFound();
            }

            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("paamra.mailserver@gmail.com");
            msg.To.Add(emailId);
            msg.Subject = "OTP to login to your PAAMRA account";
            msg.Body = "Hello, your OTP is:" + generateOTP(UName);
            msg.IsBodyHtml = true;

            SmtpClient smt = new SmtpClient();
            smt.Host = "smtp.gmail.com";
            System.Net.NetworkCredential ntwd = new NetworkCredential();
            ntwd.UserName = "paamra.mailserver@gmail.com";
            ntwd.Password = "tester-account";
            smt.UseDefaultCredentials = false;
            smt.Credentials = ntwd;
            smt.Port = 587;
            smt.EnableSsl = true;
            smt.Send(msg);
            return NoContent();
        }

        [HttpGet("ValidateWebOTP/{uName}/{otp}")]
        public async Task<ActionResult<CustPerson>> ValidateWebOTP(String uName, int otp)
        {


            if (otp >= 0)
            {
                // int? serverOTP = HttpContext.Session.GetInt32(uName);
                //System.Diagnostics.Debug.WriteLine(map.Keys.Count);
                int? serverOTP = memoryCache.Get<int?>(uName);
                

                    //(map.ContainsKey(uName)) ? map[uName]:null;
                if (serverOTP != null) memoryCache.Remove(uName);
                System.Diagnostics.Debug.WriteLine("Hello", uName);

                System.Diagnostics.Debug.WriteLine("SERVER OTP");
                System.Diagnostics.Debug.WriteLine(serverOTP);
                if (serverOTP == null)
                {
                    System.Diagnostics.Debug.WriteLine("Server OTP NULL", serverOTP);
                }

                if (serverOTP > 0 && otp == serverOTP)
                {
                    HttpContext.Session.Remove(uName);
                    var cuser = await _context.CustPerson.Where(c => c.CPerUName.Equals(uName)).FirstOrDefaultAsync();


                    if (cuser == null)
                    {
                        System.Diagnostics.Debug.WriteLine("User is NULL");
                        return NotFound();
                    }
                    else
                        return cuser;
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("OTP not equal to server OTP");
                }
            }
            System.Diagnostics.Debug.WriteLine(otp);
            return NoContent();


        }

       



    }
}
