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
        $(function () {
            databind();

        });
        
        function databind() {
             $.ajax({
                    type: "get",
                    url: "Handler/DeptHandler.ashx",
                    data:
                    {
                       deptname :$("#deptname").val()
                    },
                    dataType: "json",
                 success: function (rs)
                 {
                     var str = ""
                     $.each(rs, function (index,itme) {
                         str += "<tr>";
                         str += "<td>" + itme.DepartmentID + "</td>";
                         str += "<td>" + itme.DepartmentName + "</td>";
                         str += "<td>" + itme.DepartmentRemarks + "</td>";
                         str += "<td><input type='button' class='btn  btn-success'  name='name' value='修改' onclick='updatainfo("+itme.DepartmentID+");' />&nbsp;&nbsp;&nbsp;<input type='button' class='btn btn-danger'  name='name' value='删除' onclick='deleteinfo("+itme.DepartmentID+");' /></td>";
                         str += "</tr>";
                     });
                     //保留表头
                     $("#datatable tr:gt(0)").remove();
                     $("#datatable tbody").append(str);
                 }
                });
        }

        function deleteinfo(id) {
            alert(id);
        }

         function updatainfo(id) {
            //alert(id);
            $('#myModal').modal({ "backdrop": "static" });//打开模态框
        }
    </script>



</head>
<body>
        <div>
          <div style="width:95%;height:90%">
              <div>
                  <table>
                      <tr>
                          <td class=" label-inverse label-left">部门名称:&nbsp;&nbsp;</td>
                          <td>
                               <input type="text"  class="form-control" id="deptname" name="name" value="" />
                          </td>
                          <td>
                              &nbsp;&nbsp;&nbsp;<input type="button" class="btn btn-grey"  name="name" value="查询" onclick="databind();" />
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
                    <div class="modal-body">在这里添加一些文本         </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary">
                            提交更改           
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
