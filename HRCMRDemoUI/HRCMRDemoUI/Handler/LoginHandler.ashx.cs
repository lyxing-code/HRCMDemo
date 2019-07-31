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
                    GetSession(context);
                    break;
                default:
                    break;
            }
        }

        public void Login(HttpContext context)
        {
            string name = context.Request["name"];
            string pwd = context.Request["pwd"];
            //context.Response.ContentType = "text/plain";
            DataTable dt = new UserInfoBLL().GetTable(name, pwd);

            if (dt.Rows.Count > 0)
            {
                string id = dt.Rows[0][0].ToString();
                context.Session["getuser"] = new UserInfoBLL().GetInfoById(id);
                UserInfoEntity obj = (UserInfoEntity)context.Session["getuser"];

                if (obj.UserStatr == 1)
                {
                    //context.Session["user"] = dt;
                    //修改最后登录时间
                    new UserInfoBLL().GetUpadteLoginTime(obj.UserID.ToString());
                    contextResponseWrite(context, dt);
                }
                else
                {
                    contextResponseWrite(context, "enableed");
                    return;
                }
            }else
            {
                contextResponseWrite(context, "1");
            }

            
           
        }

        /// <summary>
        /// 设置session
        /// </summary>
        /// <param name="context"></param>
        public void GetSession(HttpContext context)
        {
            UserInfoEntity obj = context.Session["getuser"] as UserInfoEntity;
            contextResponseWrite(context, obj);
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