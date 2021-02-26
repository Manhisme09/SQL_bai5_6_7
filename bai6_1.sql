create view cau2
as
select tenvt
from ton
where soluongT = (select max(soluongT) from Ton)
--test
select * from cau2

-----------------------------------------------
create view cau3
as
select ton.mavt,tenvt
from ton inner join xuat on ton.mavt=xuat.mavt
group by ton.mavt,tenvt
having sum(soluongX)>=100
--test
select * from cau3

----------------------------------------------
create view cau4
as
select month(ngayX) as N'ngày xuất',year(ngayX) as N'năm xuất',sum(soluongX) as N'số lượng xuất'
from xuat
group by month(ngayX),year(ngayX)
--test
select * from cau4
----------------------------------------------
create view cau5
as
select ton.mavt,tenvt,soluongN,soluongX,dongiaN,dongiaX,ngayN,ngayX
from ton inner join xuat on ton.mavt=xuat.mavt
		inner join nhap on nhap.mavt=ton.mavt	
--test 
select * from cau5 

----------------------------------------------
create view cau6
as
select ton.mavt,tenvt,sum(soluongN)-sum(soluongX)+sum(soluongT) as N'Số lượng còn lại'
from ton inner join xuat on ton.mavt=xuat.mavt
		inner join nhap on nhap.mavt=ton.mavt
where year(ngayN)=2020 and YEAR(ngayX)=2020			
group by ton.mavt,tenvt
--test

select * from cau6
