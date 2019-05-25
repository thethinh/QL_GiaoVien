Create table ChamThi
(
	MaGV varchar(15),
	MaLopThiHP varchar(15),
	SoBai int,
	primary key (MaGV,MaLopThiHP)
)

Create table LopThiHP
(
	MaLopThiHP varchar(15) primary key,
	TenLop nvarchar(max),
	SySo int,
	MaHinhThucThi varchar(15)
)

Create table ToChucThiHP
(
	MaLopHP varchar(15),
	MaLopThiHp varchar(15),
	NgayThi date,
	primary key (MaLopHP,MaLopThiHP)
)

Create table HinhThucThi
(
	MaHinhThucThi varchar(15) primary key,
	TenHinhThuc nvarchar(max)
)

Create table DMChamThi
(
	MaHinhThucThi varchar(15),
	NDcongviec nvarchar(max),
	GioChuan float,
	DonVi nvarchar(max),
	GhiChu nvarchar(max)
)

Create table DMchamBTL
(
	MaLoaiBTL varchar(15),
	GioChuan float,
	DonVi nvarchar(max)
)

Create table DMchamDT
(
	MaLoaiDT varchar(15),
	GioChuan float,
	DonVi nvarchar(15)
)
