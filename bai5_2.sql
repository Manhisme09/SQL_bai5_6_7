create function fn_demsv(@malop nchar(10))
returns int
as
begin
	declare @dem int
	set @dem = (select count(*) from sv
				where malop = @malop)
	return @dem
end

select dbo.fn_demsv('4') as N'Tổng số sinh viên'

----------------------------------------------

create function fn_dssvtheolop(@tenlop nvarchar(20))
returns @bang table(
						masv nchar(10),tensv nvarchar(25)
					)
as 
begin
	insert into @bang 
					select sv.masv,tensv
					from lop inner join sv on sv.malop=lop.malop
					where tenlop = @tenlop
	return
end

select *from fn_dssvtheolop('CD')

-----------------------------------------------------

create function fn_thongkesv(@tenlop nvarchar(20))
returns @bang table(
						malop nchar(10),tenlop nvarchar(20),soluongsv int
					)
as
begin
	if(not exists(select malop from lop where tenlop = @tenlop))
		insert into @bang
						select lop.malop,tenlop,count(lop.malop)
						from  lop inner join sv on lop.malop=sv.malop
						group by lop.malop,tenlop	 
	else
		insert into @bang
						select lop.malop,tenlop,count(lop.malop)
						from lop inner join sv on lop.malop=sv.malop
						where tenlop = @tenlop
						group by lop.malop,tenlop
						
		return
end

select * from fn_thongkesv('CDm')
-----------------------------------------------------

create function fn_phonghoc(@tensv nvarchar(25))
returns nvarchar(20)
as
begin 
	declare @phong nvarchar(20)
	set @phong = ( select phong 
					from sv inner join lop on sv.malop=lop.malop
					where tensv = @tensv
				)
	return @phong
end

select dbo.fn_phonghoc('B')	as N'Phòng học'		

----------------------------------------------------

create function fn_thongkesvtheop(@phong nvarchar(20))
returns @bang table(
					 masv nchar(10),tensv nvarchar(25),tenlop nvarchar(20),phong nvarchar(20)
					)
as
begin 
	if(not exists(select phong from lop where phong =@phong))
		insert into @bang
						select sv.masv,tensv,tenlop,phong
						from sv inner join lop on lop.malop=sv.malop
	else
		insert into @bang	
						select sv.masv,tensv,tenlop,phong
						from sv inner join lop on lop.malop=sv.malop
						where phong = @phong
	return
end

select * from fn_thongkesvtheop('5')

-----------------------------------------------------

create function fn_thongkeslp(@phong nvarchar(20))
returns int
as
begin
	declare @sl int
	if(not exists(select phong from lop where phong =@phong))
		set @sl = '0'
	else 
		
		set @sl = (select count(*)
					from lop
					where phong = @phong
					)
	
	return @sl		
end

select dbo.fn_thongkeslp('5') as N'số lượng phòng'


