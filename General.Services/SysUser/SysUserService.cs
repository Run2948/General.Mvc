﻿using General.Core.Data;
using System;
using System.Collections.Generic;
using System.Text;
using General.Entities;
using System.Linq;
using General.Core.Librs;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.EntityFrameworkCore;
using General.Core;

namespace General.Services.SysUser
{
    public class SysUserService : ISysUserService
    {
        private IMemoryCache _memoryCache;
        private const string MODEL_KEY = "General.services.user_{0}";

        private readonly IRepository<Entities.SysUser> _sysUserRepository;
        private readonly IRepository<Entities.SysUserToken> _sysUserTokenRepository;
        private readonly IRepository<Entities.SysUserLoginLog> _sysUserLogRepository;

        public SysUserService(IRepository<Entities.SysUser> sysUserRepository,
            IRepository<Entities.SysUserToken> sysUserTokenRepository,
            IRepository<Entities.SysUserLoginLog> sysUserLogRepository,
            IMemoryCache memoryCache)
        {
            this._sysUserRepository = sysUserRepository;
            this._sysUserLogRepository = sysUserLogRepository;
            this._memoryCache = memoryCache;
            this._sysUserTokenRepository = sysUserTokenRepository;
        }

        /// <summary>
        /// 验证登录状态
        /// </summary>
        /// <param name="account">登录账号</param>
        /// <param name="password">登录密码</param>
        /// <param name="r">登录随机数</param>
        /// <returns></returns>
        public (bool Status, string Message, string Token, Entities.SysUser User) validateUser(string account, string password, string r)
        {
            var user = getByAccount(account);
            if (user == null)
                return (false, "用户名或密码错误", null, null);
            if (!user.Enabled)
                return (false, "你的账号已被冻结", null, null);

            if (user.LoginLock)
            {
                if (user.AllowLoginTime > DateTime.Now)
                {
                    return (false, "账号已被锁定" + ((int)(user.AllowLoginTime - DateTime.Now).Value.TotalMinutes + 1) + "分钟。", null, null);
                }
            }

            var md5Password = EncryptorHelper.GetMD5(user.Password + r);
            //匹配密码
            if (password.Equals(md5Password, StringComparison.InvariantCultureIgnoreCase))
            {
                user.LoginLock = false;
                user.LoginFailedNum = 0;
                user.AllowLoginTime = null;
                user.LastLoginTime = DateTime.Now;
                user.LastIpAddress = "";

                // _sysUserRepository.DbContext.SaveChanges();

                //登录日志
                var userLoginLog = new SysUserLoginLog()
                {
                    Id = Guid.NewGuid(),
                    IpAddress = "",
                    UserId = user.Id,
                    LoginTime = DateTime.Now,
                    Message = "登录：成功"
                };
                // user.SysUserLoginLogs.Add(userLoginLog);

                _sysUserLogRepository.insert(userLoginLog);
                // _sysUserLogRepository.SaveChanges();

                //单点登录,移除旧的登录token
                var userToken = new SysUserToken()
                {
                    Id = Guid.NewGuid(),
                    SysUserId = user.Id,
                    ExpireTime = DateTime.Now.AddDays(15)
                };

                // user.SysUserTokens.Add(userToken);
                _sysUserTokenRepository.insert(userToken);

                _sysUserRepository.DbContext.SaveChanges();

                return (true, "登录成功", userToken.Id.ToString(), user);
            }
            else
            {
                //登录日志
                user.SysUserLoginLogs.Add(new SysUserLoginLog()
                {
                    Id = Guid.NewGuid(),
                    IpAddress = "",
                    LoginTime = DateTime.Now,
                    Message = "登录：密码错误"
                });

                user.LoginFailedNum++;

                if (user.LoginFailedNum > 5)
                {
                    user.LoginLock = true;
                    user.AllowLoginTime = DateTime.Now.AddHours(2);
                }

                _sysUserRepository.DbContext.SaveChanges();
            }
            return (false, "用户名或密码错误", null, null);
        }

        /// <summary>
        /// 通过账号获取用户
        /// </summary>
        /// <param name="account"></param>
        /// <returns></returns>
        public Entities.SysUser getByAccount(string account)
        {
            return _sysUserRepository.Table.FirstOrDefault(o => o.Account == account && !o.IsDeleted);
        }

        /// <summary>
        /// 通过当前登录用户的token 获取用户信息，并缓存
        /// </summary>
        /// <param name="token"></param>
        /// <returns></returns>
        public Entities.SysUser getLogged(string token)
        {
            Entities.SysUser sysUser = null;

            _memoryCache.TryGetValue<Entities.SysUserToken>(token, out var userToken);
            if (userToken != null)
            {
                _memoryCache.TryGetValue(string.Format(MODEL_KEY, userToken.SysUserId), out sysUser);
            }
            if (sysUser != null)
                return sysUser;

            if (Guid.TryParse(token, out var tokenId))
            {
                var tokenItem = _sysUserTokenRepository.Table.Include(x => x.SysUser)
                     .FirstOrDefault(o => o.Id == tokenId);
                if (tokenItem != null)
                {
                    _memoryCache.Set(token, tokenItem, DateTimeOffset.Now.AddHours(4));
                    //缓存
                    _memoryCache.Set(string.Format(MODEL_KEY, tokenItem.SysUserId), tokenItem.SysUser, DateTimeOffset.Now.AddHours(4));
                    return tokenItem.SysUser;
                }
            }
            return null;
        }

