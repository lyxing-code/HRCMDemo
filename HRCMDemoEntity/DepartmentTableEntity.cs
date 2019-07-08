using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoEntity
{
    [Table("DepartmentTable")]
    public class DepartmentTableEntity
    {

        [Key]
        public int DepartmentNum { get; set; }

        [Required]
        [StringLength(20)]
        public string DepartmentName { get; set; }

    }
}
