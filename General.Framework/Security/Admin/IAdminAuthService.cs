using Microsoft.AspNetCore.Mvc.Filters;
using System;
using System.Collections.Generic;
using System.Text;

namespace General.Framework.Security.Admin
{
    public interface IAdminAuthService
    {
        /// <summary>
        /// 保存登录状态
        /// </summary>
        /// <param name="token"></param>
        /// <param name="name"></param>
        void SignIn(string token, string name);

        /// <summary>
        /// 退出登录
        /// </summary>
        void SignOut();

        /// <summary>
        /// 获取当前登录用户
        /// （缓存）
        /// </summary>
        /// <returns></returns>
        Entities.SysUser GetCurrentUser();

        /// <summary>
        /// 获取我的权限数据
        /// </summary>
        /// <returns></returns>
        List<Entities.SysCategory> GetMyCategories();

        /// <summary>
        /// 权限验证
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        bool Authorize(ActionExecutingContext context);

        /// <summary>
        /// 权限验证
        /// </summary>
        /// <param name="routeName"></param> 
        /// <returns></returns>
        bool Authorize(string routeName);
    }
}
