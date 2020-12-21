using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;
using General.Core.Librs;

namespace General.Entities
{
    public class GeneralDbContext : DbContext
    {
        public GeneralDbContext(DbContextOptions options) : base(options)
        {

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // base.OnModelCreating(modelBuilder);
            var salt = EncryptorHelper.CreateSaltKey();
            modelBuilder.Entity<SysUser>().HasData(new SysUser()
            {
                Id = Guid.NewGuid(),
                Account = "admin",
                Name = "超级管理员",
                Salt = salt,
                Password = EncryptorHelper.GetMD5("123456" + salt),
                Enabled = true,
                IsAdmin = true,
                CreationTime = DateTime.Now,
                LoginFailedNum = 0,
                LoginLock = false,
                LastActivityTime = null,
                IsDeleted = false
            });
        }

        public DbSet<SysCategory> Categories { get; set; }
        public DbSet<SysUser> SysUsers { get; set; }
        public DbSet<SysUserToken> SysUserTokens { get; set; }
        public DbSet<SysUserLoginLog> SysUserLoginLogs { get; set; }
        public DbSet<SysUserRole> SysUserRoles { get; set; }
        public DbSet<SysPermission> SysPermissions { get; set; }

    }
}
