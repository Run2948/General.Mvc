using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace General.Entities.Migrations
{
    public partial class init : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "SysCategory",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Name = table.Column<string>(nullable: true),
                    IsMenu = table.Column<bool>(nullable: false),
                    SysResource = table.Column<string>(nullable: true),
                    ResouceID = table.Column<string>(nullable: true),
                    FatherResource = table.Column<string>(nullable: true),
                    FatherID = table.Column<string>(nullable: true),
                    Controller = table.Column<string>(nullable: true),
                    Action = table.Column<string>(nullable: true),
                    RouteName = table.Column<string>(nullable: true),
                    CssClass = table.Column<string>(nullable: true),
                    Sort = table.Column<int>(nullable: false),
                    IsDisabled = table.Column<bool>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SysCategory", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "SysUser",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    Account = table.Column<string>(nullable: false),
                    Name = table.Column<string>(nullable: false),
                    Email = table.Column<string>(nullable: true),
                    MobilePhone = table.Column<string>(nullable: true),
                    Password = table.Column<string>(nullable: true),
                    Salt = table.Column<string>(nullable: true),
                    Sex = table.Column<string>(maxLength: 2, nullable: true),
                    Enabled = table.Column<bool>(nullable: false),
                    IsAdmin = table.Column<bool>(nullable: false),
                    CreationTime = table.Column<DateTime>(nullable: false),
                    LoginFailedNum = table.Column<int>(nullable: false),
                    AllowLoginTime = table.Column<DateTime>(nullable: true),
                    LoginLock = table.Column<bool>(nullable: false),
                    LastLoginTime = table.Column<DateTime>(nullable: true),
                    LastIpAddress = table.Column<string>(maxLength: 50, nullable: true),
                    LastActivityTime = table.Column<DateTime>(nullable: true),
                    IsDeleted = table.Column<bool>(nullable: false),
                    DeletedTime = table.Column<DateTime>(nullable: true),
                    ModifiedTime = table.Column<DateTime>(nullable: true),
                    Modifier = table.Column<Guid>(nullable: true),
                    Creator = table.Column<Guid>(nullable: true),
                    Avatar = table.Column<byte[]>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SysUser", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "SysRole",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    Name = table.Column<string>(maxLength: 500, nullable: false),
                    Creator = table.Column<Guid>(nullable: false),
                    CreationTime = table.Column<DateTime>(nullable: false),
                    Modifier = table.Column<Guid>(nullable: true),
                    ModifiedTime = table.Column<DateTime>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SysRole", x => x.Id);
                    table.ForeignKey(
                        name: "FK_SysRole_SysUser_Creator",
                        column: x => x.Creator,
                        principalTable: "SysUser",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_SysRole_SysUser_Modifier",
                        column: x => x.Modifier,
                        principalTable: "SysUser",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "SysUserLoginLog",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    UserId = table.Column<Guid>(nullable: false),
                    IpAddress = table.Column<string>(nullable: true),
                    LoginTime = table.Column<DateTime>(nullable: false),
                    Message = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SysUserLoginLog", x => x.Id);
                    table.ForeignKey(
                        name: "FK_SysUserLoginLog_SysUser_UserId",
                        column: x => x.UserId,
                        principalTable: "SysUser",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "SysUserToken",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    SysUserId = table.Column<Guid>(nullable: false),
                    ExpireTime = table.Column<DateTime>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SysUserToken", x => x.Id);
                    table.ForeignKey(
                        name: "FK_SysUserToken_SysUser_SysUserId",
                        column: x => x.SysUserId,
                        principalTable: "SysUser",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "SysPermission",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    CategoryId = table.Column<int>(nullable: false),
                    RoleId = table.Column<Guid>(nullable: false),
                    Creator = table.Column<Guid>(nullable: false),
                    CreationTime = table.Column<DateTime>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SysPermission", x => x.Id);
                    table.ForeignKey(
                        name: "FK_SysPermission_SysCategory_CategoryId",
                        column: x => x.CategoryId,
                        principalTable: "SysCategory",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_SysPermission_SysUser_Creator",
                        column: x => x.Creator,
                        principalTable: "SysUser",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_SysPermission_SysRole_RoleId",
                        column: x => x.RoleId,
                        principalTable: "SysRole",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "SysUserRole",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    RoleId = table.Column<Guid>(nullable: false),
                    UserId = table.Column<Guid>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SysUserRole", x => x.Id);
                    table.ForeignKey(
                        name: "FK_SysUserRole_SysRole_RoleId",
                        column: x => x.RoleId,
                        principalTable: "SysRole",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_SysUserRole_SysUser_UserId",
                        column: x => x.UserId,
                        principalTable: "SysUser",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_SysPermission_CategoryId",
                table: "SysPermission",
                column: "CategoryId");

            migrationBuilder.CreateIndex(
                name: "IX_SysPermission_Creator",
                table: "SysPermission",
                column: "Creator");

            migrationBuilder.CreateIndex(
                name: "IX_SysPermission_RoleId",
                table: "SysPermission",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "IX_SysRole_Creator",
                table: "SysRole",
                column: "Creator");

            migrationBuilder.CreateIndex(
                name: "IX_SysRole_Modifier",
                table: "SysRole",
                column: "Modifier");

            migrationBuilder.CreateIndex(
                name: "IX_SysUserLoginLog_UserId",
                table: "SysUserLoginLog",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_SysUserRole_RoleId",
                table: "SysUserRole",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "IX_SysUserRole_UserId",
                table: "SysUserRole",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_SysUserToken_SysUserId",
                table: "SysUserToken",
                column: "SysUserId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "SysPermission");

            migrationBuilder.DropTable(
                name: "SysUserLoginLog");

            migrationBuilder.DropTable(
                name: "SysUserRole");

            migrationBuilder.DropTable(
                name: "SysUserToken");

            migrationBuilder.DropTable(
                name: "SysCategory");

            migrationBuilder.DropTable(
                name: "SysRole");

            migrationBuilder.DropTable(
                name: "SysUser");
        }
    }
}
