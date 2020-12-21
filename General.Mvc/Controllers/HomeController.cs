using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using General.Mvc.Models;
using General.Entities;
using General.Services.SysCategory;
using General.Core;
using General.Core.Data;
using General.Framework.Controllers;

namespace General.Mvc.Controllers
{ 
    public class HomeController : BaseContoller
    { 
        public IActionResult Index()
        { 
            return View();
        }
         

        //public IActionResult Contact()
        //{
        //    ViewData["Message"] = "Your contact page.";

        //    return View();
        //}

        //public IActionResult Error()
        //{
        //    return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        //}
    }
}
