using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoEntity
{
    public class UserInfoEntity
    {
        public int UserID { get; set; }
        public int DepartmentID { get; set; }
        public int RoleID { get; set; }
        public string UserNumber { get; set; }
        public string UserFace { get; set; }
        public string LoginName { get; set; }
        public string LoginPwd { get; set; }
        public string UserName { get; set; }
        public int UserAge { get; set; }
        public int UserSex { get; set; }
        public string UserTel { get; set; }
        public string UserAddress { get; set; }
        public string UserIphone { get; set; }
        public string UserRemarks { get; set; }
        public int UserStatr { get; set; }
        public DateTime EntryTime { get; set; }
        public DateTime DimissionTime { get; set; }
        public double BasePay { get; set; }
        public string  DepartmentName { get; set; }
        public string RoleName { get; set; }
    }
}
