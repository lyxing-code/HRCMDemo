using HRCMDemoDAL;
using HRCMDemoEntity;
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
        public DataTable GetDeptTable(string name,string str)
        {
            return DepartmentDAL.SelectDeptTable(name,str);
        }

        public  bool GetAddInfo(DepartmentEntity obj)
        {
            return DepartmentDAL.InsertInfo(obj);
        }
        public bool GetUpdateInfo(DepartmentEntity obj)
        {
            return DepartmentDAL.UpdateInfo(obj);
        }
        public bool GetDeleteInfo(DepartmentEntity obj)
        {
            return DepartmentDAL.DeleteInfo(obj);
        }

    }
}
