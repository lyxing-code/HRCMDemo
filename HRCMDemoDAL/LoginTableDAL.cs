using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoDAL
{
    public class LoginTableDAL
    {
        private List<LoginTableEntity> Community(string sql)
        {

            List<LoginTableEntity> list = new List<LoginTableEntity>();
            SqlDataReader sdr = DBHelper.GetReader(sql);
            while (sdr.Read())
            {
                LoginTableEntity obj = new LoginTableEntity()
                {
                    LoginId = Convert.ToInt32(sdr["LoginId"]),
                    LoginName = Convert.ToString(sdr["LoginName"]),
                    LoginPwd = Convert.ToString(sdr["LoginPwd"]),
                    JobNum = Convert.ToInt32(sdr["JobNum"]),
                    StaffNum = Convert.ToInt32(sdr["StaffNum"])
                };
                list.Add(obj);
            };
            return list;
        }

        public List<LoginTableEntity> SelectAll()
        {
            return Community("select * from LoginTable t1, JobTable t2 WHERE t1.JobNum = t2.JobNum");
        }

        private int SelectId(string name)
        {
            string sql = "select * from LoginTable t1, JobTable t2 WHERE t1.JobNum = t2.JobNum  and t1.LoginName = '" + name + "'";
            return Community(sql).Count>0 ?  Community(sql)[0].LoginId : new int();
        }

        public List<LoginTableEntity> SelectAllByIds(string id)
        {
            return Community("select * from LoginTable t1, JobTable t2 WHERE t1.JobNum = t2.JobNum  and t1.LoginId = '" + SelectId(id)+ "'");
        }

        public LoginTableEntity SelectAllById(string id)
        {
            return Community("select * from LoginTable t1, JobTable t2 WHERE t1.JobNum = t2.JobNum  and t1.LoginId = '" + SelectId(id) + "'").Count>0 ? Community("select * from LoginTable  WHERE LoginId = '" + SelectId(id) + "'")[0] : new LoginTableEntity();
        }

    }


}



