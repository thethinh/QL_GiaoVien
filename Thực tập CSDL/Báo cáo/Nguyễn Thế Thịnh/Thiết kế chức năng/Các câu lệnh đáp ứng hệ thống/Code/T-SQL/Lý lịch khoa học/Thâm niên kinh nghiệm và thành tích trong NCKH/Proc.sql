delete from ThamGiaBaiBaoKH
select * from NhanCVKhoa

insert into ThamGiaBaiBaoKH(MaGV,MaBaiBao,VaiTro) values
('GV01','BB02',N'Đồng tác giả'),
('GV01','BB03',N'Đồng tác giả')

select * from tapChi
select * from BaiBaoKH
select * from ĐăngBaiBao
select * from ThamGiaBaiBaoKH

--Số bài báo đăng trên tạp chí trong nước
create proc SoBBTrongNuoc(@magv varchar(15), @nam varchar(15))
as
begin
select (m.SL+n.SL) as SL
from (select COUNT(*) as SL
	  from NhanCVBM,(select ThamGiaBaiBaoKH.MaGV, BaiBaoKH.MaBaiBao,ThamGiaBaiBaoKH.VaiTro, tapChi.TenTapChi, ĐăngBaiBao.NgayDang
			   from ThamGiaBaiBaoKH join BaiBaoKH on ThamGiaBaiBaoKH.MaBaiBao=BaiBaoKH.MaBaiBao join ĐăngBaiBao on BaiBaoKH.MaBaiBao=ĐăngBaiBao.MaBaiBao 
	                 join tapChi on tapChi.MaTapChi=ĐăngBaiBao.MaTapChi
               where ThamGiaBaiBaoKH.MaGV=@magv and YEAR(ĐăngBaiBao.NgayDang)<=@nam and tapChi.MaLoaiTapChi='LTC1000') as k
      where k.MaGV=NhanCVBM.MaGV and YEAR(NhanCVBM.TimeBĐ)<=@nam 
	       and (YEAR(NhanCVBM.TimeKT) is null or YEAR(NhanCVBM.TimeKT) >=@nam))as m,

	 (select COUNT(*) as SL
	 from NhanCVKhoa,(select ThamGiaBaiBaoKH.MaGV, BaiBaoKH.MaBaiBao,ThamGiaBaiBaoKH.VaiTro, tapChi.TenTapChi, ĐăngBaiBao.NgayDang
			   from ThamGiaBaiBaoKH join BaiBaoKH on ThamGiaBaiBaoKH.MaBaiBao=BaiBaoKH.MaBaiBao join ĐăngBaiBao on BaiBaoKH.MaBaiBao=ĐăngBaiBao.MaBaiBao 
	                 join tapChi on tapChi.MaTapChi=ĐăngBaiBao.MaTapChi
               where ThamGiaBaiBaoKH.MaGV=@magv and YEAR(ĐăngBaiBao.NgayDang)<=@nam and tapChi.MaLoaiTapChi='LTC1000') as k
	 where k.MaGV=NhanCVKhoa.MaGV and YEAR(NhanCVKhoa.TimeBĐ)<=@nam 
	   and (YEAR(NhanCVKhoa.TimeKT) is null or YEAR(NhanCVKhoa.TimeKT) >=@nam)) as n


end

--Số bài báo đăng trên tạp chí nước ngoài
create proc SoBBQuocTe(@magv varchar(15), @nam varchar(15))
as
begin
select (m.SL+n.SL) as SL
from (select COUNT(*) as SL
	  from NhanCVBM,(select ThamGiaBaiBaoKH.MaGV, BaiBaoKH.MaBaiBao,ThamGiaBaiBaoKH.VaiTro, tapChi.TenTapChi, ĐăngBaiBao.NgayDang
			   from ThamGiaBaiBaoKH join BaiBaoKH on ThamGiaBaiBaoKH.MaBaiBao=BaiBaoKH.MaBaiBao join ĐăngBaiBao on BaiBaoKH.MaBaiBao=ĐăngBaiBao.MaBaiBao 
	                 join tapChi on tapChi.MaTapChi=ĐăngBaiBao.MaTapChi
               where ThamGiaBaiBaoKH.MaGV=@magv and YEAR(ĐăngBaiBao.NgayDang)<=@nam and tapChi.MaLoaiTapChi='LTC1001') as k
      where k.MaGV=NhanCVBM.MaGV and YEAR(NhanCVBM.TimeBĐ)<=@nam 
	       and (YEAR(NhanCVBM.TimeKT) is null or YEAR(NhanCVBM.TimeKT) >=@nam))as m,

	 (select COUNT(*) as SL
	 from NhanCVKhoa,(select ThamGiaBaiBaoKH.MaGV, BaiBaoKH.MaBaiBao,ThamGiaBaiBaoKH.VaiTro, tapChi.TenTapChi, ĐăngBaiBao.NgayDang
			   from ThamGiaBaiBaoKH join BaiBaoKH on ThamGiaBaiBaoKH.MaBaiBao=BaiBaoKH.MaBaiBao join ĐăngBaiBao on BaiBaoKH.MaBaiBao=ĐăngBaiBao.MaBaiBao 
	                 join tapChi on tapChi.MaTapChi=ĐăngBaiBao.MaTapChi
               where ThamGiaBaiBaoKH.MaGV=@magv and YEAR(ĐăngBaiBao.NgayDang)<=@nam and tapChi.MaLoaiTapChi='LTC1001') as k
	 where k.MaGV=NhanCVKhoa.MaGV and YEAR(NhanCVKhoa.TimeBĐ)<=@nam 
	   and (YEAR(NhanCVKhoa.TimeKT) is null or YEAR(NhanCVKhoa.TimeKT) >=@nam)) as n


end

--Liệt kê đầy đủ số bài báo từ trước đến nay
create proc LietKeBB(@magv varchar(15), @nam varchar(15))
as
begin
select BaiBaoKH.TenBaiBao,ThamGiaBaiBaoKH.VaiTro, tapChi.TenTapChi, ĐăngBaiBao.NgayDang
from ThamGiaBaiBaoKH join BaiBaoKH on ThamGiaBaiBaoKH.MaBaiBao=BaiBaoKH.MaBaiBao join ĐăngBaiBao on BaiBaoKH.MaBaiBao=ĐăngBaiBao.MaBaiBao 
	    join tapChi on tapChi.MaTapChi=ĐăngBaiBao.MaTapChi
where ThamGiaBaiBaoKH.MaGV=@magv and YEAR(ĐăngBaiBao.NgayDang)<@nam
end