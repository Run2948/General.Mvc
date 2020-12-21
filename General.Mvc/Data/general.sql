/*
 Navicat Premium Data Transfer
 Source Server         : localhost
 Source Server Type    : SQL Server
 Source Server Version : 14003048
 Source Host           : localhost:1433
 Source Catalog        : General
 Source Schema         : dbo
 Target Server Type    : SQL Server
 Target Server Version : 14003048
 File Encoding         : 65001
 Date: 16/04/2019 10:13:14
*/
 USE [master]
GO
CREATE DATABASE [General]
USE [General]
GO
 -- ----------------------------
-- Table structure for ActivityLog
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog]') AND type IN ('U'))
	DROP TABLE [dbo].[ActivityLog]
GO
 CREATE TABLE [dbo].[ActivityLog] (
  [Id] uniqueidentifier DEFAULT (newid()) NOT NULL,
  [ActivityName] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [Method] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [Comment] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [UserId] uniqueidentifier  NULL,
  [CreationTime] datetime DEFAULT (getdate()) NOT NULL
)
GO
 ALTER TABLE [dbo].[ActivityLog] SET (LOCK_ESCALATION = TABLE)
GO
 -- ----------------------------
-- Table structure for Category
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Category]') AND type IN ('U'))
	DROP TABLE [dbo].[Category]
GO
 CREATE TABLE [dbo].[Category] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [Name] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [IsMenu] bit  NOT NULL,
  [SysResource] nvarchar(400) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [ResouceID] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [FatherResource] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [FatherID] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [Controller] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [Action] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [RouteName] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [CssClass] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [Sort] int DEFAULT ((100)) NOT NULL,
  [IsDisabled] bit DEFAULT ((0)) NOT NULL
)
GO
 ALTER TABLE [dbo].[Category] SET (LOCK_ESCALATION = TABLE)
GO
 EXEC sp_addextendedproperty
'MS_Description', N'禁用',
'SCHEMA', N'dbo',
'TABLE', N'Category',
'COLUMN', N'IsDisabled'
GO
 -- ----------------------------
-- Records of Category
-- ----------------------------
SET IDENTITY_INSERT [dbo].[Category] ON
GO
 INSERT INTO [dbo].[Category] ([Id], [Name], [IsMenu], [SysResource], [ResouceID], [FatherResource], [FatherID], [Controller], [Action], [RouteName], [CssClass], [Sort], [IsDisabled]) VALUES (N'1', N'系统管理', N'1', N'General.Mvc.Areas.Admin.Controllers.SystemManageController', N'0313551edcd115ae48eb7a6374b2c14c', NULL, N'', NULL, NULL, NULL, N'menu-icon fa fa-desktop', N'100', N'0')
GO
 INSERT INTO [dbo].[Category] ([Id], [Name], [IsMenu], [SysResource], [ResouceID], [FatherResource], [FatherID], [Controller], [Action], [RouteName], [CssClass], [Sort], [IsDisabled]) VALUES (N'3', N'系统用户', N'1', N'General.Mvc.Areas.Admin.Controllers.UserController.UserIndex', N'f331e06811f2c0d5934926b114e5b24a', N'General.Mvc.Areas.Admin.Controllers.SystemManageController', N'0313551edcd115ae48eb7a6374b2c14c', N'User', N'UserIndex', N'userIndex', N'menu-icon fa fa-caret-right', N'0', N'0')
GO
 INSERT INTO [dbo].[Category] ([Id], [Name], [IsMenu], [SysResource], [ResouceID], [FatherResource], [FatherID], [Controller], [Action], [RouteName], [CssClass], [Sort], [IsDisabled]) VALUES (N'1002', N'角色列表', N'1', N'General.Mvc.Areas.Admin.Controllers.RoleController.RoleIndex', N'1aa866003b08f4f053d59ec235f13bca', N'General.Mvc.Areas.Admin.Controllers.SystemManageController', N'0313551edcd115ae48eb7a6374b2c14c', N'Role', N'RoleIndex', N'roleIndex', N'menu-icon fa fa-caret-right', N'1', N'0')
GO
 INSERT INTO [dbo].[Category] ([Id], [Name], [IsMenu], [SysResource], [ResouceID], [FatherResource], [FatherID], [Controller], [Action], [RouteName], [CssClass], [Sort], [IsDisabled]) VALUES (N'1003', N'新增、修改角色', N'0', N'General.Mvc.Areas.Admin.Controllers.RoleController.EditRole', N'0ef642448f09a922a11d194715d8808d', N'General.Mvc.Areas.Admin.Controllers.RoleController.RoleIndex', N'1aa866003b08f4f053d59ec235f13bca', N'Role', N'EditRole', N'editRole', NULL, N'100', N'0')
