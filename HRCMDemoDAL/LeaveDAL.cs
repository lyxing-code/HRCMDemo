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
                  obj.CI_ID = Convert.ToInt32(sdr["CI_ID"]);
                  obj.CI_Name = sdr["CI_Name"].ToString();
                  obj.DepartmentName = sdr["DepartmentName"].ToString();
               
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

        /// <summary>
        /// 添加请假信息
        /// </summary>
        /// <param name="obj">请假的实例</param>
        /// <returns>bool</returns>
        public static bool InsertInfo(LeaveEntity obj)
        {
            string sql = "insert into Leave values("+obj.UserID+ ",3,getdate(),'" + obj.LeaveStartTime+"','"+obj.LeaveEndTime+"','"+obj.LeaveHalfDay+"','"+obj.LeaveDays+"','"+obj.LeaveReason+"','','','')";
            return DBHelper.UpdateOpera(sql);
        }

        /// <summary>
        /// 查询所有信息
        /// </summary>
        /// <returns></returns>
        public static List<LeaveEntity> SelectAll()
        {
            string sql = "SELECT * FROM v_leavepage";
            return Commnuity(sql).Count > 0 ? Commnuity(sql) : new List<LeaveEntity>();
        }

        /// <summary>
        /// 删除信息
        /// </summary>
        /// <param name="idlist">请假信息id的集合字符串</param>
        /// <returns>bool</returns>
        public static bool DeleteInfoBylevidlist(string idlist)
        {
            string sql = "DELETE Leave WHERE LeaveID IN("+ idlist + ")";
            return DBHelper.UpdateOpera(sql) ;
        }

        /// <summary>
        /// 按时间查询
        /// </summary>
        /// <param name="start">起始时间</param>
        /// <param name="end">结束时间</param>
        /// <returns></returns>
        public static List<LeaveEntity> SelectDate(string start, string end)
        {
            string sql = "SELECT * FROM v_leavepage  WHERE LeaveTime BETWEEN '" + start + "' AND '" + end + "'";
            return Commnuity(sql).Count > 0 ? Commnuity(sql) : new List<LeaveEntity>();
        }

        /// <summary>
        /// 按部门查询请假记录信息
        /// </summary>
        /// <param name="deptname">部门名称</param>
        /// <returns></returns>
        public static List<LeaveEntity> SelectBydept(string deptname)
        {
            string sql = "SELECT * FROM v_leavepage WHERE DepartmentName='"+deptname+"' ";
            return Commnuity(sql).Count > 0 ? Commnuity(sql) : new List<LeaveEntity>();
        }


    }
}
