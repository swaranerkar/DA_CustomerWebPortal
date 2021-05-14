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
    public class CallLocDescController : ControllerBase
    {
        private readonly PAAMRAdbContext _context;

        public CallLocDescController(PAAMRAdbContext context)
        {
            _context = context;
        }

        // GET: api/CallLocDesc
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CallLocDesc>>> GetCallLocDescs()
        {
            return await _context.CallLocDescs.ToListAsync();
        }

        // GET: api/CallLocDesc/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CallLocDesc>> GetCallLocDesc(int id)
        {
            var callLocDesc = await _context.CallLocDescs.FindAsync(id);

            if (callLocDesc == null)
            {
                return NotFound();
            }

            return callLocDesc;
        }

        // PUT: api/CallLocDesc/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCallLocDesc(int id, CallLocDesc callLocDesc)
        {
            if (id != callLocDesc.CallLocId)
            {
                return BadRequest();
            }

            _context.Entry(callLocDesc).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CallLocDescExists(id))
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

        // POST: api/CallLocDesc
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<CallLocDesc>> PostCallLocDesc(CallLocDesc callLocDesc)
        {
            _context.CallLocDescs.Add(callLocDesc);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCallLocDesc", new { id = callLocDesc.CallLocId }, callLocDesc);
        }

        // DELETE: api/CallLocDesc/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCallLocDesc(int id)
        {
            var callLocDesc = await _context.CallLocDescs.FindAsync(id);
            if (callLocDesc == null)
            {
                return NotFound();
            }

            _context.CallLocDescs.Remove(callLocDesc);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CallLocDescExists(int id)
        {
            return _context.CallLocDescs.Any(e => e.CallLocId == id);
        }
    }
}
