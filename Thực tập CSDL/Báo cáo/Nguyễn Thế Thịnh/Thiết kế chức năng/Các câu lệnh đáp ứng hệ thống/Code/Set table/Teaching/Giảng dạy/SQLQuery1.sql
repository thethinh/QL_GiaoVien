Create table HocPhan
(
	MaHP varchar(15) primary key,
	TenHP nvarchar(max),
	SoTC int,
	MaHinhThucThi varchar(15)
)

Create table LopHP
(
	MaLopHP varchar(15) primary key,
	TenLopHP nvarchar(max),
	TimeBĐ date,
	TimeKT date,
	DiaDiem nvarchar(max),
	HocKi char(3),
	MaHP varchar(15)
)

Create table ChiTietLopHP
(
	MaLopHP varchar(15),
	SySo int,
	DinhMuc float,
	DonViTinh nchar(7)
)

Create table HDBT
(
	MaGV varchar(15),
	MaLopHP varchar(15),
	SoTiethd float,
	primary key (MaGV,MaLopHP)
)

Create table BT_baiKT_TN_TH_TL
(
	MaBT varchar(15) primary key,
	TenBT nvarchar(max),
	MaLopHP varchar(15),
	GioChuan float,
	DonVi nvarchar(30)
)

Create table LopEng
(
	MaLopEng varchar(15) primary key,
	TenLop nvarchar(max),
	MaLoaiLopEng varchar(15)
)

Create table LoaiLopEng
(
	MaLoaiLopEng varchar(15) primary key,
	TenLoaiLopEng nvarchar(max)
)

Create table DinhMucDayEng
(
	MaLoaiLopEng varchar(15),
	GioChuan float,
	DonVi nvarchar(10),
	GhiChu nvarchar(max)
)

Create table DayEng
(
	MaGV varchar(15),
	MaLopEng varchar(15),
	SoTiet float,
	primary key (MaGV,MaLopEng)
)

Create table LopTheDuc
(	
	MaLopTD varchar(15) primary key,
	TenLopTD nvarchar(max)
)

Create table ChiTietLopTD 
(
	MaLopTD varchar(15),
	SySo int,
	GioChuan float,
	DonVi nvarchar(10),
	GhiChu nvarchar(max)
)

Create table Day_BoiDuongTD
(
	MaGV varchar(15),
	MaLopTD varchar(15),
	SoTiet float,
	primary key (MaGV,MaLopTD)
)

Create table LopChuyenNganh
(
	MaLopCN varchar(15) primary key,
	TenLopCN nvarchar(max),
	SySo int,
	HeDaoTao nvarchar(max),
	MaLoaiHinhDtao varchar(15)
)

Create table LoaiHinhDtao
(
	MaLoaiHinhDtao varchar(15) primary key,
	TenLoaiHinhDtao nvarchar(max)
)

Create table GiangDayLT
(
	MaGV varchar(15),
	MaLopHP varchar(15),
	SoTiet float,
	primary key (MaGV ,MaLopHP)
)

Create table LopDayVeKT
(
	MaLopKT varchar(15) primary key,
	TenLop nvarchar(max)
)

Create table DayVeKT
(
	MaGV varchar(15),
	MaLopKT varchar(15),
	SoTiet float,
	GioChuan float,
	primary key (MaGV, MaLopKT)
)

Create table LopPhuDao
(
	MaLopPD varchar(15) primary key,
	TenLopPD nvarchar(max)
)

Create table DayPhuDao
(
	MaGV varchar(15) references GiaoVien(MaGV),
	SoTiet float,
	MaLopHP varchar(15) references LopHP (MaLopHP),
	primary key(MaGV,MaLopHP)
)

Create table TongDMGD_HH
(
	MaHocham varchar(15),
	QuiDinhChungCacMon float,
	QuiDinhDGDTC_GDQP float
)

Create table TongDMGD_CMKT
(
	MaChucDanh varchar(15),
	QuiDinhChungCacMon float,
	QuiDinhDGDTC_GDQP float
)

Create table BTL_TapBai15t
(
	MaBTL varchar(15) primary key,
	TenBTL nvarchar(max),
	MaHP varchar(15),
	MaLoaiBTL varchar(15)
)

Create table LoaiBTL
(
	MaLoaiBTL varchar(15) primary key,
	TenLoai nvarchar(max)
)

Create table LamBTL
(
	MaLopHP varchar(15),
	MaBTL varchar(15),
	primary key (MaLopHP,MaBTL)
)

Create table DayBTL
(
	MaGV varchar(15),
	MaLopHP varchar(15),
	primary key (MaGV,MaLopHP)
)

Create table DMdayBTL
(
	MaLoaiBTL varchar(15),
	NoiDung nvarchar(max),
	GioChuan float,
	DonVi nvarchar(10),
	GhiChu nvarchar(max),
	MaLoaiDMdayBTL varchar(15)
)

Create table LoaiDMdayBTL
(
	MaLoaiDMdayBTL varchar(15) primary key,
	TenLoai nvarchar(max)
)
