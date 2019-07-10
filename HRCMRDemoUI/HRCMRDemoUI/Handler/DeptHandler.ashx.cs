using HRCMDemoBLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HRCMRDemoUI.Handler
{
    /// <summary>
    /// DeptHandler 的摘要说明
    /// </summary>
    public class DeptHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string name =context.Request["deptname"];
            context.Response.ContentType = "text/plain";
            DataTable dt = new DepartmentBLL().GetDeptTable(name);
            //发送json给前端页面
            LoginHandler.contextResponseWrite(context,dt);
            //context.Response.Write("Hello World");
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