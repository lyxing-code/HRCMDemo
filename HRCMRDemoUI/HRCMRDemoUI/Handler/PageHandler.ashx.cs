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
           int pagesize = int.Parse(context.Request["Getpagesize"]) == 0 ? 5 : int.Parse(context.Request["Getpagesize"]);
           int pageindex = int.Parse(context.Request["Getpageindex"]);
           List<HRCMDemoEntity.UserInfoEntity> list = new HRCMDemoBLL.UserInfoBLL().GetPageSelect(pageindex, pagesize);
           LoginHandler.contextResponseWrite(context,list);

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