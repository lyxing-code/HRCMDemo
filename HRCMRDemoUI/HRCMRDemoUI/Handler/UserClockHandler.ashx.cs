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
                case "selectbyprevdate":
                    SelectByDate1(context);//上个月签到情况
                    break;
                case "selectbynextdate":
                    SelectByDate2(context);//下个月签到情况
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

        private void SelectByDate2(HttpContext context)
        {
            int month = (Convert.ToInt32(context.Request["Month"]) + 1) == 12 ? 1 : (Convert.ToInt32(context.Request["Month"]) - 1);
            int year = month == 12 ? Convert.ToInt32(context.Request["Year"]) + 1 : Convert.ToInt32(context.Request["Year"]);
            List<AttendanceSheetEntity> list = new AttendanceSheetBLL().GetSelectAll(user.UserID.ToString(), (year).ToString(), (month).ToString());
            var json = from o in list
                       select new
                       {
                           time = o.AttendanceStartTime.ToString("yyyy-MM-dd"),
                           Morning = o.ClockTime.ToString("HH:mm"),
                           Afternoon = o.ClockOutTime.ToString("HH:mm"),
                           state = o.AttendanceType,
                           count = list.Count
                       };
            LoginHandler.contextResponseWrite(context, json);
            //throw new NotImplementedException();
        }

        private void SelectByDate1(HttpContext context)
        {
            int month = (Convert.ToInt32(context.Request["Month"]) - 1) ==0 ? 12 : (Convert.ToInt32(context.Request["Month"]) - 1);
            int year = month == 12 ?  Convert.ToInt32(context.Request["Year"])- 1 : Convert.ToInt32(context.Request["Year"]);
            List<AttendanceSheetEntity> list = new AttendanceSheetBLL().GetSelectAll(user.UserID.ToString(), (year).ToString(), (month).ToString());
            var json = from o in list
                       select new
                       {
                           time = o.AttendanceStartTime.ToString("yyyy-MM-dd"),
                           Morning = o.ClockTime.ToString("HH:mm"),
                           Afternoon = o.ClockOutTime.ToString("HH:mm"),
                           state = o.AttendanceType,
                           count = list.Count
                       };
            LoginHandler.contextResponseWrite(context, json);
            //throw new NotImplementedException();
        }

        private void Updateclocktwo(HttpContext context)
        {
            AttendanceSheetEntity obj = new AttendanceSheetBLL().SelectbyUserId(user.UserID.ToString());
            if (Convert.ToDateTime(obj.ClockTime.ToString("HH:mm")) >= Convert.ToDateTime("17:00"))
            {
                obj.AttendanceType = 4;
            }
            else if (obj.ClockOutTime !=DateTime.MinValue)
            {
                LoginHandler.contextResponseWrite(context, "hasclock");
            }
            else if (Convert.ToDateTime(DateTime.Now.ToString("HH:mm")) <= Convert.ToDateTime("17:00"))
            {
                obj.AttendanceType = 3;//早退
            }
            else if (Convert.ToDateTime(DateTime.Now.ToString("HH:mm")) >= Convert.ToDateTime("17:00"))
            {
                obj.AttendanceType = 1;//正常下班
            }
           
            if (new AttendanceSheetBLL().GetUPdateClock(obj))
            {
                LoginHandler.contextResponseWrite(context, obj.AttendanceType);
            }
            else
            {
                LoginHandler.contextResponseWrite(context, "clockfailed");
            }
            //throw new NotImplementedException();
        }

        private void Addclockone(HttpContext context)
        {

            AttendanceSheetEntity obj = new AttendanceSheetBLL().SelectbyUserId(user.UserID.ToString());
            //var json = from o in list
            //           where o.ClockTime.Day == DateTime.Now.Day
            //           select new
            //           {
            //               time = o.AttendanceStartTime.ToString("yyyy-MM-dd"),
            //               Morning = o.ClockTime.ToString("HH:mm"),
            //               Afternoon = o.ClockOutTime.ToString("HH:mm"),
            //               state = o.AttendanceType,
            //               count = list.Count
            //           };
            if (obj.ClockTime != DateTime.MinValue && obj.ClockOutTime != DateTime.MinValue)
            {
                LoginHandler.contextResponseWrite(context, "todayclocked");
            }
            else if (obj.ClockTime != DateTime.MinValue &&  obj.ClockOutTime == DateTime.MinValue)
            {
                LoginHandler.contextResponseWrite(context, "hasclock");
            }
            else
            {
                    obj.UserID = user.UserID;
                    obj.DepartmentID = user.DepartmentID;
                    if ((Convert.ToDateTime(DateTime.Now.ToString("HH:mm")) <= Convert.ToDateTime("09:00")))
                    {
                        obj.AttendanceType = 1;
                    }
                    else if((Convert.ToDateTime(DateTime.Now.ToString("HH:mm")) >= Convert.ToDateTime("17:00")))
                    {
                        obj.AttendanceType = 4;
                    }
                    else
                    {
                        obj.AttendanceType = 2;
                    }
                    if (new AttendanceSheetBLL().GetInsertClock(obj))
                    {
                        LoginHandler.contextResponseWrite(context, obj.AttendanceType);
                    }
                    else
                    {
                        LoginHandler.contextResponseWrite(context, "clockfailed");
                    }
                //throw new NotImplementedException();
            }
        }

        private  void SelectByid(HttpContext context)
        {
            List<AttendanceSheetEntity> list = new AttendanceSheetBLL().GetSelectAll(user.UserID.ToString(), DateTime.Now.Year.ToString(), DateTime.Now.Month.ToString());
            var json = from o in list
                       select new
                       {
                           time = o.AttendanceStartTime.ToString("yyyy-MM-dd"),
                           Morning = o.ClockTime.ToString("HH:mm"),
                           Afternoon = o.ClockOutTime.ToString("HH:mm"),
                           state = o.AttendanceType,
                           count = list.Count
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