using HRCMDemoDAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoBLL
{
    public class UserInfoBLL
    {
        public DataTable GetTable(string name, string pwd)
        {
            return new UserInfoDAL().SelectTable(name, pwd);
        }

    }
}
