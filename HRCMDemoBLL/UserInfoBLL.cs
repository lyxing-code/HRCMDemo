using HRCMDemoDAL;
using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoBLL
{
    public class UserInfoBLL
    {
        public DataTable GetTable(string name, string pwd)
        {
            return  UserInfoDAL.SelectTable(name, pwd);
        }


        /// <summary>
        /// 获取员工信息
        /// </summary>
        /// <returns>员工信息集合</returns>
        public  List<UserInfoEntity> GetAllInfo()
        {
            return UserInfoDAL.SelectAll();
        }


        /// <summary>
        /// 通过员工Id获取该员工的信息
        /// </summary>
        /// <param name="id">员工编号</param>
        /// <returns>UserInfoEntity实例</returns>
        public  UserInfoEntity GetInfoById(string id)
        {
            return UserInfoDAL.SelectById(id);
        }


        /// <summary>
        /// 删除单行或者多行数据
        /// </summary>
        /// <param name="idlist">用户id的集合</param>
        /// <returns>bool</returns>
        public  bool DeleteByIdList(string idlist)
        {
            return UserInfoDAL.DeleteByIdList(idlist);
        }


        /// <summary>
        /// 添加新用户
        /// </summary>
        /// <param name="o">用户对象的实例</param>
        /// <returns>bool</returns>
        public  bool AddInfo(UserInfoEntity o)
        {
            return UserInfoDAL.InsertInfo(o);
        }

        /// <summary>
        /// 修改用户信息
        /// </summary>
        /// <param name="o">用户对象的实例</param>
        /// <returns>bool</returns>
        public  bool UpdateInfo(UserInfoEntity o)
        {
            return UserInfoDAL.UpdateInfo(o);
        }




    }
}
