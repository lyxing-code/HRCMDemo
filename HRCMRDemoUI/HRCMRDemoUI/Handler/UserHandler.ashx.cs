using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace HRCMRDemoUI.Handler
{
    /// <summary>
    /// UserHandler 的摘要说明
    /// </summary>
    public class UserHandler : IHttpHandler, IRequiresSessionState
    {
      
        public void ProcessRequest(HttpContext context)
        {
            UserInfoEntity obj = (UserInfoEntity)context.Session["getuser"];//new LoginHandler().GetUser();
            string op = context.Request["Method"];
          

            switch (op)
            {
                case "select":
                    LoginHandler.contextResponseWrite(context, obj);
                    break;
                case "ckeck":
                    UpdatePwd(context);
                    break;
                default:
                    break;
            }

        }

        public void UpdatePwd(HttpContext context)
        {
            string OldeValue = context.Request["OldeValue"];
            string NewValue = context.Request["NewValue"];
            UserInfoEntity o = (UserInfoEntity)context.Session["getuser"];
            if (o.LoginPwd == OldeValue)
            {
                if (new HRCMDemoBLL.UserInfoBLL().GetUpdateLoginPwd(NewValue, o.UserID.ToString()))
                {
                    LoginHandler.contextResponseWrite(context, "updatesuccess");
                }
                else
                {
                    LoginHandler.contextResponseWrite(context, "updatefailed");
                }
            }
            else
            {
                LoginHandler.contextResponseWrite(context, "failed");
            }

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