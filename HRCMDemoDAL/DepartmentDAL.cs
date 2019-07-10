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
        public static DataTable SelectDeptTable(string name)
        {
            string sql = "";
            if (name != null && name !="")
            {
                sql = "SELECT * FROM Department where DepartmentName like '%'+@DepartmentName+'%'";
               SqlParameter[] parametersArr = new SqlParameter[]
               {
                   new SqlParameter("@DepartmentName",name),
               };
               return DBHelper.GetDataTable(sql, parametersArr);
            }
            else
            {
                sql = "SELECT * FROM Department";
                 return DBHelper.GetDataTable(sql); 
            }
           
        }


    }
}