GO
 INSERT INTO [dbo].[Category] ([Id], [Name], [IsMenu], [SysResource], [ResouceID], [FatherResource], [FatherID], [Controller], [Action], [RouteName], [CssClass], [Sort], [IsDisabled]) VALUES (N'1004', N'删除角色', N'0', N'General.Mvc.Areas.Admin.Controllers.RoleController.DeleteRole', N'4fb09bfa5c7d8a66393268fc2120f2e0', N'General.Mvc.Areas.Admin.Controllers.RoleController.RoleIndex', N'1aa866003b08f4f053d59ec235f13bca', N'Role', N'DeleteRole', N'deleteRole', NULL, N'100', N'0')
GO
 INSERT INTO [dbo].[Category] ([Id], [Name], [IsMenu], [SysResource], [ResouceID], [FatherResource], [FatherID], [Controller], [Action], [RouteName], [CssClass], [Sort], [IsDisabled]) VALUES (N'1005', N'角色权限设置', N'0', N'General.Mvc.Areas.Admin.Controllers.RoleController.RolePermission', N'19b29a1929b234925c014223a40e3698', N'General.Mvc.Areas.Admin.Controllers.RoleController.RoleIndex', N'1aa866003b08f4f053d59ec235f13bca', N'Role', N'RolePermission', N'rolePermission', NULL, N'100', N'0')
GO
 INSERT INTO [dbo].[Category] ([Id], [Name], [IsMenu], [SysResource], [ResouceID], [FatherResource], [FatherID], [Controller], [Action], [RouteName], [CssClass], [Sort], [IsDisabled]) VALUES (N'1006', N'编辑系统用户', N'0', N'General.Mvc.Areas.Admin.Controllers.UserController.EditUser', N'ed09a0415daaabc39b36f76b45b24577', N'General.Mvc.Areas.Admin.Controllers.UserController.UserIndex', N'f331e06811f2c0d5934926b114e5b24a', N'User', N'EditUser', N'editUser', NULL, N'100', N'0')
GO
 INSERT INTO [dbo].[Category] ([Id], [Name], [IsMenu], [SysResource], [ResouceID], [FatherResource], [FatherID], [Controller], [Action], [RouteName], [CssClass], [Sort], [IsDisabled]) VALUES (N'1007', N'设置启用与禁用账号', N'0', N'General.Mvc.Areas.Admin.Controllers.UserController.Enabled', N'283b742f8f1ea4f6d837b0b5a2c30013', N'General.Mvc.Areas.Admin.Controllers.UserController.UserIndex', N'f331e06811f2c0d5934926b114e5b24a', N'User', N'Enabled', N'enabled', NULL, N'100', N'0')
GO
 INSERT INTO [dbo].[Category] ([Id], [Name], [IsMenu], [SysResource], [ResouceID], [FatherResource], [FatherID], [Controller], [Action], [RouteName], [CssClass], [Sort], [IsDisabled]) VALUES (N'1008', N'设置登录锁解锁与锁定', N'0', N'General.Mvc.Areas.Admin.Controllers.UserController.LoginLock', N'fa355a2c51696ddce01f157e3625aad7', N'General.Mvc.Areas.Admin.Controllers.UserController.UserIndex', N'f331e06811f2c0d5934926b114e5b24a', N'User', N'LoginLock', N'loginLock', NULL, N'100', N'0')
GO
 INSERT INTO [dbo].[Category] ([Id], [Name], [IsMenu], [SysResource], [ResouceID], [FatherResource], [FatherID], [Controller], [Action], [RouteName], [CssClass], [Sort], [IsDisabled]) VALUES (N'1009', N'删除用户', N'0', N'General.Mvc.Areas.Admin.Controllers.UserController.DeleteUser', N'e167a84b5d93cf399c64b215d78f9a18', N'General.Mvc.Areas.Admin.Controllers.UserController.UserIndex', N'f331e06811f2c0d5934926b114e5b24a', N'User', N'DeleteUser', N'deleteUser', NULL, N'100', N'0')
GO
 INSERT INTO [dbo].[Category] ([Id], [Name], [IsMenu], [SysResource], [ResouceID], [FatherResource], [FatherID], [Controller], [Action], [RouteName], [CssClass], [Sort], [IsDisabled]) VALUES (N'1010', N'重置用密码', N'0', N'General.Mvc.Areas.Admin.Controllers.UserController.ResetPassword', N'f3257be800d6f19f52962da399a81c0e', N'General.Mvc.Areas.Admin.Controllers.UserController.UserIndex', N'f331e06811f2c0d5934926b114e5b24a', N'User', N'ResetPassword', N'resetPassword', NULL, N'100', N'0')
GO
 SET IDENTITY_INSERT [dbo].[Category] OFF
GO
 -- ----------------------------
-- Table structure for Setting
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Setting]') AND type IN ('U'))
	DROP TABLE [dbo].[Setting]
