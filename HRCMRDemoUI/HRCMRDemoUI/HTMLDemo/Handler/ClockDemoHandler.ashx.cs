using HRCMDemoBLL;
using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRCMRDemoUI.HTMLDemo.Handler
{
    /// <summary>
    /// ClockDemoHandler 的摘要说明
    /// </summary>
    public class ClockDemoHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            string op = context.Request["Method"];
            switch (op)
            {
                case "selectbyid":
                    SelectByid(context);
                    break;
                case "addclock":
                    Addclock(context);
                    break;
                default:
                    break;
            }

        }

        private void Addclock(HttpContext context)
        {
            string str = "";
            AttendanceSheetEntity obj = new AttendanceSheetEntity();
            obj.UserID = 11;
            obj.DepartmentID = 6;
            str = DateTime.Now.ToString("yyyy/MM/dd") + " 09:00:00";//上班时间
            if (DateTime.Compare(DateTime.Now, Convert.ToDateTime(str)) < 0)
            {
                obj.AttendanceType = 1;
            }
            else
            {
                obj.AttendanceType = 2;
            }
            if (new AttendanceSheetBLL().GetInsertClock(obj))
            {
                LoginHandler.contextResponseWrite(context, obj);
            }
            else
            {
                LoginHandler.contextResponseWrite(context, "clockfailed");
            }
            //throw new NotImplementedException();
        }

        private void SelectByid(HttpContext context)
        {
            object json = new AttendanceSheetBLL().GetSelectAll("11","2019","7");
            LoginHandler.contextResponseWrite(context, json);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}