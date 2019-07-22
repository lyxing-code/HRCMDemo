using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoDAL
{
    public class LeaveDAL
    {
        private static List<LeaveEntity> Commnuity(string sql, params SqlParameter[] parameter)
        {
            List<LeaveEntity> list = new List<LeaveEntity>();
            SqlDataReader sdr = DBHelper.GetReader(sql, parameter);
            while (sdr.Read())
            {
                LeaveEntity obj = new LeaveEntity() { };

                  obj.LeaveID = Convert.ToInt32(sdr["LeaveID"]);
                  obj.UserID = Convert.ToInt32(sdr["UserID"]);
                  obj.UserName = sdr["UserName"].ToString();
                  obj.UserTel = Convert.ToString(sdr["UserTel"]);
                  obj.LeaveState = Convert.ToInt32(sdr["LeaveState"]);
                  obj.LeaveTime = Convert.ToDateTime(sdr["LeaveTime"]);
                  obj.LeaveStartTime = Convert.ToDateTime(sdr["LeaveStartTime"]);
                  obj.LeaveEndTime = Convert.ToDateTime(sdr["LeaveEndTime"]);
                  obj.LeaveHalfDay = sdr["LeaveHalfDay"].ToString();
                  obj.LeaveDays= Convert.ToInt32(sdr["LeaveDays"]);
                  obj.LeaveReason = sdr["LeaveReason"].ToString();
                  obj.ApproverID = Convert.ToInt32(sdr["ApproverID"]);
                  obj.ApprovalTime = Convert.ToDateTime(sdr["ApprovalTime"]);
                  obj.ApproverReason = sdr["ApproverReason"].ToString();
               
                list.Add(obj);
            }
            return list;
        }



        /// <summary>
        /// bootstraptable分页查询
        /// </summary>
        /// <param name="pageindex">当前页码</param>
        /// <param name="pagesize">显示条数</param>
        /// <returns></returns>
        public static List<LeaveEntity> BootstrapPageSelect(int pageindex, int pagesize ,ref int count)
        {
            string sql = "SELECT * FROM v_leavepage WHERE  idx BETWEEN " + pageindex + "+1 AND " + (pageindex + pagesize) + "";
            count = DBHelper.GetDataTable("select * from v_leavepage").Rows.Count;
            return Commnuity(sql).Count > 0 ? Commnuity(sql) : new List<LeaveEntity>();
        }





    }
}
