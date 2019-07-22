using HRCMDemoBLL;
using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRCMRDemoUI.Handler
{
    /// <summary>
    /// LeaveHandler 的摘要说明
    /// </summary>
    public class LeaveHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {

            int pagesize = Convert.ToInt32(context.Request["limit"]);
            int pageindex = Convert.ToInt32(context.Request["offset"]);
            int count = 0;
            List<LeaveEntity> list = new LeaveBLL().GetBootstrapPageSelect(pageindex, pagesize,ref count);//GetAllInfo("")
            var json = new
            {
                total = count,
                rows = list
            };
            LoginHandler.contextResponseWrite(context, json);


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