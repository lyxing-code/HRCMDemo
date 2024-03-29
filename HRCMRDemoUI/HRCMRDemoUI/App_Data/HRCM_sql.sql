use master 
GO

IF EXISTS(SELECT * FROM sys.objects WHERE name = 'HRCMManagement')
DROP database HRCMManagement
create database HRCMManagement
GO

use HRCMManagement
GO

--表名	部门表(Department)
IF EXISTS(SELECT * FROM sys.objects WHERE name = 'Department')
DROP table Department
CREATE TABLE Department
(
	DepartmentID	INT PRIMARY KEY IDENTITY (1, 1), --部门编号(主键)
	DepartmentName	varchar	(50) NOT NULL,--部门名称
	DepartmentRemarks	Varchar	(500)  NULL,	--备注
)
GO

insert into Department values('财务部',null),('行政部',null),('公关部',null),('人事部',null),('研发部',null),('销售部',null);


--表名	角色表(Role)
IF EXISTS(SELECT * FROM sys.objects WHERE name = 'Role')
DROP table Role
CREATE TABLE Role
(
	RoleID	Int PRIMARY KEY IDENTITY (1, 1),  --角色编号(主键)
	RoleName	VARCHAR(50)	NOT NULL,	--角色名称
	RoleNumber	varchar(200)  DEFAULT('50%'),		--角色权限百分比
)
GO
INSERT INTO Role (RoleName, RoleNumber)
VALUES ('总经理','100%'),('人事经理','80%'),('人事助理','70%'),('部门经理','60%'),('普通员工',DEFAULT);

SELECT DepartmentName FROM dbo.Department WHERE DepartmentName LIKE '%'+@DepartmentName+'%'


--表名	用户表(UserInfo)
IF EXISTS(SELECT * FROM sys.objects WHERE name = 'UserInfo')
DROP table UserInfo
CREATE TABLE UserInfo
  (
    UserID INT PRIMARY KEY IDENTITY (1, 1), --序号(主键)
    DepartmentID INT  REFERENCES Department(DepartmentID), --部门编号
    RoleID INT REFERENCES Role(RoleID), --角色编号（1.总经理 2.人事经理 3.人事助理 4.部门经理 5.员工）
    UserNumber VARCHAR (50) NOT NULL, --用户编号
    UserFace VARCHAR(50) NULL,--用户头像
    LoginName VARCHAR (50) NOT NULL, --	登陆名
    LoginPwd VARCHAR (50) NOT NULL, --	密码
    UserName VARCHAR (50) NOT NULL, --真实姓名
    UserAge INT NOT NULL, --年龄
    UserSex TINYINT NOT NULL CHECK (UserSex IN(0,1)), --	性别 （1.男  0.女）
    UserTel VARCHAR (11) NOT NULL, --电话
    UserAddress VARCHAR (100) NOT null, --家庭地址
    UserIphone VARCHAR (11) NOT null, --手机
    UserRemarks VARCHAR (200) null, --备注
    UserStatr INT CHECK (UserStatr IN(0,1)) DEFAULT(1), --是否可用（0.不可登陆 1.可登陆）
    EntryTime DATETIME  NULL, --最后登陆时间
    DimissionTime DATETIME NOT NULL, --入职时间
    BasePay MONEY NOT NULL DEFAULT(2700) --	薪资
 )
 GO
 
 SELECT *FROM Department

 SELECT * FROM Role 
 --总经理
INSERT INTO UserInfo (DepartmentID, RoleID, UserNumber, UserFace, LoginName, LoginPwd, UserName, UserAge, UserSex, UserTel, UserAddress, UserIphone, UserRemarks, UserStatr, EntryTime, DimissionTime, BasePay)
VALUES (2, 1, 'masteradmin', '', 'master', '123', '韩梅梅', 18, 0,'13026382346', '武汉','13026382346','', DEFAULT, getdate(), getdate(), 9999)
--人事部
INSERT INTO UserInfo (DepartmentID, RoleID, UserNumber, UserFace, LoginName, LoginPwd, UserName, UserAge, UserSex, UserTel, UserAddress, UserIphone, UserRemarks, UserStatr, EntryTime, DimissionTime, BasePay)
VALUES (4, 2, 'admin', '', 'admin', '123', '李磊', 25, 1,'13115642371', '北京','13115642371','', DEFAULT, getdate(), getdate(), 4999)

