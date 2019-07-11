<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Department.aspx.cs" Inherits="HRCMRDemoUI.Department" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
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
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="js/jquery/jquery-2.0.3.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script>

        //加载数据
        $(function () {
            databind("select");
        });
        
        function databind(op) {
             $.ajax({
                    type: "get",
                    url: "Handler/DeptHandler.ashx",
                    data:
                    {
                       opname: op,
                       deptname: $("#deptname").val(),
                    },
                    dataType: "json",
                 success: function (rs)
                 {
                     if (rs != "-1") {
                         var str = ""
                         $.each(rs, function (index, itme) {
                             str += "<tr>";
                             str += "<td>" + itme.DepartmentID + "</td>";
                             str += "<td>" + itme.DepartmentName + "</td>";
                             str += "<td>" + itme.DepartmentRemarks + "</td>";
                             str += "<td><input type='button' class='btn  btn-success'  name='name' value='修改' onclick='updatainfo(" + itme.DepartmentID + ");' />&nbsp;&nbsp;&nbsp;<input type='button' class='btn btn-danger'  name='name' value='删除' onclick='deleteinfo(" + itme.DepartmentID + ");' /></td>";
                             str += "</tr>";
                         });
                         //保留表头
                         $("#datatable tr:gt(0)").remove();
                         $("#datatable tbody").append(str);
                     } else {
                         alert("无法加载数据!");
                     }
                    
                 }
                });
        }

        //删除部门按钮事件
        function deleteinfo(id) {

            if (confirm("是否确认删除?"))
            {
                $.ajax({
                    type: "get",
                    url: "Handler/DeptHandler.ashx",
                    data:
                    {
                       opname: "delete",
                       deptid:id
                    },
                    dataType: "json",
                 success: function (rs)
                 {
                     if (rs = "delsuccess")
                     {
                         alert("删除成功!");
                         databind("select");
                     }
                     else
                     {
                         alert("删除失败!");
                     }
                 }
                });
            }
              
        }
      
        //修改部门按钮事件
         function updatainfo(id) {
              //alert(id);
              $("#deptid").val(id);
              //alert($("#deptid").val());
             $("#myModalLabel").text("修改部门");
             $("#isupdateok").show();
             $("#isok").hide();
             //加载选中行的数据到模态框控件中
             $.ajax({
                    type: "get",
                    url: "Handler/DeptHandler.ashx",
                    data:
                    {
                       opname: "selectbyid",
                       deptid : id,
                    },
                    dataType: "json",
                 success: function (rs)
                 {
                     //alert(rs);   
                     //绑定值
                     $("#txtdeptnameModal").val(rs[0].DepartmentName),
                     $("#txtdeptmRemarkModal").val(rs[0].DepartmentRemarks)
                 }
            });

             $('#myModal').modal({ "backdrop": "static" });//打开模态框
        }
        
        //键盘点击事件
        function onkeycode() {
            if ($("#txtdeptnameModal").val() == "" || (($("#txtdeptnameModal").val()).indexOf(" ")) != -1) {
                $("#error").text("请输入部门名称");//修改文本错误信息
                $("#error").show();//显示错误信息
                $("#isok").addClass("disabled");//禁用添加按钮
            }
            else
            {
                     $.ajax({
                        type: "get",
                        url: "Handler/DeptHandler.ashx",
                        data:
                        {
                           opname: "selectbyname",
                           deptname: $("#txtdeptnameModal").val(),
                        },
                         dataType: "json",
                         success: function (rs)
                         {
                             if (rs != "-1") {
                                 $("#isok").addClass("disabled");
                                 //$("#isupdateok").addClass("disabled");
                                 $("#error").text("部门已经存在!")
                                 $("#error").show();
                             }
                             else
                             {
                                 $("#isok").removeClass("disabled");//解除添加按钮
                                 //$("#isupdateok").removeClass("disabled");
                                 $("#error").hide();//隐藏错误文本信息
                             }
                         }
                });
 
                }
             };
        
        
        //添加部门
         function addedpt() {
            //alert(id);
            $('#myModal').modal({ "backdrop": "static" });//打开模态框
            $("#myModalLabel").text("添加部门");//修改模态框标题
             //清空控件数据
             $("#txtdeptnameModal").val("");
             $("#txtdeptmRemarkModal").val("");

             $("#error").text("请输入部门名称");
             $("#error").show();
             $("#isok").addClass("disabled");
             $("#isok").show();
             $("#isupdateok").hide();//隐藏修改按钮
         }

        //模态框添加按钮
        function opOk() {
           //var a = $("#txtdeptmModal").val();
            //添加
            $.ajax({
                    type: "get",
                    url: "Handler/DeptHandler.ashx",
                    data:
                    {
                       opname: "insert",
                       deptname: $("#txtdeptnameModal").val(),
                       deptrek :$("#txtdeptmRemarkModal").val()
                    },
                    dataType: "json",
                 success: function (rs)
                 {
                     if (rs = "addsuccess")
                     {
                         alert("添加成功!");
                         databind("select");
                     }
                     else
                     {
                         alert("添加失败!");
                     }
                 }
            });
            $('#myModal').modal("hide");
        }

        //模态框修改按钮
        function isupdataok() {
            //alert($("#deptid").val());
            //修改
               $.ajax({
                    type: "get",
                    url: "Handler/DeptHandler.ashx",
                    data:
                    {
                       opname: "update",
                       deptid : $("#deptid").val(),
                       deptname: $("#txtdeptnameModal").val(),
                       deptrek :$("#txtdeptmRemarkModal").val()
                    },
                    dataType: "json",
                 success: function (rs)
                 {
                     if (rs = "updatesuccess")
                     {
                         alert("修改成功!");
                         databind("select");
                     }
                     else
                     {
                         alert("修改失败!");
                     }
                 }
            });
            $('#myModal').modal("hide");
        }

    </script>

