using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoDAL
{
   public class RoleDAL
    {
        private static List<RoleEntity> Commnuity(string sql, params SqlParameter[] parameter)
        {
            List<RoleEntity> list = new List<RoleEntity>();
            SqlDataReader sdr = DBHelper.GetReader(sql, parameter);
            while (sdr.Read())
            {
                RoleEntity obj = new RoleEntity()
                {
                     RoleID = Convert.ToInt32(sdr["RoleID"]),
                     RoleName = sdr["RoleName"].ToString(),
                     RoleNumber = sdr["RoleNumber"].ToString()
                };
                list.Add(obj);
            }
            return list;
        }

        public static List<RoleEntity> SelectAll()
        {
            return Commnuity("SELECT * FROM Role");
        }



    }
}