GO
 CREATE TABLE [dbo].[Setting] (
  [Id] uniqueidentifier DEFAULT (newid()) NOT NULL,
  [Name] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [Value] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NOT NULL
)
GO
 ALTER TABLE [dbo].[Setting] SET (LOCK_ESCALATION = TABLE)
GO
 -- ----------------------------
-- Table structure for SysDomain
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[SysDomain]') AND type IN ('U'))
	DROP TABLE [dbo].[SysDomain]
GO
 CREATE TABLE [dbo].[SysDomain] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [DomainType] int  NOT NULL,
  [Domain] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [CreationTime] datetime DEFAULT (getdate()) NOT NULL
)
GO
 ALTER TABLE [dbo].[SysDomain] SET (LOCK_ESCALATION = TABLE)
GO
 -- ----------------------------
-- Table structure for SysLog
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[SysLog]') AND type IN ('U'))
	DROP TABLE [dbo].[SysLog]
GO
 CREATE TABLE [dbo].[SysLog] (
  [Id] uniqueidentifier DEFAULT (newid()) NOT NULL,
  [Level] int  NOT NULL,
  [ShortMessage] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [FullMessage] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [IpAddress] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [PageUrl] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [ReferrerUrl] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [CreationTime] datetime DEFAULT (getdate()) NOT NULL
)
GO
 ALTER TABLE [dbo].[SysLog] SET (LOCK_ESCALATION = TABLE)
GO
 -- ----------------------------
-- Records of SysLog
-- ----------------------------
INSERT INTO [dbo].[SysLog] VALUES (N'A26105F3-175F-452F-ACB1-19BA42FB1075', N'40', N'未将对象引用设置到对象的实例。', N'未将对象引用设置到对象的实例。', N'127.0.0.1', N'http://localhost:55503/admin', N'/admin', N'2017-09-05 15:47:26.387')
GO
 INSERT INTO [dbo].[SysLog] VALUES (N'120676CC-C9EC-47CC-B96E-459EBEC155C1', N'40', N'F:\gitstorage\Mangix.Mvc\Mangix.Mvc\Mangix.Admin\Areas\admin\Views\Shared\_NavbarPartial.cshtml(47): error CS1061: ''IWorkContext'' does not contain a definition for ''MyDescriperes'' and no extension method ''MyDescriperes'' accepting a first argument of type ''IWorkContext'' could be found (are you missing a using directive or an assembly reference?)', N'F:\gitstorage\Mangix.Mvc\Mangix.Mvc\Mangix.Admin\Areas\admin\Views\Shared\_NavbarPartial.cshtml(47): error CS1061: ''IWorkContext'' does not contain a definition for ''MyDescriperes'' and no extension method ''MyDescriperes'' accepting a first argument of type ''IWorkContext'' could be found (are you missing a using directive or an assembly reference?)', N'127.0.0.1', N'http://localhost:55503/admin/home', N'/admin', N'2017-09-05 15:39:57.703')
GO
 INSERT INTO [dbo].[SysLog] VALUES (N'CA8604F9-B201-4425-A4D8-538DB82C657B', N'20', N'Admin 系统启动', N'', N'', N'', N'', N'2017-09-05 15:51:28.323')
GO
 INSERT INTO [dbo].[SysLog] VALUES (N'84689813-BA66-4571-91C7-6E1E7ECD81B8', N'20', N'Admin 系统启动', N'', N'', N'', N'', N'2017-07-09 22:11:09.467')
GO
 INSERT INTO [dbo].[SysLog] VALUES (N'19F410F3-230F-4E18-A069-769DC2DD3D26', N'40', N'未将对象引用设置到对象的实例。', N'未将对象引用设置到对象的实例。', N'127.0.0.1', N'http://localhost:55503/admin', N'/admin', N'2017-09-05 15:39:45.173')
GO
 INSERT INTO [dbo].[SysLog] VALUES (N'24244EFD-A8C9-4C22-AB58-81C76452F7E7', N'20', N'Admin 系统启动', N'', N'', N'', N'', N'2017-09-05 15:47:04.860')
