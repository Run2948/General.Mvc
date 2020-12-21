using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using General.Core.Librs;
using Microsoft.AspNetCore.Mvc;
using General.Framework.Controllers.Admin;
using General.Framework.Security.Admin;
using General.Services.SysUser;

namespace General.Mvc.Areas.Admin.Controllers
{
    [Route("admin/main")]
    public class MainController : PublicAdminController
    {
        private readonly IAdminAuthService _adminAuthService;
        private readonly ISysUserService _sysUserService;

        public MainController(IAdminAuthService adminAuthService, ISysUserService sysUserService)
        {
            this._adminAuthService = adminAuthService;
            _sysUserService = sysUserService;
        }


        [Route("", Name = "mainIndex")]
        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        [Route("account", Name = "editAccount")]
        public IActionResult EditAccount(string returnUrl = null)
        {
            ViewBag.ReturnUrl = Url.IsLocalUrl(returnUrl) ? returnUrl : Url.RouteUrl("mainIndex");
            var currentUser = _adminAuthService.GetCurrentUser();
            currentUser.Password = null;
            return View(currentUser);
        }


        [HttpPost]
        [Route("account")]
        public ActionResult EditAccount(Entities.SysUser model, string returnUrl = null)
        {
            ViewBag.ReturnUrl = Url.IsLocalUrl(returnUrl) ? returnUrl : Url.RouteUrl("mainIndex");
            if (!ModelState.IsValid)
                return View(model);
            if (!string.IsNullOrEmpty(model.MobilePhone))
                model.MobilePhone = StringUitls.toDBC(model.MobilePhone);
            model.Name = model.Name.Trim();
            model.ModifiedTime = DateTime.Now;
            model.Modifier = WorkContext.CurrentUser.Id;
            _sysUserService.updateSysUser(model);
            if (!string.IsNullOrEmpty(model.Password))
                _sysUserService.changePassword(model.Id, model.Password);
            return Redirect(ViewBag.ReturnUrl);
        }


        [Route("out", Name = "signOut")]
        public IActionResult SignOut()
        {
            _adminAuthService.SignOut();
            return RedirectToRoute("adminLogin");
        }

    }
}