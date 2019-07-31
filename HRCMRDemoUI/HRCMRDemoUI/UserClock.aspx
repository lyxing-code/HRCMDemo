<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserClock.aspx.cs" Inherits="HRCMRDemoUI.UserClock" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>HRCM 人力之源管理 | 签到打卡</title>
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
    <%--签到--%>
    <link href="js/qdclock/css/signin.css" rel="stylesheet" />
    <link href="js/qdclock/css/index.css" rel="stylesheet" />
    <link href="js/qdclock/css/public.css" rel="stylesheet" />
    <link href="js/qdclock/css/font_234130_nem7eskcrkpdgqfr.css" rel="stylesheet" />

</head>
<body>
    <div>
        <div style="width: 95%; height: 90%">
            <br />
            <!-- 表格-->
            <div class="box border inverse">
                <div class="box-title">
                    <h4><i class="fa fa-table"></i>打卡/签到</h4>
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

                    <div class="index_frame_leftTop">
                        <div id='schedule-boxS'></div>
                        <div class="index_liTLeft">
                            <div class="index_liTline"></div>
                        </div>
                        <div class="index_liTRight">
                            <div class="index_liTline"></div>
                        </div>
                    </div>
                    <div class="index_frame_leftBottom">
                        <div class="index_liBLeft"></div>
                        <div class="index_liBRight"></div>
                        <div class="index_frame_leftBottom_Top clearfix">
                            <span style="position: absolute; top: 50px; left: 12%">
                                <label style="position: relative; top: -10px;">正常:</label><span class="currentDate dayStyle zc_day"></span>
                                <label style="position: relative; top: -10px;">迟到:</label><span class="currentDate dayStyle qq-style"></span>
                                <label style="position: relative; top: -10px;">早退:</label><span class="currentDate dayStyle zt-style"></span>
                                <label style="position: relative; top: -10px;">请假:</label><span class="currentDate dayStyle cdzt-style"></span>
                            </span>
                        </div>
                        <div class="top flex flex-align-end flex-pack-center flex-warp">
                            <div class="out-1 flex flex-align-center flex-pack-center" id="signIn">
                                <div class="out-2 flex flex-align-center flex-pack-center">
                                    <div class="signBtn">
                                        <strong id="sign-txt">签到</strong>
                                        <span>连续<em id="sign-count">0</em>天</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="Scripts/jquery-3.3.1.js"></script>
    <script src="js/qdclock/js/index.js"></script>
    <script src="js/qdclock/js/schedule.js"></script>
    <script src="js/qdclock/js/rili.js"></script>
    <script>
        $(function () {
            var zc_day = "["; 
            var zt = "[";
            var cdzt = "[";
            var qq = "[";
            var cd = "[";
            var today, start, end = "";
            $.ajax({
                type: "get",
                url: "Handler/UserClockHandler.ashx",
                data:
                {
                    Method: "selectbyid"
                },
                dataType: "json",
                success: function (d, s) {
                    $(d).each(function (index, item) {
                        switch (item.AttendanceType) {
                            case 1://正常
                                today = (item.AttendanceStartTime).substring(0, (item.AttendanceStartTime).indexOf('T')) ;
                                start = item.ClockTime.substring(item.ClockTime.indexOf('T') + 1, item.ClockTime.length - 3);
                                end = item.ClockOutTime.substring(item.ClockOutTime.indexOf('T') + 1, item.ClockOutTime.length - 3);
                                zc_day += ("{time: \"" + today + "\", Morning: \"" + start + "\", Afternoon: \"" + end +"\"},");
                                //alert("状态:" + item.AttendanceType + "当前时间:" + today + "上班:" + start + "|下班:" + end);
                                break;
                            case 5://请假
                                today = (item.AttendanceStartTime).substring(0, (item.AttendanceStartTime).indexOf('T'));
                                start = item.ClockTime.substring(item.ClockTime.indexOf('T') + 1, item.ClockTime.length - 3);
                                end = item.ClockOutTime.substring(item.ClockOutTime.indexOf('T') + 1, item.ClockOutTime.length - 3);
                                cdzt += ("{time: \"" + today + "\", Morning: \"" + start + "\", Afternoon: \"" + end + "\"},");
                                //alert("状态:" + item.AttendanceType + "当前时间:" + today + "上班:" + start + "|下班:" + end);
                                break;
                            case 3://早退
                                today = (item.AttendanceStartTime).substring(0, (item.AttendanceStartTime).indexOf('T'));
                                start = item.ClockTime.substring(item.ClockTime.indexOf('T') + 1, item.ClockTime.length - 3);
                                end = item.ClockOutTime.substring(item.ClockOutTime.indexOf('T') + 1, item.ClockOutTime.length - 3);
                                zt += ("{time: \"" + today + "\", Morning: \"" + start + "\", Afternoon: \"" + end + "\"},");
                                //alert("状态:" + item.AttendanceType + "当前时间:" + today + "上班:" + start + "|下班:" + end);
                                break;
                            case 2://迟到
                                today = (item.AttendanceStartTime).substring(0, (item.AttendanceStartTime).indexOf('T'));
                                start = item.ClockTime.substring(item.ClockTime.indexOf('T') + 1, item.ClockTime.length - 3);
                                end = item.ClockOutTime.substring(item.ClockOutTime.indexOf('T') + 1, item.ClockOutTime.length - 3);
                                qq += ("{time: \"" + today + "\", Morning: \"" + start + "\", Afternoon: \"" + end + "\"},");
                                break;
                            case 4://迟到
                                today = (item.AttendanceStartTime).substring(0, (item.AttendanceStartTime).indexOf('T'));
                                start = item.ClockTime.substring(item.ClockTime.indexOf('T') + 1, item.ClockTime.length - 3);
                                end = item.ClockOutTime.substring(item.ClockOutTime.indexOf('T') + 1, item.ClockOutTime.length - 3);
                                qq += ("{time: \"" + today + "\", Morning: \"" + start + "\", Afternoon: \"" + end + "\"},");
                                break;
                            case 6,7://467
                                today = (item.AttendanceStartTime).substring(0, (item.AttendanceStartTime).indexOf('T'));
                                start = item.ClockTime.substring(item.ClockTime.indexOf('T') + 1, item.ClockTime.length - 3);
                                end = item.ClockOutTime.substring(item.ClockOutTime.indexOf('T') + 1, item.ClockOutTime.length - 3);
                                qq += ("{time: \"" + today + "\", Morning: \"" + start + "\", Afternoon: \"" + end + "\"},");
                                break;
                        }
                        //alert(item.AttendanceType);
                       // alert("状态:" + item.AttendanceType + "当前时间:" + item.AttendanceStartTime + "上班:" + item.ClockTime + "|下班:" + item.ClockOutTime);
                    });
                    zc_day += "]";
                    zt += "]";
                    cdzt += "]";
                    qq += "]";
                    alert(qq);
                    var mySchedule = new Schedule({
                        el: '#schedule-boxS',
                        //异常考勤迟到
                        //qqDate: [{ time: "2019-07-09", Morning: "", Afternoon: "16:01" }, { time: "2018-11-16", Morning: "08:15", Afternoon: "" }, { time: "2018-12-19", Morning: "08:15", Afternoon: "" }],
                        qqDate: (new Function("return " + qq))(),
                        //正常考勤
                        zcDate: (new Function("return " + zc_day))(),//字符串转json
                        //请假
                        cdzt: (new Function("return " + cdzt))(),
                        //早退
                        zt:(new Function("return " + zt))()
                    });

                }
            });
           
            

        });



    </script>
</body>
</html>
