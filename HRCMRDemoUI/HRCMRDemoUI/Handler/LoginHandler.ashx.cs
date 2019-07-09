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
             string  json = JsonConvert.SerializeObject(dt);
             context.Response.Write(json);
             context.Response.Redirect("Index.aspx");
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