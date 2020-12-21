# [ASP.NET Core2.0项目实战](https://www.bilibili.com/video/BV1PJ411m7KL)

## [General.Mvc](https://github.com/Run2948/General.Mvc)

**SQL Server 2017 :**

数据库备份文件在 `General.Mvc\Data\general.bak`，本地没有安装 SQL Server 2017 的同学，可以参考 [在 Docker 中的将 SQL Server 2017 数据库还原](https://docs.microsoft.com/zh-cn/sql/linux/tutorial-restore-backup-in-sql-server-container?view=sql-server-2017) 这篇文章。

不想折腾的同学可以直接使用我准备好的 SQL 脚本 `General.Mvc\Data\general.sql` 来快速还原数据库。

* 管理员账户：admin/123456

**升级 ASP.NET Core 3.1：**

需要旧版的同学，可以前往 Tag [v1.0](https://github.com/Run2948/General.Mvc/releases/tag/v1.0) 获取。

* 升级了项目 .NET Core 版本到 3.1
* 修复了一些无法兼容的语法和逻辑
* 切换数据库为 MySQL 5.7.x
* 引入 Autofac 重构了 GeneralEngine
* 使用 CodeFirst 自动创建数据库