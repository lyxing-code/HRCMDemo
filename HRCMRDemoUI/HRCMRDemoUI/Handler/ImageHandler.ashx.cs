using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRCMRDemoUI.Handler
{
    /// <summary>
    /// ImageHandler 的摘要说明
    /// </summary>
    public class ImageHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            int i = context.Request.Files.Count;
            if (i > 0)
            {
                HttpPostedFile file = context.Request.Files[0];
                string filename = context.Server.MapPath(@"~/UserFace/" + file.FileName);
                file.SaveAs(filename);
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