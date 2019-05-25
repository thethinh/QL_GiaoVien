--Lấy chi tiết những học phần đã giảng dạy theo mã gv và năm học
create proc GiangDayChiTiet(@magv varchar(15), @nam varchar(15))
as
begin
select LopHP.NamHoc, HocPhan.TenHP, LoaiHinhDtao.TenLoaiHinhDtao
from PhanCongGD join LopHP on PhanCongGD.MaLopHP=LopHP.MaLopHP join HocPhan on LopHP.MaHP=HocPhan.MaHP 
		join LoaiHinhDtao on LoaiHinhDtao.MaLoaiHinhDtao=HocPhan.DoiTuongHoc
where PhanCongGD.MaGV=@magv and YEAR(LopHP.TimeBĐ)<=@nam and YEAR(LopHP.TimeKT)<=@nam

end

--Lấy số luận án tiến sỹ đã hướng dẫn theo mã gv và nam
create proc SoLATSdahd(@magv varchar(15), @nam varchar(15))
as
begin
declare @Time table(madt varchar(15),mahv varchar(15), namkt varchar(15))
insert into @Time
select ChonDT.MaDT,HocVien.MaHV,LopChuyenNganh.NamKT
from ChonDT join HocVien on ChonDT.MaHV=HocVien.MaHV join LopChuyenNganh on LopChuyenNganh.MaLopCN=HocVien.MaLopCN

declare @LATS table (magv varchar(15),madt varchar(15),tendt varchar(max))
insert into @LATS
select MaGV,DeTai_CĐ.MaDT,LoaiDT.TenDT
from HuongDanHV join ChonDT on HuongDanHV.MaHV=ChonDT.MaHV join  DeTai_CĐ on DeTai_CĐ.MaDT=ChonDT.MaDT
		join LoaiDT on LoaiDT.MaLoaiDT=DeTai_CĐ.MaLoaiDT 
where MaGV=@magv and LoaiDT.TenDT=N'Luận án tiến sỹ'

select COUNT(lats.madt)
from @Time as Thgian, @LATS as lats
where Thgian.madt=lats.madt and YEAR(Thgian.namkt) < @nam
end

--Lấy số luận án tiến sỹ đang hướng dẫn theo mã gv và nam
create proc SoLATSdanghd(@magv varchar(15), @nam varchar(15))
as
begin
declare @Time table(madt varchar(15),mahv varchar(15), namkt varchar(15))
insert into @Time
select ChonDT.MaDT,HocVien.MaHV,LopChuyenNganh.NamKT
from ChonDT join HocVien on ChonDT.MaHV=HocVien.MaHV join LopChuyenNganh on LopChuyenNganh.MaLopCN=HocVien.MaLopCN

declare @LATS table (magv varchar(15),madt varchar(15),tendt varchar(max))
insert into @LATS
select MaGV,DeTai_CĐ.MaDT,LoaiDT.TenDT
from HuongDanHV join ChonDT on HuongDanHV.MaHV=ChonDT.MaHV join  DeTai_CĐ on DeTai_CĐ.MaDT=ChonDT.MaDT
		join LoaiDT on LoaiDT.MaLoaiDT=DeTai_CĐ.MaLoaiDT 
where MaGV=@magv and LoaiDT.TenDT=N'Luận án tiến sỹ'

select COUNT(lats.madt)
from @Time as Thgian, @LATS as lats
where Thgian.madt=lats.madt and YEAR(Thgian.namkt) = @nam
end

--Lấy số luận văn cao học đã hướng dẫn theo mã gv và năm
create proc SoLVCHdahd(@magv varchar(15), @nam varchar(15))
as
begin
declare @Time table(madt varchar(15),mahv varchar(15), namkt varchar(15))
	insert into @Time
	select ChonDT.MaDT,HocVien.MaHV,LopChuyenNganh.NamKT
	from ChonDT join HocVien on ChonDT.MaHV=HocVien.MaHV join LopChuyenNganh on LopChuyenNganh.MaLopCN=HocVien.MaLopCN