INSERT INTO UserInfo (DepartmentID, RoleID, UserNumber, UserFace, LoginName, LoginPwd, UserName, UserAge, UserSex, UserTel, UserAddress, UserIphone, UserRemarks, UserStatr, EntryTime, DimissionTime, BasePay)
VALUES (4, 3, 'admin1', '', 'admin1', '123', '马冬梅', 22, 0,'18726389043', '广州','18726389043','', DEFAULT, getdate(), getdate(), 3999)

INSERT INTO UserInfo (DepartmentID, RoleID, UserNumber, UserFace, LoginName, LoginPwd, UserName, UserAge, UserSex, UserTel, UserAddress, UserIphone, UserRemarks, UserStatr, EntryTime, DimissionTime, BasePay)
VALUES (4, 3, 'admin2', '', 'admin2', '123', '小昭', 20, 0,'15972360235', '上海','15972360235','', DEFAULT, getdate(), getdate(), 3999)

INSERT INTO UserInfo (DepartmentID, RoleID, UserNumber, UserFace, LoginName, LoginPwd, UserName, UserAge, UserSex, UserTel, UserAddress, UserIphone, UserRemarks, UserStatr, EntryTime, DimissionTime, BasePay)
VALUES (4, 3, 'admin3', '', 'admin3', '123', '马小蓉', 21, 0,'15156345754', '武汉','15156345754','', DEFAULT, getdate(), getdate(), 3999)

--财务部
INSERT INTO UserInfo (DepartmentID, RoleID, UserNumber, UserFace, LoginName, LoginPwd, UserName, UserAge, UserSex, UserTel, UserAddress, UserIphone, UserRemarks, UserStatr, EntryTime, DimissionTime, BasePay)
VALUES (1, 4, 'Cadmin', '', 'Cadmin', '123', 'aaa', 24, 0,'13126382378', '武汉','13126382378','', DEFAULT, getdate(), getdate(), 4999)
--行政部
INSERT INTO UserInfo (DepartmentID, RoleID, UserNumber, UserFace, LoginName, LoginPwd, UserName, UserAge, UserSex, UserTel, UserAddress, UserIphone, UserRemarks, UserStatr, EntryTime, DimissionTime, BasePay)
VALUES (2, 4, 'Xadmin', '', 'Xadmin', '123', 'bbb', 25, 1,'15115642368', '北京','15115642368','', DEFAULT, getdate(), getdate(), 4999)
--公关部
INSERT INTO UserInfo (DepartmentID, RoleID, UserNumber, UserFace, LoginName, LoginPwd, UserName, UserAge, UserSex, UserTel, UserAddress, UserIphone, UserRemarks, UserStatr, EntryTime, DimissionTime, BasePay)
VALUES (3, 4, 'Gadmin', '', 'Gadmin', '123', 'ccc', 22, 1,'18726389627', '广州','18726389627','', DEFAULT, getdate(), getdate(), 4999)
--研发部
INSERT INTO UserInfo (DepartmentID, RoleID, UserNumber, UserFace, LoginName, LoginPwd, UserName, UserAge, UserSex, UserTel, UserAddress, UserIphone, UserRemarks, UserStatr, EntryTime, DimissionTime, BasePay)
VALUES (5, 4, 'Yadmin', '', 'Yadmin', '123', 'ddd', 20, 1,'15972361498', '上海','15972361498','', DEFAULT, getdate(), getdate(), 4999)
--销售部
INSERT INTO UserInfo (DepartmentID, RoleID, UserNumber, UserFace, LoginName, LoginPwd, UserName, UserAge, UserSex, UserTel, UserAddress, UserIphone, UserRemarks, UserStatr, EntryTime, DimissionTime, BasePay)
VALUES (6, 4, 'Sadmin', '', 'Sadmin', '123', 'eee', 21, 0,'15156346864', '武汉','15156346864','', DEFAULT, getdate(), getdate(), 4999)
--普通员工
iNSERT INTO UserInfo (DepartmentID, RoleID, UserNumber, UserFace, LoginName, LoginPwd, UserName, UserAge, UserSex, UserTel, UserAddress, UserIphone, UserRemarks, UserStatr, EntryTime, DimissionTime, BasePay)
VALUES (6, 5, 'adminuser', '', 'adminuser', '123', 'fff', 21, 0,'15056346803', '武汉','15056346803','', DEFAULT, getdate(), getdate(), 2999)


SELECT * FROM UserInfo

