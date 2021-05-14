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
    public class SoftranController : ControllerBase
    {
        private readonly PAAMRAdbContext _context;

        public SoftranController(PAAMRAdbContext context)
        {
            _context = context;
        }

        // GET: api/Softran
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Softran>>> GetSoftrans()
        {
            return await _context.Softrans.ToListAsync();
        }

        // GET: api/Softran/5
        [HttpGet("{id}")]
        public IEnumerable<Softran> GetSoftran(int id)
        {
            var softran = _context.Softrans.Where(e => e.CustQuoteMasterId == id && e.IsActive == true).ToList();
            //var softran = await _context.Softrans.FindAsync(id);

            //if (softran == null)
            //{
              //  return NotFound();
            //}

            return softran;
        }

        // PUT: api/Softran/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSoftran(int id, Softran softran)
        {
            if (id != softran.SoftransId)
            {
                return BadRequest();
            }

            _context.Entry(softran).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SoftranExists(id))
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

        // POST: api/Softran
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Softran>> PostSoftran(Softran softran)
        {
            _context.Softrans.Add(softran);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetSoftran", new { id = softran.SoftransId }, softran);
        }

        // DELETE: api/Softran/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSoftran(int id)
        {
            var softran = await _context.Softrans.FindAsync(id);
            if (softran == null)
            {
                return NotFound();
            }

            _context.Softrans.Remove(softran);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool SoftranExists(int id)
        {
            return _context.Softrans.Any(e => e.SoftransId == id);
        }
    }
}
