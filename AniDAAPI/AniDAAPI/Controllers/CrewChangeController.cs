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
    public class CrewChangeController : ControllerBase
    {
        private readonly PAAMRAdbContext _context;

        public CrewChangeController(PAAMRAdbContext context)
        {
            _context = context;
        }

        // GET: api/CrewChange
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CrewChange>>> GetCrewChanges()
        {
            return await _context.CrewChanges.ToListAsync();
        }

        // GET: api/CrewChange/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CrewChange>> GetCrewChange(int id)
        {
            //var crewChange = await _context.CrewChanges.FindAsync(id);
            var crewChange = await _context.CrewChanges.FirstOrDefaultAsync(e => e.CustQuoteMasterId == id);
            if (crewChange == null)
            {
                return NotFound();
            }

            return crewChange;
        }

        // PUT: api/CrewChange/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCrewChange(int id, CrewChange crewChange)
        {
            if (id != crewChange.CustQuoteMasterId)
            {
                return BadRequest();
            }

           // _context.Entry(crewChange).State = EntityState.Modified;

            try
            {
              
                _context.Entry(crewChange).Property(x => x.SignOn).IsModified = true;
                _context.Entry(crewChange).Property(x => x.SignOff).IsModified = true;
                _context.Entry(crewChange).Property(x => x.Remarks).IsModified = true;
                _context.Entry(crewChange).Property(x => x.LastUpdatedBy).IsModified = true;
                _context.Entry(crewChange).Property(x => x.LastUpdatedDt).IsModified = true;
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CrewChangeExists(id))
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

        // POST: api/CrewChange
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<CrewChange>> PostCrewChange(CrewChange crewChange)
        {
            _context.CrewChanges.Add(crewChange);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCrewChange", new { id = crewChange.CrewChangeId }, crewChange);
        }

        // DELETE: api/CrewChange/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCrewChange(int id)
        {
            var crewChange = await _context.CrewChanges.FindAsync(id);
            if (crewChange == null)
            {
                return NotFound();
            }

            _context.CrewChanges.Remove(crewChange);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CrewChangeExists(int id)
        {
            return _context.CrewChanges.Any(e => e.CustQuoteMasterId == id);
        }
    }
}
