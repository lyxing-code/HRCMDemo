﻿using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRCMRDemoUI.Handler
{
    /// <summary>
    /// UserHandler 的摘要说明
    /// </summary>
    public class UserHandler : IHttpHandler
    {
        
        public void ProcessRequest(HttpContext context)
        {
           UserInfoEntity obj = new LoginHandler().GetUser();
           string op = context.Request["Method"];
            switch (op)
            {
                case "select":
                    LoginHandler.contextResponseWrite(context,obj);
                    break;
                default:
                    break;
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