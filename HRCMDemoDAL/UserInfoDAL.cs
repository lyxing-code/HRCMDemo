using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoDAL
{
    public static class UserInfoDAL
    {

        private static List<UserInfoEntity> Commnuity(string sql, params SqlParameter[] parameter)
        {
            List<UserInfoEntity> list = new List<UserInfoEntity>();
            SqlDataReader sdr = DBHelper.GetReader(sql, parameter);
            while (sdr.Read())
            {
                UserInfoEntity obj = new UserInfoEntity()
                {
                    UserID = Convert.ToInt32(sdr["UserID"]),
                    DepartmentID = Convert.ToInt32(sdr["DepartmentID"]),
                    RoleID = Convert.ToInt32(sdr["RoleID"]),
                    UserNumber  = sdr["UserNumber"].ToString(),
                    UserFace = sdr["UserFace"].ToString(),
                    LoginName = sdr["LoginName"].ToString(),
                    LoginPwd = sdr["LoginPwd"].ToString(),
                    UserName = sdr["UserName"].ToString(),
                    UserAge = Convert.ToInt32(sdr["UserAge"]),
                    UserSex = Convert.ToInt32(sdr["UserSex"]),
                    UserTel = Convert.ToString(sdr["UserTel"]),
                    UserAddress = Convert.ToString(sdr["UserAddress"]),
                    UserIphone = Convert.ToString(sdr["UserIphone"]),
                    UserRemarks = Convert.ToString(sdr["UserRemarks"]),
                    UserStatr = Convert.ToInt32(sdr["UserStatr"]),
                    EntryTime = Convert.ToDateTime(sdr["EntryTime"]),
                    DimissionTime = Convert.ToDateTime(sdr["DimissionTime"]),
                    BasePay = Convert.ToDouble(sdr["BasePay"]),
                    DepartmentName = sdr["DepartmentName"].ToString(),
                    RoleName = sdr["RoleName"].ToString()
                };
                list.Add(obj);
            }
            return list;
        }


        public static DataTable SelectTable(string name,string pwd)
        {
            string sql = "SELECT * FROM UserInfo WHERE LoginName =@LoginName AND LoginPwd=@LoginPwd";
            SqlParameter[] parametersArr =  new SqlParameter [] 
            {
               new SqlParameter("@LoginName",name),
               new SqlParameter("@LoginPwd",pwd),
            };
            return DBHelper.GetDataTable(sql, parametersArr);
        }


        /// <summary>
        /// 返回所有员工信息
        /// </summary>
        /// <returns>员工信息集合</returns>
        public static List<UserInfoEntity> SelectAll(string strwhere)
        {
            string sql = "SELECT t1.*,t2.DepartmentName,t3.RoleName FROM UserInfo t1,Department t2, Role t3   WHERE t1.DepartmentID = t2.DepartmentID AND t1.RoleID = t3.RoleID "+ strwhere;
            return Commnuity(sql);
        }
        
        /// <summary>
        /// 通过员工Id查询该员工的信息
        /// </summary>
        /// <param name="id">员工编号</param>
        /// <returns>UserInfoEntity实例</returns>
        public static UserInfoEntity SelectById(string id)
        {
            string sql = "SELECT t1.*,t2.DepartmentName,t3.RoleName FROM UserInfo t1,Department t2, Role t3   WHERE t1.DepartmentID = t2.DepartmentID AND t1.RoleID = t3.RoleID AND t1.UserID = @UserID ";

            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@UserID",id),
            };
            return Commnuity(sql, parameters)[0] ?? null ;
        }

        /// <summary>
        /// 删除单行或者多行数据
        /// </summary>
        /// <param name="idlist">用户id的集合</param>
        /// <returns>bool</returns>
        public static bool DeleteByIdList(string idlist)
        {
            string sql = "DELETE UserInfo WHERE UserID IN ("+idlist+")";
            return DBHelper.UpdateOpera(sql);
        }

        /// <summary>
        /// 添加新用户
        /// </summary>
        /// <param name="o">用户对象的实例</param>
        /// <returns>bool</returns>
        public static bool InsertInfo(UserInfoEntity o)
        {
            string sql = "INSERT INTO UserInfo (DepartmentID, RoleID, UserNumber, UserFace, LoginName, LoginPwd, UserName, UserAge, UserSex, UserTel, UserAddress, UserIphone, UserRemarks, UserStatr, EntryTime, DimissionTime, BasePay)VALUES "+
                "("+o.DepartmentID+", "+o.RoleID+", '"+o.UserNumber+"', '"+o.UserFace+"', '"+o.LoginName+"', '"+o.LoginPwd+"', '"+o.UserName+"',"+o.UserAge+", "+o.UserSex+",'"+o.UserTel+"', '"+o.UserAddress+"','"+o.UserIphone+"','"+o.UserRemarks+"', 0, getdate(), getdate(), "+o.BasePay + ")";
            return DBHelper.UpdateOpera(sql);
        }

        /// <summary>
        /// 修改用户信息
        /// </summary>
        /// <param name="o">用户对象的实例</param>
        /// <returns>bool</returns>
        public static bool UpdateInfo(UserInfoEntity o)
        {
            string sql = " UPDATE UserInfo SET " +
                         "DepartmentID = @departmentid," +
                          "RoleID = @roleid," +
                        "UserFace = @userface," +
                        "UserName = @username," +
                        "UserAge = @userage," +
                        "UserSex = @usersex," +
                        "UserTel = @usertel," +
                        "UserAddress = @useraddress," +
                        "UserIphone = @useriphone," +
                        "UserRemarks = @userremarks," +
                        "BasePay = @basepay " +
                        " WHERE UserID = @userid";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@departmentid",o.DepartmentID),
                new SqlParameter("@roleid",o.RoleID),
                new SqlParameter("@userface",o.UserFace),
                new SqlParameter("@username",o.UserName),
                new SqlParameter("@userage",o.UserAge),
                new SqlParameter("@usersex",o.UserSex),
                new SqlParameter("@usertel",o.UserTel),
                new SqlParameter("@useraddress",o.UserAddress),
                new SqlParameter("@useriphone",o.UserIphone),
                new SqlParameter("@userremarks",o.UserRemarks),
                new SqlParameter("@basepay",o.BasePay),
                new SqlParameter("@userid",o.UserID),
            };
            return DBHelper.UpdateOpera(sql, parameters);
        }


        /// <summary>
        /// 分页查询
        /// </summary>
        /// <param name="pageindex">当前页码</param>
        /// <param name="pagesize">显示条数</param>
        /// <returns></returns>
        public static List<UserInfoEntity> PageSelect(int pageindex,int pagesize)
        {
            string sql = "SELECT * FROM v_page WHERE  idx BETWEEN ("+ pageindex + "-1)*"+ pagesize + "+1 AND "+ pageindex + "*"+ pagesize + "";
            return Commnuity(sql).Count > 0 ? Commnuity(sql) : new List<UserInfoEntity>();
        }

        /// <summary>
        /// bootstraptable分页查询
        /// </summary>
        /// <param name="pageindex">当前页码</param>
        /// <param name="pagesize">显示条数</param>
        /// <returns></returns>
        public static List<UserInfoEntity>BootstrapPageSelect(int pageindex, int pagesize)
        {
            string sql = "SELECT * FROM v_page WHERE  idx BETWEEN " + pageindex + "+1 AND " + (pageindex + pagesize) + "";
            return Commnuity(sql).Count > 0 ? Commnuity(sql) : new List<UserInfoEntity>();
        }

        public static bool UpdateLoginState(string id)
        {
            string sql = "UPDATE UserInfo SET UserStatr = 1 WHERE UserID =" +id;
            return DBHelper.UpdateOpera(sql);
        }



    }
}
