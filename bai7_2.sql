create function fn_dssvTheoHang(@tenhang nvarchar(20))
returns @bang table(
				masp nchar(10),tensp nvarchar(30),soluong int,
				mausac nchar(10),giaban money,donvitinh nchar(10),
				mota ntext )
as
begin
	insert into @bang
				select masp,tensp,soluong,mausac,giaban,donvitinh,mota
				from sanpham inner join hangsx on sanpham.mahangsx=hangsx.mahangsx
				where tenhang=@tenhang
	return
end

select * from fn_dssvTheoHang('Samsung')

---------------------------------------------------------------
create function fn_DSSPNhapTheoNgay(@x date,@y date)
returns @bang table (
 MaSP nvarchar(10),
 TenSP nvarchar(20),
 TenHang nvarchar(20),
 NgayNhap date,
 SoLuongN int,
 DonGiaN float
 )
as
begin
 insert into @bang
 select sanpham.masp, tensp, tenhang, ngaynhap, soluongN,dongiaN
 from nhap Inner join sanpham on nhap.masp = sanpham.masp
 Inner join hangsx on sanpham.mahangsx = hangsx.mahangsx
 Inner join pnhap on pnhap.sohdn=nhap.sohdn
 where ngaynhap between @x And @y
 return
endselect * from fn_DSSPNhapTheoNgay('2/9/2018','3/9/2021')----------------------------------------------------------------create function fn_dssp(@tenhang nvarchar(20),@x int)returns @bang table(				masp nchar(10),tensp nvarchar(30),soluong int,
				mausac nchar(10),giaban money,donvitinh nchar(10),
				mota ntext )
as
begin
	if(@x=0)
		insert into @bang
		select masp,tensp,soluong,mausac,giaban,donvitinh,mota
		from sanpham inner join hangsx on sanpham.mahangsx=hangsx.mahangsx
		where tenhang = @tenhang and soluong = 0
	else
	if(@x=1)
		insert into @bang
		select masp,tensp,soluong,mausac,giaban,donvitinh,mota
		from sanpham inner join hangsx on sanpham.mahangsx=hangsx.mahangsx
		where tenhang = @tenhang and soluong > 0
	return
end

select * from fn_dssp('samsung',0)
select * from fn_dssp('samsung',1)

-----------------------------------------------------------------------------

create function fn_dsnv(@tenphong nvarchar(20))
returns @bang table(
				manv nchar(10),tennv nvarchar(20),gioitinh nchar(10),
				diachi nvarchar(20),sdt nvarchar(10),email nvarchar(20),phong nvarchar(20)
				)
as
begin 
	insert into @bang
	select manv,tennv,gioitinh,diachi,sodt,email,phong
	from nhanvien
	where phong = @tenphong
	return
end

select * from fn_dsnv(N'Kế Toán')

---------------------------------------------------------------------------

create function fn_dshangsx(@diachi nvarchar(30))
returns @bang table(
				mahangsx nvarchar(20),tenhang nvarchar(20),diachi nvarchar(20),
				sodt nchar(10),email nvarchar(20) )
as
begin
	insert into @bang
	select mahangsx,tenhang,diachi,sodt,email
	from hangsx
	where diachi like @diachi
	return
end

select * from fn_dshangsx(N'Việt Nam')

---------------------------------------------------------------------------

create function fn_dssanphamandhangsx(@x int,@y int)
returns @bang table(
				masp nchar(10),mahangsx nvarchar(20),tenhang nvarchar(20),tensp nvarchar(30),soluong int,
				mausac nchar(10),giaban money,donvitinh nchar(10),
				mota ntext )
as
begin
	insert into @bang
	select sanpham.masp,sanpham.mahangsx,tenhang,tensp,soluong,mausac,giaban,donvitinh,mota
	from sanpham inner join hangsx on sanpham.mahangsx=hangsx.mahangsx
					inner join xuat on xuat.masp=sanpham.masp
					inner join pxuat on xuat.sohdx=pxuat.sohdx
	where year(ngayx) between @x and @y
	return
end

select * from fn_dssanphamandhangsx(2018,2021)		

------------------------------------------------------------------------------------------

create function fn_dssp2(@tenhang nvarchar(20),@x int)returns @bang table(				masp nchar(10),tensp nvarchar(30),soluong int,
				mausac nchar(10),giaban money,donvitinh nchar(10),
				mota ntext )
as
begin
	if(@x=0)
		insert into @bang
		select sanpham.masp,tensp,soluong,mausac,giaban,donvitinh,mota
		from sanpham inner join hangsx on sanpham.mahangsx=hangsx.mahangsx
					inner join nhap on nhap.masp=sanpham.masp
		where tenhang = @tenhang 
	else
	if(@x=1)
		insert into @bang
		select sanpham.masp,tensp,soluong,mausac,giaban,donvitinh,mota
		from sanpham inner join hangsx on sanpham.mahangsx=hangsx.mahangsx
					inner join xuat on xuat.masp=sanpham.masp
		where tenhang = @tenhang 
	return
end

select * from fn_dssp2('samsung',0)
select * from fn_dssp2('samsung',1)

----------------------------------------------------------------------------------

create function fn_kothambien()
returns @bang table(
				masp nchar(10),mahangsx nvarchar(20),tenhang nvarchar(20),tensp nvarchar(30),soluong int,
				mausac nchar(10),giaban money,donvitinh nchar(10),
				mota ntext )
as
begin
	insert into @bang
	select sanpham.masp,sanpham.mahangsx,tenhang,tensp,soluong,mausac,giaban,donvitinh,mota
	from sanpham inner join hangsx on sanpham.mahangsx=hangsx.mahangsx
	return
end

select * from fn_kothambien()