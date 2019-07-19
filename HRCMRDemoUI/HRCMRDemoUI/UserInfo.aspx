<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserInfo.aspx.cs" Inherits="HRCMRDemoUI.UserInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
	<meta charset="utf-8"/>
	<title>HRCM 人力之源管理 | 个人信息</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no"/>
	<meta name="description" content=""/>
	<meta name="author" content=""/>
	<link rel="stylesheet" type="text/css" href="css/cloud-admin.css" />
	<link rel="stylesheet" type="text/css"  href="css/themes/default.css" id="skin_switcher" />
	<link rel="stylesheet" type="text/css"  href="css/responsive.css" />
	<!-- STYLESHEETS --><!--[if lt IE 9]><script src="js/flot/excanvas.min.js"></script><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script><![endif]-->
	<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet"/>
	<!-- ANIMATE -->
	<link rel="stylesheet" type="text/css" href="css/animatecss/animate.min.css" />
	<!-- DATE RANGE PICKER -->
	<link rel="stylesheet" type="text/css" href="js/bootstrap-daterangepicker/daterangepicker-bs3.css" />
	<!-- TODO -->
	<link rel="stylesheet" type="text/css" href="js/jquery-todo/css/styles.css" />
	<!-- FULL CALENDAR -->
	<link rel="stylesheet" type="text/css" href="js/fullcalendar/fullcalendar.min.css" />
	<!-- GRITTER -->
	<link rel="stylesheet" type="text/css" href="js/gritter/css/jquery.gritter.css" />
	<!-- FONTS -->
	<link href='http://fonts.useso.com/css?family=Open+Sans:300,400,600,700' rel='stylesheet' type='text/css'/>
    <!-- JQUERY -->
	 <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.3.1.min.js"></script>
   <%-- <script src="js/jquery/jquery-2.0.3.min.js"></script>--%>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="js/fileupjs/fileinput.min.js"></script>
    <link href="css/fileup/fileinput.css" rel="stylesheet" />
    <script src="js/fileupjs/fileinput_locale_zh.js"></script>
    <style>
       
        .imagecss {
            width:29px;
            height:29px;
            border-radius:50%;
        }

    </style>

    <script>
        var arr = new Array();

        $(function () {
            BindData("select")
            //绑定部门下拉框
            DllBind("#selectdeptModal");
            //绑定权限下拉框
            DllRole();
            //控件数据绑定
            Coldatabind();

        });

           //绑定部门下拉框
        function DllBind(name) {
                $.ajax({
             type: "get",
                    url: "Handler/EmpHandler.ashx",
                    data:
                    {
                        Method:"ddldeptbind",
                    },
                    async: false,//同步发送请求
                    dataType: "json",
                    success: function (rs)
                    {
                        var str = "<option value='-1'>==请选择==</option>";
                        if (rs != "-1") {
                            $.each(rs, function (index, item) {
                                str += "<option value='" + item.DepartmentID + "'>";
                                str += item.DepartmentName;
                                str += "</tr>";
                            });
                            //alert(rs);
                              $(name).append(str);
                        } else {
                            alert("下拉框无法加载数据!");
                        }

                    }
                });
        }

        //绑定职位下拉框
        function DllRole() {
              $.ajax({
             type: "get",
                    url: "Handler/EmpHandler.ashx",
                    data:
                    {
                        Method:"ddlRolebind",
                    },
                    async: false,//同步发送请求
                    dataType: "json",
                    success: function (rs)
                    {
                        var str = "<option value='-1'>==请选择==</option>";
                        if (rs != "-1") {
                            $.each(rs, function (index, item) {
                                str += "<option value='" + item.RoleID + "'>";
                                str += item.RoleName;
                                str += "</tr>";
                            });
                            //alert(rs);
                              $("#selectRoleModal").append(str);
                        } else {
                            alert("下拉框无法加载数据!");
                        }

                    }
                });

        }

        //数据绑定
        function BindData(op) {
              $.ajax({
             type: "get",
                    url: "Handler/UserHandler.ashx",
                    data:
                    {
                            Method: op,
                    },
                    dataType: "json",
                    async: false,
                    success: function (rs)
                    {
                        //$("#selectdeptModal").removeClass("dis")disabled="disabled"
                        arr[0] = rs.UserFace;
                        arr[1] = rs.UserName;
                        arr[2] = rs.DepartmentID;
                        arr[3] = rs.RoleID;
                        arr[4] = rs.UserAge;
                        arr[5] = rs.UserSex;
                        arr[6] = rs.UserTel;
                        arr[7] = rs.UserAddress;
                        arr[8] = rs.UserRemarks;
                        arr[9] = rs.DimissionTime;
                        arr[10] = rs.BasePay;
                        $("#empid").val(rs.UserID);
                        
                    }
        });
            
        }

        function Coldatabind() {
                        $("#userFaceModal").attr("src","UserFace/"+arr[0])
                        $("#txtuserNameModal").val(arr[1]);
                        $("#selectdeptModal").val(arr[2]);
                        $("#selectRoleModal").val(arr[3]);
                        $("#txtuserAgeModal").val(arr[4]);

                        if (arr[5] == 0)
                        {
                             $("input[name=userSexModal]:eq(1)").prop("checked","checked");
                        }
                        else
                        {
                             $("input[name=userSexModal]:eq(0)").prop("checked","checked");
                        }
                       
                        $("#txtuserTelModal").val(arr[6]);
                        $("#txtuserAdrModal").val(arr[7]);
                        $("#txtusermRemarkModal").val(arr[8]);
                        $("#txtuserDimissionTimeModal").val(arr[9]);
                        $("#txtuserSalModal").val(arr[10]);
        }
     

        function isupdataok() {
            var empid = $("#empid").val();
            //$("#txtuserFaceModal").val();
            var fliename = $("#txtuserFaceModal").val() == "" ?  $("#userFaceModal").attr("src") : $("#txtuserFaceModal").val();
            arr[0] = fliename.substring(fliename.indexOf("h")+2);
            arr[1] = $("#txtuserNameModal").val();
            arr[2] = $("#selectdeptModal").val();
            arr[3] = $("#selectRoleModal").val();
            arr[4] = $("#txtuserAgeModal").val();
            arr[5] = $("input[name=userSexModal]:checked").val();
            arr[6] = $("#txtuserTelModal").val();
            arr[7] = $("#txtuserAdrModal").val();
            arr[8] = $("#txtusermRemarkModal").val();
            arr[9] = $("#txtuserSalModal").val();
            arr[10] = $("#txtuserDimissionTimeModal").val();
            var str = ""; 
            for (var i = 0; i < arr.length; i++) {
                str += arr[i] + ",";
               
            }
           // alert(str + " |" + empid);
                 $.ajax({
                            type: "get",
                            url: "Handler/EmpHandler.ashx",
                            data:
                            {
                                    Method: "updatebyid",
                                    Eentity: str,
                                    userid :empid,
                            },
                            dataType: "json",
                         success: function (rs)
                         {
                             if (rs != "updatesuccess")
                             {
                                 alert("修改失败!");
                             }
                             else
                             {
                                 Upuserface();
                                 alert("修改成功!");
                             }
                         }
                 });
        }

         //上传图片
        function Upuserface() {

              var datalist = new FormData($("#addorupdate")[0]);
            //图片上传
            $.ajax(
                {
                    type: "post",
                    url: "Handler/ImageHandler.ashx",
                    data: datalist,
                    dataType: "json",
                    async: false,
                    contentType: false,
                    processData: false,
                    success: function (rs) {
                        //alert(rs.txtuserNameModal);
                    },
                    error: function (rs) {
                        //alert(rs);
                    }

                });

        } 

        
    </script>

