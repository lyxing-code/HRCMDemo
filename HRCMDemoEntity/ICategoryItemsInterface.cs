using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HRCMDemoEntity
{
    /// <summary>
    /// 字典数据表的接口
    /// </summary>
    interface ICategoryItemsInterface
    {
        
         int CID { get; set; }
         string C_Category { get; set; }
         int CI_ID { get; set; }
         string CI_Name { get; set; }


    }


}
