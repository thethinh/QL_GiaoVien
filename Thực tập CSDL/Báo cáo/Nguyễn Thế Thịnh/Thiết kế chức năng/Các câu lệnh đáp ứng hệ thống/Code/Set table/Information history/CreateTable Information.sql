Create table GiaoVien
(
	MaGV varchar(15) primary key,
	TenGV nvarchar(max),
	NgaySinh date,
	GT nchar(5) 
	QueQuan nvarchar(max),
	Email varchar(max),
	MaBM varchar(15)
)
ALTER TABLE GiaoVien
ADD CONSTRAINT GT_CHECK CHECK (GT IN ('Nam',N'Nữ'))

Create table HocHam
(
	MaHocHam varchar(15) primary key,
	TenHocHam nvarchar(max)
)

Create table DinhMucMienGiam
(
	MaCVdang varchar(15) primary key,
	TiLeMienGiam char(5)
)

Create table NhanHocHam
(
	MaGV varchar(15),
	MaHocHam varchar(15),
	ThoiGian date,
	primary key(MaGV,MaHocHam)
)

Create table ChucVuDang
(
	MaChucVu varchar(15) primary key,
	TenChucVu nvarchar(max)
)

Create table NhanCVdang
(
	MaChucVu varchar(15),
	MaGV varchar(15),
	ThoiGian date,
	primary key(MaChucVu,MaGV)
)

Create table HocVi
(
	MaHocVi varchar(15) primary key,
	TenHocVi nvarchar(max)
)

Create table NhanHocVi
(
	MaHocVi varchar(15),
	MaGV varchar(15),
	ThoiGian date,
	primary key(MaHocVi,MaGV)
)

Create table ChucDanhCMNV
(
	MaChucDanh varchar(15) primary key,
	TenChucDanh nvarchar(max)
)

Create table NhanChucDanhCMNV
(
	MaChucDanh varchar(15),
	MaGV varchar(15),
	ThoiGian date,
	primary key(MaChucDanh,MaGV)
)

Create table BoMon
(
	MaBM varchar(15) primary key,
	TenBM nvarchar(max),
	MaKhoa varchar(15)
)

Create table Khoa
(
	MaKhoa varchar(15) primary key,
	TenKhoa nvarchar(max)
)

Create table ChucVuBM
(
	MaCVbm varchar(15) primary key,
	TenChucVu nvarchar(max),
	TimeBĐ date,
	TimeKT date,
	MaGV varchar(15),
	MaBM varchar(15)
)

Create table ChucVuKhoa
(
	MaCVKhoa varchar(15) primary key,
	TenChucVu nvarchar(max),
	TimeBĐ date,
	TimeKT date,
	MaGV varchar(15),
	MaKhoa varchar(15)
)

Create table TongDinhMucNCKH_HH
(
	MaHocHam varchar(15),
	DinhMucTime float,
	DinhMucGioChuan float,
	DonVi nvarchar(10)
)

Create table TongDinhMucNCKH_CMKT
(
	MaChucDanh varchar(15),
	DinhMucTime float,
	DinhMucGioChuan float,
	DonVi nvarchar(10)
)

Create table CVkhoa_MienGiam
(
	MaCVkhoa varchar(15) primary key,
	TiLeGiam char(5)
)

Create table CVbm_MienGiam
(
	MaCVbm varchar(15) primary key,
	TiLeGiam char(5)
)

