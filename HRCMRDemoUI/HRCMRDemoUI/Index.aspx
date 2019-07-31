<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="HRCMRDemoUI.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
	<meta charset="utf-8"/>
	<title>HRCM 人力之源管理 | 首页</title>
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
     
    <style>
        .libgcolor{
            background-color:palevioletred;/*F4F4F4*/
        }
    </style>

    <script>
        $(function () {
            //ajax获取session
            $.ajax({
                type: "get",
                url: "Handler/LoginHandler.ashx",
                data:
                {
                    Method: "Gessession",
                },
                dataType: "json",
                success: function (rs) {
                    //alert(rs);
                    //alert(rs.UserName);
                    $("#user_name").text(rs.UserName);
                    $("#imguser").prop("src", "UserFace/" + rs.UserFace)
                    //权限分配<a href="UserFace/韩梅梅">UserFace/韩梅梅</a>
                    switch (rs[0].RoleID) {
                        //leavemanger applicationdate
                        case 1:

                            break;
                        case 2:
                            $("#deptinfo").hide();
                            $("#deptmanger").hide();
                            break;
                        case 3:
                            $("#deptinfo").hide();
                            $("#deptmanger").hide();
                            $("#empmanger").hide();
                            $("#applicationnote").hide();
                            break;
                        case 4:
                            $("#deptinfo").hide();
                            $("#deptmanger").hide();
                            $("#empmanger").hide();
                            $("#applicationnote").hide();
                            break;
                        case 5:
                            $("#deptinfo").hide();
                            $("#deptmanger").hide();
                            $("#empmanger").hide();
                            $("#leavemanger").hide();
                            $("#applicationnote").hide();
                            break;
                        default:
                            $("#deptinfo").hide();
                            $("#deptmanger").hide();
                            $("#empmanger").hide();
                            $("#leavemanger").hide();
                            $("#applicationnote").hide();
                            break;
                    }
                }

            });

            //下拉列表菜单点击事件 
            var titlt = "";//导航标题
            //showdept
            $("#list >li").click(function () {
                $("#sp_map").text($("#" + $(this).attr("id") + "  > a >span[class='menu-text']").text() + titlt)
                //alert(titlt);
                $("#list > li").removeClass("active");
                $(this).addClass("active");
                if ($(this).attr("id") == "deptinfo") {
                    $("#empmangertable").hide();
                    $("#depttable").show();
                    $("#usertable").hide();
                    $("#leavetable").hide();
                    $("#leavemangertable").hide();
                    $("#empseecolleagetable").hide();
                } else {
                    $("#depttable").hide();
                }
            });


            //showuser  
            $("#list li li").click(function () {
                titlt = " / " + $("#" + $(this).attr("id") + " > a > span").text();
                $("#sp_map").text(titlt)
                //alert(titlt);
                $(this).removeClass().addClass("libgcolor");
                if ($(this).attr("id") == "userinfo") {
                    $("#usertable").show();
                }
                else {
                    $("#usertable").hide();
                }

                if ($(this).attr("id") == "empmanger") {
                    $("#empmangertable").show();
                } else {
                    $("#empmangertable").hide();
                }

                if ($(this).attr("id") == "applicationdate") {
                    $("#leavetable").show();
                } else {
                    $("#leavetable").hide();
                }

                if ($(this).attr("id") == "leavemanger") {
                    $("#leavemangertable").show();
                } else {
                    $("#leavemangertable").hide();
                }

                if ($(this).attr("id") == "empmycolleage") {
                    $("#empseecolleagetable").show();
                } else {
                    $("#empseecolleagetable").hide();
                }


            });

            //点击头像下拉框显示
            $("#a_userinfo").click(function () {
                //alert(1);
                $("#depttable").hide();
                $("#empmangertable").hide();
                $("#leavetable").hide();
                $("#usertable").show();
            });

        
            $("#updatepwd").click(function () {
                $("#UPPwdModal").modal("show");
                $("#oldpwd").val("");
                $("#newpwd1").val("");
                $("#newpwd2").val("");
            });

        });

       //修改密码
        function UpadteValue() {
            if ($("#newpwd1").val()=="" || $("#newpwd2").val() == "") {
                alert("密码不能为空!");
                return;
            }
            else if ($("#newpwd1").val() != $("#newpwd2").val()) {
                alert("两次密码不一样");
                return;
            }
            else
            {
                $.ajax({
                    type: "get",
                    url: "Handler/UserHandler.ashx",
                    data:
                    {
                        Method: "ckeck",
                        OldeValue: $("#oldpwd").val(),
                        NewValue: $("#newpwd2").val(),
                    },
                    dataType: "json",
                    success: function (rs) {
                        if (rs != "failed" && rs != "updatefailed") {
                            alert("修改成功!");
                            alert("您的登录已经失效,请重新登陆!");
                            window.location.href = "Login.aspx";
                            $("#UPPwdModal").modal("hide");
                        }
                        else {
                            alert("输入的原密码有误!");
                        }
                    }
                });
            }
          
        }


    </script>


