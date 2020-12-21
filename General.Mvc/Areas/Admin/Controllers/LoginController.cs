using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using General.Framework.Controllers.Admin;
using General.Entities;
using General.Services.SysUser;
using Microsoft.Extensions.Caching.Memory;
using General.Framework.Security.Admin;
using General.Core.Librs;
using Microsoft.AspNetCore.Http;

namespace General.Mvc.Areas.Admin.Controllers
{
    /// <summary>
    /// 后台管理登录控制器
    /// </summary>  
    [Route("admin")]
    public class LoginController : AdminAreaController
    {
        private const string R_KEY = "R_KEY";
        private ISysUserService _sysUserService;
        private IMemoryCache _memoryCache;
        private IAdminAuthService _authenticationService;

        public LoginController(ISysUserService sysUserService,
            IAdminAuthService authenticationService,
            IMemoryCache memoryCache)
        {
            this._memoryCache = memoryCache;
            this._sysUserService = sysUserService;
            this._authenticationService = authenticationService;
        }

        /// <summary>
        /// Session
        /// </summary>
        /// <returns></returns>
        [Route("login", Name = "adminLogin")]
        public IActionResult LoginIndex()
        {
            string r = EncryptorHelper.GetMD5(Guid.NewGuid().ToString());
            HttpContext.Session.SetString(R_KEY, r);
            LoginModel loginModel = new LoginModel() { R = r };
            return View(loginModel);
        }

        [HttpPost]
        [Route("login")]
        public IActionResult LoginIndex(LoginModel model)
        {
            string r = HttpContext.Session.GetString(R_KEY);
            r = r ?? "";
            if (!ModelState.IsValid)
            {
                AjaxData.Message = "请输入用户账号和密码";
                return Json(AjaxData);
            }
            var result = _sysUserService.validateUser(model.Account, model.Password, r);
            AjaxData.Status = result.Item1;
            AjaxData.Message = result.Item2;
            if (result.Item1)
            {
                _authenticationService.signIn(result.Item3, result.Item4.Name);
            }
            return Json(AjaxData);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="account"></param>
        /// <returns></returns>
        [Route("getSalt",Name = "getSalt")]
        public IActionResult getSalt(string account)
        {
           var user = _sysUserService.getByAccount(account);
            return Content(user?.Salt);
        }

    }
}