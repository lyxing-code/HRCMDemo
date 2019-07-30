using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoBLL
{
    public class LeaveBLL
    {
        /// <summary>
        /// bootstraptable分页查询
        /// </summary>
        /// <param name="pageindex">当前页码</param>
        /// <param name="pagesize">显示条数</param>
        /// <returns></returns>
        public List<LeaveEntity> GetBootstrapPageSelect(int pageindex, int pagesize, ref int count)

        {
            return HRCMDemoDAL.LeaveDAL.BootstrapPageSelect(pageindex, pagesize, ref count);
        }


        /// <summary>
        /// 添加请假信息
        /// </summary>
        /// <param name="obj">请假的实例</param>
        /// <returns>bool</returns>
        public bool AddLeaveInfo(LeaveEntity obj)
        {

            return HRCMDemoDAL.LeaveDAL.InsertInfo(obj);
        }

        /// <summary>
        /// 查询所有信息
        /// </summary>
        /// <returns></returns>
        public List<LeaveEntity> GetSelectAll()
        {
            return HRCMDemoDAL.LeaveDAL.SelectAll();
        }

        /// <summary>
        /// 删除信息
        /// </summary>
        /// <param name="idlist">请假信息id的集合字符串</param>
        /// <returns>bool</returns>
        public bool GetDeleteInfoBylevidlist(string idlist)
        {
            return HRCMDemoDAL.LeaveDAL.DeleteInfoBylevidlist(idlist);
        }


        /// <summary>
        /// 按时间查询
        /// </summary>
        /// <param name="start">起始时间</param>
        /// <param name="end">结束时间</param>
        /// <returns></returns>
        public List<LeaveEntity> GetSelectDate(string start, string end)
        {
            return HRCMDemoDAL.LeaveDAL.SelectDate(start, end);
        }

        /// <summary>
        /// 按部门获取请假记录信息
        /// </summary>
        /// <param name="deptname">部门名称</param>
        /// <returns></returns>
        public  List<LeaveEntity> GetSelectBydept(string deptname,string str)
        {
            return HRCMDemoDAL.LeaveDAL.SelectBydept(deptname, str);
        }


        /// <summary>
        /// 审批请假
        /// </summary>
        /// <param name="idlist">请假信息id</param>
        /// <param name="state">审批状态</param>
        /// <param name="reason">备注</param>
        /// <returns></returns>
        public  bool GetUpdateLeavestateByidlist(string idlist, string state, string reason, string ApproverID)
        {
            return HRCMDemoDAL.LeaveDAL.UpdateLeavestateByidlist(idlist, state, reason, ApproverID);
        }

    }
}
