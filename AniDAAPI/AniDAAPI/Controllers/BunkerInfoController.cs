using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using AniDAAPI.Models;
using Microsoft.AspNetCore.Authorization;

namespace AniDAAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BunkerInfoController : ControllerBase
    {
        private readonly PAAMRAdbContext _context;

        public BunkerInfoController(PAAMRAdbContext context)
        {
            _context = context;
        }

        // GET: api/BunkerInfo
        [HttpGet]
        public async Task<ActionResult<IEnumerable<BunkerInfo>>> GetBunkerInfos()
        {
            return await _context.BunkerInfos.ToListAsync();
        }

        // GET: api/BunkerInfo/5
        [HttpGet("{id}")]
        public async Task<ActionResult<BunkerInfo>> GetBunkerInfo(int id)
        {
            //var bunkerInfo = await _context.BunkerInfos.FindAsync(id);

            var bunkerInfo = await _context.BunkerInfos.FirstOrDefaultAsync(e => e.CustQuoteMasterId == id);
            if (bunkerInfo == null)
            {
                return NotFound();
            }

            return bunkerInfo;
        }

        // PUT: api/BunkerInfo/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutBunkerInfo(int id, BunkerInfo bunkerInfo)
        {
            if (id != bunkerInfo.CustQuoteMasterId)
            {
                return BadRequest();
            }

           // _context.Entry(bunkerInfo).State = EntityState.Modified;

            try
            {
                

                _context.Entry(bunkerInfo).Property(x => x.Fwrecd).IsModified = true;
                _context.Entry(bunkerInfo).Property(x => x.GasOilRecd).IsModified = true;
                _context.Entry(bunkerInfo).Property(x => x.Hforecd).IsModified = true;
                _context.Entry(bunkerInfo).Property(x => x.Mdorecd).IsModified = true;
                _context.Entry(bunkerInfo).Property(x => x.LastUpdatedBy).IsModified = true;
                _context.Entry(bunkerInfo).Property(x => x.LastUpdatedDt).IsModified = true;

                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!BunkerInfoExists(id))
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

        // POST: api/BunkerInfo
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<BunkerInfo>> PostBunkerInfo(BunkerInfo bunkerInfo)
        {
            _context.BunkerInfos.Add(bunkerInfo);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetBunkerInfo", new { id = bunkerInfo.BunkerInfoId }, bunkerInfo);
        }

        // DELETE: api/BunkerInfo/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteBunkerInfo(int id)
        {
            var bunkerInfo = await _context.BunkerInfos.FindAsync(id);
            if (bunkerInfo == null)
            {
                return NotFound();
            }

            _context.BunkerInfos.Remove(bunkerInfo);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool BunkerInfoExists(int id)
        {
            return _context.BunkerInfos.Any(e => e.CustQuoteMasterId == id);
        }
    }
}