GO
 INSERT INTO [dbo].[SysLog] VALUES (N'4B5AC0DE-3384-4D0B-BA25-8E8F78AEC7E4', N'40', N'值不能为 null。
参数名: source', N'值不能为 null。
参数名: source', N'127.0.0.1', N'http://localhost:55503/admin/home', N'/admin', N'2017-09-05 15:47:47.037')
GO
 INSERT INTO [dbo].[SysLog] VALUES (N'B4ABF9C2-F832-4DEB-9330-927768B70BCC', N'20', N'Admin 系统启动', N'', N'', N'', N'', N'2017-07-09 22:06:12.737')
GO
 INSERT INTO [dbo].[SysLog] VALUES (N'19775571-77BE-464A-B9D8-A92AE7F62862', N'20', N'Admin 系统启动', N'', N'', N'', N'', N'2017-09-05 15:39:25.407')
GO
 INSERT INTO [dbo].[SysLog] VALUES (N'C71078D9-B11A-457A-B1F2-B3B19A8713D8', N'20', N'Admin 系统启动', N'', N'', N'', N'', N'2017-09-05 15:53:29.720')
GO
 INSERT INTO [dbo].[SysLog] VALUES (N'02C13948-2E5C-4C32-BC4D-D2EB5A7162C4', N'20', N'Admin 系统启动', N'', N'', N'', N'', N'2017-07-09 22:07:40.807')
GO
 INSERT INTO [dbo].[SysLog] VALUES (N'C447DDD1-4E83-44D0-AE67-D2EC8A02004B', N'20', N'Admin 系统启动', N'', N'', N'', N'', N'2017-07-09 22:01:32.860')
GO
 INSERT INTO [dbo].[SysLog] VALUES (N'75B942C3-9278-47B5-BB22-E98FB889C203', N'40', N'未将对象引用设置到对象的实例。', N'未将对象引用设置到对象的实例。', N'127.0.0.1', N'http://localhost:55503/admin', N'/admin', N'2017-07-09 22:12:23.687')
GO
 INSERT INTO [dbo].[SysLog] VALUES (N'C7437B74-B2A0-439E-9489-FBF654833793', N'40', N'未将对象引用设置到对象的实例。', N'未将对象引用设置到对象的实例。', N'127.0.0.1', N'http://localhost:55503/admin', N'/admin', N'2017-07-09 22:12:27.117')
GO
 -- ----------------------------
-- Table structure for SysPermission
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[SysPermission]') AND type IN ('U'))
	DROP TABLE [dbo].[SysPermission]
GO
 CREATE TABLE [dbo].[SysPermission] (
  [Id] uniqueidentifier DEFAULT (newid()) NOT NULL,
  [CategoryId] int  NOT NULL,
  [RoleId] uniqueidentifier  NOT NULL,
  [Creator] uniqueidentifier  NOT NULL,
  [CreationTime] datetime DEFAULT (getdate()) NOT NULL
)
GO
 ALTER TABLE [dbo].[SysPermission] SET (LOCK_ESCALATION = TABLE)
GO
 EXEC sp_addextendedproperty
'MS_Description', N'角色权限数据列表',
'SCHEMA', N'dbo',
'TABLE', N'SysPermission'
GO
 -- ----------------------------
-- Records of SysPermission
-- ----------------------------
INSERT INTO [dbo].[SysPermission] VALUES (N'B304412A-1C17-4ADA-B50E-0C2B188B1A60', N'1004', N'264C4157-8414-4B9D-89C0-5671B0F61257', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-18 00:23:41.527')
GO
 INSERT INTO [dbo].[SysPermission] VALUES (N'0E2185C2-07CE-4385-B6B3-2614BD000F8F', N'1', N'264C4157-8414-4B9D-89C0-5671B0F61257', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-18 00:21:18.283')
GO
 INSERT INTO [dbo].[SysPermission] VALUES (N'3BBD70E3-97E1-43A9-9492-3A8E21E2E508', N'1003', N'264C4157-8414-4B9D-89C0-5671B0F61257', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-18 00:23:41.523')
GO
 INSERT INTO [dbo].[SysPermission] VALUES (N'A51D14CB-F21E-4D1A-91F1-424BBF9874D0', N'1005', N'264C4157-8414-4B9D-89C0-5671B0F61257', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-18 00:23:41.527')
GO
 INSERT INTO [dbo].[SysPermission] VALUES (N'A5584192-702D-4649-965C-7A9402ADA2A0', N'1002', N'264C4157-8414-4B9D-89C0-5671B0F61257', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-18 00:23:41.520')
GO
 INSERT INTO [dbo].[SysPermission] VALUES (N'64D2E5FC-C88A-420C-B27B-E2FC3823C406', N'3', N'264C4157-8414-4B9D-89C0-5671B0F61257', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-18 00:23:41.517')
GO
 -- ----------------------------
-- Table structure for SysRole
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[SysRole]') AND type IN ('U'))
	DROP TABLE [dbo].[SysRole]
GO
 CREATE TABLE [dbo].[SysRole] (
  [Id] uniqueidentifier DEFAULT (newid()) NOT NULL,
  [Name] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [Creator] uniqueidentifier  NOT NULL,
  [CreationTime] datetime DEFAULT (getdate()) NOT NULL,
  [Modifier] uniqueidentifier  NULL,
  [ModifiedTime] datetime  NULL
)
GO
 ALTER TABLE [dbo].[SysRole] SET (LOCK_ESCALATION = TABLE)
GO
 -- ----------------------------
-- Records of SysRole
-- ----------------------------
INSERT INTO [dbo].[SysRole] VALUES (N'264C4157-8414-4B9D-89C0-5671B0F61257', N'管理员', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-08 16:21:37.753', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-17 23:35:11.803')
GO
 INSERT INTO [dbo].[SysRole] VALUES (N'32CE6463-25E7-4B8E-ACD0-D8CA262270E4', N'编辑人员', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-17 01:07:22.333', NULL, NULL)
GO
 -- ----------------------------
-- Table structure for SysStore
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[SysStore]') AND type IN ('U'))
	DROP TABLE [dbo].[SysStore]
GO
 CREATE TABLE [dbo].[SysStore] (
  [Id] uniqueidentifier DEFAULT (newid()) NOT NULL,
  [Name] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [SslEnabled] bit  NOT NULL,
  [Disabled] bit  NOT NULL,
  [IconClass] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [CompanyName] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [Creator] uniqueidentifier  NOT NULL,
  [CreationTime] datetime DEFAULT (getdate()) NOT NULL,
  [Modifier] uniqueidentifier  NULL,
  [ModifiedTime] datetime  NULL
)
GO
 ALTER TABLE [dbo].[SysStore] SET (LOCK_ESCALATION = TABLE)
GO
 -- ----------------------------
-- Table structure for SysUser
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[SysUser]') AND type IN ('U'))
	DROP TABLE [dbo].[SysUser]
GO
 CREATE TABLE [dbo].[SysUser] (
  [Id] uniqueidentifier DEFAULT (newid()) NOT NULL,
  [Account] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [Name] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [Email] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [MobilePhone] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [Password] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [Salt] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [Sex] nvarchar(2) COLLATE Chinese_PRC_CI_AS  NULL,
  [Enabled] bit DEFAULT ((1)) NOT NULL,
  [IsAdmin] bit DEFAULT ((0)) NOT NULL,
  [CreationTime] datetime DEFAULT (getdate()) NOT NULL,
  [LoginFailedNum] int DEFAULT ((0)) NOT NULL,
  [AllowLoginTime] datetime  NULL,
  [LoginLock] bit DEFAULT ((0)) NOT NULL,
  [LastLoginTime] datetime  NULL,
  [LastIpAddress] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [LastActivityTime] datetime  NULL,
  [IsDeleted] bit DEFAULT ((0)) NOT NULL,
  [DeletedTime] datetime  NULL,
  [ModifiedTime] datetime  NULL,
  [Modifier] uniqueidentifier  NULL,
  [Creator] uniqueidentifier  NULL,
  [Avatar] image  NULL
)
GO
 ALTER TABLE [dbo].[SysUser] SET (LOCK_ESCALATION = TABLE)
GO
 -- ----------------------------
-- Records of SysUser
-- ----------------------------
INSERT INTO [dbo].[SysUser] VALUES (N'D5B9B094-F5CD-47E4-8E6D-054730883317', N'sdfdssdd', N'sdsd', NULL, NULL, N'ebb2ec43813cc013e7290a007f78772d', N'VemxiiJlhlEG3fN2yFH+1ar1coTYR4TS2+Lb9zYvJTA=', NULL, N'1', N'0', N'2017-10-26 11:49:15.247', N'0', NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, N'0F42C190-D965-43F8-96F6-865D4DBB0A41', NULL)
GO
 INSERT INTO [dbo].[SysUser] VALUES (N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'admin', N'超级管理员', NULL, NULL, N'161e7675716c353c9673322b423acccd', N'tmSYU03KOXqEwjLPgG8nDV7CK8maQUPFA/czwfV3orI=', N'', N'1', N'1', N'2017-07-09 22:10:01.837', N'0', NULL, N'0', N'2017-11-07 14:20:15.153', N'', N'2017-09-05 15:53:44.557', N'0', NULL, N'2017-09-05 15:47:26.310', NULL, NULL, NULL)
GO
 -- ----------------------------
-- Table structure for SysUserLoginLog
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[SysUserLoginLog]') AND type IN ('U'))
	DROP TABLE [dbo].[SysUserLoginLog]
GO
 CREATE TABLE [dbo].[SysUserLoginLog] (
  [Id] uniqueidentifier  NOT NULL,
  [UserId] uniqueidentifier  NOT NULL,
  [IpAddress] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [LoginTime] datetime  NOT NULL,
  [Message] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NOT NULL
)
GO
 ALTER TABLE [dbo].[SysUserLoginLog] SET (LOCK_ESCALATION = TABLE)
GO
 -- ----------------------------
-- Records of SysUserLoginLog
-- ----------------------------
INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'60A1C716-8ECF-4CA3-9FC5-0D6B492DAD55', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-11-07 14:20:15.153', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'1F06914E-7820-4DA6-A560-1CB72B40B281', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-24 22:25:26.317', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'87B9A61D-A482-46AB-89CF-247298FAF460', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-08 00:32:55.153', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'BA914C67-BE0C-4171-88EA-2B6B37592B87', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-07 22:40:02.930', N'登录：密码错误')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'685C8474-630A-4B34-AD73-2D4458400185', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-08 00:29:56.927', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'B5667710-0249-4AE8-8B91-2DD1BCFB6327', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-08 15:58:38.867', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'AFA1818E-46BB-4FD9-8939-303ABBF10859', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-08 00:30:34.527', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'D1C87FC2-F109-4656-A2FE-30F9EAD559AC', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-24 23:11:38.137', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'E6960283-94B7-4783-A4EB-311C1A7FA4E4', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-11-07 14:20:03.873', N'登录：密码错误')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'723E5568-E4A0-4FA8-8A10-3FD64A9590EE', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-08 00:29:42.290', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'21073E98-FF04-4328-AC63-5A0BB54A3A40', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-10 00:21:35.323', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'FC73AE7D-ED0B-45C5-854F-5A6FB80E5946', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-24 22:25:23.150', N'登录：密码错误')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'505FEB19-9236-4E84-81F9-65BD00552B19', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-07 22:40:22.537', N'登录：密码错误')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'8E749D16-55EA-4098-A2B9-74C22EB9AA9E', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-08 00:30:20.607', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'5039928D-BBFE-4859-AFD8-84146C603E5A', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'127.0.0.1', N'2017-07-09 22:12:27.090', N'登入：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'B9D414F4-C13A-4F1C-BBB6-87A9FD36CEB2', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'127.0.0.1', N'2017-09-05 15:39:45.120', N'登入：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'6BA9A348-0C9C-4A7D-B9E4-8DAADB85E1F1', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-08 00:29:19.367', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'65603F5C-0DE4-4749-B0A5-92D504D5D8D7', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-07 22:40:27.930', N'登录：密码错误')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'855ACA4D-B959-47C5-82DE-9853D7DB9A66', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-15 00:46:46.750', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'474290C9-E885-4928-ABC5-995B4D05B31D', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-08 09:44:04.863', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'C8837AEC-0AA3-4806-A328-9A92E057A39F', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'127.0.0.1', N'2017-07-09 22:12:23.623', N'登入：失败')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'A2921DC5-9D02-44C6-A057-9D586B7000CE', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-17 00:41:47.087', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'565B7D61-C43C-4B63-94F1-A44FD0EE815E', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-08 15:10:14.117', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'296593EF-837A-4C3A-91D7-A4A746674CB7', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-07 22:40:25.493', N'登录：密码错误')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'E1C5D96F-4C08-41B7-8CF5-AE691FF0F07F', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-11-07 14:20:09.720', N'登录：密码错误')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'F9D15C37-0E5A-4365-934E-AF2008BFB3CF', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-17 00:47:39.340', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'8ABAF588-98F8-4831-A6BD-B1D539C2912E', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-07 22:40:30.620', N'登录：密码错误')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'0D947394-2B1A-49F7-B0A2-B2B82E34C2B7', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'127.0.0.1', N'2017-09-05 15:47:26.307', N'登入：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'3925B2C2-E425-48A7-926C-C000A8F1CFD8', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-08 00:30:23.600', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'7EE83EB4-79EC-4F0C-BAFF-D40EBADD1F8D', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-08 00:14:43.417', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'3EF8D590-540C-466A-9A06-D659DC147B13', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-11-07 14:19:53.057', N'登录：密码错误')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'C530645E-E55E-42DD-897C-D8D253686E98', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-15 01:22:16.493', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'EBF66D31-80E3-45D6-B10D-DC763AA40C22', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-07 22:41:51.540', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'9D01CFF9-4A33-4B11-A9C1-DCCD866A045D', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-24 22:25:22.097', N'登录：密码错误')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'E18EFFF4-C961-4ADE-9C7D-DE8978FA2DB0', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-17 23:35:04.653', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'7A6BC9CC-A1AA-4880-9F09-E0AB63F4EE7D', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-08 15:57:34.847', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'F7EA91DB-C719-4354-95FA-EAB7DAA83E14', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-26 09:21:03.467', N'登录：成功')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'0D7CE0DB-D78F-4CC4-8AE5-EDB8197AC188', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-07 22:40:16.887', N'登录：密码错误')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'1C227698-ABDF-4958-8DD0-F02E9821594B', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-10-08 00:29:50.530', N'登录：密码错误')
GO
 INSERT INTO [dbo].[SysUserLoginLog] VALUES (N'AB7AADB4-181C-4C6F-9774-F9B0DF973C07', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'', N'2017-11-07 14:19:58.090', N'登录：密码错误')
