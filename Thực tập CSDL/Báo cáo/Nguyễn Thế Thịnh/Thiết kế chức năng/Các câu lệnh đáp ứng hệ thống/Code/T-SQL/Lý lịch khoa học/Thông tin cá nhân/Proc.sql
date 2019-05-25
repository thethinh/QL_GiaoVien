alter table NhanHocHam add NoiBoNhiem nvarchar(max)
alter table GiaoVien add DienThoai varchar(20)
alter table GiaoVien add NgaySinh date
select * from GiaoVien

select * from NhanCVKhoa

--Lấy ra thông tin của ban chủ nhiệm khoa theo mã giáo viên theo từng năm
create proc ThongTinCNKhoa(@magv varchar(15), @nam varchar(15))
as
begin
select TenGV, TenBM, ChucVuKhoa.TenChucVu, GiaoVien.GT, GiaoVien.QueQuan, GiaoVien.Email,GiaoVien.NgaySinh,GiaoVien.DienThoai
from GiaoVien join BoMon on GiaoVien.MaBM=BoMon.MaBM join NhanCVKhoa on GiaoVien.MaGV=NhanCVKhoa.MaGV 
		join ChucVuKhoa on ChucVuKhoa.MaCVKhoa=NhanCVKhoa.MaCVKhoa
where YEAR(NhanCVKhoa.TimeBĐ)<=@nam and (YEAR(NhanCVKhoa.TimeKT) >@nam or YEAR(NhanCVKhoa.TimeKT) is NULL)
		and GiaoVien.MaGV=@magv
end

--Lấy ra thông tin của các giáo viên bộ môn
create proc ThongTinGVBM(@magv varchar(15), @nam varchar(15))
as
begin
select GiaoVien.TenGV,BoMon.TenBM, ChucVuBM.TenChucVu, GiaoVien.GT, GiaoVien.QueQuan, GiaoVien.Email, GiaoVien.NgaySinh,GiaoVien.DienThoai
from GiaoVien join BoMon on GiaoVien.MaBM=BoMon.MaBM join NhanCVBM on GiaoVien.MaGV=NhanCVBM.MaGV
		join ChucVuBM on ChucVuBM.MaCVbm=NhanCVBM.MaCVbm
where YEAR(NhanCVBM.TimeBĐ)<=@nam and (YEAR(NhanCVBM.TimeKT) is NULL or YEAR(NhanCVBM.TimeKT) >@nam)
		and GiaoVien.MaGV=@magv
end

ThongTinGVBM'GV27','2018'


--Lấy ra học hoàm cao nhất của giáo viên
create proc HochamMax(@magv varchar(15), @nam varchar(15))
as
begin
declare @hh table (magv varchar(15),nam int,mahh varchar(15),noibonhiem nvarchar(max))
insert into @hh
select k.MaGV,k.nam,NhanHocHam.MaHocHam, NhanHocHam.NoiBoNhiem
from NhanHocHam,(select MaGV,max(year(ThoiGian)) as nam
					from NhanHocHam where YEAR(NhanHocHam.ThoiGian) <= @nam
					group by MaGV) as k
where NhanHocHam.MaGV = k.MaGV
and year( NhanHocHam.ThoiGian) = k.nam 

--Lấy ra danh sách giáo viên và tên học hàm cao nhất của họ
declare @total1 table (magv varchar(15),tenhh nvarchar(max),nam int, noibonhiem nvarchar(max))
insert into @total1
select hh.magv,HocHam.TenHocHam, hh.nam, hh.noibonhiem
from @hh as hh,HocHam
where HocHam.MaHocHam=hh.mahh 

select GiaoVien.TenGV, total1.tenhh
from @total1 as total1, GiaoVien
where total1.magv=GiaoVien.MaGV and total1.magv=@magv
end


--Lấy ra học vị cao nhất của giáo viên
create proc HocViMax(@maGV varchar(15), @nam varchar(15))
as
begin
--Lấy ra mã học vị có thời điểm nhận gần nhất ứng với từng mã giáo viên
declare @hv table (magv varchar(15), nam int , mahv varchar(15))
insert into @hv
select h.MaGV, h.nam, NhanHocVi.MaHocVi
from NhanHocVi, (select MaGV,MAX(year(NhanHocVi.ThoiGian)) as nam
					from NhanHocVi where YEAR(NhanHocVi.ThoiGian) <=@nam
					group by MaGV) as h
where NhanHocVi.MaGV=h.MaGV and YEAR(NhanHocVi.ThoiGian) = h.nam

--Lấy ra danh sách giáo viên và tên học vị cao nhất của họ
declare @total2 table (magv varchar(15),tenhv nvarchar(max))
insert into @total2
select hv.magv, HocVi.TenHocVi
from @hv as hv,HocVi
where hv.mahv=HocVi.MaHocVi

select GiaoVien.TenGV, total2.tenhv
from @total2 as total2, GiaoVien
where total2.magv=GiaoVien.MaGV and total2.magv=@maGV
end

--Lấy ra các học phần giáo viên đã giảng dạy theo nam
create proc GiangDay(@magv varchar(15), @nam varchar(15))
as
begin
select distinct MaGV, TenHP, NamHoc
from PhanCongGD join LopHP on PhanCongGD.MaLopHP=LopHP.MaLopHP join HocPhan on HocPhan.MaHP=LopHP.MaHP
where YEAR(LopHP.TimeBĐ)<=@nam and YEAR(LopHP.TimeKT)<=@nam and MaGV=@magv
end

--Lấy ra học học hàm của 1 giáo viên
create proc HocHamFull(@magv varchar(15), @nam varchar(15))
as
begin
select HocHam.TenHocHam,NhanHocHam.ThoiGian,NhanHocHam.NoiBoNhiem
from NhanHocHam join HocHam on NhanHocHam.MaHocHam=HocHam.MaHocHam
where NhanHocHam.MaGV=@magv and YEAR(NhanHocHam.ThoiGian)<=@nam
end
--Lấy ra học vị của 1 giáo viên
create proc HocViFull(@magv varchar(15), @nam varchar(15))
as
begin
select HocVi.TenHocVi,NhanHocVi.ThoiGian
from NhanHocVi join HocVi on NhanHocVi.MaHocVi=HocVi.MaHocVi
where NhanHocVi.MaGV=@magv and YEAR(NhanHocVi.ThoiGian)<=@nam
end
--Lấy ra Chức vụ đầy đủ của 1 giáo viên bộ môn
create proc ChucVuFull(@magv varchar(15), @nam varchar(15))
as
begin
select ChucVuBM.TenChucVu,NhanCVBM.TimeBĐ,NhanCVBM.TimeKT
from NhanCVBM join ChucVuBM on NhanCVBM.MaCVbm=ChucVuBM.MaCVbm
where NhanCVBM.MaGV=@magv and ((Year(NhanCVBM.TimeBĐ) <= @nam and (YEAR(NhanCVBM.TimeKT) <@nam or YEAR(NhanCVBM.TimeKT) is null))
								or (YEAR(NhanCVBM.TimeBĐ)<=@nam and YEAR(NhanCVBM.TimeKT)>@nam)) 
end

--Chức vụ khoa
create proc CVKhoa(@magv varchar(15))
as
begin
select ChucVuKhoa.TenChucVu,NhanCVKhoa.TimeBĐ,NhanCVKhoa.TimeKT
from NhanCVKhoa join ChucVuKhoa on NhanCVKhoa.MaCVKhoa=ChucVuKhoa.MaCVKhoa
where NhanCVKhoa.MaGV=@magv 
end

drop procedure CVKh
CVKhoa'GV01'

