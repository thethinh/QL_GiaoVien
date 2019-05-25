Create table HoiDong
(
	MaHD varchar(15) primary key,
	TenHD nvarchar(max),
	MaLoaiHD varchar(15)
)

Create table LoaiHD
(
	MaLoaiHD varchar(15) primary key,
	TenLoaiHD nvarchar(max)
)

Create table ThamGiaHD
(
	MaGV varchar(15),
	MaHD varchar(15),
	TimeBĐ date,
	TimeKT date
)

Create table DMthamgiaHD
(
	MaHĐ varchar(15) ,
	VaiTro nvarchar(max),
	GioChuan float,
	DonVi nvarchar(max),
	GhiChu nvarchar(max)
)