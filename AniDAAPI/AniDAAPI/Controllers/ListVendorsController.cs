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
    public class ListVendorsController : ControllerBase
    {
        private readonly PAAMRAdbContext _context;

        public ListVendorsController(PAAMRAdbContext context)
        {
            _context = context;
        }

        // GET: api/ListVendors
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ListVendors>>> GetListVendors()
        {
            return await _context.ListVendors.ToListAsync();
        }

        // GET: api/ListVendors/5
        [HttpGet("{VendorTypeId}")]
        public  IEnumerable<ListVendors> GetListVendors(int VendorTypeId)
        {
            var listVendors = _context.ListVendors.Where(e => e.VendTypeId == VendorTypeId).ToList();

          //  if (listVendors == null)
            //{
              //  return NotFound();
           // }

            return listVendors;
        }

        // PUT: api/ListVendors/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutListVendors(int id, ListVendors listVendors)
        {
            if (id != listVendors.VendorId)
            {
                return BadRequest();
            }

            _context.Entry(listVendors).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ListVendorsExists(id))
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

        // POST: api/ListVendors
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<ListVendors>> PostListVendors(ListVendors listVendors)
        {
            _context.ListVendors.Add(listVendors);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetListVendors", new { id = listVendors.VendorId }, listVendors);
        }

        // DELETE: api/ListVendors/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteListVendors(int id)
        {
            var listVendors = await _context.ListVendors.FindAsync(id);
            if (listVendors == null)
            {
                return NotFound();
            }

            _context.ListVendors.Remove(listVendors);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ListVendorsExists(int id)
        {
            return _context.ListVendors.Any(e => e.VendorId == id);
        }
    }
}
