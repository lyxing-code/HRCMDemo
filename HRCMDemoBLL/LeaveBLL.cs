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
        public  List<LeaveEntity> GetBootstrapPageSelect(int pageindex, int pagesize,ref int count)
        {
            return HRCMDemoDAL.LeaveDAL.BootstrapPageSelect(pageindex, pagesize, ref count);
        }
    }
}
