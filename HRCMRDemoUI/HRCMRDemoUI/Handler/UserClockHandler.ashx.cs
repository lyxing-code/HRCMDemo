using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using HRCMDemoBLL;
using HRCMDemoEntity;

namespace HRCMRDemoUI.Handler
{
    /// <summary>
    /// UserClockHandler 的摘要说明
    /// </summary>
    public class UserClockHandler : IHttpHandler,IRequiresSessionState
    {
        UserInfoEntity user = null;
        public void ProcessRequest(HttpContext context)
        {
            user = context.Session["getuser"] as UserInfoEntity;
            string op = context.Request["Method"];//
            switch (op)
            {
                case "selectbyid":
                    SelectByid(context);
                    break;
                case "clockone":
                    Addclockone(context);
                    break;
                case "clocktwo":
                    Updateclocktwo(context);
                    break;
                default:
                    break;
            }
           
        }

        private void Updateclocktwo(HttpContext context)
        {
            AttendanceSheetEntity obj = new AttendanceSheetEntity();
            obj.UserID = user.UserID;
            if (Convert.ToDateTime(DateTime.Now.ToString("HH:mm")) <= Convert.ToDateTime("17:00"))
            {
                obj.AttendanceType = 3;
            }
            else
            {
                obj.AttendanceType = 1;
            }
            if (new AttendanceSheetBLL().GetUPdateClock(obj))
            {
                LoginHandler.contextResponseWrite(context, obj);
            }
            else
            {
                LoginHandler.contextResponseWrite(context, "clockfailed");
            }
            //throw new NotImplementedException();
        }

        private void Addclockone(HttpContext context)
        {
           
            AttendanceSheetEntity obj = new AttendanceSheetEntity();
            obj.UserID = user.UserID;
            obj.DepartmentID = user.DepartmentID;
            if ((Convert.ToDateTime(DateTime.Now.ToString("HH:mm")) <= Convert.ToDateTime("09:00")))
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

        private  void SelectByid(HttpContext context)
        {
           
            var json = from o in new AttendanceSheetBLL().GetSelectAll(user.UserID.ToString(),DateTime.Now.Year.ToString(),DateTime.Now.Month.ToString())
                       select new
                       {
                           time = o.AttendanceStartTime.ToString("yyyy-MM-dd"),
                           Morning = o.ClockTime.ToString("HH:mm"),
                           Afternoon = o.ClockOutTime.ToString("HH:mm"),
                           state = o.AttendanceType
                       };
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