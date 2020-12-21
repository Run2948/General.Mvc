using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Autofac;
using Autofac.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using General.Entities;
using Microsoft.EntityFrameworkCore;
using General.Core;
using General.Core.Extensions;
using General.Core.Data;
using General.Framework;
using General.Framework.Infrastructure;
using General.Framework.Security.Admin;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Caching.Memory;
using General.Framework.Register;
using Microsoft.Extensions.Hosting;

namespace General.Mvc
{
    public class Startup
    {

        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddMvc();

            services.AddDbContextPool<GeneralDbContext>(options => options.UseMySql(Configuration.GetConnectionString("DefaultConnection")));

            services.AddAuthentication(o =>
            {
                o.DefaultAuthenticateScheme = CookieAdminAuthInfo.AuthenticationScheme;
                o.DefaultChallengeScheme = CookieAdminAuthInfo.AuthenticationScheme;
            })
                .AddCookie(CookieAdminAuthInfo.AuthenticationScheme, o =>
            {
                o.LoginPath = "/admin/login";
            });

            //程序集依赖注入
            services.AddAssembly("General.Services");

            services.AddSession();

            //泛型注入到DI里面
            services.AddScoped(typeof(IRepository<>), typeof(EfRepository<>));

            services.AddScoped<IWorkContext, WorkContext>();
            services.AddScoped<IAdminAuthService, AdminAuthService>();
            services.AddSingleton<IMemoryCache, MemoryCache>();
            services.AddSingleton<IRegisterApplicationService, RegisterApplicationService>();

            services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();
            //
            // EnginContext.Initialize(new GeneralEngine(services.BuildServiceProvider()));
        }

        public void ConfigureContainer(ContainerBuilder builder)
        {
            // builder.Register(c => c.Resolve<GeneralDbContext>()).As<DbContext>();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
            }

            app.UseSession();

            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthentication();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "area",
                    pattern: "{area:exists}/{controller=Home}/{action=Index}/{id?}");

                endpoints.MapControllerRoute(
                   name: "default",
                   pattern: "{controller=Home}/{action=Index}/{id?}");
            });

            #region Autofac依赖注入服务
            // AutofacEngine.Container = app.ApplicationServices.GetAutofacRoot();
            #endregion

            EnginContext.Initialize(new GeneralEngine(app.ApplicationServices.GetAutofacRoot()));

            //初始化菜单
            EnginContext.Current.Resolve<IRegisterApplicationService>().initRegister();
        }
    }
}
