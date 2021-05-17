using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using AniDAAPI.Models;

namespace AniDAAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustPersonController : ControllerBase
    {
        private readonly PAAMRAdbContext _context;

        public CustPersonController(PAAMRAdbContext context)
        {
            _context = context;
        }

        // GET: api/CustPerson
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CustPerson>>> GetCustPersonDetails()
        {
            return await _context.CustPerson.ToListAsync();
        }


        // GET: api/CustPerson/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CustPerson>> GetCustPersonDetail(int id)
        {
            var custPersonDetail = await _context.CustPerson.FindAsync(id);

            if (custPersonDetail == null)
            {
                return NotFound();
            }

            return custPersonDetail;
        }
        


        
    }
}
