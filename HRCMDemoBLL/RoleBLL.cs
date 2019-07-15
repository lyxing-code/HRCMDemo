using HRCMDemoEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoBLL
{
    public class RoleBLL
    {
        public  List<RoleEntity> GetRoleAll()
        {
            return HRCMDemoDAL.RoleDAL.SelectAll();
        }

    }
}
