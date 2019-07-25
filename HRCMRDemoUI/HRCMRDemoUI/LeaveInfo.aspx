<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LeaveInfo.aspx.cs" Inherits="HRCMRDemoUI.LeaveInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>HRCM 人力之源管理 | 申请请假</title>
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
        //点击申请按钮打开模态框
        function ApplicationDate()
        {
            $('#myModal').modal("show");
        }

        //申请提交按钮事件
        function submitinfo() {
            var datalist = new FormData($("#formleaveadd")[0]);
            datalist.append('op', 'addinfo');
            $.ajax({
                type: "post",
                url: "Handler/LeaveHandler.ashx",
                data: datalist,
                dataType: "json",
                async: false,
                contentType: false,
                processData: false,
                success: function (rs) {
                    if (rs == "addsuccess") {
                        alert("提交申请成功,请等待相关人员审批!");
                        $("#leavetable").bootstrapTable("refresh");
                    }
                    else {
                        alert("提交申请失败!");
                    }
                }
            });
            $('#myModal').modal("hide");

        }

        //查看审批进度
        function ViewPress(id) {

            $.ajax({
                type: "get",
                url: "Handler/LeaveHandler.ashx",
                data: {
                    op: "selectbyid",
                    leaveid: id
                },
                dataType: "json",
                success: function (rs, state) {
                    if (state == "success") {
                        var str = "";
                        switch (rs[0].LeaveState) {
                            case 1:
                                $("#rowbgcolor").removeAttr("class").addClass("bg-success");
                                $("#rowtext").removeAttr("class").addClass("text-success");
                                str = "同意";
                                break;
                            case 2:
                                $("#rowbgcolor").removeAttr("class").addClass("bg-danger");
                                $("#rowtext").removeAttr("class").addClass("text-danger");
                                str = "不同意";
                                break;
                            case 3:
                                $("#rowbgcolor").removeAttr("class").addClass("bg-warning");
                                $("#rowtext").removeAttr("class").addClass("text-warning");
                                str = "暂无审批意见";
                                break;
                            default:
                        }
                       ;
                        $("#txtApproverReason").text(str + " " + rs[0].ApproverReason);
                        //alert(rs[0].ApproverReason); 
                    } else
                    {
                        $(".bg-warning").addClass("bg-warning");
                        $(".text-warning").addClass("text-warning");
                        $("#txtApproverReason").text("暂无审批意见");
                    }
                }


            });


            $("#ViewModal").modal("show");
            //$("#leavetable").bootstrapTable("refresh");
        }

        //删除信息
        function DelApplication() {
            var str = ""; 
            $("#leavetable > tbody > tr").each(function (index,item) {
                if ($(this).hasClass("selected")) {
                    //username = $(this).children("td:nth-child(3)").text();
                    str += $(this).children("td:nth-child(4)").text()+",";
                }
            });
            str = str.substring(0, str.length - 1);
            //alert(str);
            if (str != "") {
                if (confirm("你确定要取消申请吗?")) {
                    if (true) {

                    }
                    $.ajax({
                        url: "Handler/LeaveHandler.ashx",
                        type: "get",
                        data: {
                            op: "deleteinfo",
                            idlist: str,
                        },
                        dataType: "json",
                        success: function (rs) {
                            if (rs != "checksuccess") {
                                if (rs != "delfailed") {
                                    alert("取消成功!");
                                    $("#leavetable").bootstrapTable("refresh");
                                }
                                else {
                                    alert("取消失败!");
                                }
                            }
                            else {
                                alert("取消失败,意见已经通过审核!");
                            }
                        
                        }
                    });
                }
            } else {
                alert("请选择删除行!");
            }
           
        }

        //按日期查询
        function Selectbydate() {
           $("#leavetable").bootstrapTable('refresh');
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
										<h4><i class="fa fa-table"></i>申请请假</h4>
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
                                      <label style="float:left;margin-top:6px;" class="label-left">按照申请时间查询:</label>&nbsp;&nbsp;
                                      <input type="datetime"  style="width:25%;float:left"  class=" form-control" id="timestart" name="name" value="" />
                                      <label style="float:left;margin-top:5px;">&nbsp;至&nbsp;</label>
                                      <input type="datetime" style="width:25%;float:left" class=" form-control " id="timeend" name="name" value="" />
                                  </td>
                                  <td>
                                      &nbsp;&nbsp;&nbsp;<input type="button" class="btn btn-grey"  name="name" value="查询" onclick="Selectbydate();" />
                                  </td>
                                  <td>
                                      &nbsp;&nbsp;&nbsp;<input type="button" id="addleave" class="btn btn-success"  name="name" value="申请请假" onclick="ApplicationDate();" />
                                  </td>
                                  <td>
                                      &nbsp;&nbsp;&nbsp;<input type="button" id="deleteleave" class="btn btn-danger"  name="name" value="取消申请" onclick="DelApplication();"  />
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
                        <h4 class="modal-title" id="myModalLabel">请假申请</h4>

                    </div>
                    <div class="modal-body">
                        <table class="text-center">
                            <tr>
                                <td>
                                   <label>开始时间:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <input type="datetime" placeholder="开始时间" id="txtdateStartModal" class="form-control" name="txtdateStartModal" value="" />
                                </td>
                                <td>
                                   &nbsp;&nbsp;&nbsp;<label>结束时间:</label>&nbsp;&nbsp;
                                </td>
                                 <td>
                                  <input type="datetime" placeholder="结束时间" id="txtdateEndModal" class="form-control" name="txtdateEndModal" value=""  />
                                </td>
                            </tr>
                            <tr><td>&nbsp;</td></tr>
                            <tr id="dateselect">
                                <td>
                                   <label>是否半天:</label>&nbsp;&nbsp;
                                </td>
                                <td>
                                    <select class="form-control" name="selectdaytimes" id="selectdaytimes" style="width:120px;">
                                        <option value="全天">全天</option>
                                        <option value="上午">上午</option>
                                        <option value="下午">下午</option>
                                    </select>
                                </td>
                                <td>
                                   <label>请假时工:</label>&nbsp;&nbsp;
                                </td>
                                <td>
                                    <input type="text" placeholder="以小时为单位" class="form-control"  id="LeaveTimeChaModal" name="LeaveTimeChaModal" value="" />
                                </td>
                            </tr>
                             <tr>
                                 <td>
                                     <input type="hidden" id="LeaveIdModal" name="name" value="" />
                                 </td>
                                 <td>&nbsp;</td>
                             </tr>
                            <tr id="Remark">
                                <td>
                                   <label>请假原因:</label>&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <textarea id="txtLeaveRemarkModal" name="txtLeaveRemarkModal"  class="form-control"></textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                         <button id="isupdateok" hidden="hidden"  type="button" class="btn btn-primary" onclick="submitinfo();">
                            确认提交   
                        </button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal -->
        </div>
   </form>     
              
         <!-- 模态框（Modal-view） -->
    <div class="modal fade" id="ViewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" >
                    <div class="modal-header">
                        <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                            &times;           
                        </button>
                        <h4 class="modal-title" id="ViewModalLabel">查看审批进度</h4>
                    </div>
                    <div class="modal-body">
                        <table class="table table-bordered">
                            <tr id="rowbgcolor" class="bg-warning">
                                <td id="rowtext" class="text-warning">
                                    部门经理
                                </td>
                            </tr>
                            <tr>
                                <td id="txtApproverReason" class="text-dark">
                                    暂无审批意见
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">退出</button>
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
                pagination: true, //是否显示分页（*）
                //sortable: true, //是否启用排序
                sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）       打开后表中才有数据
                pageNumber: 1, //初始化加载第一页，默认第一页
                clickToSelect: false, // 是否启用点击选中行
                pageSize: 50, //每页的记录行数（*）
                pageList: [50], //可供选择的每页的行数（*）
                queryParams: function (parms) {
                    var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                        op: "select",//此参数用来判断操作
                        limit: parms.limit, //页面大小
                        //////页码
                        offset: parms.offset,
                        starttime : $("#timestart").val(),
                        endtime : $("#timeend").val(),
                    };
                    return temp;
                },
                columns: [
                    { checkbox: true},
                    { field: 'CI_ID', title: '状态编号', align: 'center', class: 'hidden' },
                    { field: 'UserID', title: '用户编号', align: 'center', class: 'hidden' },
                    { field: 'LeaveID', title: '编号', align: 'center', class: 'hidden'},
                    { field: 'UserName', title: '姓名', align: 'center', },
                    { field: 'DepartmentName', title: '部门', align: 'center', class: 'hidden'},
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
                    { field: 'LeaveDays', title: '请假工时', align: 'center',formatter: function (value) { return "<font color='blue'>" + value + "</font>" } },
                    {
                        field: 'ApprovalTime', title: '审批时间', align: 'center',
                        formatter: function (value) {
                            if (value != null) {
                                if (value.substring(0, value.indexOf("T")) == "1900-01-01") {
                                    return "-";
                                }
                                else
                                {

                                    return value.substring(0, value.indexOf("T"));
                                }
                            }
                        }
                    },
                    {
                        field: 'CI_Name',//LeaveState
                        title: '审批状态',
                        align: 'center',
                        formatter: function (value) {
                            if (value != null) {
                                if (value == "审批中") {
                                    return "<label class='label label-warning'>" + value + "</label>";
                                }
                                else if (value == "驳回")
                                {
                                    return "<label class='label label-danger'>" + value + "</label>";
                                }
                                else if (value == "同意") {
                                    return "<label class='label label-success'>" + value + "</label>";
                                }

                            }
                        }
                    },
                    {
                        field:'LeaveID',
                        input: 'Button',
                        title: '操作',
                        align: 'center',
                        formatter: function (value) {
                            return " <input  type='button' class='btn btn-default text-center' onclick='ViewPress(" + value + ");' name='' value='查看' />";
                        }
                    }
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
    <hr />
    <label id="test" class="label label-danger ">123</label>
    
</body>
</html>
