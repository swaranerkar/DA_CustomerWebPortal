using AniDAAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AniDAAPI.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class ListDAActTypeController : ControllerBase
    {
        private readonly PAAMRAdbContext _context;

        public ListDAActTypeController(PAAMRAdbContext context)
        {
            _context = context;
        }

        // GET: api/ListDAActType
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ListDAActType>>> GetListDAActTypes()
        {
            return await _context.ListDAActType.ToListAsync();
        }

        // GET: api/ListDAActType/5
        [HttpGet("Get/{type}")]
        public  async Task<ActionResult<ListDAActType>> GetListDAActType(String type)
        {
            var listDAActType = await _context.ListDAActType.Where(e => e.CqmtransTypeDesc == type).FirstOrDefaultAsync();

            if (listDAActType == null)
            {
                return NotFound();
            }

            return listDAActType;
        }

        // GET: api/ListDAActType/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ListDAActType>> GetListDAActType(int id)
        {
            var listDAActType = await _context.ListDAActType.FindAsync(id);

            if (listDAActType == null)
            {
                return NotFound();
            }

            return listDAActType;
        }

        // PUT: api/Sofmaster/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutListDAActType(int id, ListDAActType listDAActType)
        {
            if (id != listDAActType.CqmtransTypeId)
            {
                return BadRequest();
            }

            _context.Entry(listDAActType).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ListDAActTypeExists(id))
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
        public async Task<ActionResult<ListDAActType>> PostListDAActType(ListDAActType listDAActType)
        {
            _context.ListDAActType.Add(listDAActType);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetListDAActType", new { id = listDAActType.CqmtransTypeId}, listDAActType);
        }

        // DELETE: api/Sofmaster/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteListDAActType(int id)
        {
            var listDAActType = await _context.ListDAActType.FindAsync(id);
            if (listDAActType == null)
            {
                return NotFound();
            }

            _context.ListDAActType.Remove(listDAActType);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ListDAActTypeExists(int id)
        {
            return _context.ListDAActType.Any(e => e.CqmtransTypeId == id);
        }
    }
}
