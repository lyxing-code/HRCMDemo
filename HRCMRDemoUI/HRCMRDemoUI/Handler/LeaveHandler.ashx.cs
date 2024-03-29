﻿using HRCMDemoBLL;
using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace HRCMRDemoUI.Handler
{
    /// <summary>
    /// LeaveHandler 的摘要说明
    /// </summary>
    public class LeaveHandler : IHttpHandler,IRequiresSessionState
    {
        UserInfoEntity user = null;//new LoginHandler().GetUser();

        public void ProcessRequest(HttpContext context)
        {
            user = (UserInfoEntity)context.Session["getuser"];
            string op = context.Request["op"];
            switch (op)
            {
                case "select":
                    SelectLeaveinfo(context);
                    break;
                case "selectbyid":
                    SelectLeavebyidinfo(context);
                    break;
                case "addinfo":
                    AddLeaveInfo(context);
                    break;
                case "deleteinfo":
                    Deleteinfo(context);
                    break;
                case "selectbydept":
                    Selectbydept(context);
                    break; 
                case "updateleavestate":
                    Updateleavestate(context);
                    break; 
                default:
                    break;
            }
         

        }

        /// <summary>
        /// 修改审核状态
        /// </summary>
        /// <param name="context"></param>
        private void Updateleavestate(HttpContext context)
        {
            string ids = context.Request["leaveid"];
            string state = context.Request["leavestate"];
            string reason = context.Request["leavereason"];
            if (user.RoleID != 4 || user.RoleID != 5)
            {
                if (new LeaveBLL().GetUpdateLeavestateByidlist(ids, state, reason,user.UserID.ToString()))
                {
                    LoginHandler.contextResponseWrite(context, "updatesuccess");
                }
                else
                {
                    LoginHandler.contextResponseWrite(context, "updatefailed");
                }
            }
            else
            {
                LoginHandler.contextResponseWrite(context, "error");
            }


            //throw new NotImplementedException();
        }

        /// <summary>
        /// 请假审核信息
        /// </summary>
        /// <param name="context"></param>
        private void Selectbydept(HttpContext context)
        {
            string starttime = (context.Request["starttime"]);
            string endtime = (context.Request["endtime"]);
            if (user.RoleID != 4 || user.RoleID !=5)
            {
                
                List<LeaveEntity> list = null;
                if (starttime !="" && endtime !="")
                {
                    string str = " AND LeaveTime BETWEEN '"+ starttime + "' AND '"+ endtime + "'";
                    list = new LeaveBLL().GetSelectBydept(user.DepartmentName, str);
                }
                else
                {
                    list = new LeaveBLL().GetSelectBydept(user.DepartmentName,"");
                }

                
                LoginHandler.contextResponseWrite(context, list);
            }
            else
            {
                LoginHandler.contextResponseWrite(context, "error");
            }
            //throw new NotImplementedException();
        }

        /// <summary>
        /// 添加申请请假信息
        /// </summary>
        /// <param name="context"></param>
        public void AddLeaveInfo(HttpContext context)
        {
            if (user.UserID ==0)
            {
                LoginHandler.contextResponseWrite(context, "addfailed");
            }
            else
            {
                LeaveEntity obj = new LeaveEntity();
                obj.UserID = user.UserID;
                obj.LeaveStartTime = Convert.ToDateTime(context.Request["txtdateStartModal"]);
                obj.LeaveEndTime = Convert.ToDateTime(context.Request["txtdateEndModal"]);
                obj.LeaveHalfDay =  context.Request["selectdaytimes"];
                obj.LeaveDays = Convert.ToInt32(context.Request["LeaveTimeChaModal"]);
                obj.LeaveReason = context.Request["txtLeaveRemarkModal"];
                if (new LeaveBLL().AddLeaveInfo(obj))
                {
                    LoginHandler.contextResponseWrite(context, "addsuccess");
                }
                else
                {
                    LoginHandler.contextResponseWrite(context, "addfailed");
                }
            }
         
        }

        /// <summary>
        /// 获取当前请假编号查询审批信息
        /// </summary>
        /// <param name="context"></param>
        private  void SelectLeavebyidinfo(HttpContext context)
        {
            int id =Convert.ToInt32(context.Request["leaveid"]);
            //使用linq条件查询
            var data = from o in new LeaveBLL().GetSelectAll()
                       where o.LeaveID == id
                       select o;
            LoginHandler.contextResponseWrite(context, data);
        }

        /// <summary>
        /// 获取所有请假的信息记录
        /// </summary>
        /// <param name="context"></param>
        private  void SelectLeaveinfo(HttpContext context)
        {
            string starttime = (context.Request["starttime"]);
            string endtime = (context.Request["endtime"]);
            int pagesize = Convert.ToInt32(context.Request["limit"]);
            int pageindex = Convert.ToInt32(context.Request["offset"]);
            int count = 0;
            List<LeaveEntity> list = new LeaveBLL().GetBootstrapPageSelect(pageindex, pagesize, ref count);//GetAllInfo("")

            if (starttime != "" && endtime !="")
            {
                var datetime = from o in new LeaveBLL().GetSelectDate(starttime, endtime)
                           where o.UserID == user.UserID
                           select o;
                var json = new
                {
                    total = datetime.ToList().Count,//count,
                    rows = datetime
                };
                LoginHandler.contextResponseWrite(context, json);
            }
            else
            {
                var date = from o in list
                           where o.UserID == user.UserID
                           select o;
                var json = new
                {
                    total = date.ToList().Count,//count,
                    rows = date
                };
                LoginHandler.contextResponseWrite(context, json);
            }
            
          
        }

        /// <summary>
        /// 删除请假信息
        /// </summary>
        /// <param name="context"></param>
        private  void Deleteinfo(HttpContext context)
        {
            string str = context.Request["idlist"];
            string [] strarr = str.Split(',');
            List<LeaveEntity> list = new LeaveBLL().GetSelectAll();
           //循环判断是否有的信息已经审批过 如果有则不能删除记录
            for (int i = 0; i < strarr.Length; i++)
            {
                var date = from o in list
                           where o.LeaveID.ToString() == strarr[i]
                           where o.LeaveState != 3
                           select o;
                if (date.ToList().Count > 0 )
                {
                    LoginHandler.contextResponseWrite(context, "checksuccess");
                    return;
                }
            }
            if (new LeaveBLL().GetDeleteInfoBylevidlist(str))
            {
                LoginHandler.contextResponseWrite(context, "delsuccess");
            }
            else
            {
                LoginHandler.contextResponseWrite(context, "delfailed");
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