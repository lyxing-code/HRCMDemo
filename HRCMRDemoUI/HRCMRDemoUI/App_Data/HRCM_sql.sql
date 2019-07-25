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
SELECT * FROM v_page  WHERE idx BETWEEN  0+1 AND 5 //0 -5
SELECT * FROM v_page  WHERE idx BETWEEN  5+1 AND 5 + 5 // 5 - 10

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

SELECT  FROM CategoryItems WHERE CategoryItems.C_Category = 'LeaveStart'
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
--创建申请假条视图
CREATE VIEW v_leavepage
as
(
SELECT row_number()  OVER (ORDER BY leave.LeaveID) idx, Leave.*,UserInfo.UserName,UserInfo.UserTel from Leave LEFT JOIN UserInfo ON UserInfo.UserID = Leave.UserID
) 

SELECT * FROM v_leavepage  WHERE idx BETWEEN  5+1 AND 5 + 5
select count(*) from v_leavepage