</head>
<body>
    <form id="addorupdate" enctype="multipart/form-data">
            <div id="this_user" style="margin-left:20px;">
           <%--表title部分--%>
                <div class="box-title">
                    <h4><i class="fa fa-table"></i>
                         <font style="vertical-align: inherit;">
                             <font style="vertical-align: inherit;">
                                        个人信息
                                  </font>
                                   </font>
                   </div>
                <table class="text-center">
                             <tr>
                                 <td>
                                     <input type="hidden" id="empid" name="name" value="" />
                                 </td>
                                 <td>&nbsp;</td>
                             </tr>
                            <%--用户头像--%>
                             <tr>
                                <td>
                                   <label>头像:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <img class="imagecss" src="#" alt="无法加载" id="userFaceModal" />
                                </td>
                            </tr>
                            <tr><td>&nbsp;</td></tr>
                           <%-- 头像上传txtuserFaceModal--%>
                            <tr>
                                <td>
                                   <label>头像上传:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <input onchange="" type="file" id="txtuserFaceModal" class="field" name="txtuserFaceModal"  multiple="multiple"/>
                                </td>
                            </tr>
                          <tr><td>&nbsp;</td></tr>
                            <%--姓名txtuserNameModal--%>
                              <tr>
                                <td>
                                   <label>姓名:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <input type="text" id="txtuserNameModal" class="form-control field" name="txtuserNameModal" value=""/>
                                </td>
                            </tr>
                          <tr><td>&nbsp;</td></tr>
                           <%-- 部门selectdeptModal--%>
                              <tr>
                                <td>
                                   <label>部门:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                   <select  id="selectdeptModal" disabled="disabled" class="form-control disabled" name="selectdeptModal" style="width: 150px">
                                       
                                    </select>
                                </td>
                            </tr>
                          <tr><td>&nbsp;</td></tr>
                          <%--  职位selectRoleModal--%>
                              <tr>
                                <td>
                                   <label>职位:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <select  id="selectRoleModal" disabled="disabled" class="form-control" name="selectRoleModal" style="width: 150px">
                                        
                                    </select>
                                </td>
                            </tr>
                          <tr><td>&nbsp;</td></tr>
                            <%--年龄txtuserAgeModal--%>
                              <tr>
                                <td>
                                   <label>年龄:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <input type="text" id="txtuserAgeModal" class="form-control field" name="txtuserAgeModal" value=""/>
                                </td>
                            </tr>
                          <tr><td>&nbsp;</td></tr>
                            <%--性别userSexModal--%>
                              <tr>
                                <td>
                                   <label>性别:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <input type="radio" id="man"  name="userSexModal" value="1"  />男
                                    &nbsp;&nbsp;
                                    <input type="radio" id="won"  name="userSexModal" value="0"/> 女
                                </td>
                            </tr>
                          <tr><td>&nbsp;</td></tr>
                            <%--电话txtuserTelModal--%>
                              <tr>
                                <td>
                                   <label>电话:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <input type="text" id="txtuserTelModal" class="form-control field" name="txtuserTelModal" value=""/>
                                </td>
                            </tr>
                          <tr><td>&nbsp;</td></tr>
                          <%--  地址txtuserAdrModal--%>
                              <tr>
                                <td>
                                   <label>地址:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <input type="text" id="txtuserAdrModal" class="form-control field" name="txtuserAdrModal" value=""/>
                                </td>
                            </tr>
                          <tr><td>&nbsp;</td></tr>
                      <%--  入职时间txtuserDimissionTimeModal--%>
                            <tr id="empdimissionTime">
                                <td>
                                   <label>入职时间:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <input type="text"  disabled="disabled" id="txtuserDimissionTimeModal" class="form-control" name="txtuserSalModal" value="" />
                                </td>
                            </tr>
                     <tr><td>&nbsp;</td></tr>
                      <%--  薪资txtuserSalModal--%>
                            <tr id="empsal">
                                <td>
                                   <label>薪资:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <input type="text" disabled="disabled" id="txtuserSalModal" class="form-control" name="txtuserSalModal" value="" />
                                </td>
                            </tr>
                             <tr><td>&nbsp;</td></tr>
                          <%--  备注txtusermRemarkModal--%>
                            <tr id="Remark">
                                <td>
                                   <label>备注:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <input type="text" id="txtusermRemarkModal" class="form-control" name="txtusermRemarkModal" value="" />
                                </td>
                            </tr>
                     <tr><td>&nbsp;</td></tr>
                            <tr>
                                <td></td>
                                <td>
                                    <input type="button" onclick="isupdataok();" class=" btn btn-default" name="name" value="修改" />
                                    &nbsp;&nbsp;
                                    <input type="button" class=" btn btn-default" name="name" value="取消" />
                                </td>
                            </tr>
                     </table>

    </div>
    </form>

    <script>    
         $("#txtuserFaceModal").fileinput({
            //uploadUrl: 'Handler/ImageHandler.ashx',//上传自动请求handler
            allowedFileExtensions: ['jpg', 'png', 'gif'],
            maxFileSize: 1000,
            showUpload: false,
            showCaption: false,
            showZoom: false,
            browseClass:  "btn btn-success",
            maxFileCount: 1,
            msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
            msgInvalidFileExtension:"不支持该类型的文件{name},只支持{extensions}的文件!"
        });
    </script>

</body>
</html>
