using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoDAL
{
    public static class AttendanceSheetDAL
    {
        private static List<AttendanceSheetEntity> Commnuity(string sql, params SqlParameter[] parameter)
        {
            List<AttendanceSheetEntity> list = new List<AttendanceSheetEntity>();
            SqlDataReader sdr = DBHelper.GetReader(sql, parameter);
            while (sdr.Read())
            {
                AttendanceSheetEntity obj = new AttendanceSheetEntity() { };
                   obj.UserID = Convert.ToInt32(sdr["UserID"]);
                   obj.DepartmentID = Convert.ToInt32(sdr["DepartmentID"]);
                   obj.AttendanceID = Convert.ToInt32(sdr["AttendanceID"]);
                   obj.AttendanceStartTime = Convert.ToDateTime(sdr["AttendanceStartTime"] is DBNull ? DateTime.MinValue : sdr["AttendanceStartTime"]);
                   obj.AttendanceType = Convert.ToInt32(sdr["AttendanceType"]);
                   obj.ClockTime = Convert.ToDateTime(sdr["ClockTime"] is DBNull ? DateTime.MinValue : sdr["ClockTime"]);
                   obj.ClockOutTime = Convert.ToDateTime(sdr["ClockOutTime"] is DBNull ? DateTime.MinValue : sdr["ClockOutTime"]);
                   obj.Workinghours = Convert.ToInt32(sdr["Workinghours"] is DBNull ? 0 : sdr["Workinghours"]);
                   obj.Remake = Convert.ToString(sdr["Remake"] is DBNull ? "" : sdr["Remake"]);
                   obj.Late = Convert.ToInt32(sdr["Late"] is DBNull ? 0 : sdr["Late"]);
                   obj.Absenteeism = Convert.ToInt32(sdr["Absenteeism"] is DBNull ? 0 :sdr["Absenteeism"]);
                   obj.CI_ID = Convert.ToInt32(sdr["CI_ID"]);
                   obj.CI_Name = Convert.ToString(sdr["CI_Name"]);
                   obj.DepartmentName = Convert.ToString(sdr["DepartmentName"]);
                   obj.UserName = Convert.ToString(sdr["UserName"]);
                   list.Add(obj);
            }
            return list;
        }



        /// <summary>
        /// 查询所有信息
        /// </summary>
        /// <returns></returns>
        public static List<AttendanceSheetEntity> SelectAll(string wherestr)
        {
            string sql = "SELECT * FROM v_attendance " + wherestr;
            return Commnuity(sql).Count > 0 ? Commnuity(sql) : new List<AttendanceSheetEntity>();
        }

       

        /// <summary>
        /// 上班签到
        /// </summary>
        /// <param name="obj">签到信息</param>
        /// <returns>bool</returns>
        public static bool InsertClock(AttendanceSheetEntity obj)
        {
            string sql = "insert  AttendanceSheet values(getdate(),"+obj.AttendanceType + ","+obj.UserID+","+obj.DepartmentID+",getdate(),null,null,null,null,null)";
            return DBHelper.UpdateOpera(sql);
        }
        
        /// <summary>
        /// 下班签到
        /// </summary>
        /// <param name="obj">签到信息</param>
        /// <returns>bool</returns>
        public static bool UPdateClock(AttendanceSheetEntity obj)
        {
            string sql = "UPDATE v_attendance SET ClockOutTime = getdate(),Workinghours = "+obj.Workinghours+" ,AttendanceType=" + obj.AttendanceType+ ",Late="+obj.Late+ ",Absenteeism="+obj.Absenteeism+" WHERE day(AttendanceStartTime) =  day(getdate()) and UserID =" + obj.UserID;
            return DBHelper.UpdateOpera(sql);
        }

        /// <summary>
        /// 当天签到数据
        /// </summary>
        /// <param name="pageindex">起始页</param>
        /// <param name="pagesize">显示条数</param>
        /// <param name="deptid">部门id</param>
        /// <param name="count">数据条数</param>
        /// <returns></returns>
        public static List<AttendanceSheetEntity> SelectbyPage(int pageindex, int pagesize, string deptid,ref int count)
        {
            string sql = "SELECT* FROM " +
                "(SELECT  row_number() OVER(order BY AttendanceID) AS idx, " +
                "*FROM v_attendance  where DepartmentID = "+ deptid + " AND year(AttendanceStartTime)= year(getdate()) AND month(AttendanceStartTime)= month(getdate())  AND day(AttendanceStartTime) = day(getdate())" +
                " )a WHERE 1 = 1 AND idx BETWEEN "+ (pageindex+1) + " AND "+ (pageindex+pagesize) + "";
            List <AttendanceSheetEntity> list= Commnuity(sql).Count > 0 ? Commnuity(sql) : new List<AttendanceSheetEntity>();
            count = Commnuity("SELECT  row_number() OVER (order BY AttendanceID) AS idx,* FROM v_attendance  where DepartmentID="+ deptid + " AND year(AttendanceStartTime)= year(getdate()) AND month(AttendanceStartTime)= month(getdate()) AND day(AttendanceStartTime)=day(getdate())").Count;
            return list;
        }

        /// <summary>
        /// 修改考勤记录
        /// </summary>
        /// <param name="id"></param>
        /// <param name="remake"></param>
        /// <returns></returns>
        public static bool UpdateClockRemake(string id,string remake)
        {
            string sql = "UPDATE AttendanceSheet SET remake = '"+ remake + "' WHERE AttendanceID in ("+id+")";
            return DBHelper.UpdateOpera(sql);
        }

        /// <summary>
        /// 复合查询签到数据
        /// </summary>
        /// <param name="pageindex">起始页</param>
        /// <param name="pagesize">显示条数</param>
        /// <param name="wherestr">查询条件</param>
        /// <param name="count">数据条数</param>
        /// <returns></returns>
        public static List<AttendanceSheetEntity> SelectClockListPage(int pageindex, int pagesize,string wherestr, ref int count)
        {
            string sql = "SELECT * FROM (SELECT  row_number() OVER(order BY AttendanceID) AS idx, *FROM v_attendance" +
                " WHERE 1 = 1 " +wherestr+
                ")a where  idx BETWEEN "+ (pageindex+1) + " AND "+(pagesize+ pageindex) +"";
            //"and DepartmentID = 6--AND year(AttendanceStartTime) = year(getdate()) AND month(AttendanceStartTime) = month(getdate()) AND day(AttendanceStartTime) = day(getdate())" +
            List<AttendanceSheetEntity> list = Commnuity(sql).Count > 0 ? Commnuity(sql) : new List<AttendanceSheetEntity>();
            string sql2 = "SELECT * FROM (SELECT  row_number() OVER(order BY AttendanceID) AS idx, *FROM v_attendance" +
                " WHERE 1 = 1 " + wherestr +
                ")a";
            count = Commnuity(sql2).Count;
            return list;
        }
 

    }
}
