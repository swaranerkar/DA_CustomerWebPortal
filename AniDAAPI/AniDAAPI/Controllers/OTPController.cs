﻿using AniDAAPI.Models;
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

        public OTPController(PAAMRAdbContext context)
        {
            _context = context;
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
  
            int? serverOTP = HttpContext.Session.GetInt32(key);
            System.Diagnostics.Debug.WriteLine("SERVER OTP");
            System.Diagnostics.Debug.WriteLine(serverOTP);
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


    }
}