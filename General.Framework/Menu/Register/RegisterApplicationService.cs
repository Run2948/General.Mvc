using General.Entities;
using General.Framework.Menu;
using General.Services.SysCategory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace General.Framework.Register
{
    public class RegisterApplicationService : IRegisterApplicationService
    {
        private readonly ISysCategoryService _sysCategoryService;

        public RegisterApplicationService(ISysCategoryService sysCategoryService)
        {
            this._sysCategoryService = sysCategoryService;
        }

        /// <summary>
        /// 初始化
        /// </summary>
        [MethodImpl(MethodImplOptions.Synchronized)]
        public void initRegister()
        {
            List<Entities.SysCategory> list = new List<Entities.SysCategory>();
            FunctionManager.getFunctionLists().ForEach(item =>
            {
                list.Add(new Entities.SysCategory()
                {
                    Action = item.Action,
                    Controller = item.Controller,
                    CssClass = item.CssClass,
                    FatherResource = item.FatherResource,
                    IsMenu = item.IsMenu,
                    Name = item.Name,
                    RouteName = item.RouteName,
                    SysResource = item.SysResource,
                    Sort = item.Sort,
                    FatherID = item.FatherID,
                    IsDisabled = false,
                    ResouceID = item.ResouceID
                });
            });
            _sysCategoryService.initCategory(list);


        }
    }
}
