using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoEntity
{
    [Table("StaffTable")]
    public class StaffTableEntity
    {
        [Key]
        public int StaffNum { get; set; }

        [StringLength(50)]
        public string StaffImg { get; set; }

        [StringLength(20)]
        public string StaffName { get; set; }

        public int? DepartmentNum { get; set; }

        public int StaffAge { get; set; }

        [StringLength(2)]
        public string StaffSex { get; set; }

        [Required]
        [StringLength(20)]
        public string StaffIphone { get; set; }

        [Required]
        [StringLength(20)]
        public string StaffAddress { get; set; }

        public DateTime StaffStime { get; set; }

        public int StaffWages { get; set; }

        public int? JobNum { get; set; }

        [StringLength(500)]
        public string Remarks { get; set; }



    }
}
