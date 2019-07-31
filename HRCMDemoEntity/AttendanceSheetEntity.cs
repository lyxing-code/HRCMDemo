using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoEntity
{
    public class AttendanceSheetEntity : UserInfoEntity, ICategoryItemsInterface
    {
        public int AttendanceID { get; set; }
        public DateTime AttendanceStartTime { get; set; }
        public int AttendanceType { get; set; }
        public new  int UserID { get; set; }
        public new int DepartmentID { get; set; }
        public DateTime ClockTime { get; set; }
        public DateTime ClockOutTime { get; set; }
        public int Workinghours { get; set; }
        public string Remake { get; set; }
        public int Late { get; set; }
        public int Absenteeism { get; set; }

        public int CID { get  ; set ; }
        public string C_Category { get ; set ; }
        public int CI_ID { get; set ; }
        public string CI_Name { get ; set; }
    }


}
