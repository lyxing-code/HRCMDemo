using HRCMDemoBLL;
using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace HRCMRDemoUI.Handler
{
    /// <summary>
    /// PageHandler 的摘要说明
    /// </summary>
    public class PageHandler : IHttpHandler,IRequiresSessionState
    {
        UserInfoEntity user = null;
        public void ProcessRequest(HttpContext context)
        {
            string ops = context.Request["ops"];


            switch (ops)
            {
                case "setpage":
                    SetPage(context);
                    break;
                case "getmaxpage":
                    Getmaxpage(context);
                    break;
                case "selectclockpage":
                    Selectclockpage(context);//当日签到信息分页
                    break;
                default:
                    break;
            }


        }
       
        private void Selectclockpage(HttpContext context)
        {
           
            user = (UserInfoEntity)context.Session["getuser"];
            int pageindex =Convert.ToInt32(context.Request["offset"]);
            int pagesize = Convert.ToInt32(context.Request["limit"]);
            string username = context.Request["username"];
            int count = 0;
            List <AttendanceSheetEntity> clocklist = new AttendanceSheetBLL().GetSelectbyPage(pageindex, pagesize, user.DepartmentID.ToString(), ref count);
            if (username != "")
            {
                var list = from o in clocklist
                           where o.UserName.Contains(username)
                           select new
                           {
                               CI_ID = o.CI_ID,
                               UserID = o.UserID,
                               AttendanceID = o.AttendanceID,
                               UserName = o.UserName,
                               ClockTime = o.ClockTime,
                               ClockOutTime = o.ClockOutTime,
                               remake = o.Remake,
                               CI_Name = o.CI_Name

                           };
                var json = new
                {
                    total = list.Count(),
                    rows = list
                };
                LoginHandler.contextResponseWrite(context, json);
            }
            else
            {

                var list = from o in clocklist
                           select new
                       {
                           CI_ID = o.CI_ID,
                           UserID = o.UserID,
                           AttendanceID = o.AttendanceID,
                           UserName = o.UserName,
                           ClockTime = o.ClockTime,
                           ClockOutTime = o.ClockOutTime,
                           remake = o.Remake,
                           CI_Name = o.CI_Name

                       };
                var json = new
                {
                    total = count,
                    rows = list
                };
                LoginHandler.contextResponseWrite(context,json);
            }
           
            //throw new NotImplementedException();
        }


        private void Getmaxpage(HttpContext context)
        {
            //throw new NotImplementedException();
            double pagesize = int.Parse(context.Request["Getpagesize"]) == 0 ? 5 : int.Parse(context.Request["Getpagesize"]);
            double querycount = new HRCMDemoBLL.UserInfoBLL().GetAllInfo("").Count;
            pagesize = Math.Ceiling((querycount / pagesize));
            LoginHandler.contextResponseWrite(context, pagesize);

        }

        public void SetPage(HttpContext context)
        {
            int pagesize = int.Parse(context.Request["Getpagesize"]) == 0 ? 5 : int.Parse(context.Request["Getpagesize"]);
            int pageindex = int.Parse(context.Request["Getpageindex"]);
            List<HRCMDemoEntity.UserInfoEntity> list = new HRCMDemoBLL.UserInfoBLL().GetPageSelect(pageindex, pagesize);
            LoginHandler.contextResponseWrite(context, list);

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