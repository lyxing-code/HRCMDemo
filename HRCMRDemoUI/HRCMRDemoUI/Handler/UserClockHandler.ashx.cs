using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
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
            string op = context.Request["Method"];
            switch (op)
            {
                case "selectbyid":
                    SelectByid(context);
                    break;
                default:
                    break;
            }
           
        }

        private  void SelectByid(HttpContext context)
        {
            object json = new HRCMDemoBLL.AttendanceSheetBLL().GetSelectAll(user.UserID.ToString());
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