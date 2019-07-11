using HRCMDemoBLL;
using HRCMDemoEntity;
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
            //opname
            string op = context.Request["opname"];
            switch (op)
            {
                case "select":
                    Select(context);
                    break;
                case "selectbyname":
                    SelectByName(context, "selectbyname");
                    break;
                case "selectbyid":
                    SelectByid(context, "selectbyid");
                    break;
                case "insert":
                    Add(context);
                    break;
                case "delete":
                    Delete(context);
                    break;
                case "update":
                    Update(context);
                    break;
                default:
                    break;
            }
       
        }

        //select
        public void Select(HttpContext context)
        {
            string name = context.Request["deptname"];
            context.Response.ContentType = "text/plain";
            DataTable dt = new DepartmentBLL().GetDeptTable(name,"");
            if (dt.Rows.Count > 0)
            {
                //发送json给前端页面
                LoginHandler.contextResponseWrite(context, dt);
            }
            else
            {
                LoginHandler.contextResponseWrite(context, "-1");
            }
           
        }

        public void SelectByName(HttpContext context,string op)
        {
            string name = context.Request["deptname"];
            context.Response.ContentType = "text/plain";
            DataTable dt = new DepartmentBLL().GetDeptTable(name, "selectbyname");
            if (dt.Rows.Count > 0)
            {
                //发送json给前端页面
                LoginHandler.contextResponseWrite(context, dt);
            }
            else
            {
                LoginHandler.contextResponseWrite(context, "-1");
            }

        }

        
        public void SelectByid(HttpContext context, string op)
        {
            string deptid = context.Request["deptid"];
            context.Response.ContentType = "text/plain";
            DataTable dt = new DepartmentBLL().GetDeptTable(deptid, "selectbyid");
            if (dt.Rows.Count > 0)
            {
                //发送json给前端页面
                LoginHandler.contextResponseWrite(context, dt);
            }
            else
            {
                LoginHandler.contextResponseWrite(context, "-1");
            }

        }


        //add
        public void Add(HttpContext context)
        {
            string name = context.Request["deptname"];
            string rek = context.Request["deptrek"];
            DepartmentEntity o = new DepartmentEntity();
            o.DepartmentName = name;
            o.DepartmentRemarks = rek;
            if (new DepartmentBLL().GetAddInfo(o))
            {
                LoginHandler.contextResponseWrite(context, "addsuccess");
            }
            else
            {
                LoginHandler.contextResponseWrite(context, "addfailed");
            }
            
        }

        //delete
        public void Delete(HttpContext context)
        {
            string id = context.Request["deptid"];
            if (new DepartmentBLL().GetDeleteInfo(new DepartmentEntity() { DepartmentID= Convert.ToInt32(id) }))
            {
                LoginHandler.contextResponseWrite(context, "delsuccess");
            }
            else
            {
                LoginHandler.contextResponseWrite(context, "delfailed");
            }

        }

        //update
        public void Update(HttpContext context)
        {
            string id = context.Request["deptid"];
            string name = context.Request["deptname"];
            string rek = context.Request["deptrek"];
            DepartmentEntity o = new DepartmentEntity();
            o.DepartmentID = Convert.ToInt32(id);
            o.DepartmentName = name;
            o.DepartmentRemarks = rek;
            if (new DepartmentBLL().GetUpdateInfo(o))
            {
                LoginHandler.contextResponseWrite(context, "updatesuccess");
            }
            else
            {
                LoginHandler.contextResponseWrite(context, "updatefailed");
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