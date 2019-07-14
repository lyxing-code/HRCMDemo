<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserInfo.aspx.cs" Inherits="HRCMRDemoUI.UserInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
	<meta charset="utf-8"/>
	<title>HRCM 人力之源管理 | 员工管理</title>
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
	<script src="js/jquery/jquery-2.0.3.min.js"></script>

    <script>



    </script>

</head>
<body>
    <div id="this_user">
        <table>
            <tr>
                <td>123456</td>
            </tr>
        </table>
    </div>
       <div>
      <%--    <div style="width:95%;height:90%">
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
										<h4><i class="fa fa-table"></i>员工信息</h4>
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
              
          
          </div>--%>
        </div>
</body>
</html>
