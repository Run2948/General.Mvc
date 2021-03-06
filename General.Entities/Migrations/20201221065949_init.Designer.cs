﻿// <auto-generated />
using System;
using General.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace General.Entities.Migrations
{
    [DbContext(typeof(GeneralDbContext))]
    [Migration("20201221065949_init")]
    partial class init
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "3.1.10")
                .HasAnnotation("Relational:MaxIdentifierLength", 64);

            modelBuilder.Entity("General.Entities.SysCategory", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Action")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<string>("Controller")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<string>("CssClass")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<string>("FatherID")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<string>("FatherResource")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<bool>("IsDisabled")
                        .HasColumnType("tinyint(1)");

                    b.Property<bool>("IsMenu")
                        .HasColumnType("tinyint(1)");

                    b.Property<string>("Name")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<string>("ResouceID")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<string>("RouteName")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<int>("Sort")
                        .HasColumnType("int");

                    b.Property<string>("SysResource")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.HasKey("Id");

                    b.ToTable("SysCategory");
                });

            modelBuilder.Entity("General.Entities.SysPermission", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("char(36)");

                    b.Property<int>("CategoryId")
                        .HasColumnType("int");

                    b.Property<DateTime>("CreationTime")
                        .HasColumnType("datetime(6)");

                    b.Property<Guid>("Creator")
                        .HasColumnType("char(36)");

                    b.Property<Guid>("RoleId")
                        .HasColumnType("char(36)");

                    b.HasKey("Id");

                    b.HasIndex("CategoryId");

                    b.HasIndex("Creator");

                    b.HasIndex("RoleId");

                    b.ToTable("SysPermission");
                });

            modelBuilder.Entity("General.Entities.SysRole", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("char(36)");

                    b.Property<DateTime>("CreationTime")
                        .HasColumnType("datetime(6)");

                    b.Property<Guid>("Creator")
                        .HasColumnType("char(36)");

                    b.Property<DateTime?>("ModifiedTime")
                        .HasColumnType("datetime(6)");

                    b.Property<Guid?>("Modifier")
                        .HasColumnType("char(36)");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("varchar(500) CHARACTER SET utf8mb4")
                        .HasMaxLength(500);

                    b.HasKey("Id");

                    b.HasIndex("Creator");

                    b.HasIndex("Modifier");

                    b.ToTable("SysRole");
                });

            modelBuilder.Entity("General.Entities.SysUser", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("char(36)");

                    b.Property<string>("Account")
                        .IsRequired()
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<DateTime?>("AllowLoginTime")
                        .HasColumnType("datetime(6)");

                    b.Property<byte[]>("Avatar")
                        .HasColumnType("longblob");

                    b.Property<DateTime>("CreationTime")
                        .HasColumnType("datetime(6)");

                    b.Property<Guid?>("Creator")
                        .HasColumnType("char(36)");

                    b.Property<DateTime?>("DeletedTime")
                        .HasColumnType("datetime(6)");

                    b.Property<string>("Email")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<bool>("Enabled")
                        .HasColumnType("tinyint(1)");

                    b.Property<bool>("IsAdmin")
                        .HasColumnType("tinyint(1)");

                    b.Property<bool>("IsDeleted")
                        .HasColumnType("tinyint(1)");

                    b.Property<DateTime?>("LastActivityTime")
                        .HasColumnType("datetime(6)");

                    b.Property<string>("LastIpAddress")
                        .HasColumnType("varchar(50) CHARACTER SET utf8mb4")
                        .HasMaxLength(50);

                    b.Property<DateTime?>("LastLoginTime")
                        .HasColumnType("datetime(6)");

                    b.Property<int>("LoginFailedNum")
                        .HasColumnType("int");

                    b.Property<bool>("LoginLock")
                        .HasColumnType("tinyint(1)");

                    b.Property<string>("MobilePhone")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<DateTime?>("ModifiedTime")
                        .HasColumnType("datetime(6)");

                    b.Property<Guid?>("Modifier")
                        .HasColumnType("char(36)");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<string>("Password")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<string>("Salt")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<string>("Sex")
                        .HasColumnType("varchar(2) CHARACTER SET utf8mb4")
                        .HasMaxLength(2);

                    b.HasKey("Id");

                    b.ToTable("SysUser");
                });

            modelBuilder.Entity("General.Entities.SysUserLoginLog", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("char(36)");

                    b.Property<string>("IpAddress")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<DateTime>("LoginTime")
                        .HasColumnType("datetime(6)");

                    b.Property<string>("Message")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<Guid>("UserId")
                        .HasColumnType("char(36)");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("SysUserLoginLog");
                });

            modelBuilder.Entity("General.Entities.SysUserRole", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("char(36)");

                    b.Property<Guid>("RoleId")
                        .HasColumnType("char(36)");

                    b.Property<Guid>("UserId")
                        .HasColumnType("char(36)");

                    b.HasKey("Id");

                    b.HasIndex("RoleId");

                    b.HasIndex("UserId");

                    b.ToTable("SysUserRole");
                });

            modelBuilder.Entity("General.Entities.SysUserToken", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("char(36)");

                    b.Property<DateTime>("ExpireTime")
                        .HasColumnType("datetime(6)");

                    b.Property<Guid>("SysUserId")
                        .HasColumnType("char(36)");

                    b.HasKey("Id");

                    b.HasIndex("SysUserId");

                    b.ToTable("SysUserToken");
                });

            modelBuilder.Entity("General.Entities.SysPermission", b =>
                {
                    b.HasOne("General.Entities.SysCategory", "Category")
                        .WithMany("SysPermissions")
                        .HasForeignKey("CategoryId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("General.Entities.SysUser", "SysUser")
                        .WithMany()
                        .HasForeignKey("Creator")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("General.Entities.SysRole", "SysRole")
                        .WithMany("SysPermission")
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("General.Entities.SysRole", b =>
                {
                    b.HasOne("General.Entities.SysUser", "SysUser")
                        .WithMany()
                        .HasForeignKey("Creator")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("General.Entities.SysUser", "SysUser1")
                        .WithMany()
                        .HasForeignKey("Modifier");
                });

            modelBuilder.Entity("General.Entities.SysUserLoginLog", b =>
                {
                    b.HasOne("General.Entities.SysUser", "SysUser")
                        .WithMany("SysUserLoginLogs")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("General.Entities.SysUserRole", b =>
                {
                    b.HasOne("General.Entities.SysRole", "SysRole")
                        .WithMany("SysUserRole")
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("General.Entities.SysUser", "SysUser")
                        .WithMany("SysUserRoles")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("General.Entities.SysUserToken", b =>
                {
                    b.HasOne("General.Entities.SysUser", "SysUser")
                        .WithMany("SysUserTokens")
                        .HasForeignKey("SysUserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });
#pragma warning restore 612, 618
        }
    }
}
