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
        /// 获取单个信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public List<AttendanceSheetEntity> GetSelectAll(string id)
        {
            string str = " WHERE UserID ="+id;
            return HRCMDemoDAL.AttendanceSheetDAL.SelectAll(str);
        }

        /// <summary>
        /// 签到
        /// </summary>
        /// <param name="obj">签到信息</param>
        /// <returns>bool</returns>
        public  bool GetInsertClock(AttendanceSheetEntity obj)
        {
            return HRCMDemoDAL.AttendanceSheetDAL.InsertClock(obj);
        }


    }
}