</head>
  <body>
	<!-- top -->
	<header class="navbar clearfix" id="header">
		<div class="container">

				<div class="navbar-brand">
					<!-- COMPANY LOGO -->
					<a href="Index.aspx">
						<img src="img/logo/logo.png" alt="Cloud Admin Logo" class="img-responsive" height="30" width="120">
					</a>
					<!-- /COMPANY LOGO -->
					<!-- TEAM STATUS FOR MOBILE -->
					<div class="visible-xs">
						<a href="#" class="team-status-toggle switcher btn dropdown-toggle">
							<i class="fa fa-users"></i>
						</a>
					</div>
					<!-- /TEAM STATUS FOR MOBILE -->
					<!-- SIDEBAR COLLAPSE -->
					<div id="sidebar-collapse" class="sidebar-collapse btn">
						<i class="fa fa-bars" 
							data-icon1="fa fa-bars" 
							data-icon2="fa fa-bars" ></i>
					</div>
					<!-- /SIDEBAR COLLAPSE -->
				</div>

				<%--管理人员下拉框--%>
				<ul class="nav navbar-nav pull-left hidden-xs" id="navbar-left">
					<li class="dropdown">
						<a href="#" class="team-status-toggle dropdown-toggle tip-bottom" data-toggle="tooltip" title="查看各部门管理人员">
							<i class="fa fa-users"></i>
							<span class="name">管理人员</span>
							<i class="fa fa-angle-down"></i>
						</a>
					</li>
				</ul>
				<%--/管理人员下拉框--%>

				<!-- BEGIN TOP NAVIGATION MENU -->				
				<ul class="nav navbar-nav pull-right">
					<!-- 消息通知 -->	
					<li class="dropdown" id="header-notification">
						<a href="#" class="dropdown-toggle" title="消息通知" data-toggle="dropdown">
							<i class="fa fa-bell"></i>
							<span class="badge">0</span>						
						</a>
						<ul class="dropdown-menu notification">
							<li class="dropdown-title">
								<span><i class="fa fa-bell"></i> 7 Notifications</span>
							</li>
							<li>
								<a href="#">
									<span class="label label-success"><i class="fa fa-user"></i></span>
									<span class="body">
										<span class="message">5 users online. </span>
										<span class="time">
											<i class="fa fa-clock-o"></i>
											<span>Just now</span>
										</span>
									</span>
								</a>
							</li>
							<li>
								<a href="#">
									<span class="label label-primary"><i class="fa fa-comment"></i></span>
									<span class="body">
										<span class="message">Martin commented.</span>
										<span class="time">
											<i class="fa fa-clock-o"></i>
											<span>19 mins</span>
										</span>
									</span>
								</a>
							</li>
							<li>
								<a href="#">
									<span class="label label-warning"><i class="fa fa-lock"></i></span>
									<span class="body">
										<span class="message">DW1 server locked.</span>
										<span class="time">
											<i class="fa fa-clock-o"></i>
											<span>32 mins</span>
										</span>
									</span>
								</a>
							</li>
							<li>
								<a href="#">
									<span class="label label-info"><i class="fa fa-twitter"></i></span>
									<span class="body">
										<span class="message">Twitter connected.</span>
										<span class="time">
											<i class="fa fa-clock-o"></i>
											<span>55 mins</span>
										</span>
									</span>
								</a>
							</li>
							<li>
								<a href="#">
									<span class="label label-danger"><i class="fa fa-heart"></i></span>
									<span class="body">
										<span class="message">Jane liked. </span>
										<span class="time">
											<i class="fa fa-clock-o"></i>
											<span>2 hrs</span>
										</span>
									</span>
								</a>
							</li>
							<li>
								<a href="#">
									<span class="label label-warning"><i class="fa fa-exclamation-triangle"></i></span>
									<span class="body">
										<span class="message">Database overload.</span>
										<span class="time">
											<i class="fa fa-clock-o"></i>
											<span>6 hrs</span>
										</span>
									</span>
								</a>
							</li>
							<li class="footer">
								<a href="#">See all notifications <i class="fa fa-arrow-circle-right"></i></a>
							</li>
						</ul>
					</li>
					<!-- /消息通知 -->
					<!-- 邮件 -->
					<li class="dropdown" id="header-message">
						<a href="#" class="dropdown-toggle" title="邮件" data-toggle="dropdown">
						<i class="fa fa-envelope"></i>
						<span class="badge">3</span>
						</a>
						<ul class="dropdown-menu inbox">
							<li class="dropdown-title">
								<span><i class="fa fa-envelope-o"></i> 3 Messages</span>
								<span class="compose pull-right tip-right" title="Compose message"><i class="fa fa-pencil-square-o"></i></span>
							</li>
							<li>
								<a href="#">
									<img src="img/avatars/avatar2.jpg" alt="" />
									<span class="body">
										<span class="from">Jane Doe</span>
										<span class="message">
										Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse mole ...
										</span> 
										<span class="time">
											<i class="fa fa-clock-o"></i>
											<span>Just Now</span>
										</span>
									</span>
									 
								</a>
							</li>
							<li>
								<a href="#">
									<img src="img/avatars/avatar1.jpg" alt="" />
									<span class="body">
										<span class="from">Vince Pelt</span>
										<span class="message">
										Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse mole ...
										</span> 
										<span class="time">
											<i class="fa fa-clock-o"></i>
											<span>15 min ago</span>
										</span>
									</span>
									 
								</a>
							</li>
							<li>
								<a href="#">
									<img src="img/avatars/avatar8.jpg" alt="" />
									<span class="body">
										<span class="from">Debby Doe</span>
										<span class="message">
										Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse mole ...
										</span> 
										<span class="time">
											<i class="fa fa-clock-o"></i>
											<span>2 hours ago</span>
										</span>
									</span>
									 
								</a>
							</li>
							<li class="footer">
								<a href="#">See all messages <i class="fa fa-arrow-circle-right"></i></a>
							</li>
						</ul>
					</li>
					<!-- /邮件 -->

					<!-- 任务进度 -->
					<li class="dropdown" id="header-tasks">
						<a href="#" class="dropdown-toggle" title="任务进度" data-toggle="dropdown">
						<i class="fa fa-tasks"></i>
						<span class="badge">3</span>
						</a>
						<ul class="dropdown-menu tasks">
							<li class="dropdown-title">
								<span><i class="fa fa-check"></i> 6 tasks in progress</span>
							</li>
							<li>
								<a href="#">
									<span class="header clearfix">
										<span class="pull-left">Software Update</span>
										<span class="pull-right">60%</span>
									</span>
									<div class="progress">
									  <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
										<span class="sr-only">60% Complete</span>
									  </div>
									</div>
								</a>
							</li>
							<li>
								<a href="#">
									<span class="header clearfix">
										<span class="pull-left">Software Update</span>
										<span class="pull-right">25%</span>
									</span>
									<div class="progress">
									  <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="width: 25%;">
										<span class="sr-only">25% Complete</span>
									  </div>
									</div>
								</a>
							</li>
							<li>
								<a href="#">
									<span class="header clearfix">
										<span class="pull-left">Software Update</span>
										<span class="pull-right">40%</span>
									</span>
									<div class="progress progress-striped">
									  <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%;">
										<span class="sr-only">40% Complete</span>
									  </div>
									</div>
								</a>
							</li>
							<li>
								<a href="#">
									<span class="header clearfix">
										<span class="pull-left">Software Update</span>
										<span class="pull-right">70%</span>
									</span>
									<div class="progress progress-striped active">
									  <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 70%;">
										<span class="sr-only">70% Complete</span>
									  </div>
									</div>
								</a>
							</li>
							<li>
								<a href="#">
									<span class="header clearfix">
										<span class="pull-left">Software Update</span>
										<span class="pull-right">65%</span>
									</span>
									<div class="progress">
									  <div class="progress-bar progress-bar-success" style="width: 35%">
										<span class="sr-only">35% Complete (success)</span>
									  </div>
									  <div class="progress-bar progress-bar-warning" style="width: 20%">
										<span class="sr-only">20% Complete (warning)</span>
									  </div>
									  <div class="progress-bar progress-bar-danger" style="width: 10%">
										<span class="sr-only">10% Complete (danger)</span>
									  </div>
									</div>
								</a>
							</li>
							<li class="footer">
								<a href="#">See all tasks <i class="fa fa-arrow-circle-right"></i></a>
							</li>
						</ul>
					</li>
					<!-- 任务进度 -->

					<!-- 用户信息 -->
					<li class="dropdown user" id="header-user">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<img alt="" src="#" id="imguser" />
							<span class="username" id="user_name"></span>
							<i class="fa fa-angle-down"></i>
						</a>
						<ul class="dropdown-menu">
							<li><a href="#" id="a_userinfo"><i class="fa fa-user"></i>个人信息</a></li>
							<li><a href="#"><i class="fa fa-cog"></i>账号设置</a></li>
							<li id="updatepwd"><a href="#"><i class="fa fa-eye"></i>修改密码</a></li>
							<li><a href="Login.aspx"><i class="fa fa-power-off"></i>退出登录</a></li>
						</ul>
					</li>
					<!-- 用户信息 -->
				</ul>
				<!-- END TOP NAVIGATION MENU -->
		</div>
		<!-- 团队信息 -->
		<div class="container team-status" id="team-status">
		  <div id="scrollbar">
			<div class="handle">
			</div>
		  </div>
		  <div id="teamslider">
			  <ul class="team-list">
				<li class="current">
				  <a href="javascript:void(0);">
				  <span class="image">
					  <img src="img/avatars/avatar3.jpg" alt="" />
				  </span>
				  <span class="title" id="me">我</span>
					<div class="progress">
					  <div class="progress-bar progress-bar-success" style="width: 35%">
						<span class="sr-only">35% Complete (success)</span>
					  </div>
					  <div class="progress-bar progress-bar-warning" style="width: 20%">
						<span class="sr-only">20% Complete (warning)</span>
					  </div>
					  <div class="progress-bar progress-bar-danger" style="width: 10%">
						<span class="sr-only">10% Complete (danger)</span>
					  </div>
					</div>
					<span class="status">
						<div class="field">
							<span class="badge badge-green">6</span> completed
							<span class="pull-right fa fa-check"></span>
						</div>
						<div class="field">
							<span class="badge badge-orange">3</span> in-progress
							<span class="pull-right fa fa-adjust"></span>
						</div>
						<div class="field">
							<span class="badge badge-red">1</span> pending
							<span class="pull-right fa fa-list-ul"></span>
						</div>
				    </span>
				  </a>
				</li>
				<li>
				  <a href="javascript:void(0);">
				  <span class="image">
					  <img src="img/avatars/avatar1.jpg" alt="" />
				  </span>
				  <span class="title">
					Max Doe
				  </span>
					<div class="progress">
					  <div class="progress-bar progress-bar-success" style="width: 15%">
						<span class="sr-only">35% Complete (success)</span>
					  </div>
					  <div class="progress-bar progress-bar-warning" style="width: 40%">
						<span class="sr-only">20% Complete (warning)</span>
					  </div>
					  <div class="progress-bar progress-bar-danger" style="width: 20%">
						<span class="sr-only">10% Complete (danger)</span>
					  </div>
					</div>
					<span class="status">
						<div class="field">
							<span class="badge badge-green">2</span> completed
							<span class="pull-right fa fa-check"></span>
						</div>
						<div class="field">
							<span class="badge badge-orange">8</span> in-progress
							<span class="pull-right fa fa-adjust"></span>
						</div>
						<div class="field">
							<span class="badge badge-red">4</span> pending
							<span class="pull-right fa fa-list-ul"></span>
						</div>
				    </span>
				  </a>
				</li>
				<li>
				  <a href="javascript:void(0);">
				  <span class="image">
					  <img src="img/avatars/avatar2.jpg" alt="" />
				  </span>
				  <span class="title">
					Jane Doe
				  </span>
					<div class="progress">
					  <div class="progress-bar progress-bar-success" style="width: 65%">
						<span class="sr-only">35% Complete (success)</span>
					  </div>
					  <div class="progress-bar progress-bar-warning" style="width: 10%">
						<span class="sr-only">20% Complete (warning)</span>
					  </div>
					  <div class="progress-bar progress-bar-danger" style="width: 15%">
						<span class="sr-only">10% Complete (danger)</span>
					  </div>
					</div>
					<span class="status">
						<div class="field">
							<span class="badge badge-green">10</span> completed
							<span class="pull-right fa fa-check"></span>
						</div>
						<div class="field">
							<span class="badge badge-orange">3</span> in-progress
							<span class="pull-right fa fa-adjust"></span>
						</div>
						<div class="field">
							<span class="badge badge-red">4</span> pending
							<span class="pull-right fa fa-list-ul"></span>
						</div>
				    </span>
				  </a>
				</li>
				<li>
				  <a href="javascript:void(0);">
				  <span class="image">
					  <img src="img/avatars/avatar4.jpg" alt="" />
				  </span>
				  <span class="title">
					Ellie Doe
				  </span>
					<div class="progress">
					  <div class="progress-bar progress-bar-success" style="width: 5%">
						<span class="sr-only">35% Complete (success)</span>
					  </div>
					  <div class="progress-bar progress-bar-warning" style="width: 48%">
						<span class="sr-only">20% Complete (warning)</span>
					  </div>
					  <div class="progress-bar progress-bar-danger" style="width: 27%">
						<span class="sr-only">10% Complete (danger)</span>
					  </div>
					</div>
					<span class="status">
						<div class="field">
							<span class="badge badge-green">1</span> completed
							<span class="pull-right fa fa-check"></span>
						</div>
						<div class="field">
							<span class="badge badge-orange">6</span> in-progress
							<span class="pull-right fa fa-adjust"></span>
						</div>
						<div class="field">
							<span class="badge badge-red">2</span> pending
							<span class="pull-right fa fa-list-ul"></span>
						</div>
				    </span>
				  </a>
				</li>
				<li>
				  <a href="javascript:void(0);">
				  <span class="image">
					  <img src="img/avatars/avatar5.jpg" alt="" />
				  </span>
				  <span class="title">
					Lisa Doe
				  </span>
					<div class="progress">
					  <div class="progress-bar progress-bar-success" style="width: 21%">
						<span class="sr-only">35% Complete (success)</span>
					  </div>
					  <div class="progress-bar progress-bar-warning" style="width: 20%">
						<span class="sr-only">20% Complete (warning)</span>
					  </div>
					  <div class="progress-bar progress-bar-danger" style="width: 40%">
						<span class="sr-only">10% Complete (danger)</span>
					  </div>
					</div>
					<span class="status">
						<div class="field">
							<span class="badge badge-green">4</span> completed
							<span class="pull-right fa fa-check"></span>
						</div>
						<div class="field">
							<span class="badge badge-orange">5</span> in-progress
							<span class="pull-right fa fa-adjust"></span>
						</div>
						<div class="field">
							<span class="badge badge-red">9</span> pending
							<span class="pull-right fa fa-list-ul"></span>
						</div>
				    </span>
				  </a>
				</li>
				<li>
				  <a href="javascript:void(0);">
				  <span class="image">
					  <img src="img/avatars/avatar6.jpg" alt="" />
				  </span>
				  <span class="title">
					Kelly Doe
				  </span>
					<div class="progress">
					  <div class="progress-bar progress-bar-success" style="width: 45%">
						<span class="sr-only">35% Complete (success)</span>
					  </div>
					  <div class="progress-bar progress-bar-warning" style="width: 21%">
						<span class="sr-only">20% Complete (warning)</span>
					  </div>
					  <div class="progress-bar progress-bar-danger" style="width: 10%">
						<span class="sr-only">10% Complete (danger)</span>
					  </div>
					</div>
					<span class="status">
						<div class="field">
							<span class="badge badge-green">6</span> completed
							<span class="pull-right fa fa-check"></span>
						</div>
						<div class="field">
							<span class="badge badge-orange">3</span> in-progress
							<span class="pull-right fa fa-adjust"></span>
						</div>
						<div class="field">
							<span class="badge badge-red">1</span> pending
							<span class="pull-right fa fa-list-ul"></span>
						</div>
				    </span>
				  </a>
				</li>
				<li>
				  <a href="javascript:void(0);">
				  <span class="image">
					  <img src="img/avatars/avatar7.jpg" alt="" />
				  </span>
				  <span class="title">
					Jessy Doe
				  </span>
					<div class="progress">
					  <div class="progress-bar progress-bar-success" style="width: 7%">
						<span class="sr-only">35% Complete (success)</span>
					  </div>
					  <div class="progress-bar progress-bar-warning" style="width: 30%">
						<span class="sr-only">20% Complete (warning)</span>
					  </div>
					  <div class="progress-bar progress-bar-danger" style="width: 10%">
						<span class="sr-only">10% Complete (danger)</span>
					  </div>
					</div>
					<span class="status">
						<div class="field">
							<span class="badge badge-green">1</span> completed
							<span class="pull-right fa fa-check"></span>
						</div>
						<div class="field">
							<span class="badge badge-orange">6</span> in-progress
							<span class="pull-right fa fa-adjust"></span>
						</div>
						<div class="field">
							<span class="badge badge-red">2</span> pending
							<span class="pull-right fa fa-list-ul"></span>
						</div>
				    </span>
				  </a>
				</li>
				<li>
				  <a href="javascript:void(0);">
				  <span class="image">
					  <img src="img/avatars/avatar8.jpg" alt="" />
				  </span>
				  <span class="title">
					Debby Doe
				  </span>
					<div class="progress">
					  <div class="progress-bar progress-bar-success" style="width: 70%">
						<span class="sr-only">35% Complete (success)</span>
					  </div>
					  <div class="progress-bar progress-bar-warning" style="width: 20%">
						<span class="sr-only">20% Complete (warning)</span>
					  </div>
					  <div class="progress-bar progress-bar-danger" style="width: 5%">
						<span class="sr-only">10% Complete (danger)</span>
					  </div>
					</div>
					<span class="status">
						<div class="field">
							<span class="badge badge-green">13</span> completed
							<span class="pull-right fa fa-check"></span>
						</div>
						<div class="field">
							<span class="badge badge-orange">7</span> in-progress
							<span class="pull-right fa fa-adjust"></span>
						</div>
						<div class="field">
							<span class="badge badge-red">1</span> pending
							<span class="pull-right fa fa-list-ul"></span>
						</div>
				    </span>
				  </a>
				</li>
			  </ul>
			</div>
		  </div>
		<!-- /团队信息 -->
	</header>
	<!--/top -->

	<!-- main -->
	<section id="page">
				<!-- SIDEBAR -->
				<div id="sidebar" class="sidebar">
					<div class="sidebar-menu nav-collapse">
						<div class="divide-20"></div>
						<!-- 搜索框 -->
						<div id="search-bar">
							<input class="search" type="text" placeholder="搜索"><i class="fa fa-search search-icon"></i>
						</div>
						<!-- /搜索框 -->
						
						<!-- SIDEBAR QUICK-LAUNCH -->
						<!-- <div id="quicklaunch">
						<!-- /SIDEBAR QUICK-LAUNCH -->
						
						<!-- 菜单列表 -->
						<ul id="list">
                           <%-- 员工资料--%>
							<li class="has-sub" id="empinfo">
								<a href="#">
								<i class="fa fa-tachometer fa-fw"></i> <span class="menu-text">员工资料管理</span>
								<span class="arrow"></span>
								</a>	
                                <ul class="sub">
                                    <li id="userinfo"><a class="" href="#"><span class="sub-menu-text">个人信息</span></a></li>
                                    <li id="empmycolleage"><a class="" href="#"><span class="sub-menu-text">查询同事信息</span></a></li>
                                    <li id="empmanger"><a class="" href="#"><span class="sub-menu-text">员工信息管理</span></a></li>
                                </ul>
							</li>
                             <%-- 员工资料--%>

                            <%--请假管理--%>
                            <li class="has-sub" id="sumday">
								<a href="javascript:;" class="">
								<i class="fa fa-pencil-square-o fa-fw"></i> <span class="menu-text">请假管理</span>
								<span class="arrow"></span>
								</a>
                                <ul class="sub">
                                    <li id="leavemanger"><a class="" href="#"><span class="sub-menu-text">请假管理</span></a></li>
									<li id="applicationdate"><a class="" href="#"><span class="sub-menu-text">申请请假</span></a></li>
                                    <li id="applicationnote"><a class="" href="#"><span class="sub-menu-text">请假记录</span></a></li>
                                </ul>
							</li>
                            <%--请假管理--%>

                            <%--考勤管理--%>
							<li class="has-sub" id="testwork">
								<a href="javascript:;" class="">
								<i class="fa fa-bookmark-o fa-fw"></i> <span class="menu-text">考勤管理</span>
								<span class="arrow"></span>
								</a>
								<ul class="sub">
									<li><a class="" href="#"><span class="sub-menu-text">签到</span></a></li>
									<li><a class="" href="#"><span class="sub-menu-text">查看本日考勤</span></a></li>
									<li><a class="" href="#"><span class="sub-menu-text">查看考勤记录</span></a></li>
								    <%--包含3级菜单--%>
                                    <%--	<li class="has-sub-sub">
										<a href="javascript:;" class=""><span class="sub-menu-text">Third Level Menu</span>
										<span class="arrow"></span>
										</a>
										<ul class="sub-sub">
											<li><a class="" href="#"><span class="sub-sub-menu-text">Item 1</span></a></li>
											<li><a class="" href="#"><span class="sub-sub-menu-text">Item 2</span></a></li>
										</ul>
									</li>--%>
								</ul>
							</li>
                            <%--考勤管理--%>

                             <%--部门管理--%>
							<li id="deptinfo">
                                <a class="" href="#">
                                <i class="fa fa-desktop fa-fw"></i> 
                                <span class="menu-text">部门管理</span>
							    </a>
							</li>
                            <%--部门管理--%>
                            
                             <%--加班管理--%>
                            <li id="addwork">
                                <a class="" href="#">
                                <i class="fa fa-columns fa-fw"></i> 
                                <span class="menu-text">加班管理</span>
                                </a>
                            </li>
                              <%--加班管理--%>

                              <%--业绩管理--%>
                            <li class="has-sub" id="workinfo">
								<a href="javascript:;" class="">
								<i class="fa fa-bar-chart-o fa-fw"></i> <span class="menu-text">业绩评定</span>
								<span class="menu-text"></span>
								</a>
							</li>
                            <%--业绩管理--%>

                              <%--薪资管理--%>
                            <li class="has-sub" id="salinfo">
								<a href="javascript:;" class="">
								<i class="fa fa-file-text fa-fw"></i> <span class="menu-text">薪资管理</span>
								<span class="menu-text"></span>
								</a>
							</li>
                            <%--薪资管理--%>

                              <%--公告管理--%>
                            <li class="has-sub" id="msg">
								<a href="javascript:;" class="">
								<i class="fa fa-calendar fa-fw"></i> <span class="menu-text">管理公告</span>
								<span class="menu-text"></span>
								</a>
							</li>
                            <%--公告管理--%>

							 <%--其他--%>
							<li class="has-sub">
								<a href="javascript:;" class="">
								<i class="fa fa-briefcase fa-fw"></i> <span class="menu-text">Other Pages <span class="badge pull-right">9</span></span>
								<span class="arrow"></span>
								</a>
								<ul class="sub">
									<li><a class="" href="search_results.html"><span class="sub-menu-text">Search Results</span></a></li>
									<li><a class="" href="email_templates.html"><span class="sub-menu-text">Email Templates</span></a></li>
									<li><a class="" href="error_404.html"><span class="sub-menu-text">Error 404 Option 1</span></a></li><li><a class="" href="error_404_2.html"><span class="sub-menu-text">Error 404 Option 2</span></a></li><li><a class="" href="error_404_3.html"><span class="sub-menu-text">Error 404 Option 3</span></a></li>
									<li><a class="" href="error_500.html"><span class="sub-menu-text">Error 500 Option 1</span></a></li><li><a class="" href="error_500_2.html"><span class="sub-menu-text">Error 500 Option 2</span></a></li>
									<li><a class="" href="faq.html"><span class="sub-menu-text">FAQ</span></a></li>
									<li><a class="" href="blank_page.html"><span class="sub-menu-text">Blank Page</span></a></li>
								</ul>
							</li>
						</ul>
						<!-- /菜单列表 -->
					</div>
				</div>
				<!-- /SIDEBAR -->
		<div id="main-content">

            <div class="container">

               <%-- 站点导航栏--%>
                	<div class="row">
							<div class="col-sm-12">
								<div class="page-header">
									<ul class="breadcrumb">
										<li>
											<i class="fa fa-home"></i>
											<a href="index.html">首页</a>
										</li>
										<li id="map"><span id="sp_map"></span></li>
							    </ul>
						</div>
                    </div>
		        </div>
               


      <!-- 模态框（Modal-view） -->
    <div class="modal fade" id="UPPwdModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" >
                    <div class="modal-header">
                        <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                            &times;           
                        </button>
                        <h4 class="modal-title" id="ViewModalLabel">修改密码</h4>
                    </div>
                    <div class="modal-body">
                        <table class="table">
                            <tr id="rowbgcolor" class="">
                                <td id="rowoldpwd" class="">
                                  原密码:<input id="oldpwd" type="password"  class="form-control" name="name" value="" />
                                </td>
                            </tr>
                            <tr>
                                 <td id="rowonewpwd1" class="">
                                  密码:<input id="newpwd1" type="password" class="form-control" name="name" value="" />
                                </td>
                            </tr>
                            <tr>
                                 <td id="rowonewpwd2" class="">
                                  确认密码:<input id="newpwd2" type="password" class="form-control" name="name" value="" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="UpadteValue();">提交</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal -->
        </div>


                <%--其他页面--%>
                   <div style="width:100%;height:100%" class="text-center">
                       <iframe style="width:100%;height:600px;" src="Department.aspx" hidden="hidden" id="depttable" frameborder="0">
                       </iframe>
                   </div>
                  <div style="width:100%;height:100%" class="text-center">
                       <iframe style="width:100%;height:600px;" src="EmpManger.aspx" hidden="hidden" id="empmangertable" frameborder="0">
                       </iframe>
                   </div>
                <div style="width:100%;height:100%" class="text-center">
                       <iframe style="width:100%;height:600px;" src="UserInfo.aspx" hidden="hidden" id="usertable" frameborder="0">
                       </iframe>
                   </div>
                 <div style="width:100%;height:100%" class="text-center">
                       <iframe style="width:100%;height:600px;" src="LeaveInfo.aspx" hidden="hidden" id="leavetable" frameborder="0">
                       </iframe>
                   </div>
                 <div style="width:100%;height:100%" class="text-center">
                       <iframe style="width:100%;height:600px;" src="LeaveManger.aspx" hidden="hidden" id="leavemangertable" frameborder="0">
                       </iframe>
                   </div>
                <div style="width:100%;height:100%" class="text-center">
                       <iframe style="width:100%;height:600px;" src="EmpMyColleage.aspx" hidden="hidden" id="empseecolleagetable" frameborder="0">
                       </iframe>
                   </div>
                
           </div>
            </div>
	
    </section>
	<!--/页面 -->
	<!-- JAVASCRIPTS -->
	<!-- Placed at the end of the document so the pages load faster -->
	
	<!-- JQUERY UI-->
	<script src="js/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js"></script>
	<!-- BOOTSTRAP -->
	<script src="bootstrap-dist/js/bootstrap.min.js"></script>
	
		
	<!-- DATE RANGE PICKER -->
	<script src="js/bootstrap-daterangepicker/moment.min.js"></script>
	
	<script src="js/bootstrap-daterangepicker/daterangepicker.min.js"></script>
	<!-- SLIMSCROLL -->
	<script type="text/javascript" src="js/jQuery-slimScroll-1.3.0/jquery.slimscroll.min.js"></script>
	<!-- SLIMSCROLL -->
	<script type="text/javascript" src="js/jQuery-slimScroll-1.3.0/jquery.slimscroll.min.js"></script><script type="text/javascript" src="js/jQuery-slimScroll-1.3.0/slimScrollHorizontal.min.js"></script>
	<!-- BLOCK UI -->
	<script type="text/javascript" src="js/jQuery-BlockUI/jquery.blockUI.min.js"></script>
	<!-- SPARKLINES -->
	<script type="text/javascript" src="js/sparklines/jquery.sparkline.min.js"></script>
	<!-- EASY PIE CHART -->
	<script src="js/jquery-easing/jquery.easing.min.js"></script>
	<script type="text/javascript" src="js/easypiechart/jquery.easypiechart.min.js"></script>
	<!-- FLOT CHARTS -->
	<script src="js/flot/jquery.flot.min.js"></script>
	<script src="js/flot/jquery.flot.time.min.js"></script>
    <script src="js/flot/jquery.flot.selection.min.js"></script>
	<script src="js/flot/jquery.flot.resize.min.js"></script>
    <script src="js/flot/jquery.flot.pie.min.js"></script>
    <script src="js/flot/jquery.flot.stack.min.js"></script>
    <script src="js/flot/jquery.flot.crosshair.min.js"></script>
	<!-- TODO -->
	<script type="text/javascript" src="js/jquery-todo/js/paddystodolist.js"></script>
	<!-- TIMEAGO -->
	<script type="text/javascript" src="js/timeago/jquery.timeago.min.js"></script>
	<!-- FULL CALENDAR -->
	<script type="text/javascript" src="js/fullcalendar/fullcalendar.min.js"></script>
	<!-- COOKIE -->
	<script type="text/javascript" src="js/jQuery-Cookie/jquery.cookie.min.js"></script>
	<!-- GRITTER -->
	<script type="text/javascript" src="js/gritter/js/jquery.gritter.min.js"></script>
	<!-- CUSTOM SCRIPT -->
	<script src="js/script.js"></script>
	<script>
		jQuery(document).ready(function() {		
			App.setPage("Index.aspx");  //Set current page
			App.init(); //Initialise plugins and elements
		});
	</script>
	<!-- /JAVASCRIPTS -->
</body>
</html>
