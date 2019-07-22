using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoEntity
{
    /// <summary>
    /// 申请请假
    /// </summary>
    public class LeaveEntity : UserInfoEntity
    {
        public int LeaveID { get; set; }

        public new int UserID { get; set; }

        public int LeaveState { get; set; }

        public DateTime LeaveTime { get; set; }

        public DateTime LeaveStartTime { get; set; }

        public DateTime LeaveEndTime { get; set; }

        public string LeaveHalfDay { get; set; }

        public int LeaveDays { get; set; }

        public string LeaveReason { get; set; }

        public int ApproverID { get; set; }

        public DateTime ApprovalTime { get; set; }

        public string ApproverReason { get; set; }
    }
}
