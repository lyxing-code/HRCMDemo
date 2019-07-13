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
    public static class DepartmentDAL
    {

        private static List<DepartmentEntity> Commnuity(string sql,params SqlParameter[] parameter)
        {
            List<DepartmentEntity> list = new List<DepartmentEntity>();
            SqlDataReader sdr = DBHelper.GetReader(sql, parameter);
            while (sdr.Read())
            {
                DepartmentEntity obj = new DepartmentEntity()
                {
                    DepartmentID = Convert.ToInt32(sdr["DepartmentID"]),
                    DepartmentName = sdr["DepartmentName"].ToString(),
                    DepartmentRemarks = sdr["DepartmentRemarks"].ToString()
                };
                list.Add(obj);
            }
            return list;
        }


        /// <summary>
        /// 查询所有部门
        /// </summary>
        /// <param name="name">部门名称</param>
        /// <returns></returns>
        public static DataTable SelectDeptTable(string name, string str)
        {
            string sql = "";
            if (name != null && name !="")
            {
                SqlParameter[] parametersArr = new SqlParameter[1] ;
                if (str == "selectbyname")
                {
                    sql = "SELECT * FROM Department where DepartmentName = ''+@DepartmentName+''";
                    parametersArr[0] = new SqlParameter("@DepartmentName", name);
                   
                }
                else if(str == "selectbyid")
                {
                    sql = "SELECT * FROM Department where DepartmentID = @DepartmentID";

                    parametersArr[0] = new SqlParameter("@DepartmentID", name);
                   
                }
                else
                {
                    sql = "SELECT * FROM Department where DepartmentName like '%'+@DepartmentName+'%'";
                    parametersArr[0] = new SqlParameter("@DepartmentName", name);
                   
                }
               return DBHelper.GetDataTable(sql, parametersArr);
            }
            else
            {
                sql = "SELECT * FROM Department";
                 return DBHelper.GetDataTable(sql); 
            }
           
        }

        /// <summary>
        /// 部门添加
        /// </summary>
        /// <param name="obj">部门实例</param>
        /// <returns>bool</returns>
        public static bool InsertInfo(DepartmentEntity obj)
        {
            string sql = "INSERT INTO Department (DepartmentName, DepartmentRemarks)VALUES (@departmentname, @departmentremarks)";
            SqlParameter[] parametersArr = new SqlParameter[]
               {
                   new SqlParameter("@departmentname",obj.DepartmentName),
                   new SqlParameter("@departmentremarks",obj.DepartmentRemarks),
               };
            return DBHelper.UpdateOpera(sql, parametersArr);
        }

        /// <summary>
        /// 部门修改
        /// </summary>
        /// <param name="obj">部门实例</param>
        /// <returns>bool</returns>
        public static bool UpdateInfo(DepartmentEntity obj)
        {
            string sql = "UPDATE Department SET DepartmentName = @departmentname, DepartmentRemarks = @departmentremarks WHERE DepartmentID = @departmentid";
            SqlParameter[] parametersArr = new SqlParameter[]
               {
                    new SqlParameter("@departmentid",obj.DepartmentID),
                   new SqlParameter("@departmentname",obj.DepartmentName),
                   new SqlParameter("@departmentremarks",obj.DepartmentRemarks),
               };
            return DBHelper.UpdateOpera(sql, parametersArr);
        }

        /// <summary>
        /// 部门删除
        /// </summary>
        /// <param name="obj">部门实例</param>
        /// <returns>bool</returns>
        public static bool DeleteInfo(DepartmentEntity obj)
        {
            string sql = "DELETE FROM Department WHERE DepartmentID = @DepartmentID";
            SqlParameter[] parametersArr = new SqlParameter[]
               {
                    new SqlParameter("@departmentid",obj.DepartmentID),
               };
            return DBHelper.UpdateOpera(sql, parametersArr);
        }
        
        /// <summary>
        /// 删除单|多行
        /// </summary>
        /// <param name="id">id</param>
        /// <returns></returns>
        public static bool DeleteInfo(string id)
        {
            string sql = "SELECT * FROM Department WHERE DepartmentID IN (SELECT DepartmentID FROM UserInfo WHERE DepartmentID IN("+id+"));";
            
            if (Commnuity(sql).Count > 0)
            {
                return false;
            }
            else
            {
                sql = "DELETE Department WHERE DepartmentID IN ("+id+")";
                return DBHelper.UpdateOpera(sql);
            }
        }


    }
}
