using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoEntity
{

    [Table("LoginTable")]
    public class LoginTableEntity 
    {
        [Key]
        public int LoginId { get; set; }

        [Required(ErrorMessage = "用户名不能为空!")]
        [StringLength(20)]
        public string LoginName { get; set; }

        [Required(ErrorMessage = "密码不能为空!")]
        [StringLength(20)]
        public string LoginPwd { get; set; }

        public int? StaffNum { get; set; }

        public int JobNum { get; set; }

        public bool LoginState { get; set; }

    }

    
}

