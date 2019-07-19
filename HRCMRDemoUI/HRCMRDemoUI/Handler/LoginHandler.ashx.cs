using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using HRCMDemoBLL;
using Newtonsoft.Json;
using System.Web.SessionState;
using HRCMDemoEntity;

namespace HRCMRDemoUI
{
    /// <summary>
    /// LoginHandler 的摘要说明
    /// </summary>
    public class LoginHandler : IHttpHandler,IRequiresSessionState
    {
        
        public void ProcessRequest(HttpContext context)
        {
            string method = context.Request["Method"];
            switch (method)
            {
                case "Login":
                    Login(context);
                    break;
                case "Gessession":
                    GesSession(context);
                    break;
                default:
                    break;
            }
        }

       private static UserInfoEntity obj = new UserInfoEntity();
        public void Login(HttpContext context)
        {
            string name = context.Request["name"];
            string pwd = context.Request["pwd"];
            //context.Response.ContentType = "text/plain";
            DataTable dt = new UserInfoBLL().GetTable(name, pwd);
            if (dt.Rows.Count > 0)
            {
                string id = dt.Rows[0][0].ToString();
                obj = new UserInfoBLL().GetInfoById(id);
                context.Session["user"] = dt;
                contextResponseWrite(context, dt);
                
            }
            else
            {
                contextResponseWrite(context, "1");
            }
        }

        /// <summary>
        /// 设置session
        /// </summary>
        /// <param name="context"></param>
        public void GesSession(HttpContext context)
        {
            DataTable dts = context.Session["user"] as DataTable;
            contextResponseWrite(context, dts);
        }

        
        public UserInfoEntity GetUser()
        {
            return obj;
        }

        /// <summary>
        /// 返回json交给前端页面
        /// </summary>
        /// <param name="context">上下文</param>
        /// <param name="o">传递数据</param>
        public static void contextResponseWrite(HttpContext context,object o)
        {
             string json = JsonConvert.SerializeObject(o);
             context.Response.Write(json);
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