--视图
CREATE VIEW v_page
AS 
SELECT * FROM 
(
SELECT  row_number() OVER(ORDER BY UserInfo.UserID)AS idx,  UserInfo.* ,Department.DepartmentName, Role.RoleName FROM UserInfo
LEFT JOIN Department ON Department.DepartmentID =  UserInfo.DepartmentID 
RIGHT JOIN Role ON Role.RoleID = UserInfo.RoleID
) AS a

--分页算法SELECT * FROM v_page where idx BETWEEN (pageindex-1)*pagesize+ 1 AND pagesize*pageindex
--SELECT * FROM v_page where idx BETWEEN (2-1)*3 + 1 AND 3*2
--SELECT * FROM v_page  WHERE idx BETWEEN  0+1 AND 5 //0 -5
--SELECT * FROM v_page  WHERE idx BETWEEN  5+1 AND 5 + 5 // 5 - 10

--自联表
create table CategoryItems (
   CID                  int         primary key      identity,
   C_Category           varchar(20)          null,
   CI_ID                int                  null,
   CI_Name              varchar(20)          null,
)
go
insert into CategoryItems values('LeaveStart','1','同意')
insert into CategoryItems values('LeaveStart','2','驳回')
insert into CategoryItems values('LeaveStart','3','审批中')

insert into CategoryItems values('UserStatr','1','在职')
insert into CategoryItems values('UserStatr','2','请假')
insert into CategoryItems values('UserStatr','3','出差')
insert into CategoryItems values('UserStatr','4','离职')

insert into CategoryItems values('Attendance',1,'正常')
insert into CategoryItems values('Attendance',2,'迟到')
insert into CategoryItems values('Attendance',3,'早退')
insert into CategoryItems values('Attendance',4,'缺勤')
insert into CategoryItems values('Attendance',5,'请假')
insert into CategoryItems values('Attendance',6,'迟到/早退')
insert into CategoryItems values('Attendance',7,'未打卡')

insert into CategoryItems values('ApprovalType','1','加班')
insert into CategoryItems values('ApprovalType','2','请假')
insert into CategoryItems values('ApprovalType','3','加薪')

insert into CategoryItems values('NoticeState','1','重要')
insert into CategoryItems values('NoticeState','2','一般')
insert into CategoryItems values('NoticeState','3','紧急')

insert into CategoryItems values('performance',1,'已评')
insert into CategoryItems values('performance',2,'未评')

SELECT * FROM CategoryItems WHERE CategoryItems.C_Category = 'LeaveStart'
--请假表Leave
IF EXISTS(SELECT * FROM sys.objects WHERE name = 'Leave')
DROP table Leave
CREATE TABLE Leave
(
	LeaveID INT PRIMARY KEY IDENTITY (1, 1), --请假编号(主键)
	UserID INT REFERENCES UserInfo (UserID), --用户编号
	LeaveState INT CHECK (LeaveState IN (1, 2, 3)), --审批状态
	LeaveTime DATETIME NULL, --请假时间
	LeaveStartTime DATETIME NULL, --请假起始时间
	LeaveEndTime DATETIME NULL,--结束时间
	LeaveHalfDay VARCHAR (20) NULL, --时间段（上午或下午）
	LeaveDays INT NULL, --请假天数
	LeaveReason VARCHAR (250) NOT NULL, --请假原因
	ApproverID INT NULL, --审批人编号
	ApprovalTime DATETIME NULL, --审批时间
	ApproverReason VARCHAR (250) NULL --	审批备注
)
go
insert into Leave values(13,3,'2019-03-18','2019-03-19','2019-03-22','上午','4','回家看病','','','')
insert into Leave values(14,3,'2019-03-18','2019-04-01','2019-04-02','上午','4','回家看病','','','')
insert into Leave values(10,3,'2019-03-18','2019-03-19','2019-03-22','上午','4','老婆生孩子','','','')
insert into Leave values(11,3,'2019-03-18','2019-04-01','2019-04-02','上午','4','孩子家长会','','','')
insert into Leave values(9,3,'2019-03-18','2019-03-19','2019-03-22','上午','4','休假','','','')
insert into Leave values(8,3,'2019-03-18','2019-04-01','2019-04-02','上午','4','休假','','','')
insert into Leave values(8,2,'2019-03-18','2019-04-01','2019-04-02','上午','4','休假',1,'2019-4-1','')
insert into Leave values(6,1,'2019-03-18','2019-04-01','2019-04-02','上午','4','休假',1,'2019-4-1','好好调整一下趴!')
--创建申请假条视图
IF EXISTS(SELECT * FROM sys.objects WHERE name = 'v_leavepage')
DROP VIEW v_leavepage
go
CREATE VIEW v_leavepage
as
(
SELECT row_number()  OVER (ORDER BY leave.LeaveID) idx, 
Leave.*,
UserInfo.UserName,
UserInfo.UserTel ,
CategoryItems.CI_ID,
CategoryItems.CI_Name,
--Department.DepartmentID,
Department.DepartmentName
from Leave 
LEFT JOIN UserInfo ON UserInfo.UserID = Leave.UserID 
LEFT JOIN Department ON Department.DepartmentID = UserInfo.DepartmentID
left JOIN CategoryItems  ON Leave.LeaveState = CategoryItems.CI_ID 
AND CategoryItems.C_Category ='LeaveStart'  
) 

