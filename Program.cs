using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace AniDAAPI
{
    public class Program
    {
        public static void Main(string[] args)
        {
            /*
            ProcessStartInfo start = new ProcessStartInfo();
            start.FileName = "C:\\Users\\shruti\\Desktop\\Disbursement-Accounting\\Disbursement-Accounting-master\\file-upload\\dist\\main";
            start.UseShellExecute = false;
            start.Arguments = string.Format("\"{0}\", args);
            start.CreateNoWindow = true;
            start.RedirectStandardOutput = true;
            start.RedirectStandardOutput = true;// Any output, generated by application will be redirected back
            start.RedirectStandardError = true; // Any error in standard output will be redirected back (for example exceptions)
            //start.LoadUserProfile = true;

            using (Process process = Process.Start(start))
            {
                using (StreamReader reader = process.StandardOutput)
                {
                    string stderr = process.StandardError.ReadToEnd();
                    Console.WriteLine(stderr);
                    string result = reader.ReadToEnd();
                    Console.WriteLine(result);

                }
            }*/
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                });
    }
}