GO
 -- ----------------------------
-- Table structure for SysUserRole
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[SysUserRole]') AND type IN ('U'))
	DROP TABLE [dbo].[SysUserRole]
GO
 CREATE TABLE [dbo].[SysUserRole] (
  [Id] uniqueidentifier DEFAULT (newid()) NOT NULL,
  [RoleId] uniqueidentifier  NOT NULL,
  [UserId] uniqueidentifier  NOT NULL
)
GO
 ALTER TABLE [dbo].[SysUserRole] SET (LOCK_ESCALATION = TABLE)
GO
 -- ----------------------------
-- Table structure for SysUserToken
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[SysUserToken]') AND type IN ('U'))
	DROP TABLE [dbo].[SysUserToken]
GO
 CREATE TABLE [dbo].[SysUserToken] (
  [Id] uniqueidentifier  NOT NULL,
  [SysUserId] uniqueidentifier  NOT NULL,
  [ExpireTime] datetime  NOT NULL
)
GO
 ALTER TABLE [dbo].[SysUserToken] SET (LOCK_ESCALATION = TABLE)
GO
 -- ----------------------------
-- Records of SysUserToken
-- ----------------------------
INSERT INTO [dbo].[SysUserToken] VALUES (N'32687123-409C-41E5-B328-09A62E9255AB', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-23 00:30:23.600')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'B3990295-2E72-412E-A11D-1BCC11937649', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-23 00:30:34.527')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'21513F8D-5A6A-4EC7-8FCB-2CDD16DD91B6', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-09-20 15:47:26.390')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'5DDCF78A-EF96-4169-BE98-32B28D312236', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-23 00:29:19.370')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'15C6C575-1420-4973-9C2C-345520807A39', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-11-22 14:20:15.153')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'49A3704D-ABB5-4770-833D-3C90C252A0EB', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-11-08 23:11:38.137')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'49A5047A-DD15-4950-BC5A-3D5D54064C32', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-23 00:29:56.927')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'A47CA048-D664-46D6-8F52-48DB3C3F1733', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-23 00:14:43.417')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'87E1689B-E9E8-42E0-A919-4AE292828B1D', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-23 00:30:20.607')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'9B263763-7474-454D-92D2-523AD5C47BC2', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-11-10 09:21:03.467')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'CE1762E1-54AB-4C5F-BB08-59BF2EBC5A40', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-30 00:46:46.750')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'1762A35B-F519-49E2-A43C-665196A22732', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-11-01 00:41:47.087')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'4F0FE4DC-37CE-4CD5-A212-6ACC0854FB94', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-11-01 00:47:39.340')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'5C6FA56E-4F3B-4741-954F-72C7834D79C7', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-23 15:58:38.867')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'262F5BF8-8CB2-4379-901A-748E5AF41943', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-23 00:29:42.290')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'0B192A4D-3CED-4345-8B78-8B88EAEC3BDD', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-23 15:57:34.847')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'A4431D4D-FC18-49F9-80E8-AB38DCE79030', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-11-08 22:25:26.317')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'E11BF7F2-E1DE-47B4-9495-B0DA078D3959', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-11-01 23:35:04.653')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'EF05EBE7-B737-469B-8102-B2A4F4805D11', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-23 15:10:14.117')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'FB45CBE9-0126-4123-973D-C336761FA9E0', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-22 22:41:51.543')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'D0C5FF81-C07C-4A4D-9804-CF045C0DF9CF', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-23 09:44:04.863')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'A8314D41-0FAE-4FBD-8CFF-DC4855EEEB41', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-30 01:22:16.493')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'64A5BF51-8940-49AC-8BBA-FBFF2384FC1C', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-23 00:32:55.153')
GO
 INSERT INTO [dbo].[SysUserToken] VALUES (N'73D04EDA-29C0-4590-96FB-FFA1D4BB874A', N'0F42C190-D965-43F8-96F6-865D4DBB0A41', N'2017-10-25 00:21:35.323')
