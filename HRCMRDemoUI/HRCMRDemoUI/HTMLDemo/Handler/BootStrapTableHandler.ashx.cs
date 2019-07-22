using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HRCMDemoBLL;
using HRCMDemoEntity;

namespace HRCMRDemoUI.HTMLDemo
{
    /// <summary>
    /// BootStrapTableHandler 的摘要说明
    /// </summary>
    public class BootStrapTableHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            int pagesize = Convert.ToInt32(context.Request["limit"]);
            int pageindex = Convert.ToInt32(context.Request["offset"]);
            List<UserInfoEntity> list = new UserInfoBLL().GetBootstrapPageSelect(pageindex,pagesize);//GetAllInfo("")
            var json = new
            {
                total = new UserInfoBLL().GetAllInfo("").Count,
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