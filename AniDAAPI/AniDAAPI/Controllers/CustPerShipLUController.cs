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
    public class CustPerShipLUController : ControllerBase
    {
        private readonly PAAMRAdbContext _context;

        public CustPerShipLUController(PAAMRAdbContext context)
        {
            _context = context;
        }

        // GET: api/CustPerShipLU
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CustPerShipLU>>> GetCustPerShipLU()
        {
            return await _context.CustPerShipLU.ToListAsync();
        }
        //to fectch vesselID of employee
        // GET: api/CustPerShipLU/5
        [HttpGet("{id}")]
        public IEnumerable<CustPerShipLU> GetCustPerShipLUDetails(int id)
        {

            var custPerShipLUDetails = _context.CustPerShipLU.Where(e => e.CustPersonId == id).ToList();

           

            return custPerShipLUDetails;
        }
    }
}