GO
 -- ----------------------------
-- Primary Key structure for table ActivityLog
-- ----------------------------
ALTER TABLE [dbo].[ActivityLog] ADD CONSTRAINT [PK__Activity__3214EC075A414E67] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO
 -- ----------------------------
-- Uniques structure for table Category
-- ----------------------------
ALTER TABLE [dbo].[Category] ADD CONSTRAINT [IX_Category] UNIQUE NONCLUSTERED ([SysResource] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO
 -- ----------------------------
-- Primary Key structure for table Category
-- ----------------------------
ALTER TABLE [dbo].[Category] ADD CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO
 -- ----------------------------
-- Primary Key structure for table Setting
-- ----------------------------
ALTER TABLE [dbo].[Setting] ADD CONSTRAINT [PK__Setting__3214EC076FACA9D8] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO
 -- ----------------------------
-- Primary Key structure for table SysDomain
-- ----------------------------
ALTER TABLE [dbo].[SysDomain] ADD CONSTRAINT [PK__SysDomai__3214EC07705883E5] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO
 -- ----------------------------
-- Primary Key structure for table SysLog
-- ----------------------------
ALTER TABLE [dbo].[SysLog] ADD CONSTRAINT [PK__SysLog__3214EC07EA70B8D8] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO
 -- ----------------------------
-- Primary Key structure for table SysPermission
-- ----------------------------
ALTER TABLE [dbo].[SysPermission] ADD CONSTRAINT [PK_PermissionRecord] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO
 -- ----------------------------
-- Primary Key structure for table SysRole
-- ----------------------------
ALTER TABLE [dbo].[SysRole] ADD CONSTRAINT [PK__SysRole__3214EC07E6B401B7] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO
 -- ----------------------------
-- Primary Key structure for table SysStore
-- ----------------------------
ALTER TABLE [dbo].[SysStore] ADD CONSTRAINT [PK__SysStore__3214EC0772A17995] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO
 -- ----------------------------
-- Primary Key structure for table SysUser
-- ----------------------------
ALTER TABLE [dbo].[SysUser] ADD CONSTRAINT [PK__SysUser__3214EC078BFF6E21] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO
 -- ----------------------------
-- Primary Key structure for table SysUserLoginLog
-- ----------------------------
ALTER TABLE [dbo].[SysUserLoginLog] ADD CONSTRAINT [PK__SysUserL__3214EC075DD7F385] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO
 -- ----------------------------
-- Primary Key structure for table SysUserRole
-- ----------------------------
ALTER TABLE [dbo].[SysUserRole] ADD CONSTRAINT [PK__SysUserR__3214EC07CE911EAC] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO
 -- ----------------------------
-- Primary Key structure for table SysUserToken
-- ----------------------------
ALTER TABLE [dbo].[SysUserToken] ADD CONSTRAINT [PK__SysUserT__3214EC0737559360] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO
 -- ----------------------------
-- Foreign Keys structure for table ActivityLog
-- ----------------------------
ALTER TABLE [dbo].[ActivityLog] ADD CONSTRAINT [FK_ActivityLog_SysUser] FOREIGN KEY ([UserId]) REFERENCES [dbo].[SysUser] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
 -- ----------------------------
-- Foreign Keys structure for table SysPermission
-- ----------------------------
ALTER TABLE [dbo].[SysPermission] ADD CONSTRAINT [FK_PermissionRecord_SysRole] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[SysRole] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
 ALTER TABLE [dbo].[SysPermission] ADD CONSTRAINT [FK_PermissionRecord_SysUser] FOREIGN KEY ([Creator]) REFERENCES [dbo].[SysUser] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
 ALTER TABLE [dbo].[SysPermission] ADD CONSTRAINT [FK_SysPermission_Category] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Category] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
 -- ----------------------------
