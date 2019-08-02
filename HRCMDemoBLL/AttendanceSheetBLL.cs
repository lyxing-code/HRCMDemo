using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoBLL
{
    public class AttendanceSheetBLL
    {
        /// <summary>
        /// 获取所有信息
        /// </summary>
        /// <returns></returns>
        public List<AttendanceSheetEntity> GetSelectAll()
        {
            return HRCMDemoDAL.AttendanceSheetDAL.SelectAll("");
        }

        /// <summary>
        /// 获取当前月份的签到信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public List<AttendanceSheetEntity> GetSelectAll(string id,string year,string month)
        {
            string str = " WHERE year(AttendanceStartTime) ="+year+" and month(AttendanceStartTime) = "+month+" AND UserID=" + id;
            return HRCMDemoDAL.AttendanceSheetDAL.SelectAll(str);
        }

        /// <summary>
        /// 上班签到
        /// </summary>
        /// <param name="obj">签到信息</param>
        /// <returns>bool</returns>
        public  bool GetInsertClock(AttendanceSheetEntity obj)
        {
            return HRCMDemoDAL.AttendanceSheetDAL.InsertClock(obj);
        }

        /// <summary>
        /// 下班签到
        /// </summary>
        /// <param name="obj">签到信息</param>
        /// <returns>bool</returns>
        public bool GetUPdateClock(AttendanceSheetEntity obj)
        {
            return HRCMDemoDAL.AttendanceSheetDAL.UPdateClock(obj);
        }
    }
}