declare @LVCH table (magv varchar(15),madt varchar(15),tendt varchar(max))
	insert into @LVCH
	select MaGV,DeTai_CĐ.MaDT,LoaiDT.TenDT
	from HuongDanHV join ChonDT on HuongDanHV.MaHV=ChonDT.MaHV join  DeTai_CĐ on DeTai_CĐ.MaDT=ChonDT.MaDT
			join LoaiDT on LoaiDT.MaLoaiDT=DeTai_CĐ.MaLoaiDT 
	where MaGV=@magv and LoaiDT.TenDT=N'Luận văn cao học'

select COUNT(lvch.madt)
from @Time as Thgian, @LVCH as lvch
where Thgian.madt=lvch.madt and YEAR(Thgian.namkt) < @nam

end

--Hiển thị chi tiết hướng dẫn luận án tiến sỹ theo năm và mã gv
create proc ChiTietHDLATS(@magv varchar(15), @nam varchar(15))
as
begin
select DeTai_CĐ.TenDT,HuongDanHV.VaiTro,HocVien.TenHV,LopChuyenNganh.NienKhoa
from DeTai_CĐ join ChonDT on DeTai_CĐ.MaDT=ChonDT.MaDT join HuongDanHV on HuongDanHV.MaHV=ChonDT.MaHV 
		join HocVien on HocVien.MaHV=HuongDanHV.MaHV join LopChuyenNganh on HocVien.MaLopCN=LopChuyenNganh.MaLopCN
where DeTai_CĐ.MaLoaiDT='LDT1203' and YEAR(LopChuyenNganh.NamKT) <= @nam and HuongDanHV.MaGV=@magv
end

--Hiển thị chi tiết hướng dẫn luận văn cao học theo năm và mã gv
create proc ChiTietHDLVCH(@magv varchar(15), @nam varchar(15))
as
begin
select DeTai_CĐ.TenDT,HuongDanHV.VaiTro,HocVien.TenHV,LopChuyenNganh.NienKhoa
from DeTai_CĐ join ChonDT on DeTai_CĐ.MaDT=ChonDT.MaDT join HuongDanHV on HuongDanHV.MaHV=ChonDT.MaHV 
		join HocVien on HocVien.MaHV=HuongDanHV.MaHV join LopChuyenNganh on HocVien.MaLopCN=LopChuyenNganh.MaLopCN
where DeTai_CĐ.MaLoaiDT='LDT1204' and YEAR(LopChuyenNganh.NamKT) <@nam and HuongDanHV.MaGV=@magv
end

--Thêm dữ liệu giải định
insert into LoaiSach values ('LS1002',N'Sách giáo trình mới',150,N'Giờ',null),
							('LS1003',N'Giáo trình tái bản',120,N'Giờ',null),
							('LS1004',N'Tài liệu biên dịch, sách tham khảo',100,N'Giờ',null)
insert into Sach values ('SACH2100',N'Sách chuyên khảo 1','LS1001'),
						('SACH2101',N'Sách chuyên khảo 2','LS1001'),
						('SACH2102',N'Sách chuyên khảo 3','LS1001'),
						('SACH2106',N'Sách chuyên khảo 7','LS1001'),
						('SACH2104',N'Sách chuyên khảo 6','LS1001'),
						('SACH2103',N'Sách chuyên khảo 5','LS1001'),
						('SACH2105',N'Sách chuyên khảo 4','LS1001'),
						('SACH2107',N'Sách chuyên khảo 8','LS1001'),
						('SACH2108',N'Sách chuyên khảo 9','LS1001'),
						('SACH2109',N'Sách chuyên khảo 10','LS1001'),
						('SACH2200',N'Sách giáo trình mới 1','LS1002'),
						('SACH2201',N'Sách giáo trình mới 2','LS1002'),
						('SACH2202',N'Sách giáo trình mới 3','LS1002'),
						('SACH2203',N'Sách giáo trình mới 4','LS1002'),
						('SACH2204',N'Sách giáo trình mới 5','LS1002'),
						('SACH2205',N'Sách giáo trình mới 6','LS1002'),
						('SACH2206',N'Sách giáo trình mới 7','LS1002'),
						('SACH2207',N'Sách giáo trình mới 8','LS1002'),
						('SACH2208',N'Sách giáo trình mới 9','LS1002'),
						('SACH2209',N'Sách giáo trình mới 10','LS1002'),
						('SACH2300',N'Sách tham khảo 1','LS1004'),
						('SACH2301',N'Sách tham khảo 2','LS1004'),
						('SACH2302',N'Sách tham khảo 3','LS1004'),
						('SACH2303',N'Sách tham khảo 4','LS1004'),
						('SACH2304',N'Sách tham khảo 5','LS1004'),
						('SACH2305',N'Sách tham khảo 6','LS1004'),
						('SACH2306',N'Sách tham khảo 7','LS1004'),
						('SACH2307',N'Sách tham khảo 8','LS1004'),
						('SACH2308',N'Sách tham khảo 9','LS1004'),
						('SACH2309',N'Sách tham khảo 10','LS1004'),
						('SACH2400',N'Giáo trình tái bản 1','LS1003'),
						('SACH2401',N'Giáo trình tái bản 2','LS1003'),
						('SACH2402',N'Giáo trình tái bản 3','LS1003'),
						('SACH2403',N'Giáo trình tái bản 4','LS1003'),
						('SACH2404',N'Giáo trình tái bản 5','LS1003')
