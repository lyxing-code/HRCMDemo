<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LeaveManger.aspx.cs" Inherits="HRCMRDemoUI.LeaveManger" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>HRCM 人力之源管理 | 请假管理</title>
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

    <script src="js/datetimepicker/bootstrap-datetimepicker.js"></script>
    <link href="js/datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <script src="js/datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="js/bootstraptable/bootstrap-table-zh-CN.min.js"></script>
    <script>    
        $(function () {
            DllBind("#selectdept");
        });

        //绑定部门下拉框
        function DllBind(name) {
            $.ajax({
                type: "get",
                url: "Handler/EmpHandler.ashx",
                data:
                {
                    Method: "ddldeptbind",
                },
                async: true,//同步发送请求
                dataType: "json",
                success: function (rs) {
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

        function ApplicationCheck() {
            $("#myModal").modal("show");
        }

        function submitinfo() {
            $("#myModal").modal("hide");
            $("#CheckViewModal").modal("show");
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
										<h4><i class="fa fa-table"></i>申请审批</h4>
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
                                    <td class=" label-inverse label-left">部门:&nbsp;&nbsp;</td>
                                    <td>
                                        <select  id="selectdept" class="form-control" style="width: 150px">
                                  
                                        </select>
                                      
                                        <%--<input type="text"  class="form-control" id="deptname" name="name" value="" />--%>
                                    </td>
                                       <td>&nbsp;</td>
                                       <td>
                                          <input type="datetime"  placeholder="按照申请时间查询"  style="width:150px;"  class=" form-control" id="timestart" name="name" value="" />
                                       </td>
                                       <td>
                                          <label>至</label>
                                       </td>
                                       <td>
                                          <input type="datetime" style="width:150px;" placeholder="按照申请时间查询"  class=" form-control " id="timeend" name="name" value="" />
                                       </td>
                                       <td>&nbsp;</td>
                                      <td>
                                            <input type="button" class="btn btn-grey"  name="name" value="查询" onclick="Selectbydate();" />
                                      </td>
                                          <td>&nbsp;</td>
                                      <td>
                                           <input type="button" id="addleave" class="btn btn-yellow"  name="name" value="审批" onclick="ApplicationCheck();" />
                                      </td>
                                     </tr>
                                 </table>
									
                                    </div>
									<div class="box-body  text-center">
										<table id="leavetable">
							
										  </table>
									</div>
								</div>
           <!-- 模态框（Modal-table） -->
    <form id="formleaveadd" enctype="multipart/form-data">
       <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" >
                    <div class="modal-header">
                        <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                            &times;           
                        </button>
                        <h4 class="modal-title" id="myModalLabel">请假审批</h4>
                    </div>
                    <div class="modal-body">
                        <table class="text-center">
                            <tr>
                                <td>
                                   <label>请假理由:</label>
                                </td>
                                <td>
                                   <textarea id="txtLeaveRemarkModal1" disabled="disabled"  style="width:500px"  class="form-control" name="txtLeaveRemarkModal"></textarea>
                                </td>
                            </tr>
                            <tr><td>&nbsp;</td></tr>
                             <tr>
                                 <td>
                                     <input type="hidden" id="LeaveIdModal"   name="name" value="" />
                                 </td>
                                 <td>&nbsp;</td>
                             </tr>
                            <tr id="Remark">
                                <td>
                                   <label>审批理由:</label>
                                </td>
                                <td>
                                    <textarea id="txtLeaveRemarkModal2" style="width:500px" name="txtLeaveRemarkModal"  class="form-control"></textarea>
                                </td>
                            </tr>
                               <tr><td>&nbsp;</td></tr>
                            <tr>
                                <td>
                                   <label>审批结果:</label>
                                </td>
                                <td>
                                    <select id="selectcheck" class="form-control" style="width: 150px">
                                        <option value="0" selected="selected">=请选择=</option>
                                        <option value="1">同意</option>
                                        <option value="2">驳回</option>
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">退出</button>
                         <button id="isupdateok" hidden="hidden"  type="button" class="btn btn-primary" onclick="submitinfo();">
                            保存  
                        </button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal -->
        </div>
   </form>     
              
         <!-- 模态框（Modal-view） -->
    <div class="modal fade" id="CheckViewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" >
                    <div class="modal-header">
                        <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                            &times;           
                        </button>
                        <h4 class="modal-title" id="ViewModalLabel">操作提示</h4>
                    </div>
                    <div class="modal-body">
                        <label>操作成功</label>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">确定</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal -->
        </div>



          </div>
        </div>
    <script>
        $(function () {
            //日历控件初始化
            BindDate();
            //绑定datatable
            DataTable();
        });

        //绑定datatable
        function DataTable() {
            $("#leavetable").bootstrapTable({
                url: 'Handler/LeaveHandler.ashx', //请求后台的URL（*）控制器中的方法   那个控制器 那个方法
                dataType: "json",
                method: "get",
                striped: true, //是否显示行间隔色
                cache: false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                //pagination: true, //是否显示分页（*）
                //sortable: true, //是否启用排序
                //sidePagination: "client", //分页方式：client客户端分页，server服务端分页（*）       打开后表中才有数据
                pageNumber: 1, //初始化加载第一页，默认第一页
                clickToSelect: false, // 是否启用点击选中行
                pageSize: 50, //每页的记录行数（*）
                pageList: [50], //可供选择的每页的行数（*）
                queryParams: function (parms) {
                    var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                        op: "selectbydept",//此参数用来判断操作
                        starttime: $("#timestart").val(),
                        endtime: $("#timeend").val()
                    };
                    return temp;
                },
                columns: [
                    { checkbox: true },
                    { field: 'CI_ID', title: '状态编号', align: 'center', class: 'hidden' },
                    { field: 'UserID', title: '用户编号', align: 'center', class: 'hidden' },
                    { field: 'LeaveID', title: '编号', align: 'center', class: 'hidden' },
                    { field: 'UserName', title: '姓名', align: 'center', },
                    { field: 'DepartmentName', title: '部门', align: 'center' },
                    { field: 'UserTel', title: '电话', align: 'center' },
                    {
                        field: 'LeaveStartTime',
                        title: '开始时间',
                        align: 'center',
                        formatter: function (value) {
                            if (value != null) {
                                return value.substring(0, value.indexOf("T"));
                            }
                        }
                    },
                    {
                        field: 'LeaveEndTime', title: '结束时间', align: 'center',
                        formatter: function (value) {
                            if (value != null) {
                                return value.substring(0, value.indexOf("T"));
                            }
                        }
                    },
                    { field: 'LeaveDays', title: '请假工时', align: 'center', formatter: function (value) { return "<font color='blue'>" + value + "</font>" } },
                    { field: 'LeaveHalfDay', title: '是否为半天', align: 'center' },
                    { field: 'LeaveTime', title: '申请时间', align: 'center' },
                    { field: 'LeaveReason', title: '理由', align: 'center' }
                ]

            });
        }


        //日期控件
        function BindDate() {
            $('input[type=datetime]').datetimepicker({
                format: 'yyyy-mm-dd',  //显示格式可为yyyymm/yyyy-mm-dd/yyyy.mm.dd
                weekStart: 1,  	//0-周日,6-周六 。默认为0
                autoclose: true,
                startView: 2,  	//打开时显示的视图。0-'hour' 1-'day' 2-'month' 3-'year' 4-'decade'
                minView: 2,  	//最小时间视图。默认0-'hour'
                //maxView: 4, 	//最大时间视图。默认4-'decade'
                todayBtn: true, 	//true时"今天"按钮仅仅将视图转到当天的日期。如果是'linked'，当天日期将会被选中。
                todayHighlight: true,	//默认值: false,如果为true, 高亮当前日期。
                initialDate: new Date(),	//初始化日期.默认new Date()当前日期
                forceParse: false,  	//当输入非格式化日期时，强制格式化。默认true
                bootcssVer: 3,	//显示向左向右的箭头
                language: 'zh-CN', //语言,
                clearBtn: true//清除按钮
            });
        }
    </script>
</body>
</html>
