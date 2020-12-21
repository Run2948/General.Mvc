using System;
using System.Collections.Generic;
using System.Text;

namespace General.Core
{
    public interface IEngine
    {
        /// <summary>
        /// 获取服务(Single)
        /// </summary>
        /// <typeparam name="T">接口类型</typeparam>
        /// <returns></returns>
        T Resolve<T>() where T : class;

        /// <summary>
        /// 获取服务(请求生命周期内)
        /// </summary>
        /// <typeparam name="T">接口类型</typeparam>
        /// <returns></returns>
        T ResolveScope<T>() where T : class;
    }
}
