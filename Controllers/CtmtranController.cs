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
    public class CtmtranController : ControllerBase
    {
        private readonly PAAMRAdbContext _context;

        public CtmtranController(PAAMRAdbContext context)
        {
            _context = context;
        }

        // GET: api/Ctmtran
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Ctmtran>>> GetCtmtrans()
        {
            return await _context.Ctmtrans.ToListAsync();
        }

        // GET: api/Ctmtran/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Ctmtran>> GetCtmtran(int id)
        {
            //var ctmtran = await _context.Ctmtrans.FindAsync(id);
            var ctmtran = await _context.Ctmtrans.FirstOrDefaultAsync(e => e.CustQuoteMasterId == id);
            if (ctmtran == null)
            {
                return NotFound();
            }

            return ctmtran;
        }

        // PUT: api/Ctmtran/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCtmtran(int id, Ctmtran ctmtran)
        {
            if (id != ctmtran.CustQuoteMasterId)
            {
                return BadRequest();
            }

            _context.Entry(ctmtran).State = EntityState.Modified;

            try
            {
                
                 _context.Entry(ctmtran).Property(x => x.CtmamtReq).IsModified = true;
                _context.Entry(ctmtran).Property(x => x.CtmdelAmt).IsModified = true;
                _context.Entry(ctmtran).Property(x => x.CtmdeliveryDate).IsModified = true;
                _context.Entry(ctmtran).Property(x => x.Ctmcurrency).IsModified = true;
                _context.Entry(ctmtran).Property(x => x.LastUpdatedBy).IsModified = true;
                _context.Entry(ctmtran).Property(x => x.LastUpdatedDt).IsModified = true;
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CtmtranExists(id))
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

        // POST: api/Ctmtran
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Ctmtran>> PostCtmtran(Ctmtran ctmtran)
        {
            _context.Ctmtrans.Add(ctmtran);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCtmtran", new { id = ctmtran.CtmtransId }, ctmtran);
        }

        // DELETE: api/Ctmtran/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCtmtran(int id)
        {
            var ctmtran = await _context.Ctmtrans.FindAsync(id);
            if (ctmtran == null)
            {
                return NotFound();
            }

            _context.Ctmtrans.Remove(ctmtran);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CtmtranExists(int id)
        {
            return _context.Ctmtrans.Any(e => e.CustQuoteMasterId == id);
        }
    }
}
