using System;
using System.Collections.Generic;
using System.Text;
using General.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Authentication;
using System.Security.Claims;
using Microsoft.AspNetCore.Authentication.Cookies;
using General.Services.SysUser;
using General.Services.Category;
using General.Services.SysUserRole;
using System.Linq;
using General.Services.SysPermission;
using Microsoft.AspNetCore.Mvc.Filters;

namespace General.Framework.Security.Admin
{
    public class AdminAuthService : IAdminAuthService
    {
        private IHttpContextAccessor _httpContextAccessor;
        private ISysUserService _sysUserService;
        private ICategoryService _categoryService;
        private ISysUserRoleService _sysUserRoleService;
        private ISysPermissionService _sysPermissionServices;

        public AdminAuthService(IHttpContextAccessor httpContextAccessor,
            ISysUserService sysUserService,
            ICategoryService categoryService,
            ISysPermissionService sysPermissionServices,
            ISysUserRoleService sysUserRoleService)
        {
            this._sysPermissionServices = sysPermissionServices;
            this._sysUserRoleService = sysUserRoleService;
            this._categoryService = categoryService;
            this._httpContextAccessor = httpContextAccessor;
            this._sysUserService = sysUserService;
        }

        /// <summary>
        /// 获取当前登录用户
        /// </summary>
        /// <returns></returns>
        public SysUser getCurrentUser()
        {
            var result = _httpContextAccessor.HttpContext.AuthenticateAsync(CookieAdminAuthInfo.AuthenticationScheme).Result;
            if (result.Principal == null)
                return null;
            var token = result.Principal.FindFirstValue(ClaimTypes.Sid);
            return _sysUserService.getLogged(token ?? "");
        }

        /// <summary>
        /// 保存等状态
        /// </summary>
        /// <param name="token"></param>
        /// <param name="name"></param>
        public void signIn(string token, string name)
        {
            ClaimsIdentity claimsIdentity = new ClaimsIdentity();
            claimsIdentity.AddClaim(new Claim(ClaimTypes.Sid, token));
            claimsIdentity.AddClaim(new Claim(ClaimTypes.Name, name));
            ClaimsPrincipal claimsPrincipal = new ClaimsPrincipal(claimsIdentity);
            _httpContextAccessor.HttpContext.SignInAsync(CookieAdminAuthInfo.AuthenticationScheme, claimsPrincipal);

        }

        /// <summary>
        /// 退出登录
        /// </summary>
        public void signOut()
        {
            _httpContextAccessor.HttpContext.SignOutAsync(CookieAdminAuthInfo.AuthenticationScheme);
        }

        /// <summary>
        /// 获取我的权限数据
        /// </summary>
        /// <returns></returns>
        public List<Entities.Category> getMyCategories()
        {
            var user = getCurrentUser();
            return getMyCategories(user);
        }

        /// <summary>
        /// 私有方法，获取当前用户的方法数据
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        private List<Entities.Category> getMyCategories(Entities.SysUser user)
        {
            var list = _categoryService.getAll();
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
        public bool authorize(ActionExecutingContext context)
        {
            var user = getCurrentUser();
            if (user == null)
                return false;
            //如果是超级管理员
            //if (user.IsAdmin) return true;
            string action = context.ActionDescriptor.RouteValues["action"];
            string controller = context.ActionDescriptor.RouteValues["controller"];

            return authorize(action, controller);
        }

        /// <summary>
        /// 私有方法，判断权限
        /// </summary>
        /// <param name="action"></param>
        /// <param name="controller"></param>
        /// <returns></returns>
        private bool authorize(string action, string controller)
        {
            var user = getCurrentUser();
            if (user == null)
                return false;
            //如果是超级管理员
            if (user.IsAdmin) return true;
            var list = getMyCategories(user);
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
        public bool authorize(string routeName)
        {
            var user = getCurrentUser();
            if (user == null)
                return false;
            //如果是超级管理员
            if (user.IsAdmin) return true;
            var list = getMyCategories(user);
            if (list == null) return false;
            return list.Any(o => o.RouteName != null &&
            o.RouteName.Equals(routeName, StringComparison.InvariantCultureIgnoreCase) );
        }
    }
}