--SELECT * FROM v_leavepage  WHERE   DepartmentName='财务部' AND LeaveTime BETWEEN '2019-3-18' AND '2019-3-23'
--SELECT * FROM v_leavepage  WHERE LeaveStartTime ='2019-7-23'  
SELECT * FROM v_leavepage 

/*测试sql*/
 --查询当前用户所有的表
--SELECT * FROM sys.objects WHERE type='u'
--select count(*) from v_leavepage

--SELECT * FROM v_leavepage t1,CategoryItems t2 
--WHERE   t1.LeaveState = t2.CI_ID 
--AND t2.C_Category =
--'LeaveStart'  
--UPDATE UserInfo SET EntryTime = getdate() WHERE UserID = 0 

--考勤信息表(AttendanceSheet)
IF EXISTS(SELECT * FROM sys.objects WHERE name = 'AttendanceSheet')
DROP table AttendanceSheet
CREATE TABLE AttendanceSheet
(
AttendanceID INT PRIMARY KEY IDENTITY, 
AttendanceStartTime DATETIME NULL, --考勤时间
AttendanceType INT NULL, --考勤状态
UserID INT NULL, --员工ID
DepartmentID INT NULL, --部门ID
ClockTime DATETIME, --开始
ClockOutTime DATETIME, --结束
Workinghours INT, --工作小时
remake VARCHAR (500) NULL, 
Late INT, --迟到次数
Absenteeism INT --缺勤次数
)
insert  AttendanceSheet values('2019-7-1',1,11,6,'2019-7-1 07:30','2019-07-1 18:06',8,null,null,null)
insert  AttendanceSheet values('2019-7-2',1,11,6,'2019-7-2 07:10','2019-07-2 18:05',8,null,null,null)
insert  AttendanceSheet values('2019-7-3',1,11,6,'2019-7-3 07:20','2019-07-3 18:01',8,null,null,null)
insert  AttendanceSheet values('2019-7-4',1,11,6,'2019-7-4 07:50','2019-07-4 18:10',8,null,null,null)
insert  AttendanceSheet values('2019-7-5',1,11,6,'2019-7-5 07:45','2019-07-5 18:03',8,null,null,null)
insert  AttendanceSheet values('2019-7-6',1,11,6,'2019-7-6 07:34','2019-07-6 18:04',8,null,null,null)
insert  AttendanceSheet values('2019-7-7',1,11,6,'2019-7-7 07:53','2019-07-7 18:00',8,null,null,null)
insert  AttendanceSheet values('2019-7-8',2,11,6,'2019-07-08 10:10','2019-07-07 18:11',8,null,1,null)
insert  AttendanceSheet values('2019-7-9',3,11,6,'2019-07-09 07:50','2019-07-08 16:00',6,null,NULL,null)
insert  AttendanceSheet values('2019-7-10',4,11,6,NULL,NULL,0,null,NULL,null)
insert  AttendanceSheet values('2019-7-11',5,11,6,NULL,NULL,0,null,NULL,null)
insert  AttendanceSheet values('2019-7-12',7,11,6,NULL,NULL,0,'',1,null)
insert  AttendanceSheet values('2019-7-13',1,11,6,'2019-7-13 07:30','2019-07-13 18:06',8,null,null,null)
insert  AttendanceSheet values('2019-7-14',1,11,6,'2019-7-14 07:10','2019-07-14 18:05',8,null,null,null)
insert  AttendanceSheet values('2019-7-15',1,11,6,'2019-7-15 07:20','2019-07-15 18:01',8,null,null,null)
insert  AttendanceSheet values('2019-7-16',1,11,6,'2019-7-16 07:50','2019-07-16 18:10',8,null,null,null)
insert  AttendanceSheet values('2019-7-17',1,11,6,'2019-7-17 07:45','2019-07-17 18:03',8,null,null,null)
insert  AttendanceSheet values('2019-7-18',1,11,6,'2019-7-18 07:34','2019-07-18 18:04',8,null,null,null)
insert  AttendanceSheet values('2019-7-19',1,11,6,'2019-7-19 07:53','2019-07-19 18:00',8,null,null,null)
insert  AttendanceSheet values('2019-7-20',1,11,6,'2019-7-20 07:30','2019-07-20 18:06',8,null,null,null)
insert  AttendanceSheet values('2019-7-21',1,11,6,'2019-7-21 07:10','2019-07-21 18:05',8,null,null,null)
insert  AttendanceSheet values('2019-7-22',1,11,6,'2019-7-22 07:20','2019-07-22 18:01',8,null,null,null)
insert  AttendanceSheet values('2019-7-23',1,11,6,'2019-7-23 07:20','2019-07-23 18:01',8,null,null,null)
insert  AttendanceSheet values('2019-7-24',1,11,6,'2019-7-24 07:50','2019-07-24 18:10',8,null,null,null)
insert  AttendanceSheet values('2019-7-25',1,11,6,'2019-7-25 07:45','2019-07-25 18:03',8,null,null,null)
insert  AttendanceSheet values('2019-7-26',1,11,6,'2019-7-26 07:34','2019-07-26 18:04',8,null,null,null)
insert  AttendanceSheet values('2019-7-27',1,11,6,'2019-7-27 07:53','2019-07-27 18:00',8,null,null,null)
insert  AttendanceSheet values('2019-7-28',1,11,6,'2019-7-28 07:50','2019-07-28 18:10',8,null,null,null)
insert  AttendanceSheet values('2019-7-29',1,11,6,'2019-7-29 07:45','2019-07-29 18:03',8,null,null,null)
insert  AttendanceSheet values('2019-7-30',1,11,6,'2019-7-30 07:34','2019-07-30 18:04',8,null,null,null)
insert  AttendanceSheet values('2019-7-31',1,11,6,'2019-7-31 07:53','2019-07-31 18:00',8,null,null,null)


