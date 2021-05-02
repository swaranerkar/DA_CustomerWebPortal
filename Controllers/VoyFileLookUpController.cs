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
    public class VoyFileLookUpController : ControllerBase
    {
        private readonly PAAMRAdbContext _context;

        public VoyFileLookUpController(PAAMRAdbContext context)
        {
            _context = context;
        }

        // GET: api/VoyFileLookUp
        [HttpGet]
        public async Task<ActionResult<IEnumerable<VoyFileLookUp>>> GetVoyFileLookUps()
        {
            return await _context.VoyFileLookUps.ToListAsync();
        }

        // GET: api/VoyFileLookUp/5
        [HttpGet("{id}")]
        public  IEnumerable<VoyFileLookUp> GetVoyFileLookUp(int id)
        {
            //async  Task<IEnumerable<ActionResult<VoyFileLookUp>>>
            //var voyFileLookUp = from q in _context.VoyFileLookUps
            //                  where q.CustQuoteMasterId == id
            //                select new VoyFileLookUp(q);
            // = await _context.VoyFileLookUps.FindAsync(id);

            var voyFileLookUp =  _context.VoyFileLookUps.Where(e => e.UserId == id).ToList();

           // if (voyFileLookUp == null)
           // {
              //  return (IEnumerable<VoyFileLookUp>)NotFound();
           // }

            return voyFileLookUp;
        }

        // PUT: api/VoyFileLookUp/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutVoyFileLookUp(int id, VoyFileLookUp voyFileLookUp)
        {
            if (id != voyFileLookUp.VoyFileLookUpId)
            {
                return BadRequest();
            }

            _context.Entry(voyFileLookUp).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!VoyFileLookUpExists(id))
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

        // POST: api/VoyFileLookUp
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<VoyFileLookUp>> PostVoyFileLookUp(VoyFileLookUp voyFileLookUp)
        {
            _context.VoyFileLookUps.Add(voyFileLookUp);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetVoyFileLookUp", new { id = voyFileLookUp.VoyFileLookUpId }, voyFileLookUp);
        }

        // DELETE: api/VoyFileLookUp/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteVoyFileLookUp(int id)
        {
            var voyFileLookUp = await _context.VoyFileLookUps.FindAsync(id);
            if (voyFileLookUp == null)
            {
                return NotFound();
            }

            _context.VoyFileLookUps.Remove(voyFileLookUp);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool VoyFileLookUpExists(int id)
        {
            return _context.VoyFileLookUps.Any(e => e.VoyFileLookUpId == id);
        }
    }
}