-- Foreign Keys structure for table SysRole
-- ----------------------------
ALTER TABLE [dbo].[SysRole] ADD CONSTRAINT [FK_SysRole_SysUser] FOREIGN KEY ([Creator]) REFERENCES [dbo].[SysUser] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
 ALTER TABLE [dbo].[SysRole] ADD CONSTRAINT [FK_SysRole_SysUser1] FOREIGN KEY ([Modifier]) REFERENCES [dbo].[SysUser] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
 -- ----------------------------
-- Foreign Keys structure for table SysStore
-- ----------------------------
ALTER TABLE [dbo].[SysStore] ADD CONSTRAINT [FK_SysStore_SysUser] FOREIGN KEY ([Creator]) REFERENCES [dbo].[SysUser] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
 ALTER TABLE [dbo].[SysStore] ADD CONSTRAINT [FK_SysStore_SysUser_Modifier] FOREIGN KEY ([Modifier]) REFERENCES [dbo].[SysUser] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
 -- ----------------------------
-- Foreign Keys structure for table SysUser
-- ----------------------------
ALTER TABLE [dbo].[SysUser] ADD CONSTRAINT [FK_SysUser_SysUser] FOREIGN KEY ([Id]) REFERENCES [dbo].[SysUser] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
 ALTER TABLE [dbo].[SysUser] ADD CONSTRAINT [FK_SysUser_SysUser_creator] FOREIGN KEY ([Creator]) REFERENCES [dbo].[SysUser] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
 -- ----------------------------
-- Foreign Keys structure for table SysUserLoginLog
-- ----------------------------
ALTER TABLE [dbo].[SysUserLoginLog] ADD CONSTRAINT [FK_SysUserLoginLog_SysUser] FOREIGN KEY ([UserId]) REFERENCES [dbo].[SysUser] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
 -- ----------------------------
-- Foreign Keys structure for table SysUserRole
-- ----------------------------
ALTER TABLE [dbo].[SysUserRole] ADD CONSTRAINT [FK_SysUserRole_SysRole] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[SysRole] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
 ALTER TABLE [dbo].[SysUserRole] ADD CONSTRAINT [FK_SysUserRole_SysUser] FOREIGN KEY ([UserId]) REFERENCES [dbo].[SysUser] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
 -- ----------------------------
-- Foreign Keys structure for table SysUserToken
-- ----------------------------
ALTER TABLE [dbo].[SysUserToken] ADD CONSTRAINT [FK_SysUserToken_SysUser] FOREIGN KEY ([SysUserId]) REFERENCES [dbo].[SysUser] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO