Create table ChucVuTheThao
(
	MaChucVuTT varchar(15) primary key,
	TenChucVu nvarchar(max)
)

Create table NhanCVthethao
(
	MaChucVuTT varchar(15),
	MaGV varchar(15),
	TimeBĐ date,
	TimeKT date,
	primary key (MaChucVuTT,MaGV)
)

Create table TheThao
(
	MaMonTT varchar(15) primary key,
	TenMonTT nvarchar(max)
)

Create table ThamGiaTheThao
(
	MaGV varchar(15),
	MaMonTT varchar(15),
	NgayThamGia date,
	NgayKetThuc date,
	primary key (MaGV,MaMonTT)
)

Create table ĐMthethao
(
	MaMonTT varchar(15),
	MaChucVuTT varchar(15),
	GioChuan float,
	DonVi nvarchar(10),
	primary key (MaMonTT,MaChucVuTT)
)

Create table CongTacKhac
(
	MaCongTac varchar(15) primary key,
	TenCongTac nvarchar(max),
	Kieu nvarchar(max),
)

Create table ThamGiaCongTacKhac
(
	MaGV varchar(15),
	MaCongTac varchar(15),
	TimeBĐ date,
	TimeKT date,
	VaiTro nvarchar(max),
	primary key(MaGV,MaCongTac)
)
	