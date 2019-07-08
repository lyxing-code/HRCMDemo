using HRCMDemoDAL;
using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoBLL
{
     public class LoginTableBLL
    {
        /// <summary>
        /// 获取所有信息
        /// </summary>
        /// <returns>List</returns>
        public List<LoginTableEntity> GetAllInfo()
        {
            return new LoginTableDAL().SelectAll();
        }

        /// <summary>
        /// 获取当前用户的信息
        /// </summary>
        /// <param name="id">用户名</param>
        /// <returns>List</returns>
        public List<LoginTableEntity> GetAllByIds(string id)
        {
            return new LoginTableDAL().SelectAllByIds(id);
        }

        /// <summary>
        /// 获取当前用户的信息
        /// </summary>
        /// <param name="id">用户名</param>
        /// <returns>LoginTableEntity</returns>
        public LoginTableEntity SelectAllById(string id)
        {
             return new LoginTableDAL().SelectAllById(id);
        }

        /// <summary>
        /// 判断是否登录成功
        /// </summary>
        /// <param name="obj">用户实例</param>
        /// <returns>bool</returns>
        public bool IsLoginOk(LoginTableEntity obj)
        {
            obj.LoginState = false;
            if (obj.LoginName == null || obj.LoginPwd == null)
            {
                    
                    return false;
            }
            else
            {
                if (obj.LoginName.Contains(" ") || obj.LoginPwd.Contains(" "))
                {
                    return false;
                }
                else
                {
                   obj.LoginState = true;
                   return SelectAllById(obj.LoginName).LoginPwd == obj.LoginPwd;
                }
            }

        }

    }
}
