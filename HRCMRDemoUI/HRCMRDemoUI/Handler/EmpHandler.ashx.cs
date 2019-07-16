using HRCMDemoBLL;
using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Drawing;
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
                case "selector":
                    SelectinfoAll(context);
                    break;
                case "ddldeptbind":
                    DdlDataBind(context);
                    break;
                case "ddlRolebind":
                    DdlRolebind(context);
                    break;
                case "delete":
                    Delete(context);
                    break;
                case "insert":
                    Insert(context);
                    break;
                case "selectbyid":
                    SelectbyId(context);
                    break;
                case "updatebyid":
                    UpdatebyId(context);
                    break;
                default:
                    break;
            }

        }

        //上传头像Imgup
     

        //修改
        public void UpdatebyId(HttpContext context)
        {
            string id = context.Request["userid"];
            string str = context.Request["Eentity"];
            string[] obj = str.Split(',');
            UserInfoEntity o = new UserInfoEntity() {
                UserID = Convert.ToInt32(id),
                UserFace = obj[0],
                UserName = obj[1],
                DepartmentID = Convert.ToInt32(obj[2]),
                RoleID = Convert.ToInt32(obj[3]),
                UserAge = Convert.ToInt32(obj[4]),
                UserSex = Convert.ToInt32(obj[5]),
                UserTel = (obj[6]),
                UserIphone= (obj[6]),
                UserAddress = obj[7],
                UserRemarks = obj[8],
                BasePay = Convert.ToDouble(obj[9])
            };

            //bool bo = new UserInfoBLL().UpdateInfo(o);
            if (new UserInfoBLL().UpdateInfo(o))
            {
                LoginHandler.contextResponseWrite(context, "updatesuccess");
            }
            else
            {
                LoginHandler.contextResponseWrite(context, "updatefailed");
            }


        }

        //删除
        public void Delete(HttpContext context)
        {
            string id = context.Request["deptid"];
            //new DepartmentEntity() { DepartmentID= Convert.ToInt32(id) }
            if (new UserInfoBLL().DeleteByIdList(id))
            {
                LoginHandler.contextResponseWrite(context, "delsuccess");
            }
            else
            {
                LoginHandler.contextResponseWrite(context, "delfailed");
            }

        }

        //查询所用信息
        public void SelectinfoAll(HttpContext context)
        {
            string str = "";
            string deptid = context.Request["deptId"];
            string username = context.Request["userName"];
            if (deptid != "-1" && deptid != "")
            {
                str += " and t1.DepartmentID=" + deptid + "";
            }
            if (username != "")
            {
                str += " AND t1.UserName LIKE '%" + username + "%'";
            }
            List<UserInfoEntity> list = new UserInfoBLL().GetAllInfo(str);
            LoginHandler.contextResponseWrite(context, list);
        }

        //dept下拉框数据源
        public void DdlDataBind(HttpContext context)
        {
            List<DepartmentEntity> list = new DepartmentBLL().GetAllInfo();
            LoginHandler.contextResponseWrite(context, list);
        }


        //职位下拉框数据源
        public void DdlRolebind(HttpContext context)
        {
            List<RoleEntity> list = new RoleBLL().GetRoleAll();
            LoginHandler.contextResponseWrite(context, list);
        }

        //添加
        public void Insert(HttpContext context)
        {
            string str = context.Request["Eentity"];
            string[] obj = str.Split(',');
           

            UserInfoEntity o = new UserInfoEntity() { };
                o.UserFace = obj[0];
                o.UserName = obj[1];
                o.DepartmentID = Convert.ToInt32(obj[2]);
                o.RoleID = Convert.ToInt32(obj[3]);
                o.UserAge = Convert.ToInt32(obj[4]);
                o.UserSex = Convert.ToInt32(obj[5]);
                o.UserTel = obj[6];
                o.UserAddress = obj[7];
                o.UserRemarks = obj[8];
                o.LoginName = obj[9];
                o.LoginPwd = obj[10];
                o.BasePay = Convert.ToDouble(obj[11]);
                o.UserNumber = "NO" + obj[1];
                o.UserIphone = obj[6];

            if (new UserInfoBLL().AddInfo(o))
            {
                LoginHandler.contextResponseWrite(context, "addsuccess");
            }
            else
            {
                LoginHandler.contextResponseWrite(context, "addfailed");
            }

        }

        //查询当行
        public void SelectbyId(HttpContext context)
        {
            string id = context.Request["userid"];
            UserInfoEntity obj = new UserInfoBLL().GetInfoById(id);
            LoginHandler.contextResponseWrite(context, obj);
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