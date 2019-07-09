using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoDAL
{
    public class UserInfoDAL
    {
        public DataTable SelectTable(string name,string pwd)
        {
            string sql = "SELECT * FROM UserInfo WHERE LoginName =@LoginName AND LoginPwd=@LoginPwd";
            SqlParameter[] parametersArr =  new SqlParameter [] 
            {
               new SqlParameter("@LoginName",name),
               new SqlParameter("@LoginPwd",pwd),
            };
            return DBHelper.GetDataTable(sql, parametersArr);
        }

    }
}
