using System;
using System.Collections.Generic;
using System.Text;
using General.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Authentication;
using System.Security.Claims;
using General.Services.SysUser;
using General.Services.SysCategory;
using General.Services.SysUserRole;
using System.Linq;
using General.Services.SysPermission;
using Microsoft.AspNetCore.Mvc.Filters;

namespace General.Framework.Security.Admin
{
    public class AdminAuthService : IAdminAuthService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly ISysUserService _sysUserService;
        private readonly ISysCategoryService _sysCategoryService;
        private readonly ISysUserRoleService _sysUserRoleService;
        private readonly ISysPermissionService _sysPermissionServices;

        public AdminAuthService(IHttpContextAccessor httpContextAccessor,
            ISysUserService sysUserService,
            ISysCategoryService sysCategoryService,
            ISysPermissionService sysPermissionServices,
            ISysUserRoleService sysUserRoleService)
        {
            this._sysPermissionServices = sysPermissionServices;
            this._sysUserRoleService = sysUserRoleService;
            this._sysCategoryService = sysCategoryService;
            this._httpContextAccessor = httpContextAccessor;
            this._sysUserService = sysUserService;
        }

        /// <summary>
        /// 获取当前登录用户
        /// </summary>
        /// <returns></returns>
        public SysUser GetCurrentUser()
        {
            var result = _httpContextAccessor.HttpContext.AuthenticateAsync(CookieAdminAuthInfo.AuthenticationScheme).Result;
            if (result.Principal == null)
                return null;
            var token = result.Principal.FindFirstValue(ClaimTypes.Sid);
            return _sysUserService.getLogged(token ?? "");
        }

        /// <summary>
        /// 保存登录状态
        /// </summary>
        /// <param name="token"></param>
        /// <param name="name"></param>
        public void SignIn(string token, string name)
        {
            var claimsIdentity = new ClaimsIdentity(CookieAdminAuthInfo.AuthenticationScheme);
            claimsIdentity.AddClaim(new Claim(ClaimTypes.Sid, token));
            claimsIdentity.AddClaim(new Claim(ClaimTypes.Name, name));
            var claimsPrincipal = new ClaimsPrincipal(claimsIdentity);
            _httpContextAccessor.HttpContext.SignInAsync(CookieAdminAuthInfo.AuthenticationScheme, claimsPrincipal);
        }

        /// <summary>
        /// 退出登录
        /// </summary>
        public void SignOut()
        {
            _httpContextAccessor.HttpContext.SignOutAsync(CookieAdminAuthInfo.AuthenticationScheme);
        }

        /// <summary>
        /// 获取我的权限数据
        /// </summary>
        /// <returns></returns>
        public List<Entities.SysCategory> GetMyCategories()
        {
            var user = GetCurrentUser();
            return GetMyCategories(user);
        }

        /// <summary>
        /// 私有方法，获取当前用户的方法数据
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        private List<Entities.SysCategory> GetMyCategories(Entities.SysUser user)
        {
            var list = _sysCategoryService.getAll();
            if (user == null) return null;
            if (user.IsAdmin) return list;

            //获取权限数据
            var userRoles = _sysUserRoleService.getAll();
            if (userRoles == null || !userRoles.Any()) return null;
            var roleIds = userRoles.Where(o => o.UserId == user.Id).Select(x => x.RoleId).Distinct().ToList();
            var permissionList = _sysPermissionServices.getAll();
            if (permissionList == null || !permissionList.Any()) return null;

            var categoryIds = permissionList.Where(o => roleIds.Contains(o.RoleId)).Select(x => x.CategoryId).Distinct().ToList();
            if (!categoryIds.Any())
                return null;
            list = list.Where(o => categoryIds.Contains(o.Id)).ToList();
            return list;
        }

        /// <summary>
        /// 权限验证
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public bool Authorize(ActionExecutingContext context)
        {
            var user = GetCurrentUser();
            if (user == null)
                return false;
            //如果是超级管理员
            //if (user.IsAdmin) return true;
            string action = context.ActionDescriptor.RouteValues["action"];
            string controller = context.ActionDescriptor.RouteValues["controller"];

            return Authorize(action, controller);
        }

        /// <summary>
        /// 私有方法，判断权限
        /// </summary>
        /// <param name="action"></param>
        /// <param name="controller"></param>
        /// <returns></returns>
        private bool Authorize(string action, string controller)
        {
            var user = GetCurrentUser();
            if (user == null)
                return false;
            //如果是超级管理员
            if (user.IsAdmin) return true;
            var list = GetMyCategories(user);
            if (list == null) return false;
            return list.Any(o => o.Controller != null && o.Action != null ||
            o.Controller.Equals(controller, StringComparison.InvariantCultureIgnoreCase)
            && o.Action.Equals(action, StringComparison.InvariantCultureIgnoreCase));
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="routeName"></param>
        /// <returns></returns>
        public bool Authorize(string routeName)
        {
            var user = GetCurrentUser();
            if (user == null)
                return false;
            //如果是超级管理员
            if (user.IsAdmin) return true;
            var list = GetMyCategories(user);
            if (list == null) return false;
            return list.Any(o => o.RouteName != null &&
            o.RouteName.Equals(routeName, StringComparison.InvariantCultureIgnoreCase) );
        }
    }
}
