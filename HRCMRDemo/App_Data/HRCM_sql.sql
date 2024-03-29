use master 
go
create database PersonnelManagementSystem
go
use PersonnelManagementSystem
go
--部门表
create table DepartmentTable
(
DepartmentNum int primary key identity(1,1) ,--部门编号
DepartmentName varchar(20) not null ,--部门名称
)
insert into DepartmentTable values('财务部'),('行政部'),('公关部'),('人事部'),('研发部'),('销售部');

--职位表
create table JobTable
(
JobNum int primary key identity(1,1) ,--职位编号
Jobname varchar(20) not null ,--职位名称
)
insert into JobTable values ('总经理'),('部门经理'),('人事经理'),('人事助理'),('普通员工');

--人员表
create table StaffTable
(
StaffNum int primary key identity(1,1),--人员编号
StaffImg varchar(50) ,--人员照片
StaffName varchar(20) ,--人员名字
DepartmentNum int references DepartmentTable(DepartmentNum),--部门编号
StaffAge int not null,--年龄
StaffSex varchar(2) check(StaffSex='男' or StaffSex='女'),--
StaffIphone varchar(20) not null,--电话
StaffAddress varchar(20) not null,--地址
StaffStime datetime not null,--入职时间
StaffWages int not null,--薪资
JobNum int references JobTable(JobNum),--职位编号
Remarks varchar(500),--个人介绍
)

insert into  StaffTable values('@','老大',1,24,'男','17607113724','青年联合城一栋','2019-7-1',3000,1,null);
insert into  StaffTable values('@','行政1',2,24,'男','17607113724','青年联合城一栋','2019-7-1',3000,5,null);
insert into  StaffTable values('@','公关1',3,24,'男','17607113724','青年联合城一栋','2019-7-1',3000,5,null);
insert into  StaffTable values('@','人事经理',4,24,'男','17607113724','青年联合城一栋','2019-7-1',3000,3,null);
insert into  StaffTable values('@','人事助理',4,24,'男','17607113724','青年联合城一栋','2019-7-1',3000,4,null);
insert into  StaffTable values('@','研发经理',5,24,'男','17607113724','青年联合城一栋','2019-7-1',3000,2,null);
insert into  StaffTable values('@','研发1',5,24,'男','17607113724','青年联合城一栋','2019-7-1',3000,5,null);
insert into  StaffTable values('@','研发2',5,24,'男','17607113724','青年联合城2栋','2019-7-1',3000,5,null);
insert into  StaffTable values('@','研发3',5,24,'男','17607113724','青年联合城3栋','2019-7-1',3000,5,null);
insert into  StaffTable values('@','研发4',5,24,'男','17607113724','青年联合城4栋','2019-7-1',3000,5,null);
insert into  StaffTable values('@','研发5',5,24,'男','17607113724','青年联合城5栋','2019-7-1',3000,5,null);
insert into  StaffTable values('@','销售1',6,24,'男','17607113724','青年联合城6栋','2019-7-1',3000,5,null);

create table LoginTable
(
LoginId int primary key identity(1,1),--登录编号
LoginName varchar(20) not null,--登录名称
LoginPwd varchar(20) not null,--登录密码
StaffNum int references StaffTable(StaffNum),--人员编号
JobNum int references JobTable(JobNum)--职位编号
)
insert into LoginTable values ('admin1','123',1,1),('admin2','123',2,5),('admin3','123',3,5),('admin4','123',4,3),('admin5','123',5,4),('admin6','123',6,2);
insert into LoginTable values ('admin7','123',7,5),('admin8','123',8,5),('admin9','123',9,5),('admin10','123',10,5),('admin11','123',11,5),('admin12','123',12,5);
select * from JobTable; --职位表
select * from DepartmentTable;--部门表
select * from StaffTable;--人员表
select * from LoginTable  WHERE LoginName ='admin1'
select * from LoginTable t1, JobTable t2 WHERE t1.JobNum = t2.JobNum;--登录表,

select * from LoginTable  WHERE JobNum = 5

select * from LoginTable t1, JobTable t2 WHERE t1.JobNum = t2.JobNum  and t1.LoginName = 'admin1'
