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
    public class ArrivalInfoesController : ControllerBase
    {
        private readonly PAAMRAdbContext _context;

        public ArrivalInfoesController(PAAMRAdbContext context)
        {
            _context = context;
        }

        // GET: api/ArrivalInfoes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ArrivalInfo>>> GetArrivalInfos()
        {
            return await _context.ArrivalInfos.ToListAsync();
        }

        // GET: api/ArrivalInfoes/5
        [HttpGet("Departure/{id}")]
        public async Task<ActionResult<ArrivalInfo>> GetDepartureInfo(int id)
        {
            var arrivalInfo = await _context.ArrivalInfos.Where(c => c.VslCallCondtn == "Departure" && c.CustQuoteMasterId == id)
                 .FirstOrDefaultAsync();
            //var arrivalInfo = await _context.ArrivalInfos.FindAsync(id);

            if (arrivalInfo == null)
            {
                return NotFound();
            }

            return arrivalInfo;
        }

        // GET: api/ArrivalInfoes/5
        [HttpGet("Arrival/{id}")]
        public async Task<ActionResult<ArrivalInfo>> GetArrivalInfo(int id)
        {
            var arrivalInfo = await _context.ArrivalInfos.Where(c => c.VslCallCondtn == "Arrival" && c.CustQuoteMasterId == id)
                 .FirstOrDefaultAsync();
            //var arrivalInfo = await _context.ArrivalInfos.FindAsync(id);

            if (arrivalInfo == null)
            {
                return NotFound();
            }

            return arrivalInfo;
        }
        // PUT: api/ArrivalInfoes/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutArrivalInfo(int id, ArrivalInfo arrivalInfo)
        {
            if (id != arrivalInfo.ArrInfoId)
            {
                return BadRequest();
            }

           // _context.Entry(arrivalInfo).State = EntityState.Modified;

            try
            {
               
                _context.Entry(arrivalInfo).Property(x => x.Fwrob).IsModified = true;
                _context.Entry(arrivalInfo).Property(x => x.GasOilRob).IsModified = true;
                _context.Entry(arrivalInfo).Property(x => x.Hforob).IsModified = true;
                _context.Entry(arrivalInfo).Property(x => x.LubRob).IsModified = true;
                _context.Entry(arrivalInfo).Property(x => x.Mdorob).IsModified = true;
                _context.Entry(arrivalInfo).Property(x => x.LastUpdatedBy).IsModified = true;
                _context.Entry(arrivalInfo).Property(x => x.LastUpdatedDt).IsModified = true;

                await _context.SaveChangesAsync();

            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ArrivalInfoExists(id))
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

        // POST: api/ArrivalInfoes
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<ArrivalInfo>> PostArrivalInfo(ArrivalInfo arrivalInfo)
        {
            _context.ArrivalInfos.Add(arrivalInfo);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetArrivalInfo", new { id = arrivalInfo.ArrInfoId }, arrivalInfo);
        }

        // DELETE: api/ArrivalInfoes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteArrivalInfo(int id)
        {
            var arrivalInfo = await _context.ArrivalInfos.FindAsync(id);
            if (arrivalInfo == null)
            {
                return NotFound();
            }

            _context.ArrivalInfos.Remove(arrivalInfo);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ArrivalInfoExists(int id)
        {
            return _context.ArrivalInfos.Any(e => e.ArrInfoId == id);
        }
    }
}
