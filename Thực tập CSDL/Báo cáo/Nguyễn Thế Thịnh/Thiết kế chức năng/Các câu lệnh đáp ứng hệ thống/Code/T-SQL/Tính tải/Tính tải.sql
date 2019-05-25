select * from LopHP
select * from ChiTietLopHP

insert into ChiTietLopHP values ('LHP1418',80,1.1,N'1 tiết'),
								('LHP14181',75,1,N'1 tiết'),
								('LHP1419', 105,1.2,N'1 tiết'),
								('LHP1420',60,1,N'1 tiết'),
								('LHP1519',40,1,N'1 tiết'),
								('LHP1520',40,1,N'1 tiết')

alter table LopHP
add HeDaotao nvarchar(max)

--Lấy ra thông tin tải giảng dạy theo mã gv và loại hình đào tạo
create proc ThongTinTaiGD(@magv varchar(15), @loaihinhDT varchar(15), @namhoc nvarchar(30))
as
begin
select HocPhan.TenHP, ChiTietLopHP.SySo, LopHP.HeDaotao, LopHP.TenLopHP, HocPhan.SoTC, TableFakeGD.SoTiet, (TableFakeGD.SoTiet * ChiTietLopHP.DinhMuc) as N'Giờ chuẩn', TableFakeGD.GhiChu
from TableFakeGD join LopHP on LopHP.MaLopHP=TableFakeGD.MaLopHP join ChiTietLopHP on ChiTietLopHP.MaLopHP=TableFakeGD.MaLopHP
		join HocPhan on HocPhan.MaHP=LopHP.MaHP
where MaGV=@magv and LopHP.LoaiHinhDaoTao=@loaihinhDT and LopHP.NamHoc=@namhoc
end

ThongTinTaiGD 'GV28', 'LHDT1000','2018-2019'

drop procedure TinhtaiGD

--Tính tải giảng dạy theo lại hình đào tạo
create proc TinhtaiGD(@magv varchar(15), @loaihinhDT varchar(15), @namhoc nvarchar(30))
as
begin
select sum(TableFakeGD.SoTiet * ChiTietLopHP.DinhMuc) as N'Giờ chuẩn'
from TableFakeGD join LopHP on LopHP.MaLopHP=TableFakeGD.MaLopHP join ChiTietLopHP on ChiTietLopHP.MaLopHP=TableFakeGD.MaLopHP
		join HocPhan on HocPhan.MaHP=LopHP.MaHP
where MaGV=@magv and LopHP.LoaiHinhDaoTao=@loaihinhDT and LopHP.NamHoc=@namhoc
end

TinhtaiGD 'GV28','LHDT1001','2018-2019'

create proc NamHoc
as
begin
select DISTINCT LopHP.NamHoc
from LopHP
order by LopHP.NamHoc desc
end

--Tính tổng tải giảng dạy của 1 gv theo năm học
create proc TongTaiGD(@magv varchar(15), @namhoc nvarchar(15))
as
begin
select sum(TableFakeGD.SoTiet * ChiTietLopHP.DinhMuc) as N'Giờ chuẩn'
from TableFakeGD join LopHP on LopHP.MaLopHP=TableFakeGD.MaLopHP join ChiTietLopHP on ChiTietLopHP.MaLopHP=TableFakeGD.MaLopHP
		join HocPhan on HocPhan.MaHP=LopHP.MaHP
where MaGV= and LopHP.NamHoc=@namhoc
end

select * from Giao



