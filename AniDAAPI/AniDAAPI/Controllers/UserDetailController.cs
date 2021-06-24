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
    public class UserDetailController : ControllerBase
    {
        private readonly PAAMRAdbContext _context;

        public UserDetailController(PAAMRAdbContext context)
        {
            _context = context;
        }

        // GET: api/UserDetail
        [HttpGet]
        public async Task<ActionResult<IEnumerable<UserDetail>>> GetUserDetails()
        {
            return await _context.UserDetails.ToListAsync();
        }

        // GET: api/UserDetail/5
        [HttpGet("{id}")]
        public async Task<ActionResult<UserDetail>> GetUserDetail(int id)
        {
            var userDetail = await _context.UserDetails.FindAsync(id);

            if (userDetail == null)
            {
                return NotFound();
            }

            return userDetail;
        }
        [HttpGet("{id}/{imeiNo}")]
        public async Task<ActionResult<UserDetail>> GetUserDetail(int id, String imeiNo)
        {
            var userDetail = await _context.UserDetails.Where(c => c.UserId == id && c.Imeino.Equals(imeiNo) && c.IsActive.Equals(1)).FirstOrDefaultAsync();

            if (userDetail == null)
            {
                return NotFound();
            }

            return userDetail;
        }
        //Desktop Login
        [HttpGet("login/{logonName}/{password}")]
        public async Task<ActionResult<UserDetail>> AuthUserDetail(String logonName, String password)
        {
            var userDetail = await _context.UserDetails.Where(c => c.LogonName.Equals(logonName) && c.Password.Equals(password)).FirstOrDefaultAsync();

            if (userDetail == null)
            {
                return NotFound();
            }

            return userDetail;
        }


        // PUT: api/UserDetail/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutUserDetail(int id, UserDetail userDetail)
        {
            if (id != userDetail.UserId)
            {
                return BadRequest();
            }

            _context.Entry(userDetail).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UserDetailExists(id))
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

        // POST: api/UserDetail
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<UserDetail>> PostUserDetail(UserDetail userDetail)
        {
            _context.UserDetails.Add(userDetail);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetUserDetail", new { id = userDetail.UserId }, userDetail);
        }

        // DELETE: api/UserDetail/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUserDetail(int id)
        {
            var userDetail = await _context.UserDetails.FindAsync(id);
            if (userDetail == null)
            {
                return NotFound();
            }

            _context.UserDetails.Remove(userDetail);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool UserDetailExists(int id)
        {
            return _context.UserDetails.Any(e => e.UserId == id);
        }
    }
}
