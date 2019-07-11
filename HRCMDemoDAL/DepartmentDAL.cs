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


    }
}
