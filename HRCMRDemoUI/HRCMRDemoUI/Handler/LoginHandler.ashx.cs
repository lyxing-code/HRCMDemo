using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using HRCMDemoBLL;
using Newtonsoft.Json;

namespace HRCMRDemoUI
{
    /// <summary>
    /// LoginHandler 的摘要说明
    /// </summary>
    public class LoginHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string name = context.Request["name"];
            string pwd = context.Request["pwd"];
            context.Response.ContentType = "text/plain";
            DataTable dt = new UserInfoBLL().GetTable(name, pwd);
            if (dt.Rows.Count>0)
            {
                contextResponseWrite(context, dt);
                //json = JsonConvert.SerializeObject(dt);
                //context.Response.Write(json);
            }
            else
            {
                //json = JsonConvert.SerializeObject(dt);
                contextResponseWrite(context, "1");
            }
        }

        public void contextResponseWrite(HttpContext context,object o)
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