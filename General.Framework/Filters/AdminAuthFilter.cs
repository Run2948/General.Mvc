using General.Core;
using General.Framework.Security.Admin;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System;
using System.Collections.Generic;
using System.Text;

namespace General.Framework.Filters
{
    /// <summary>
    /// 登录状态过滤器
    /// </summary>
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, AllowMultiple = true, Inherited = true)]
    public class AdminAuthFilter : Attribute, IResourceFilter
    { 
        public void OnResourceExecuted(ResourceExecutedContext context)
        {

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="context"></param>
        public void OnResourceExecuting(ResourceExecutingContext context)
        {
           var _adminAuthService = EnginContext.Current.Resolve<IAdminAuthService>();
            var user = _adminAuthService.GetCurrentUser();
            if (user == null || !user.Enabled)
                context.Result = new RedirectToRouteResult("adminLogin", new { returnUrl = context.HttpContext.Request.Path });
        }
    }
}
