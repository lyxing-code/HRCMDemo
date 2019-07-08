using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoEntity
{
    [Table("JobTable")]
    public class JobTableEntity
    {
        [Key]
        public int JobNum { get; set; }

        [Required]
        [StringLength(20)]
        public string Jobname { get; set; }

    }
}
