﻿using General.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Autofac;
using Microsoft.AspNetCore.Http;

namespace General.Mvc
{
    /// <summary>
    /// 
    /// </summary>
    public class GeneralEngine : IEngine
    {
        private readonly ILifetimeScope _lifetimeScope;

        public GeneralEngine(ILifetimeScope lifetimeScope)
        {
            this._lifetimeScope = lifetimeScope;
        }

        /// <summary>
        /// 获取服务(Single)
        /// </summary>
        /// <typeparam name="T">接口类型</typeparam>
        /// <returns></returns>
        public T Resolve<T>() where T : class
        {
            return _lifetimeScope.Resolve<T>();
        }

        /// <summary>
        /// 获取服务(请求生命周期内)
        /// </summary>
        /// <typeparam name="T">接口类型</typeparam>
        /// <returns></returns>
        public T ResolveScope<T>() where T : class
        {
            return (T)Resolve<IHttpContextAccessor>().HttpContext.RequestServices.GetService(typeof(T)); ;
        }
    }
}
