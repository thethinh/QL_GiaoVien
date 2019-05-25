Create table DeTaiKH 
(
	MaCT varchar(15) primary key,
	TenCT nvarchar(max),
	Kieu nvarchar(30),
	NoiQuanLy nvarchar(max),
	MaLoaiCT varchar(15)
)

Create table CapĐT
(
	MaCapDT varchar(15) primary key,
	TenCapDT nvarchar(max)
)

Create table NghienCuuDTKH
(
	MaCT varchar(15),
	MaGV varchar(15),
	TimeBĐ date,
	TimeKT date,
	VaiTro nvarchar(max)
)

Create table TinhTrangCTKH
(
	MaCT varchar(15),
	TinhTrang nvarchar(max),
	ThoiDiem date
)

Create table DinhMucNCKH
(
	MaCT varchar(15),
	MaCapDT varchar(15),
	DonVi nvarchar(10),
	GioChuan float,
	GhiChu nvarchar(max)
)

Create table BaiBaoKH
(
	MaBaiBao varchar(15) primary key,
	TenBaiBao nvarchar(max),
	Loai nvarchar(max)
)

Create table BaoCaoKH
(
	MaBaocao varchar(15) primary key,
	TenBaoCao nvarchar(max),
	Loai nvarchar(max)
)

Create table ThamGiaBaiBaoKH
(
	MaGV varchar(15),
	MaBaiBao varchar(15),
	TimeBĐ date ,
	TimeKT date ,
	VaiTro nvarchar(max)
)

Create table ThamGiaBaoCaoKH
(
	MaGV varchar(15),
	MaBaoCao varchar(15),
	TimeBĐ date ,
	TimeKT date,
	VaiTro nvarchar(max)
)

Create table ĐăngBaiBao
(
	MaTapChi varchar(15),
	MaBaiBao varchar(15),
	NgayDang date,
	primary key (MaTapChi,MaBaiBao) 
)

Create table ĐăngBaoCao
(
	MaHoiNghi varchar(15),
	MaBaoCao varchar(15),
	NgayDang date,
	primary key (MaHoiNghi,MaBaocao)
)

Create table HoiNghiKH
(
	MaHoiNghi varchar(15) primary key,
	TenHoiNghi nvarchar(max),
	MaLoaiHoiNghi varchar(15)
)

Create table tapChi
(
	MaTapChi varchar(15) primary key,
	TenTapChi nvarchar(max),
	MaLoaiTapChi varchar(15)
)

Create table ĐMBaoCao
(
	MaLoaiHoiNghi varchar(15) primary key,
	TenLoaiHoiNghi nvarchar(max),
	GioChuan float,
	DonVi nvarchar(10),
	GhiChu nvarchar(max)
)

Create table ĐMBaiBao
(
	MaLoaiTapChi varchar(15) primary key,
	TenLoaiTapChi nvarchar(max),
	GioChuan float,
	DonVi nvarchar(10),
	GhiChu nvarchar(max)
)

Create table Sach
(
	MaSach varchar(15) primary key,
	TenSach nvarchar(max),
	MaLoaiSach varchar(15)
)

Create table LoaiSach
(
	MaLoaiSach varchar(15) primary key,
	TenLoaiSach varchar(max),
	DinhMuc float,
	DonVi nvarchar(10),
	GhiChu nvarchar(max)
)

Create table VietSach
(
	MaGV varchar(15),
	MaSach varchar(15),
	VaiTro nvarchar(max),
	SoTrang_TC int,
	primary key (MaGV,MaSach)
)

Create table NhaXB
(
	MaNXB varchar(15) primary key,
	TenNXB nvarchar(max)
)

Create table XuatBan
(
	MaNXB varchar(15),
	MaSach varchar(15),
	NơiXB nvarchar(max),
	NgayXB date
	primary key (MaNXB,MaSach) 
)

create table GiaiThuongKHCN
(
	MaGiaiThuong varchar(15) primary key,
	TenGiaiThuong nvarchar(15),
	Cap nvarchar(max),
	HinhThuc nvarchar(max),
	PhamVi nvarchar(max),
	MaLoaiGiaiThuong varchar(15)
)

Create table LoaiGiaiThuong
(
	MaLoaiGiaiThuong varchar(15) primary key,
	TenLloaiGiaiThuong nvarchar(max),
	DinhMuc float,
	DonVi nvarchar(10),
	GhiChu nvarchar(max)
)

Create table NhanGiaiThuong
(
	MaGV varchar(15),
	MaGiaiThuong varchar(15),
	NgayNhan date,
	ToChucTraoGiai nvarchar(max),
	primary key (MaGV,MaGiaiThuong)
)

Create table BangPhatMinh
(
	MaVanBang varchar(15) primary key,
	TenVanBang nvarchar(max),
	NoiDung nvarchar(max),
	So char(50),
	MaLoaiVB varchar(15)
)

Create table LoaiVB
(
	MaLoaiVB varchar(15) primary key,
	TenLoaiVB nvarchar(max),
	DinhMuc float,
	DonVi nvarchar(10),
	GhiChu nvarchar(max)
)

Create table CapVanBang
(
	MaGV varchar(15),
	MaVanBang varchar(15),
	NgayCap date,
	NoiCap nvarchar(max),
	primary key (MaGV,MaVanBang)
)

Create table SanPhamKHCN
(
	MaSP varchar(15) primary key,
	TenSP nvarchar(max),
	CapSP nvarchar(max),
	MaCT varchar(15)
)

Create table UngDungSPKH
(
	MaSP varchar(15),
	MaDiaChi varchar(15),
	QuyMo nvarchar(max),
	PhamVi nvarchar(max),
	HieuQua nvarchar(max),
	HinhThuc nvarchar(max),
	ThoiGian date,
	primary key (MaSP,MaDiaChi)
)

Create table NoiUngDungSPKH
(
	MaDiaChi varchar(15) primary key,
	TenDiaChi nvarchar(max)
)





