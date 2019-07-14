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
    <script src="js/jquery/jquery-2.0.3.min.js"></script>

    <script>

      
        $(function () {
            BindData("select");
            //绑定下拉框
            DllBind();
        });

        //绑定下拉框
        function DllBind() {
                $.ajax({
             type: "get",
                    url: "Handler/EmpHandler.ashx",
                    data:
                    {
                        Method:"ddlbind",
                    },
                    async: false,//同步发送请求
                    dataType: "json",
                    success: function (rs)
                    {
                        var str = "";
                        if (rs != "-1") {
                            $.each(rs, function (index, item) {
                                str += "<option value='" + item.DepartmentID + "'>";
                                str += item.DepartmentName;
                                str += "</tr>";
                            });
                            //alert(rs);
                              $("#selectdept").append(str);
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
                    url: "Handler/EmpHandler.ashx",
                    data:
                    {
                        Method:op,
                    },
                    dataType: "json",
                      async: false,
                    success: function (rs)
                    {
                        var str = "";
                        if (rs != "-1") {
                            $.each(rs , function (index,item) {
                                str += "<tr class=gradeA odd'>";
                                str += "<td>" + item.UserNumber + "</td>";
                                str += "<td>" + item.UserName + "</td>";
                                str += "<td>" + item.DepartmentName + "</td>";
                                str += "<td>" + (item.UserSex == 1 ? "男" : "女") + "</td>";
                                str += "<td>" + item.UserAge + "</td>";
                                str += "<td>" + item.UserTel + "</td>";
                                str += "<td>" + (item.DimissionTime).substring(0,(item.DimissionTime).indexOf("T")) + "</td>";
                                str += "<td>" + (item.BasePay + " ¥") + "</td>";
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

      </script>

   

</head>
<body>
    <form id="form1" runat="server">
        <div>
           <%--大层div--%>
            <div style="width: 95%; height: 90%">

                <div style="margin-top: 15px; margin-left: 10px;">
                    <table>
                        <tr>
                            <td class=" label-inverse label-left">部门:&nbsp;&nbsp;</td>
                            <td>
                                <select id="selectdept" class="form-control" style="width: 150px">
                                    <%--<option value="value">
                                        <font style="vertical-align: inherit;">13</font>
                                    </option>--%>
                                </select>
                                <%--<input type="text"  class="form-control" id="deptname" name="name" value="" />--%>
                            </td>
                            <td>&nbsp;&nbsp;</td>
                            <td class=" label-inverse label-left">姓名:&nbsp;&nbsp;</td>
                            <td>
                                <input type="text" class="form-control" id="empname" name="name" value="" />
                            </td>
                            <td>&nbsp;&nbsp;&nbsp;<input type="button" class="btn btn-grey" name="name" value="查询" onclick="" />
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
                                            <h4><i class="fa fa-table"></i><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">员工信息</font></font></h4>
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
                                                                    <input type="text" aria-controls="datatable1" placeholder="搜索" class="form-control input-sm"></label></div>
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
                                                            <font style="vertical-align: inherit;">入职时间</font>
                                                        </font>
                                                            </th>
                                                            <th style="text-align:center" class="sorting_asc" role="columnheader" tabindex="0" aria-controls="datatable1" rowspan="1" colspan="1" style="width: 176px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">
                                                                <font style="vertical-align: inherit;">
                                                            <font style="vertical-align: inherit;">基本工资</font>
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

        </div>
    </form>
</body>
</html>