insert  AttendanceSheet values('2019-7-1',1,7,6,'2019-7-1 07:30','2019-07-1 18:06',8,null,null,null)
insert  AttendanceSheet values('2019-7-2',1,7,6,'2019-7-2 07:10','2019-07-2 18:05',8,null,null,null)
insert  AttendanceSheet values('2019-7-3',1,7,6,'2019-7-3 07:20','2019-07-3 18:01',8,null,null,null)
insert  AttendanceSheet values('2019-7-4',1,7,6,'2019-7-4 07:50','2019-07-4 18:10',8,null,null,null)
insert  AttendanceSheet values('2019-7-5',1,7,6,'2019-7-5 07:45','2019-07-5 18:03',8,null,null,null)
insert  AttendanceSheet values('2019-7-6',1,7,6,'2019-7-6 07:34','2019-07-6 18:04',8,null,null,null)
insert  AttendanceSheet values('2019-7-7',1,7,6,'2019-7-7 07:53','2019-07-7 18:00',8,null,null,null)
insert  AttendanceSheet values('2019-7-8',1,7,6,'2019-07-08 10:10','2019-07-07 18:11',8,null,NULL,null)
insert  AttendanceSheet values('2019-7-9',1,7,6,'2019-07-09 07:50','2019-07-08 16:00',8,null,NULL,null)
insert  AttendanceSheet values('2019-7-10',1,7,6,'2019-7-7 07:53','2019-07-7 18:00',8,null,null,null)
insert  AttendanceSheet values('2019-7-11',1,7,6,'2019-7-7 07:53','2019-07-7 18:00',8,null,null,null)
insert  AttendanceSheet values('2019-7-12',1,7,6,'2019-7-7 07:53','2019-07-7 18:00',8,null,null,null)
insert  AttendanceSheet values('2019-7-13',1,7,6,'2019-7-13 07:30','2019-07-13 18:06',8,null,null,null)
insert  AttendanceSheet values('2019-7-14',1,7,6,'2019-7-14 07:10','2019-07-14 18:05',8,null,null,null)
insert  AttendanceSheet values('2019-7-15',1,7,6,'2019-7-15 07:20','2019-07-15 18:01',8,null,null,null)
insert  AttendanceSheet values('2019-7-16',1,7,6,'2019-7-16 07:50','2019-07-16 18:10',8,null,null,null)
insert  AttendanceSheet values('2019-7-17',1,7,6,'2019-7-17 07:45','2019-07-17 18:03',8,null,null,null)
insert  AttendanceSheet values('2019-7-18',1,7,6,'2019-7-18 07:34','2019-07-18 18:04',8,null,null,null)
insert  AttendanceSheet values('2019-7-19',1,7,6,'2019-7-19 07:53','2019-07-19 18:00',8,null,null,null)
insert  AttendanceSheet values('2019-7-20',1,7,6,'2019-7-20 07:30','2019-07-20 18:06',8,null,null,null)
insert  AttendanceSheet values('2019-7-21',1,7,6,'2019-7-21 07:10','2019-07-21 18:05',8,null,null,null)
insert  AttendanceSheet values('2019-7-22',1,7,6,'2019-7-22 07:20','2019-07-22 18:01',8,null,null,null)
insert  AttendanceSheet values('2019-7-23',1,7,6,'2019-7-23 07:20','2019-07-23 18:01',8,null,null,null)
insert  AttendanceSheet values('2019-7-24',1,7,6,'2019-7-24 07:50','2019-07-24 18:10',8,null,null,null)
insert  AttendanceSheet values('2019-7-25',1,7,6,'2019-7-25 07:45','2019-07-25 18:03',8,null,null,null)
insert  AttendanceSheet values('2019-7-26',1,7,6,'2019-7-26 07:34','2019-07-26 18:04',8,null,null,null)
insert  AttendanceSheet values('2019-7-27',1,7,6,'2019-7-27 07:53','2019-07-27 18:00',8,null,null,null)
insert  AttendanceSheet values('2019-7-28',1,7,6,'2019-7-28 07:50','2019-07-28 18:10',8,null,null,null)
insert  AttendanceSheet values('2019-7-29',1,7,6,'2019-7-29 07:45','2019-07-29 18:03',8,null,null,null)
insert  AttendanceSheet values('2019-7-30',1,7,6,'2019-7-30 07:34','2019-07-30 18:04',8,null,null,null)
insert  AttendanceSheet values('2019-7-31',1,7,6,'2019-7-31 07:53','2019-07-31 18:00',8,null,null,null)
insert  AttendanceSheet values(getdate(),1,7,6,getdate(),getdate(),8,null,null,null)
--创建考勤记录视图
IF EXISTS(SELECT * FROM sys.objects WHERE name = 'v_attendance')
DROP VIEW v_attendance
go
CREATE VIEW v_attendance
AS
(
SELECT t1.*,t2.UserName,t4.DepartmentName,t3.CI_ID,t3.CI_Name 
FROM AttendanceSheet t1, UserInfo t2 , CategoryItems t3, Department t4
WHERE t1.UserID = t2.UserID 
AND t3.CI_ID=t1.AttendanceType 
AND t1.DepartmentID = t4.DepartmentID
AND t1.DepartmentID=t4.DepartmentID 
AND t3.C_Category='Attendance'
)
SELECT  * FROM v_attendance WHERE UserID =11
SELECT  * FROM v_attendance  WHERE year(AttendanceStartTime) =2019 and month(AttendanceStartTime) = 8 AND UserID=11
--SELECT * FROM UserInfo WHERE UserName='fff'
--SELECT  * FROM v_attendance WHERE year(AttendanceStartTime) =year(getdate()) and month(AttendanceStartTime) = month(getdate()) AND UserID=7
--SELECT  * FROM v_attendance WHERE year(AttendanceStartTime) =year(getdate()) AND month(AttendanceStartTime) =7 AND UserID=7
--DELETE FROM AttendanceSheet WHERE month(AttendanceStartTime) =  month(getdate())

--DELETE FROM AttendanceSheet WHERE AttendanceID IN(108)
SELECT * from v_attendance WHERE month(AttendanceStartTime) = 8 AND UserID IN(11,7) 
SELECT * from v_attendance WHERE UserName='fff'
SELECT * FROM v_attendance  WHERE year(AttendanceStartTime) =2019 and month(AttendanceStartTime) = 7 AND UserID=7
--DELETE AttendanceSheet WHERE AttendanceID in(64,65,70,73)
SELECT * FROM v_attendance  WHERE year(AttendanceStartTime) =year(getdate()) and month(AttendanceStartTime) = month(getdate()) AND day(AttendanceStartTime) =day(getdate())  AND UserID=7;