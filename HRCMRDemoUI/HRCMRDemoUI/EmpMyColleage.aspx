<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmpMyColleage.aspx.cs" Inherits="HRCMRDemoUI.EmpSeeColleage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>HRCM 人力之源管理 | 同事信息</title>
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

    <script src="Scripts/jquery-3.3.1.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link href="js/bootstraptable/bootstrap-table.css" rel="stylesheet" />
    <script src="js/bootstraptable/bootstrap-table.js"></script>
    <script src="js/bootstraptable/bootstrap-table-zh-CN.min.js"></script>
    <script>

        function Selectbyname() {
            $("#emptable").bootstrapTable("refresh");
        }
    </script>

</head>
<body>
      <div>
          <div style="width:95%;height:90%">
              <br />
		    <!-- 表格-->
		<div class="box border inverse">
									<div class="box-title">
										<h4><i class="fa fa-table"></i>同事信息</h4>
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
                                 <table style="margin-top:5px;margin-bottom:8px;">
                                  <tr>
                                      <td>
                                          姓名:&nbsp;&nbsp;
                                      </td>
                                      <td>
                                          <input type="text" id="textUsername" class="form-control" name="name" value="" />
                                      </td>
                                  <td>
                                      &nbsp;&nbsp;&nbsp;<input type="button" class="btn btn-grey"  name="name" value="查询" onclick="Selectbyname();" />
                                  </td>
                                 </tr>
                                 </table>
									
                                    </div>
									<div class="box-body  text-center">
										<table id="emptable">
							
										  </table>
									</div>
								</div>
          </div>
        </div>

    <script>

        $(function () {
            DataTable();
        });


        //绑定datatable<a href="">Handler/EmpHandler.ashx</a>
        function DataTable() {
            $("#emptable").bootstrapTable({
                url: 'Handler/EmpHandler.ashx', //请求后台的URL（*）控制器中的方法   那个控制器 那个方法
                dataType: "json",
                //async: true,
                //method: "get",
                type: "get",
                striped: true, //是否显示行间隔色
                cache: false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true, //是否显示分页（*）
                //sortable: true, //是否启用排序
                //sidePagination: "client", //分页方式：client客户端分页，server服务端分页（*）       打开后表中才有数据
                pageNumber: 1, //初始化加载第一页，默认第一页
                clickToSelect: false, // 是否启用点击选中行
                pageSize: 10, //每页的记录行数（*）
                pageList: [5,10,30,50], //可供选择的每页的行数（*）
                queryParams: function (parms) {
                    var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                        Method: "SelectMyColleageInfo",//此参数用来判断操作
                        userName: $("#textUsername").val()
                    };
                    return temp;
                },
                columns: [
                    { field: 'UserNumber', title: '编号', align: 'center'},
                    { field: 'UserName', title: '姓名', align: 'center' },
                    { field: 'UserAge', title: '年龄', align: 'center'},
                    {
                        field: 'UserSex', title: '性别', align: 'center',
                        formatter: function (value) {
                            if (value != null) {
                                return value == 1 ? "<font color='blue'>男</font>" : "<font color='red'>女</font>" ;
                            }
                        }
                    },
                    { field: 'UserTel', title: '电话', align: 'center' },
                    {
                        field: 'BasePay', title: '薪资', align: 'center',
                        formatter: function (value) {
                            if (value != null) {
                                return "<font color='green'>" + value + "¥</font>";
                            }
                        }
                    },
                    { field: 'UserAddress', title: '地址', align: 'center' },
                    {
                        field: 'DimissionTime', title: '入职日期', align: 'center',
                        formatter: function (value) {
                            if (value != null) {
                                return value.substring(0, value.indexOf("T"));
                            }
                        }
                    },
                ]

            });
        }


    </script>
</body>
</html>
