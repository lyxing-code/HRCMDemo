using HRCMDemoDAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace HRCMDemoBLL
{
    public class DepartmentBLL
    {
        public DataTable GetDeptTable(string name)
        {
            return DepartmentDAL.SelectDeptTable(name);
        }

    }
}