        /// <summary>
        /// 搜索数据
        /// </summary>
        /// <param name="arg"></param>
        /// <param name="page"></param>
        /// <param name="size"></param>
        /// <returns></returns>
        public IPagedList<Entities.SysUser> searchUser(SysUserSearchArg arg, int page, int size)
        {
            var query = _sysUserRepository.Table.Where(o => !o.IsDeleted);
            if (arg != null)
            {
                if (!string.IsNullOrEmpty(arg.q))
                    query = query.Where(o => o.Account.Contains(arg.q) || o.MobilePhone.Contains(arg.q) || o.Email.Contains(arg.q) || o.Name.Contains(arg.q));
                if (arg.enabled.HasValue)
                    query = query.Where(o => o.Enabled == arg.enabled);
                if (arg.unlock.HasValue)
                    query = query.Where(o => o.LoginLock == arg.unlock);
                if (arg.roleId.HasValue)
                    query = query.Where(o => o.SysUserRoles.Any(r => r.RoleId == arg.roleId));
            }
            query = query.OrderBy(o => o.Account).ThenBy(o => o.Name).ThenByDescending(o => o.CreationTime);
            return new PagedList<Entities.SysUser>(query, page, size);
        }

        /// <summary>
        /// 获取用户详情
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public Entities.SysUser getById(Guid id)
        {
            return _sysUserRepository.getById(id);
        }

        /// <summary>
        /// 新增，插入
        /// </summary>
        /// <param name="model"></param>
        public void insertSysUser(Entities.SysUser model)
        {
            if (existAccount(model.Account))
                return;
            _sysUserRepository.insert(model);
        }

        /// <summary>
        /// 更新修改
        /// </summary>
        /// <param name="model"></param>
        public void updateSysUser(Entities.SysUser model)
        {
            _sysUserRepository.DbContext.Entry(model).State = EntityState.Unchanged;
            _sysUserRepository.DbContext.Entry(model).Property("Name").IsModified = true;
            _sysUserRepository.DbContext.Entry(model).Property("Email").IsModified = true;
            _sysUserRepository.DbContext.Entry(model).Property("MobilePhone").IsModified = true;
            _sysUserRepository.DbContext.Entry(model).Property("Sex").IsModified = true;
            _sysUserRepository.DbContext.SaveChanges();
        }

        /// <summary>
        /// 重置密码。默认重置成账号一样
        /// </summary>
        /// <param name="id"></param>
        /// <param name="modifer"></param>
        public void resetPassword(Guid id, Guid modifer)
        {
            var sysUser = _sysUserRepository.getById(id);
            sysUser.Password = EncryptorHelper.GetMD5(sysUser.Account + sysUser.Salt);
            sysUser.Modifier = modifer;
            _sysUserRepository.update(sysUser);
        }

        /// <summary>
        /// 验证账号是否已经存在
        /// </summary>
        /// <param name="account"></param>
        /// <returns></returns>
        public bool existAccount(string account)
        {
            return _sysUserRepository.Table.Any(o => o.Account == account && !o.IsDeleted);
        }

        /// <summary>
        /// 启用禁用账号
        /// </summary>
        /// <param name="id"></param>
        /// <param name="enabled"></param>
        /// <param name="modifer"></param>
        public void enabled(Guid id, bool enabled, Guid modifer)
        {
            var sysUser = _sysUserRepository.getById(id);
            if (sysUser.IsAdmin) return;
            sysUser.Enabled = enabled;
            sysUser.Modifier = modifer;
            _sysUserRepository.update(sysUser);
        }

        /// <summary>
        /// 登录锁与解锁
        /// </summary>
        /// <param name="id"></param>
        /// <param name="locked"></param>
        /// <param name="modifer"></param>
        public void loginLock(Guid id, bool locked, Guid modifer)
        {
            var sysUser = _sysUserRepository.getById(id);
            if (sysUser.IsAdmin) return;
            sysUser.LoginLock = locked;
            sysUser.Modifier = modifer;
            _sysUserRepository.update(sysUser);
        }

        /// <summary>
        /// 删除用户。无法删除超级用户
        /// </summary>
        /// <param name="id"></param>
        /// <param name="modifer"></param>
        public void deleteUser(Guid id, Guid modifer)
        {
            var sysUser = _sysUserRepository.getById(id);
            if (sysUser.IsAdmin) return;
            sysUser.IsDeleted = true;
            sysUser.Modifier = modifer;
            _sysUserRepository.update(sysUser);
        }

        /// <summary>
        /// 添加用户头像
        /// </summary>
        /// <param name="id"></param>
        /// <param name="avatar"></param>
        public void addAvatar(Guid id, byte[] avatar)
        {
            var sysUser = _sysUserRepository.getById(id);
            sysUser.Avatar = avatar;
            sysUser.Modifier = sysUser.Id;
            _sysUserRepository.update(sysUser);
        }

        /// <summary>
        /// 用户自己修改密码
        /// </summary>
        /// <param name="id"></param>
        /// <param name="password"></param>
        public void changePassword(Guid id, string password)
        {
            var sysUser = _sysUserRepository.getById(id);
            sysUser.Password = EncryptorHelper.GetMD5(password + sysUser.Salt);
            sysUser.Modifier = sysUser.Id;
            _sysUserRepository.update(sysUser);
        }

        /// <summary>
        /// 设置用户最后活动时间
        /// </summary>
        /// <param name="id"></param>
        public void lastLoginTime(Guid id)
        {
            var sysUser = _sysUserRepository.getById(id);
            sysUser.LastLoginTime = DateTime.Now;
            sysUser.Modifier = sysUser.Id;
            _sysUserRepository.update(sysUser);
        }

        /// <summary>
        /// 设置用户最后活动时间
        /// </summary>
        /// <param name="id"></param>
        public void lastActivityTime(Guid id)
        {
            var sysUser = _sysUserRepository.getById(id);
            sysUser.LastActivityTime = DateTime.Now;
            sysUser.Modifier = sysUser.Id;
            _sysUserRepository.update(sysUser);
        }
    }
}
