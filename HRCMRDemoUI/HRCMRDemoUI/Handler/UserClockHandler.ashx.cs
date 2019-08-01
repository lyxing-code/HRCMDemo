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
            obj.UserID = user.UserID;
            obj.DepartmentID = user.DepartmentID;
            str = DateTime.Now.ToString("yyyy/MM/dd") + " 08:00:00";
            if (DateTime.Compare(DateTime.Now,Convert.ToDateTime(str)) < 0)
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
            object json = new AttendanceSheetBLL().GetSelectAll(user.UserID.ToString());
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