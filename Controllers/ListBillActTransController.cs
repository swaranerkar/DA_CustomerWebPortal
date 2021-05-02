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
    public class ListBillActTransController : ControllerBase
    {
        private readonly PAAMRAdbContext _context;

        public ListBillActTransController(PAAMRAdbContext context)
        {
            _context = context;
        }

        // GET: api/ListBillActTrans
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ListBillActTrans>>> GetListBillActTrans()
        {
            return await _context.ListBillActTrans.ToListAsync();
        }

        // GET: api/ListBillActTrans/5
        [HttpGet("{id}")]
        public  IEnumerable<ListBillActTrans> GetListBillActTrans(int id)
        {
            // Task<ActionResult<ListBillActTrans>>
            //var listBillActTrans = await _context.ListBillActTrans.FindAsync(id);
            var listBillActTrans =  _context.ListBillActTrans.Where(e => e.CustQuoteMasterId == id && e.IsActive == true).ToList();
           // if (listBillActTrans == null)
            //{
              //  return NotFound();
           // }

            return listBillActTrans;
        }

        // PUT: api/ListBillActTrans/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutListBillActTrans(int id, ListBillActTrans listBillActTrans)
        {
            if (id != listBillActTrans.CqmtransId)
            {
                return BadRequest();
            }

            _context.Entry(listBillActTrans).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ListBillActTransExists(id))
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

        // POST: api/ListBillActTrans
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<ListBillActTrans>> PostListBillActTrans(ListBillActTrans listBillActTrans)
        {
            _context.ListBillActTrans.Add(listBillActTrans);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetListBillActTrans", new { id = listBillActTrans.CqmtransId}, listBillActTrans);
        }

        // DELETE: api/ListBillActTrans/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteListBillActTrans(int id)
        {
            var listBillActTrans = await _context.ListBillActTrans.FindAsync(id);
            if (listBillActTrans == null)
            {
                return NotFound();
            }

            _context.ListBillActTrans.Remove(listBillActTrans);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ListBillActTransExists(int id)
        {
            return _context.ListBillActTrans.Any(e => e.CqmtransId == id);
        }
    }
}
