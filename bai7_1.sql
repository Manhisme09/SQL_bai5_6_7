create function fn_timhang(@masp nchar(10))
returns nvarchar(20)
as
begin
	declare @hang nvarchar(20)
	set @hang = ( select tenhang	
					from hangsx inner join sanpham on hangsx.mahangsx=sanpham.mahangsx
					where masp = @masp)
	return @hang
end

select dbo.fn_timhang('sp01') as N'ten hangsx'
-----------------------------------------------
create function fn_tonggtnhap(@x int,@y int)
returns int
as
begin
	declare @tong int
	set @tong = (select sum(soluongN*dongiaN)
					from nhap inner join pnhap on nhap.sohdn=pnhap.sohdn
					where year(ngaynhap) between @x and @y )
	return @tong
end

select dbo.fn_tonggtnhap(2016,2020) as N'Tổng lượng nhập theo năm'

---------------------------------------------------
create function fn_tknhapxuat(@x nvarchar(20),@y int)
returns int
as
begin
	declare @tongnhap int
	declare @tongxuat int
	declare @thaydoi int
	select @tongnhap = sum(soluongN)
		from nhap inner join sanpham on nhap.masp=sanpham.masp
					inner join pnhap on pnhap.sohdn=nhap.sohdn
	where tensp = @x and year(ngaynhap) =@y

	select @tongnhap = sum(soluongX)
		from xuat inner join sanpham on sanpham.masp=xuat.masp
					inner join pxuat on xuat.sohdx=pxuat.sohdx
	where tensp = @x and year(ngayx) =@y
	
	set @thaydoi = @tongnhap-@tongxuat
	return @thaydoi
end

select dbo.fn_tknhapxuat('Galaxy Note 11',2020) as N'thay đổi'

-----------------------------------------------------------
create function fn_tonggtnhap2(@x int,@y int)
returns int
as
begin
	declare @tong int
	set @tong = (select sum(soluongN*dongiaN)
					from nhap inner join pnhap on nhap.sohdn=pnhap.sohdn
					where day(ngaynhap) between @x and @y )
	return @tong
end

select dbo.fn_tonggtnhap2(1,30) as N'Tổng lượng nhập theo ngày'
-----------------------------------------------------------------
create function fn_tksoluongnv(@phong nvarchar(20))
returns int
as
begin
	declare @dem int
	set @dem = (select count(*) 
				from nhanvien
				where phong = @phong)
	return @dem
end

select dbo.fn_tksoluongnv(N'kế toán') as N'số lượng nv'

----------------------------------------------------------------
create function fn_tkxuat(@tensp nvarchar(30),@y int)
returns int
as
begin
	declare @sl int
	set @sl = (select sum(soluongX)
				from sanpham inner join xuat on sanpham.masp=xuat.masp
							inner join pxuat on xuat.sohdx=pxuat.sohdx
				where tensp = @tensp and day(ngayx) =@y)
				
	return @sl
end

select dbo.fn_tkxuat(N'F3 lite',14) as N'số lượng xuất'
---------------------------------------------------------------

create function fn_sdt(@sohdx nchar(10))
returns nchar(10)
as
begin
	declare @sdt nchar(10)
	set @sdt = (select sodt
				from nhanvien inner join pxuat on pxuat.manv=nhanvien.manv 
				where sohdx =@sohdx)
	return @sdt
end

select dbo.fn_sdt('X04') as N'Số điện thoại'
----------------------------------------------------------------

create function fn_slsanpham(@tenhang nvarchar(20))
returns int
as
begin
	declare @tong int
	set @tong = (select sum(soluong)
				  from sanpham inner join hangsx on sanpham.mahangsx=hangsx.mahangsx
				  where tenhang =@tenhang )
	return @tong
end

select dbo.fn_slsanpham('oppo') as N'tổng số lượng'