insert into VietSach values 
							('GV02','SACH2300',N'Biên soạn',null),
							('GV04','SACH2400',N'Biên soạn',null)							
insert into XuatBan values 	('NXB17','SACH2301',N'Hà Nội','2017-4-5'),
							('NXB17','SACH2302',N'Hà Nội','2017-4-5'),
							('NXB18','SACH2303',N'Hà Nội','2017-4-5'),
							('NXB17','SACH2304',N'Hà Nội','2017-4-5'),
							('NXB18','SACH2305',N'Hà Nội','2017-4-5'),
							('NXB15','SACH2306',N'Hà Nội','2018-4-5'),
							('NXB14','SACH2307',N'Hà Nội','2017-4-5'),
							('NXB17','SACH2308',N'Hà Nội','2013-4-5'),
							('NXB17','SACH2309',N'Hà Nội','2013-4-5'),
							('NXB17','SACH2400',N'Hà Nội','2014-4-5'),
							('NXB17','SACH2401',N'Hà Nội','2013-4-5'),
							('NXB17','SACH2402',N'Hà Nội','2018-4-5'),
							('NXB17','SACH2403',N'Hà Nội','2018-4-5'),
							('NXB17','SACH2404',N'Hà Nội','2018-4-5')

--Danh sách sách chuyên khảo đã viết của giáo viên							
create proc SachChuyenKhao(@magv varchar(15), @nam varchar(15))
as
begin
select Sach.TenSach, VietSach.VaiTro,XuatBan.NơiXB,XuatBan.NgayXB
from LoaiSach join Sach on Sach.MaLoaiSach=LoaiSach.MaLoaiSach join VietSach on Sach.MaSach=VietSach.MaSach 
			join XuatBan on XuatBan.MaSach=VietSach.MaSach
where VietSach.MaGV=@magv and YEAR(XuatBan.NgayXB) < @nam and LoaiSach.TenLoaiSach=N'Sách chuyên khảo'
end

--Danh sách sách giáo trình đã viết của giáo viên
create proc SachGiaoTrinh(@magv varchar(15), @nam varchar(15))
as
begin
select Sach.TenSach, VietSach.VaiTro,XuatBan.NơiXB,XuatBan.NgayXB
from LoaiSach join Sach on Sach.MaLoaiSach=LoaiSach.MaLoaiSach join VietSach on Sach.MaSach=VietSach.MaSach 
			join XuatBan on XuatBan.MaSach=VietSach.MaSach
where VietSach.MaGV=@magv and YEAR(XuatBan.NgayXB) < @nam 
		and (LoaiSach.TenLoaiSach=N'Sách giáo trình mới' or LoaiSach.TenLoaiSach='Giáo trình tái bản')
end

--Danh sách sách tham khảo và tài liệu khác của giáo viên
create proc TaiLieuKhac(@magv varchar(15), @nam varchar(15))
as
begin
select Sach.TenSach, VietSach.VaiTro,XuatBan.NơiXB,XuatBan.NgayXB
from LoaiSach join Sach on Sach.MaLoaiSach=LoaiSach.MaLoaiSach join VietSach on Sach.MaSach=VietSach.MaSach 
			join XuatBan on XuatBan.MaSach=VietSach.MaSach
where VietSach.MaGV=@magv and YEAR(XuatBan.NgayXB) < @nam and LoaiSach.TenLoaiSach=N'tài liệu biên dịch, sách tham khảo'
end






















select * from VietSach
select * from XuatBan