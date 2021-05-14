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
    public class ListVoyFileController : ControllerBase
    {
        private readonly PAAMRAdbContext _context;

        public ListVoyFileController(PAAMRAdbContext context)
        {
            _context = context;
        }

        // GET: api/ListVoyFile
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ListVoyFile>>> GetListVoyFiles()
        {
            return await _context.ListVoyFiles.ToListAsync();
        }

        // GET: api/ListVoyFile/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ListVoyFile>> GetListVoyFile(int id)
        {
            var listVoyFile = await _context.ListVoyFiles.FindAsync(id);

            if (listVoyFile == null)
            {
                return NotFound();
            }

            return listVoyFile;
        }

        // PUT: api/ListVoyFile/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutListVoyFile(int id, ListVoyFile listVoyFile)
        {
            if (id != listVoyFile.CustQuoteMasterId)
            {
                return BadRequest();
            }

           // _context.Entry(listVoyFile).State = EntityState.Modified;

            try
            {
                _context.Entry(listVoyFile).Property(x => x.PurposeCall).IsModified = true;
                _context.Entry(listVoyFile).Property(x => x.AgencyTypeDesc).IsModified = true;
                _context.Entry(listVoyFile).Property(x => x.VslEta).IsModified = true;
                _context.Entry(listVoyFile).Property(x => x.VslEtd).IsModified = true;
                _context.Entry(listVoyFile).Property(x => x.CallLocId).IsModified = true;
                _context.Entry(listVoyFile).Property(x => x.LastUpdatedBy).IsModified = true;
                _context.Entry(listVoyFile).Property(x => x.LastUpdatedDt).IsModified = true;

                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ListVoyFileExists(id))
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

        // POST: api/ListVoyFile
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<ListVoyFile>> PostListVoyFile(ListVoyFile listVoyFile)
        {
            _context.ListVoyFiles.Add(listVoyFile);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (ListVoyFileExists(listVoyFile.CustQuoteMasterId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetListVoyFile", new { id = listVoyFile.CustQuoteMasterId }, listVoyFile);
        }

        // DELETE: api/ListVoyFile/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteListVoyFile(int id)
        {
            var listVoyFile = await _context.ListVoyFiles.FindAsync(id);
            if (listVoyFile == null)
            {
                return NotFound();
            }

            _context.ListVoyFiles.Remove(listVoyFile);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ListVoyFileExists(int id)
        {
            return _context.ListVoyFiles.Any(e => e.CustQuoteMasterId == id);
        }
    }
}
