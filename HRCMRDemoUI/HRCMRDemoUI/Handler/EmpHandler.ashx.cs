using HRCMDemoBLL;
using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRCMRDemoUI.Handler
{
    /// <summary>
    /// UserInfoHandler 的摘要说明
    /// </summary>
    public class UserInfoHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string op = context.Request["Method"];
            switch (op)
            {
                case "select":
                    SelectinfoAll(context);
                    break;
                case "ddlbind":
                    DdlDataBind(context);
                    break;
                default:
                    break;
            }

        }


        public void SelectinfoAll(HttpContext context)
        {
            List<UserInfoEntity> list = new UserInfoBLL().GetAllInfo();
            LoginHandler.contextResponseWrite(context,list);
        }

        public void DdlDataBind(HttpContext context)
        {
            List<DepartmentEntity> list = new DepartmentBLL().GetAllInfo();
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