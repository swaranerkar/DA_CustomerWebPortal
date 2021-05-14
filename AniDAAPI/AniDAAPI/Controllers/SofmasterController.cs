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
    public class SofmasterController : ControllerBase
    {
        private readonly PAAMRAdbContext _context;

        public SofmasterController(PAAMRAdbContext context)
        {
            _context = context;
        }

        // GET: api/Sofmaster
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Sofmaster>>> GetSofmasters()
        {
            return await _context.Sofmasters.ToListAsync();
        }

        // GET: api/Sofmaster/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Sofmaster>> GetSofmaster(int id)
        {
            var sofmaster = await _context.Sofmasters.FindAsync(id);

            if (sofmaster == null)
            {
                return NotFound();
            }

            return sofmaster;
        }

        // PUT: api/Sofmaster/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSofmaster(int id, Sofmaster sofmaster)
        {
            if (id != sofmaster.SofmasterId)
            {
                return BadRequest();
            }

            _context.Entry(sofmaster).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SofmasterExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Sofmaster
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Sofmaster>> PostSofmaster(Sofmaster sofmaster)
        {
            _context.Sofmasters.Add(sofmaster);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetSofmaster", new { id = sofmaster.SofmasterId }, sofmaster);
        }

        // DELETE: api/Sofmaster/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSofmaster(int id)
        {
            var sofmaster = await _context.Sofmasters.FindAsync(id);
            if (sofmaster == null)
            {
                return NotFound();
            }

            _context.Sofmasters.Remove(sofmaster);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool SofmasterExists(int id)
        {
            return _context.Sofmasters.Any(e => e.SofmasterId == id);
        }
    }
}
