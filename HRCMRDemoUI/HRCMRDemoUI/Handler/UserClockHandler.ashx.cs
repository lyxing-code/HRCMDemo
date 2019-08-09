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
                case "updateremake":
                    UpdateRemake(context);
                    break; 
                case "SelectByUserid":
                    SelectByUserid(context);
                    break; 
                default:
                    break;
            }

        }

        //修改备注信息
        private void UpdateRemake(HttpContext context)
        {
            string idlist = context.Request["Clockid"];
            string remake = context.Request["Remake"];
            if (new AttendanceSheetBLL().GetUpdateClockRemake(idlist,remake))
            {
                LoginHandler.contextResponseWrite(context, "updatesuccess");
            }
            else
            {
                LoginHandler.contextResponseWrite(context, "updatefailed");
            }

            //throw new NotImplementedException();
        }

        //下个月签到情况
        private void SelectByDate2(HttpContext context)
        {
            int month =Convert.ToInt32(context.Request["Month"]);
            int year = Convert.ToInt32(context.Request["Year"]);
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

        //上个月签到情况
        private void SelectByDate1(HttpContext context)
        {
            int month = Convert.ToInt32(context.Request["Month"]);
            int year = Convert.ToInt32(context.Request["Year"]);
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

        //第二次下班打卡
        private void Updateclocktwo(HttpContext context)
        {
            AttendanceSheetEntity obj = new AttendanceSheetBLL().SelectbyUserId(user.UserID.ToString());
            TimeSpan workinghours = (DateTime.Now - obj.ClockTime);
            obj.Workinghours = (int)workinghours.Hours;//工作时长
            if (Convert.ToDateTime(obj.ClockTime.ToString("HH:mm")) >= Convert.ToDateTime("17:00"))
            {
                obj.AttendanceType = 4;
                obj.Absenteeism = 0;
            }
            else if (obj.ClockOutTime !=DateTime.MinValue)
            {
                LoginHandler.contextResponseWrite(context, "hasclock");
            }
            else if (Convert.ToDateTime(DateTime.Now.ToString("HH:mm")) <= Convert.ToDateTime("17:00"))
            {
                obj.AttendanceType = 3;//早退
                TimeSpan t = Convert.ToDateTime("17:00") - (Convert.ToDateTime(DateTime.Now.ToString("HH:mm")));
                obj.Absenteeism = (int)t.TotalMinutes;

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

        //第一次上班打卡
        private void Addclockone(HttpContext context)
        {

            AttendanceSheetEntity obj = new AttendanceSheetBLL().SelectbyUserId(user.UserID.ToString());
           
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
                        obj.Absenteeism = 0;
                    }
                    else
                    {
                        obj.AttendanceType = 2;
                        TimeSpan t = Convert.ToDateTime("09:00") - (Convert.ToDateTime(DateTime.Now.ToString("HH:mm")));
                        obj.Late = (int)t.TotalMinutes;
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

        //查询当前当月的打卡信息
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

        //查询当月的打卡信息
        private void SelectByUserid(HttpContext context)
        {
            DateTime time =Convert.ToDateTime(context.Request["time"]);
            string userid = context.Request["id"];
            List<AttendanceSheetEntity> list = new AttendanceSheetBLL().GetSelectAll(userid.ToString(), time.Year.ToString(), time.Month.ToString());
            var json = from o in list
                       //where o.Late > 0
                       select new
                       {
                           time =o.AttendanceStartTime,
                           cd=o.Late,
                           zt=o.Absenteeism
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