</head>
<body>
        <div>
          <div style="width:95%;height:90%">
              <div style="margin-top:15px;margin-left:10px;">
                  <table>
                      <tr>
                          <td class=" label-inverse label-left">部门名称:&nbsp;&nbsp;</td>
                          <td>
                               <input type="text"  class="form-control" id="deptname" name="name" value="" />
                          </td>
                          <td>
                              &nbsp;&nbsp;&nbsp;<input type="button" class="btn btn-grey"  name="name" value="查询" onclick="databind('select');" />
                          </td>
                          <td>
                              &nbsp;&nbsp;&nbsp;<input type="button" id="adddept" class="btn btn-grey"  name="name" value="添加" onclick="addedpt();" />
                          </td>
                      </tr>
                  </table>
              </div>
              <br />
		    <!-- 表格-->
		<div class="box border inverse">
									<div class="box-title">
										<h4><i class="fa fa-table"></i>部门信息</h4>
										<div class="tools">
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
									<div class="box-body  text-center">
										<table class="table table-bordered table-hover" id="datatable">
											<thead>
											  <tr>
												<th  style="text-align:center">部门编号</th>
												<th  style="text-align:center">部门名称</th>
												<th  style="text-align:center">备注</th>
												<th  style="text-align:center">操作</th>
											  </tr>
											</thead>
											<tbody>
											</tbody>
										  </table>
									</div>
								</div>



           <!-- 模态框（Modal） -->
       <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" >
                    <div class="modal-header">
                        <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                            &times;           
                        </button>
                        <h4 class="modal-title" id="myModalLabel">修改部门 </h4>

                    </div>
                    <div class="modal-body">
                        <table class="text-center">
                            <tr>
                                <td>
                                   <label>部门名称:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <input type="text" id="txtdeptnameModal" class="form-control" name="name" value=""   onkeyup="onkeycode();"/>
                                </td>
                                <td>
                                   &nbsp;&nbsp;&nbsp;<label id="error" class="text-danger">请输入部门名称</label>
                                </td>
                            </tr>
                             <tr>
                                 <td>
                                     <input type="hidden" id="deptid" name="name" value="" />
                                 </td>
                                 <td>&nbsp;</td>
                             </tr>
                            <tr id="Remark">
                                <td>
                                   <label>备注:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <input type="text" id="txtdeptmRemarkModal" class="form-control" name="name" value="" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button id="isok"  type="button" class="btn btn-primary disabled" onclick="opOk();">
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
              
          
          </div>
        </div>
    
</body>
</html>
