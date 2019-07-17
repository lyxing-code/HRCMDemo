<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmpManger.aspx.cs" Inherits="HRCMRDemoUI.DeptManger" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <meta charset="utf-8" />
    <title>HRCM 人力之源管理 | 员工管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <link rel="stylesheet" type="text/css" href="css/cloud-admin.css" />
    <link rel="stylesheet" type="text/css" href="css/themes/default.css" id="skin_switcher" />
    <link rel="stylesheet" type="text/css" href="css/responsive.css" />
    <!-- STYLESHEETS -->
    <!--[if lt IE 9]><script src="js/flot/excanvas.min.js"></script><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script><![endif]-->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" />
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
    <link href='http://fonts.useso.com/css?family=Open+Sans:300,400,600,700' rel='stylesheet' type='text/css' />
    <!-- JQUERY -->
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="js/jquery/jquery-2.0.3.min.js"></script>
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


        $(function () {
            //数据加载
            BindData("select","","");

            //绑定部门下拉框
            DllBind("#selectdept");
            DllBind("#selectdeptModal");
            //绑定权限下拉框
            DllRole();
            //复合查询
            $("#selector").click(function () {
                var id = $("#selectdept > option:selected").val();
                var name = $("#empname").val();
                //alert(id + "|" + name);
                SelectByNameOrDept(id,name);
            });

            //addInfo();
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
        function BindData(op,id,name) {
              $.ajax({
             type: "get",
                    url: "Handler/EmpHandler.ashx",
                    data:
                    {
                            Method: op,
                            deptId: id,
                            userName: name,
                    },
                    dataType: "json",
                    async: false,
                    success: function (rs)
                    {
                        var str = "";
                        if (rs != "-1") {
                            $.each(rs , function (index,item) {
                                str += "<tr class=gradeA odd'>";
                                str += "<td><input type='checkbox' name='chklist' value='' id='"+item.UserID+"'  /></td>";
                                str += "<td>" + item.UserNumber + "</td>";
                                str += "<td>" + item.UserName + "</td>"; 
                                str += "<td ><img class='imagecss' alt='无法加载' src='UserFace/"+item.UserFace+"' /></td>";
                                str += "<td>" + item.DepartmentName + "</td>";
                                str += "<td>" + (item.UserSex == 1 ? "<font color='blue'>男</font>" : "<font color='red'>女</font>") + "</td>";
                                str += "<td>" + item.UserAge + "</td>";
                                str += "<td>" + item.UserTel + "</td>";
                                str += "<td>" + item.RoleName + "</td>";
                                str += "<td>" + (item.DimissionTime).substring(0,(item.DimissionTime).indexOf("T")) + "</td>";
                                str += "<td>" + (item.UserStatr == 1 ? "<font color='green'>可登录</font>" : "<font color='red'>不可登录</font>" ) + "</td>";
                                str += "<td>" + (item.BasePay + " ¥") + "</td>";
                                str +="<td><input class='btn btn-success' type='button' name='name' value='修改'  onclick='updateinfo("+item.UserID+");' /></td>"
                                str += "</tr>";

                            });
                              $("#datatable1 tr:gt(0)").remove();
                              $("#datatable1 tbody").append(str);
                        } else {
                            alert("无法加载数据!");
                        }

                    }
        });
            
        }

        
        //复合查询
        function SelectByNameOrDept(id,name) {
            //selector
            BindData("selector",id, name);
        }



        //删除部门按钮事件
        function deleteinfobyid(id) {
            if (id == "") {
                alert("请选择删除行!");
            }
            else if (confirm("是否确认删除?"))
            {
                $.ajax({
                    type: "get",
                    url: "Handler/EmpHandler.ashx",
                    data:
                    {
                       Method: "delete",
                       deptid:id
                    },
                    dataType: "json",
                 success: function (rs)
                 {
                     //alert(rs);
                     if (rs != "delfailed") 
                     {
                         alert("删除成功!");
                         BindData("select","","");
                     }
                     else
                     {
                         alert("删除失败!");
                     }
                 }
                });
            }
              
        }

        //获取选中的删除行
        function deleteinfo() {
            var str = "";
            $("input[name='chklist']").each(function (index, i) {
                //alert(i.id);
                if (this.checked) {
                    str += i.id + ",";
                }
            });
            //alert(str);
            deleteinfobyid(str.substring(0, str.length-1))
        }

         //点击全选
        function delall() {
            $("input[name='chklist']").each(function (index,i) {
                i.checked = $("#chkall").prop("checked");
            });
        }

        var arr = new Array();

        //添加事件
        function addInfo() {
            $("#addok").removeClass("disabled");
            $("#addok").show();
            $("#isupdateok").hide();
            $("#myModalLabel").text("添加员工信息")
            $('#myModal').modal({ "backdrop": "static" });//打开模态框
            $("#username").show();
            $("#userpwd1").show();
            $("#userpwd2").show();
            $("#a1").show();
            $("#a2").show();
            $("#a3").show();
            //清空文本
            $("#txtuserFaceModal").val("");
            $("#userFaceModal").attr("src","");
            $("#txtuserFaceModal").val("");
            $("#txtuserNameModal").val("");
            $("#selectdeptModal").val("-1");
            $("#selectRoleModal").val("-1");
            $("#txtuserAgeModal").val("");
            //$("input[name=userSexModal]:checked").val("");
            $("#txtuserTelModal").val("");
            $("#txtuserAdrModal").val("");
            $("#txtusermRemarkModal").val("");
            $("#txtLoginNameModal").val("");
            $("#txtLoginPwdModal1").val("");
            $("#txtLoginPwdModal2").val("");
            $("#txtuserSalModal").val("");
        }
        
        //修改信息
        function updateinfo(id)
        {
            $("#addok").hide();
            $("#isupdateok").show();
            $('#myModal').modal({ "backdrop": "static" });//打开模态框
            $("#myModalLabel").text("修改员工信息");//修改模态框标题
            $("#empid").val(id);
            $("#username").hide();
            $("#userpwd1").hide();
            $("#userpwd2").hide();
            $("#a1").hide();
            $("#a2").hide();
            $("#a3").hide();

            //绑定用户
            $.ajax({
                            type: "get",
                            url: "Handler/EmpHandler.ashx",
                            //processData: false,
                            data:
                            {
                                    Method: "selectbyid",
                                    userid: id
                            },
                            dataType: "json",
                         success: function (rs,state)
                         {
                             if (state = "success")
                             {
                                 $("#userFaceModal").attr("src", "UserFace/" + rs.UserFace);
                                 //$("#txtuserFaceModal").val(rs.UserFace);
                                 $("#txtuserNameModal").val(rs.UserName);
                                 $("#selectdeptModal").val(rs.DepartmentID);
                                 $("#selectRoleModal").val(rs.RoleID);
                                 $("#txtuserAgeModal").val(rs.UserAge);
                                 if (rs.UserSex == 1) {
                                     $("#man").prop("checked", "checked");
                                 }
                                 else
                                 {
                                      $("#won").prop("checked", "checked");
                                 }
                                 //$("input[name=userSexModal]:checked").val(rs.UserSex);
                                 $("#txtuserTelModal").val(rs.UserTel);
                                 $("#txtuserAdrModal").val(rs.UserAddress);
                                 $("#txtusermRemarkModal").val(rs.UserRemarks);
                                 $("#txtuserSalModal").val(rs.BasePay);
                             }
                             else
                             {
                                 alert("无法显示原有数据!");
                             }
                         }
                    });
        }

        //模态框添加按钮
        function AddOk() {
            
            var fliename = $("#txtuserFaceModal").val();
            //alert(fliename.substring(fliename.indexOf("h")+2));
            arr[0] = fliename.substring(fliename.indexOf("h")+2);
            arr[1] = $("#txtuserNameModal").val();
            arr[2] = $("#selectdeptModal").val();
            arr[3] = $("#selectRoleModal").val();
            arr[4] = $("#txtuserAgeModal").val();
            arr[5] = $("input[name=userSexModal]:checked").val();
            arr[6] = $("#txtuserTelModal").val();
            arr[7] = $("#txtuserAdrModal").val();
            arr[8] = $("#txtusermRemarkModal").val();
            arr[9] = $("#txtLoginNameModal").val();
            arr[10]= $("#txtLoginPwdModal2").val();
            arr[11] = $("#txtuserSalModal").val();
            var str = ""; 
            for (var i = 0; i < arr.length; i++) {
                str += arr[i] + ",";
            }
            //alert(arr);
            //alert( arr[10] + "|" +  $("#txtLoginPwdModal1").val());
            //添加
            if ($("#txtLoginPwdModal1").val() == $("#txtLoginPwdModal2").val())
            {
                 $.ajax({
                            type: "get",
                            url: "Handler/EmpHandler.ashx",
                            data:
                            {
                                    Method: "insert",
                                    Eentity: str
                            },
                            dataType: "json",
                            async: false,
                         success: function (rs)
                         {
                             if (rs = "addsuccess")
                             {
                                 Upuserface();
                                 alert("添加成功!");
                                 BindData("select","","");
                             }
                             else
                             {
                                 alert("添加失败!");
                             }
                         }
                    });

                $('#myModal').modal("hide");
            }
            else
            {
                alert("两次输入的密码不一样!");
                return;
            }

          
        }

        //模态框修改按钮
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
           
            var str = ""; 
            for (var i = 0; i < arr.length; i++) {
                str += arr[i] + ",";
               
            }
            //alert( arr[10] + "|" +  $("#txtLoginPwdModal1").val());
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
                                 BindData("select","","");
                             }
                         }
                 });
                $('#myModal').modal("hide");
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
        <div>
           <%--大层div--%>
            <div style="width: 95%; height: 90%">

               <%-- 查询层--%>
                <div style="margin-top: 15px; margin-left: 10px;">
                    <table>
                        <tr>
                            <td class=" label-inverse label-left">部门:&nbsp;&nbsp;</td>
                            <td>
                                <select  id="selectdept" class="form-control" style="width: 150px">
                                  
                                </select>
                                <%--<input type="text"  class="form-control" id="deptname" name="name" value="" />--%>
                            </td>
                            <td>&nbsp;&nbsp;</td>
                            <td class=" label-inverse label-left">姓名:&nbsp;&nbsp;</td>
                            <td>
                                <input type="text" class="form-control" id="empname" name="name" value="" />
                            </td>
                            <td>&nbsp;&nbsp;&nbsp;<input type="button" id="selector" class="btn btn-grey" name="name" value="查询" />
                            </td>
                        </tr>
                    </table>
                </div>
                <br />

                <!-- 表格-->
                <div class="container">
                    <div class="row">

                        <div id="content" class="col-lg-12">
                            <!-- DATA TABLES -->
                            <div class="row">
                                <div class="col-md-12">
                                    <!-- BOX -->
                                    <div class="box border inverse">

                                        <%--表title部分--%>
                                        <div class="box-title">
                                            <h4><i class="fa fa-table"></i>
                                                <font style="vertical-align: inherit;">
                                                <font style="vertical-align: inherit;">
                                                    员工信息
                                                </font>
                                                </font>
                                            </h4>
                                            &nbsp;&nbsp;&nbsp;
                                             <h4>
                                                 <input class="btn btn-success" type="button" name="name" value="添加" onclick="addInfo();" />
                                            </h4>
                                             &nbsp;&nbsp;&nbsp;
                                            <h4>
                                                  <input class="btn btn-danger" type="button" name="name" value="删除" onclick="deleteinfo();" />
                                            </h4>
                                            <div class="tools hidden-xs">
                                                <a href="#box-config" data-toggle="modal" class="config">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                                <a href="javascript:;" class="reload">
                                                    <i class="fa fa-refresh"></i>
                                                </a>
                                                <a href="javascript:;" class="collapse">
                                                    <i class="fa fa-chevron-up"></i>
                                                </a>
                                                <a href="javascript:;" class="remove">
                                                    <i class="fa fa-times"></i>
                                                </a>
                                            </div>
                                        </div>

                                        <%--表主体--%>
                                        <div class="box-body">

                                            <div id="datatable1_wrapper" class="dataTables_wrapper form-inline" role="grid">
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                       <%-- 搜索框--%>
                                                        <div class="pull-right">
                                                            <div class="dataTables_filter" id="datatable1_filter">
                                                                <label>
                                                                    <input type="text" aria-controls="datatable1" placeholder="搜索" class="form-control input-sm">
                                                                </label>
                                                            </div>
                                                        </div>

                                                       <%-- 显示行数--%>
                                                        <div class="pull-left">
                                                            <div id="datatable1_length" class="dataTables_length">
                                                                <label><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">节目 </font></font>
                                                                    <select size="1" name="datatable1_length" aria-controls="datatable1" class="form-control input-sm">
                                                                        <option value="10" selected="selected"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">10</font></font></option>
                                                                        <option value="25"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">25</font></font></option>
                                                                        <option value="50"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">50</font></font></option>
                                                                        <option value="100"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">100</font></font></option>
                                                                    </select>
                                                                    <font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> 行</font></font></label></div>
                                                        </div>
                                                        
                                                        <div class="clearfix"></div>
                                                    </div>
                                                </div>
                                                <table id="datatable1" cellpadding="0" cellspacing="0" border="0" class="datatable table table-striped table-bordered table-hover dataTable text-center" aria-describedby="datatable1_info">
                                                 <%--  表头--%>
                                                    <thead>
                                                        <tr role="row">
                                                            <th style="text-align:center" class="sorting_asc" role="columnheader" tabindex="0" aria-controls="datatable1" rowspan="1" colspan="1" style="width: 176px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">
                                                                <font style="vertical-align: inherit;">
                                                            <font style="vertical-align: inherit;">
                                                                 <input type="checkbox" id="chkall" name="name" value="" onchange="delall();"/>
                                                            </font>
                                                        </font>
                                                            </th>
                                                            <th style="text-align:center" class="sorting_asc" role="columnheader" tabindex="0" aria-controls="datatable1" rowspan="1" colspan="1" style="width: 176px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">
                                                                <font style="vertical-align: inherit;">
                                                            <font style="vertical-align: inherit;">编号</font>
                                                        </font>
                                                            </th>
                                                            <th style="text-align:center" class="sorting_asc" role="columnheader" tabindex="0" aria-controls="datatable1" rowspan="1" colspan="1" style="width: 176px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">
                                                                <font style="vertical-align: inherit;">
                                                            <font style="vertical-align: inherit;">姓名</font>
                                                        </font>
                                                            </th>
                                                            <th style="text-align:center" class="sorting_asc" role="columnheader" tabindex="0" aria-controls="datatable1" rowspan="1" colspan="1" style="width: 176px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">
                                                                <font style="vertical-align: inherit;">
                                                            <font style="vertical-align: inherit;">头像</font>
                                                        </font>
                                                            </th>
                                                            <th style="text-align:center" class="sorting_asc" role="columnheader" tabindex="0" aria-controls="datatable1" rowspan="1" colspan="1" style="width: 176px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">
                                                                <font style="vertical-align: inherit;">
                                                            <font style="vertical-align: inherit;">部门</font>
                                                        </font>
                                                            </th>
                                                            <th style="text-align:center" class="sorting_asc" role="columnheader" tabindex="0" aria-controls="datatable1" rowspan="1" colspan="1" style="width: 176px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">
                                                                <font style="vertical-align: inherit;">
                                                            <font style="vertical-align: inherit;">性别</font>
                                                        </font>
                                                            </th>
                                                            <th style="text-align:center" class="sorting_asc" role="columnheader" tabindex="0" aria-controls="datatable1" rowspan="1" colspan="1" style="width: 176px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">
                                                                <font style="vertical-align: inherit;">
                                                            <font style="vertical-align: inherit;">年龄</font>
                                                        </font>
                                                            </th>
                                                            <th style="text-align:center" class="sorting_asc" role="columnheader" tabindex="0" aria-controls="datatable1" rowspan="1" colspan="1" style="width: 176px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">
                                                                <font style="vertical-align: inherit;">
                                                            <font style="vertical-align: inherit;">联系电话</font>
                                                        </font>
                                                            </th>
                                                              <th style="text-align:center" class="sorting_asc" role="columnheader" tabindex="0" aria-controls="datatable1" rowspan="1" colspan="1" style="width: 176px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">
                                                                <font style="vertical-align: inherit;">
                                                            <font style="vertical-align: inherit;">职位</font>
                                                        </font>
                                                            </th>
                                                            <th style="text-align:center" class="sorting_asc" role="columnheader" tabindex="0" aria-controls="datatable1" rowspan="1" colspan="1" style="width: 176px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">
                                                                <font style="vertical-align: inherit;">
                                                            <font style="vertical-align: inherit;">入职时间</font>
                                                        </font>
                                                            </th>
                                                                 <th style="text-align:center" class="sorting_asc" role="columnheader" tabindex="0" aria-controls="datatable1" rowspan="1" colspan="1" style="width: 176px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">
                                                                <font style="vertical-align: inherit;">
                                                            <font style="vertical-align: inherit;">登录状态</font>
                                                        </font>
                                                            </th>
                                                            <th style="text-align:center" class="sorting_asc" role="columnheader" tabindex="0" aria-controls="datatable1" rowspan="1" colspan="1" style="width: 176px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">
                                                                <font style="vertical-align: inherit;">
                                                            <font style="vertical-align: inherit;">基本工资</font>
                                                        </font>
                                                            </th>
                                                              <th style="text-align:center" class="sorting_asc" role="columnheader" tabindex="0" aria-controls="datatable1" rowspan="1" colspan="1" style="width: 176px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">
                                                                <font style="vertical-align: inherit;">
                                                            <font style="vertical-align: inherit;">操作</font>
                                                        </font>
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                  <%--表主数据格--%>
                                                    <tbody role="alert" aria-live="polite" aria-relevant="all">
                                                       
                                                    </tbody>
                                                </table>
                                                <%--分页部分--%>
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <div class="pull-left">
                                                            <div class="dataTables_info" id="datatable1_info">
                                                                <font style="vertical-align: inherit;">
                                                             <font style="vertical-align: inherit;">
                                                                 显示57个参赛作品中的11到20个
                                                             </font>
                                                         </font>
                                                            </div>
                                                        </div>
                                                        <div class="pull-right">
                                                            <div class="dataTables_paginate paging_bs_full" id="datatable1_paginate">
                                                                <ul class="pagination">
                                                                    <li class="">
                                                                        <a tabindex="0" class="paginate_button first" id="datatable1_first">
                                                                            <font style="vertical-align: inherit;"><font style="vertical-align: inherit;">
                                                                        第一页
                                                                        </font>
                                                                     </font>
                                                                        </a>
                                                                    </li>
                                                                    <li class="">
                                                                        <a tabindex="0" class="paginate_button previous" id="datatable1_previous">
                                                                            <font style="vertical-align: inherit;">
                                                                         <font style="vertical-align: inherit;">
                                                                             上一页
                                                                         </font>
                                                                     </font>
                                                                        </a>
                                                                    </li>
                                                                    <li class="">
                                                                        <a tabindex="0" class="paginate_button next" id="datatable1_next">
                                                                            <font style="vertical-align: inherit;">
                                                                         <font style="vertical-align: inherit;">
                                                                             下一页
                                                                         </font>
                                                                     </font>
                                                                        </a>
                                                                    </li>
                                                                    <li class="">
                                                                        <a tabindex="0" class="paginate_button last" id="datatable1_last">
                                                                            <font style="vertical-align: inherit;">
                                                                         <font style="vertical-align: inherit;">
                                                                            最后页
                                                                         </font>
                                                                     </font>
                                                                        </a>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="clearfix"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /BOX -->
                                </div>
                            </div>
                            <!-- /DATA TABLES -->
                        </div>
                        <!-- /CONTENT-->
                    </div>

                </div>

            </div>

     <!-- 模态框（Modal） -->
      <form id="addorupdate" enctype="multipart/form-data">
       <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" >
                    <div class="modal-header">
                        <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                            &times;           
                        </button>
                        <h4 class="modal-title" id="myModalLabel">添加员工</h4>

                    </div>
                    <div class="modal-body">
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
                                   <select  id="selectdeptModal" class="form-control" name="selectdeptModal" style="width: 150px">
                                  
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
                                    <select  id="selectRoleModal" class="form-control" name="selectRoleModal" style="width: 150px">
                                  
                                    </select>
                                </td>
                            </tr>
                          <tr><td>&nbsp;</td></tr>
                          <%--  登录名txtLoginNameModal--%>
                              <tr id="username">
                                <td>
                                   <label>登录名:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <input type="text"  class="form-control" id="txtLoginNameModal" name="txtLoginNameModal" value="" />
                                </td>
                            </tr>
                                <tr id="a1"><td>&nbsp;</td></tr>
                              <%--  登录密码txtLoginPwdModal--%>
                              <tr id="userpwd1">
                                <td>
                                   <label>登录密码:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                  <input type="password"  class="form-control" id="txtLoginPwdModal1" name="txtLoginPwdModal1" value="" />
                                </td>
                            </tr>
                                <tr id="a2"><td>&nbsp;</td></tr>
                              <%--  确认密码txtLoginPwdModal--%>
                              <tr id="userpwd2">
                                <td>
                                   <label>确认密码:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                  <input type="password"  class="form-control" id="txtLoginPwdModal2" name="txtLoginPwdModal2" value="" />
                                </td>
                            </tr>
                                <tr id="a3"><td>&nbsp;</td></tr>
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
                          <%--  薪资txtuserSalModal--%>
                            <tr id="empsal">
                                <td>
                                   <label>薪资:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <input type="text" id="txtuserSalModal" class="form-control" name="txtuserSalModal" value="" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button id="addok"  type="button" class="btn btn-primary disabled" onclick="AddOk();">
                            添加     
                        </button>
                         <button id="isupdateok" hidden="hidden"  type="button" class="btn btn-primary" onclick="isupdataok();">
                            修改     
                        </button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal -->
        </div>
           </form>
      <%--模态框结束--%>

        </div>

    <script>    
         $("#txtuserFaceModal").fileinput({
            uploadUrl: '',
            allowedFileExtensions: ['jpg', 'png', 'gif'],
            maxFileSize: 1000,
            showUpload: false,
            showCaption: false,
            showZoom: true,
            browseClass:  "btn btn-success",
            maxFileCount: 1,
            msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
            msgInvalidFileExtension:"不支持该类型的文件{name},只支持{extensions}的文件!"
        });
    </script>

</body>
</html>
