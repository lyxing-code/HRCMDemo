using HRCMDemoBLL;
using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;

namespace HRCMRDemo.Controllers
{
    public class HRCMDemoController : Controller
    {
        static  LoginTableEntity obj0 = new LoginTableEntity();
        // GET: HRCMDemo
        //[Authorize]
        public ActionResult Index()
        {
            string id = Request.QueryString["idm"].ToString() ?? "";
            @ViewBag.User = obj0.LoginName;
            return View();
        }

        [HttpPost]
        public ActionResult Index(LoginTableEntity obj)
        {
            return View();
        }


        public ActionResult Login()
        {
            if (obj0.LoginState)
            {
                if (Request.Cookies["name"] != null && Request.Cookies["pwd"] != null)
                {
                    obj0.LoginName = Request.Cookies["name"].Value;
                    obj0.LoginPwd = Request.Cookies["pwd"].Value;
                }
                return View(obj0);
            }
            else
            {
                return View();
            }
           
        }

        /// <summary>
        ///  设置cookies
        /// </summary>
        /// <param name="obj"></param>
        public void CreateCookie(LoginTableEntity obj)
        {
            HttpCookie namecookies = new HttpCookie("name", obj.LoginName);
            HttpCookie pwdcookies = new HttpCookie("pwd", obj.LoginPwd);
            namecookies.Expires = DateTime.Now.AddMinutes(0.5);
            pwdcookies.Expires = DateTime.Now.AddMinutes(0.5);
            Response.Cookies.Add(namecookies);
            Response.Cookies.Add(pwdcookies);
          
        }


        [HttpPost]
        public ActionResult Login(LoginTableEntity obj)
        {

            if (obj.LoginName != null && obj.LoginPwd != null)
            {
                if (new LoginTableBLL().IsLoginOk(obj))
                {
                    if (obj.LoginState)
                    {
                        obj0.LoginState = true;
                        obj0.LoginName = obj.LoginName;
                        CreateCookie(obj);
                    }
                    return RedirectToAction("Index", "HRCMDemo" ,new { idm = new LoginTableBLL().SelectAllById(obj.LoginName).JobNum });
                }
                else
                {
                    return Content("<script>alert('账号密码有误!');history.go(-1);</script>","text/html");
                    //return JavaScript("alert('账号密码有误!');");
                }
            }
            else
            {
                    //return Content("<script>alert('账号密码不能为空!');history.go(-1);</script>", "text/html");
                return View(obj);
            }
            
        }




    }
}