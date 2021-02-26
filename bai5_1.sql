create view vw_cau2
as
select ton.mavt,tenvt,sum(soluongX*dongiaX) as N'Tiền bán'
from ton inner join xuat on ton.mavt=xuat.mavt
group by ton.mavt,tenvt

--test

select * from vw_cau2 

----------------------------------------------
create view vw_cau3
as
select ton.tenvt,count(soluongX) as N'tổng slX'
from ton inner join xuat on ton.mavt=xuat.mavt
group by ton.tenvt
--test
select * from vw_cau3
---------------------------------------------
create view vw_cau4
as
select ton.tenvt,count(soluongN) as N'tổng slN'
from ton inner join nhap on ton.mavt=nhap.mavt
group by ton.tenvt
--test
select * from vw_cau4
----------------------------------------------
create view vw_cau5
as
select ton.mavt,tenvt,sum(soluongN)-sum(soluongX)+sum(soluongT) as N'số lượng còn' 
from ton inner join xuat on ton.mavt=xuat.mavt
			inner join nhap on nhap.mavt=ton.mavt
group by ton.mavt,tenvt
--test
select * from vw_cau5