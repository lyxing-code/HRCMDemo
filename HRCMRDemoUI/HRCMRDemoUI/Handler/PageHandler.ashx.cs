using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRCMRDemoUI.Handler
{
    /// <summary>
    /// PageHandler 的摘要说明
    /// </summary>
    public class PageHandler : IHttpHandler
    {

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
                default:
                    break;
            }


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