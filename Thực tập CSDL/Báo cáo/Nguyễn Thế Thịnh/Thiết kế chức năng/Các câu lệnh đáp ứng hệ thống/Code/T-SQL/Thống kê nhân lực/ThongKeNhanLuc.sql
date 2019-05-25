--Thống kê ban chủ nhiệm khoa
create proc ThongKeCNKhoa(@nam varchar(10))
as
begin	
	--Lấy ra mã học hàm cao có thời điểm nhận gần nhất ứng với từng mã giáo viên
	declare @hh table (magv varchar(15),nam int,mahh varchar(15))
	insert into @hh
	select k.MaGV,k.nam,NhanHocHam.MaHocHam
	from NhanHocHam,(select MaGV,max(year(ThoiGian)) as nam
						from NhanHocHam where YEAR(NhanHocHam.ThoiGian) <= @nam
						group by MaGV) as k
	where NhanHocHam.MaGV = k.MaGV
	and year( NhanHocHam.ThoiGian) = k.nam 

	--Lấy ra danh sách giáo viên và tên học hàm cao nhất của họ
	declare @total1 table (magv varchar(15),tenhh nvarchar(max))
	insert into @total1
	select hh.magv,HocHam.TenHocHam
	from @hh as hh,HocHam
	where HocHam.MaHocHam=hh.mahh 

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

	--Lấy ra chức vụ ban chủ nhiệm khoa theo năm yêu cầu
	declare @cvk table (magv varchar(15), tencv nvarchar(max))
	insert into @cvk
	select NhanCVKhoa.MaGV, ChucVuKhoa.TenChucVu
	from ChucVuKhoa, NhanCVKhoa
	where ChucVuKhoa.MaCVKhoa=NhanCVKhoa.MaCVKhoa 
	      and YEAR(NhanCVKhoa.TimeBĐ)<=@nam and (YEAR(NhanCVKhoa.TimeKT) is NULL or YEAR(NhanCVKhoa.TimeKT)>@nam)

	--Lấy ra chức vụ ban chủ nhiệm khoa và tên học hàm, học vị của họ
	select GiaoVien.TenGV, cvk.tencv, total1.tenhh, total2.tenhv , cvk.magv
	from @total1 as total1, @total2 as total2, @cvk as cvk, GiaoVien
	where total1.magv=total2.magv and total1.magv=cvk.magv and total1.magv=GiaoVien.MaGV
			and total2.magv=cvk.magv and total2.magv=GiaoVien.MaGV and cvk.magv=GiaoVien.MaGV

end

--Thống kê nhân lực từng bộ môn theo năm
create proc NhanLucBM(@nam varchar(10), @mabm varchar(15))
as
begin
	--Lấy ra danh sách giáo viên và mã học hàm cao nhất của họ
	declare @hh1 table (magv varchar(15),nam int,mahh varchar(15))
	insert into @hh1
	select k.MaGV,k.nam,NhanHocHam.MaHocHam
	from NhanHocHam,(select MaGV,max(year(ThoiGian)) as nam
						from NhanHocHam where YEAR(NhanHocHam.ThoiGian) <= @nam
						group by MaGV) as k
	where NhanHocHam.MaGV = k.MaGV
	and year( NhanHocHam.ThoiGian) = k.nam 

	--Lấy ra danh sách giáo viên và tên học hàm cao nhất của họ
	declare @total11 table (magv varchar(15),tenhh nvarchar(max))
	insert into @total11
	select hh1.magv,HocHam.TenHocHam
	from @hh1 as hh1,HocHam
	where HocHam.MaHocHam=hh1.mahh 

	--Lấy ra mã học vị có thời điểm nhận gần nhất ứng với từng mã giáo viên
	declare @hv1 table (magv varchar(15), nam int , mahv varchar(15))
	insert into @hv1
	select h.MaGV, h.nam, NhanHocVi.MaHocVi
	from NhanHocVi, (select MaGV,MAX(year(NhanHocVi.ThoiGian)) as nam
						from NhanHocVi where yEAR(NhanHocVi.ThoiGian) <=@nam
						group by MaGV) as h
	where NhanHocVi.MaGV=h.MaGV and YEAR(NhanHocVi.ThoiGian) = h.nam

	--Lấy ra danh sách giáo viên và tên học vị cao nhất của họ
	declare @total21 table (magv varchar(15),tenhv nvarchar(max))
	insert into @total21
	select hv1.magv, HocVi.TenHocVi
	from @hv1 as hv1,HocVi
	where hv1.mahv=HocVi.MaHocVi

	--Lấy ra nhân lực của 1 bộ môn theo năm
	declare @cvbm table (magv varchar(15),macv varchar(15), tencv nvarchar(max))
	insert into @cvbm
	select NhanCVBM.MaGV,ChucVuBM.MaCVbm, ChucVuBM.TenChucVu
	from ChucVuBM, NhanCVBM
	where ChucVuBM.MaCVbm=NhanCVBM.MaCVbm 
	      and YEAR(NhanCVBM.TimeBĐ)<=@nam and (YEAR(NhanCVBM.TimeKT) is NULL or YEAR(NhanCVBM.TimeKT)>@nam)
		  and NhanCVBM.MaBM=@mabm
	
	--Lấy ra danh sách nhân lực bộ môn CNPM và tên học hàm, học vị của họ
	select GiaoVien.TenGV,cvbm.tencv, total11.tenhh, total21.tenhv, cvbm.magv
	from GiaoVien join @cvbm as cvbm on GiaoVien.MaGV=cvbm.magv 
		join @total11 as total11 on cvbm.magv=total11.magv
		join @total21 as total21 on total11.magv=total21.magv
	order by cvbm.macv 
end

drop procedure NhanLucBM
ThongKeCNKhoa'2014'
NhanLucBM'2014','BM02'
drop procedure NhanLucKhoa
NhanLucKhoa'Kh01','2013'
create proc NhanLucKhoa(@makhoa varchar(15),@nam varchar(15))
as
begin
	--Lấy ra số giáo sư trong 1 khoa
	declare @GS table(makhoa varchar(15),SoGS int)
	insert into @GS
	select db2.MaKhoa,db1.SL
	from (select (select ROW_NUMBER() over(order by k.SL+h.SL)) STT,k.SL+h.SL as SL
		  from (select COUNT(*) as SL
			    from (select i.MaGV,NhanHocHam.MaHocHam,i.nam,NhanCVBM.MaBM,Khoa.MaKhoa
					  from (select MaGV,Max(year(ThoiGian)) as nam
							from NhanHocHam where YEAR(NhanHocHam.ThoiGian) <= @nam
							group by MaGV) as i, NhanHocHam, NhanCVBM,BoMon,Khoa
					  where i.nam=YEAR(NhanHocHam.ThoiGian) and i.MaGV=NhanHocHam.MaGV and NhanCVBM.MaGV=i.MaGV 
					  and BoMon.MaBM=NhanCVBM.MaBM and Khoa.MaKhoa=BoMon.MaKhoa
	                  and YEAR(NhanCVBM.TimeBĐ)<=@nam and (YEAR(NhanCVBM.TimeKT) is null or YEAR(NhanCVBM.TimeKT)>=@nam)) as k
                where k.MaKhoa='Kh01' and k.MaHocHam='HH1000' and k.nam<=@nam) as k,

			    (select COUNT(*) as SL
				 from (select i.MaGV,NhanHocHam.MaHocHam,i.nam,NhanCVKhoa.MaKhoa
					   from (select MaGV,Max(year(ThoiGian)) as nam
					         from NhanHocHam where YEAR(NhanHocHam.ThoiGian) <= @nam
					         group by MaGV) as i, NhanHocHam, NhanCVKhoa,Khoa
						where i.nam=YEAR(NhanHocHam.ThoiGian) and i.MaGV=NhanHocHam.MaGV and NhanCVKhoa.MaGV=i.MaGV and Khoa.MaKhoa=NhanCVKhoa.MaKhoa
						and YEAR(NhanCVKhoa.TimeBĐ)<=@nam and (YEAR(NhanCVKhoa.TimeKT) is null or YEAR(NhanCVKhoa.TimeKT)>=@nam)) as k
				  where k.MaKhoa='Kh01' and k.MaHocHam='HH1000' and k.nam<=2013) as h) as db1,

		(select (select ROW_NUMBER() over(order by Khoa.MaKhoa)) STT,Khoa.MaKhoa
		    from Khoa
	        where Khoa.MaKhoa=@makhoa) as db2
	where db1.STT=db2.STT

	--Lấy ra số phó giáo sư trong 1 khoa
	declare @PGS table (makhoa varchar(15),SPGS int)
	insert into @PGS
	select db2.MaKhoa,db1.SL
	from (select (select ROW_NUMBER() over(order by k.SL+h.SL)) STT,k.SL+h.SL as SL
		  from (select COUNT(*) as SL
			    from (select i.MaGV,NhanHocHam.MaHocHam,i.nam,NhanCVBM.MaBM,Khoa.MaKhoa
					  from (select MaGV,Max(year(ThoiGian)) as nam
							from NhanHocHam where YEAR(NhanHocHam.ThoiGian) <= @nam
							group by MaGV) as i, NhanHocHam, NhanCVBM,BoMon,Khoa
					  where i.nam=YEAR(NhanHocHam.ThoiGian) and i.MaGV=NhanHocHam.MaGV and NhanCVBM.MaGV=i.MaGV 
					  and BoMon.MaBM=NhanCVBM.MaBM and Khoa.MaKhoa=BoMon.MaKhoa
	                  and YEAR(NhanCVBM.TimeBĐ)<=@nam and (YEAR(NhanCVBM.TimeKT) is null or YEAR(NhanCVBM.TimeKT)>=@nam)) as k
                where k.MaKhoa='Kh01' and k.MaHocHam='HH1001' and k.nam<=@nam) as k,

			    (select COUNT(*) as SL
				 from (select i.MaGV,NhanHocHam.MaHocHam,i.nam,NhanCVKhoa.MaKhoa
					   from (select MaGV,Max(year(ThoiGian)) as nam
					         from NhanHocHam where YEAR(NhanHocHam.ThoiGian) <= @nam
					         group by MaGV) as i, NhanHocHam, NhanCVKhoa,Khoa
						where i.nam=YEAR(NhanHocHam.ThoiGian) and i.MaGV=NhanHocHam.MaGV and NhanCVKhoa.MaGV=i.MaGV and Khoa.MaKhoa=NhanCVKhoa.MaKhoa
						and YEAR(NhanCVKhoa.TimeBĐ)<=@nam and (YEAR(NhanCVKhoa.TimeKT) is null or YEAR(NhanCVKhoa.TimeKT)>=@nam)) as k
				  where k.MaKhoa='Kh01' and k.MaHocHam='HH1001' and k.nam<=@nam) as h) as db1,

		(select (select ROW_NUMBER() over(order by Khoa.MaKhoa)) STT,Khoa.MaKhoa
		    from Khoa
	        where Khoa.MaKhoa=@makhoa) as db2
	where db1.STT=db2.STT
	 
	--Lấy ra số tiến sỹ KH trong 1 khoa
	declare @TSKH table (makhoa varchar(15),STSKH int)
	insert into @TSKH
	select db2.MaKhoa,db1.SL
	from (select (select ROW_NUMBER() over(order by k.SL+h.SL)) STT,k.SL+h.SL as SL
		  from (select COUNT(*) as SL
			    from (select i.MaGV,NhanHocVi.MaHocVi,i.nam,NhanCVBM.MaBM,Khoa.MaKhoa
					  from (select MaGV,Max(year(ThoiGian)) as nam
							from NhanHocVi where YEAR(NhanHocVi.ThoiGian) <= @nam
							group by MaGV) as i, NhanHocVi, NhanCVBM,BoMon,Khoa
					  where i.nam=YEAR(NhanHocVi.ThoiGian) and i.MaGV=NhanHocVi.MaGV and NhanCVBM.MaGV=i.MaGV 
					  and BoMon.MaBM=NhanCVBM.MaBM and Khoa.MaKhoa=BoMon.MaKhoa
	                  and YEAR(NhanCVBM.TimeBĐ)<=@nam and (YEAR(NhanCVBM.TimeKT) is null or YEAR(NhanCVBM.TimeKT)>=@nam)) as k
                where k.MaKhoa='Kh01' and k.MaHocVi='HV3003' and k.nam<=@nam) as k,

			    (select COUNT(*) as SL
				 from (select i.MaGV,NhanHocVi.MaHocVi,i.nam,NhanCVKhoa.MaKhoa
					   from (select MaGV,Max(year(ThoiGian)) as nam
					         from NhanHocVi where YEAR(NhanHocVi.ThoiGian) <= @nam
					         group by MaGV) as i, NhanHocVi, NhanCVKhoa,Khoa
						where i.nam=YEAR(NhanHocVi.ThoiGian) and i.MaGV=NhanHocVi.MaGV and NhanCVKhoa.MaGV=i.MaGV and Khoa.MaKhoa=NhanCVKhoa.MaKhoa
						and YEAR(NhanCVKhoa.TimeBĐ)<=@nam and (YEAR(NhanCVKhoa.TimeKT) is null or YEAR(NhanCVKhoa.TimeKT)>=@nam)) as k
				  where k.MaKhoa='Kh01' and k.MaHocVi='HV3003' and k.nam<=@nam) as h) as db1,

		(select (select ROW_NUMBER() over(order by Khoa.MaKhoa)) STT,Khoa.MaKhoa
		    from Khoa
	        where Khoa.MaKhoa=@makhoa) as db2
	where db1.STT=db2.STT

	--Lấy ra số tiến sỹ trong 1 khoa 
	declare @TS table (makhoa varchar(15),STS int)
	insert into @TS
	select db2.MaKhoa,db1.SL
	from (select (select ROW_NUMBER() over(order by k.SL+h.SL)) STT,k.SL+h.SL as SL
		  from (select COUNT(*) as SL
			    from (select i.MaGV,NhanHocVi.MaHocVi,i.nam,NhanCVBM.MaBM,Khoa.MaKhoa
					  from (select MaGV,Max(year(ThoiGian)) as nam
							from NhanHocVi where YEAR(NhanHocVi.ThoiGian) <= @nam
							group by MaGV) as i, NhanHocVi, NhanCVBM,BoMon,Khoa
					  where i.nam=YEAR(NhanHocVi.ThoiGian) and i.MaGV=NhanHocVi.MaGV and NhanCVBM.MaGV=i.MaGV 
					  and BoMon.MaBM=NhanCVBM.MaBM and Khoa.MaKhoa=BoMon.MaKhoa
	                  and YEAR(NhanCVBM.TimeBĐ)<=@nam and (YEAR(NhanCVBM.TimeKT) is null or YEAR(NhanCVBM.TimeKT)>=@nam)) as k
                where k.MaKhoa='Kh01' and k.MaHocVi='HV3002' and k.nam<=@nam) as k,

			    (select COUNT(*) as SL
				 from (select i.MaGV,NhanHocVi.MaHocVi,i.nam,NhanCVKhoa.MaKhoa
					   from (select MaGV,Max(year(ThoiGian)) as nam
					         from NhanHocVi where YEAR(NhanHocVi.ThoiGian) <= @nam
					         group by MaGV) as i, NhanHocVi, NhanCVKhoa,Khoa
						where i.nam=YEAR(NhanHocVi.ThoiGian) and i.MaGV=NhanHocVi.MaGV and NhanCVKhoa.MaGV=i.MaGV and Khoa.MaKhoa=NhanCVKhoa.MaKhoa
						and YEAR(NhanCVKhoa.TimeBĐ)<=@nam and (YEAR(NhanCVKhoa.TimeKT) is null or YEAR(NhanCVKhoa.TimeKT)>=@nam)) as k
				  where k.MaKhoa='Kh01' and k.MaHocVi='HV3002' and k.nam<=@nam) as h) as db1,

		(select (select ROW_NUMBER() over(order by Khoa.MaKhoa)) STT,Khoa.MaKhoa
		    from Khoa
	        where Khoa.MaKhoa=@makhoa) as db2
	where db1.STT=db2.STT

	--Lấy ra số thạc sỹ trong 1 khoa
	declare @ThS table (makhoa varchar(15),SThS int)
	insert into @ThS
	select db2.MaKhoa,db1.SL
	from (select (select ROW_NUMBER() over(order by k.SL+h.SL)) STT,k.SL+h.SL as SL
		  from (select COUNT(*) as SL
			    from (select i.MaGV,NhanHocVi.MaHocVi,i.nam,NhanCVBM.MaBM,Khoa.MaKhoa
					  from (select MaGV,Max(year(ThoiGian)) as nam
							from NhanHocVi where YEAR(NhanHocVi.ThoiGian) <= @nam
							group by MaGV) as i, NhanHocVi, NhanCVBM,BoMon,Khoa
					  where i.nam=YEAR(NhanHocVi.ThoiGian) and i.MaGV=NhanHocVi.MaGV and NhanCVBM.MaGV=i.MaGV 
					  and BoMon.MaBM=NhanCVBM.MaBM and Khoa.MaKhoa=BoMon.MaKhoa
	                  and YEAR(NhanCVBM.TimeBĐ)<=@nam and (YEAR(NhanCVBM.TimeKT) is null or YEAR(NhanCVBM.TimeKT)>=@nam)) as k
                where k.MaKhoa='Kh01' and k.MaHocVi='HV3004' and k.nam<=@nam) as k,

			    (select COUNT(*) as SL
				 from (select i.MaGV,NhanHocVi.MaHocVi,i.nam,NhanCVKhoa.MaKhoa
					   from (select MaGV,Max(year(ThoiGian)) as nam
					         from NhanHocVi where YEAR(NhanHocVi.ThoiGian) <= @nam
					         group by MaGV) as i, NhanHocVi, NhanCVKhoa,Khoa
						where i.nam=YEAR(NhanHocVi.ThoiGian) and i.MaGV=NhanHocVi.MaGV and NhanCVKhoa.MaGV=i.MaGV and Khoa.MaKhoa=NhanCVKhoa.MaKhoa
						and YEAR(NhanCVKhoa.TimeBĐ)<=@nam and (YEAR(NhanCVKhoa.TimeKT) is null or YEAR(NhanCVKhoa.TimeKT)>=@nam)) as k
				  where k.MaKhoa='Kh01' and k.MaHocVi='HV3004' and k.nam<=@nam) as h) as db1,

		(select (select ROW_NUMBER() over(order by Khoa.MaKhoa)) STT,Khoa.MaKhoa
		    from Khoa
	        where Khoa.MaKhoa=@makhoa) as db2
	where db1.STT=db2.STT

	--Lấy ra số GV cao cấp trong 1 khoa 
	declare @GVCC table (makhoa varchar(15),SGVCC int)
	insert into @GVCC
	select db2.MaKhoa,db1.SL
    from (select (select ROW_NUMBER() over(order by k.SL+h.SL)) STT,k.SL+h.SL as SL
		  from (select COUNT(*) as SL
			    from (select i.MaGV,NhanHocHam.MaHocHam,i.nam,NhanCVBM.MaBM,Khoa.MaKhoa
					  from (select MaGV,Max(year(ThoiGian)) as nam
							from NhanHocHam where YEAR(NhanHocHam.ThoiGian) <= @nam
							group by MaGV) as i, NhanHocHam, NhanCVBM,BoMon,Khoa
					  where i.nam=YEAR(NhanHocHam.ThoiGian) and i.MaGV=NhanHocHam.MaGV and NhanCVBM.MaGV=i.MaGV 
					  and BoMon.MaBM=NhanCVBM.MaBM and Khoa.MaKhoa=BoMon.MaKhoa
	                  and YEAR(NhanCVBM.TimeBĐ)<=@nam and (YEAR(NhanCVBM.TimeKT) is null or YEAR(NhanCVBM.TimeKT)>=@nam)) as k
                where k.MaKhoa='Kh01' and k.MaHocHam='HH1004' and k.nam<=@nam) as k,

			    (select COUNT(*) as SL
				 from (select i.MaGV,NhanHocHam.MaHocHam,i.nam,NhanCVKhoa.MaKhoa
					   from (select MaGV,Max(year(ThoiGian)) as nam
					         from NhanHocHam where YEAR(NhanHocHam.ThoiGian) <= @nam
					         group by MaGV) as i, NhanHocHam, NhanCVKhoa,Khoa
						where i.nam=YEAR(NhanHocHam.ThoiGian) and i.MaGV=NhanHocHam.MaGV and NhanCVKhoa.MaGV=i.MaGV and Khoa.MaKhoa=NhanCVKhoa.MaKhoa
						and YEAR(NhanCVKhoa.TimeBĐ)<=@nam and (YEAR(NhanCVKhoa.TimeKT) is null or YEAR(NhanCVKhoa.TimeKT)>=@nam)) as k
				  where k.MaKhoa='Kh01' and k.MaHocHam='HH1004' and k.nam<=@nam) as h) as db1,

		(select (select ROW_NUMBER() over(order by Khoa.MaKhoa)) STT,Khoa.MaKhoa
		    from Khoa
	        where Khoa.MaKhoa=@makhoa) as db2
	where db1.STT=db2.STT

	--Lấy ra số giảng viên chính trong 1 khoa
	declare @GVC table(makhoa varchar(15),SGVC int)
	insert into @GVC
	select db2.MaKhoa,db1.SL
	from (select (select ROW_NUMBER() over(order by k.SL+h.SL)) STT,k.SL+h.SL as SL
		  from (select COUNT(*) as SL
			    from (select i.MaGV,NhanHocHam.MaHocHam,i.nam,NhanCVBM.MaBM,Khoa.MaKhoa
					  from (select MaGV,Max(year(ThoiGian)) as nam
							from NhanHocHam where YEAR(NhanHocHam.ThoiGian) <= @nam
							group by MaGV) as i, NhanHocHam, NhanCVBM,BoMon,Khoa
					  where i.nam=YEAR(NhanHocHam.ThoiGian) and i.MaGV=NhanHocHam.MaGV and NhanCVBM.MaGV=i.MaGV 
					  and BoMon.MaBM=NhanCVBM.MaBM and Khoa.MaKhoa=BoMon.MaKhoa
	                  and YEAR(NhanCVBM.TimeBĐ)<=@nam and (YEAR(NhanCVBM.TimeKT) is null or YEAR(NhanCVBM.TimeKT)>=@nam)) as k
                where k.MaKhoa='Kh01' and k.MaHocHam='HH1002' and k.nam<=@nam) as k,

			    (select COUNT(*) as SL
				 from (select i.MaGV,NhanHocHam.MaHocHam,i.nam,NhanCVKhoa.MaKhoa
					   from (select MaGV,Max(year(ThoiGian)) as nam
					         from NhanHocHam where YEAR(NhanHocHam.ThoiGian) <= @nam
					         group by MaGV) as i, NhanHocHam, NhanCVKhoa,Khoa
						where i.nam=YEAR(NhanHocHam.ThoiGian) and i.MaGV=NhanHocHam.MaGV and NhanCVKhoa.MaGV=i.MaGV and Khoa.MaKhoa=NhanCVKhoa.MaKhoa
						and YEAR(NhanCVKhoa.TimeBĐ)<=@nam and (YEAR(NhanCVKhoa.TimeKT) is null or YEAR(NhanCVKhoa.TimeKT)>=@nam)) as k
				  where k.MaKhoa='Kh01' and k.MaHocHam='HH1002' and k.nam<=@nam) as h) as db1,

		(select (select ROW_NUMBER() over(order by Khoa.MaKhoa)) STT,Khoa.MaKhoa
		    from Khoa
	        where Khoa.MaKhoa=@makhoa) as db2
	where db1.STT=db2.STT

	--Lấy ra số giảng viên trong 1 khoa
	declare @GV table(makhoa varchar(15),SGV int)
	insert into @GV
	select db2.MaKhoa,db1.SL
	from (select (select ROW_NUMBER() over(order by k.SL+h.SL)) STT,k.SL+h.SL as SL
		  from (select COUNT(*) as SL
			    from (select i.MaGV,NhanHocHam.MaHocHam,i.nam,NhanCVBM.MaBM,Khoa.MaKhoa
					  from (select MaGV,Max(year(ThoiGian)) as nam
							from NhanHocHam where YEAR(NhanHocHam.ThoiGian) <= @nam
							group by MaGV) as i, NhanHocHam, NhanCVBM,BoMon,Khoa
					  where i.nam=YEAR(NhanHocHam.ThoiGian) and i.MaGV=NhanHocHam.MaGV and NhanCVBM.MaGV=i.MaGV 
					  and BoMon.MaBM=NhanCVBM.MaBM and Khoa.MaKhoa=BoMon.MaKhoa
	                  and YEAR(NhanCVBM.TimeBĐ)<=@nam and (YEAR(NhanCVBM.TimeKT) is null or YEAR(NhanCVBM.TimeKT)>=@nam)) as k
                where k.MaKhoa='Kh01' and k.MaHocHam='HH1003' and k.nam<=@nam) as k,

			    (select COUNT(*) as SL
				 from (select i.MaGV,NhanHocHam.MaHocHam,i.nam,NhanCVKhoa.MaKhoa
					   from (select MaGV,Max(year(ThoiGian)) as nam
					         from NhanHocHam where YEAR(NhanHocHam.ThoiGian) <= @nam
					         group by MaGV) as i, NhanHocHam, NhanCVKhoa,Khoa
						where i.nam=YEAR(NhanHocHam.ThoiGian) and i.MaGV=NhanHocHam.MaGV and NhanCVKhoa.MaGV=i.MaGV and Khoa.MaKhoa=NhanCVKhoa.MaKhoa
						and YEAR(NhanCVKhoa.TimeBĐ)<=@nam and (YEAR(NhanCVKhoa.TimeKT) is null or YEAR(NhanCVKhoa.TimeKT)>=@nam)) as k
				  where k.MaKhoa='Kh01' and k.MaHocHam='HH1003' and k.nam<=@nam) as h) as db1,

		(select (select ROW_NUMBER() over(order by Khoa.MaKhoa)) STT,Khoa.MaKhoa
		    from Khoa
	        where Khoa.MaKhoa=@makhoa) as db2
	where db1.STT=db2.STT

	--Lấy ra số trợ giảng trong 1 khoa
	declare @TrG table(makhoa varchar(15),STrG int)
	insert into @TrG
	select db2.MaKhoa,db1.SL
	from (select (select ROW_NUMBER() over(order by k.SL+h.SL)) STT,k.SL+h.SL as SL
		  from (select COUNT(*) as SL
			    from (select i.MaGV,NhanHocHam.MaHocHam,i.nam,NhanCVBM.MaBM,Khoa.MaKhoa
					  from (select MaGV,Max(year(ThoiGian)) as nam
							from NhanHocHam where YEAR(NhanHocHam.ThoiGian) <= @nam
							group by MaGV) as i, NhanHocHam, NhanCVBM,BoMon,Khoa
					  where i.nam=YEAR(NhanHocHam.ThoiGian) and i.MaGV=NhanHocHam.MaGV and NhanCVBM.MaGV=i.MaGV 
					  and BoMon.MaBM=NhanCVBM.MaBM and Khoa.MaKhoa=BoMon.MaKhoa
	                  and YEAR(NhanCVBM.TimeBĐ)<=@nam and (YEAR(NhanCVBM.TimeKT) is null or YEAR(NhanCVBM.TimeKT)>=@nam)) as k
                where k.MaKhoa='Kh01' and k.MaHocHam='HH1005' and k.nam<=@nam) as k,

			    (select COUNT(*) as SL
				 from (select i.MaGV,NhanHocHam.MaHocHam,i.nam,NhanCVKhoa.MaKhoa
					   from (select MaGV,Max(year(ThoiGian)) as nam
					         from NhanHocHam where YEAR(NhanHocHam.ThoiGian) <= @nam
					         group by MaGV) as i, NhanHocHam, NhanCVKhoa,Khoa
						where i.nam=YEAR(NhanHocHam.ThoiGian) and i.MaGV=NhanHocHam.MaGV and NhanCVKhoa.MaGV=i.MaGV and Khoa.MaKhoa=NhanCVKhoa.MaKhoa
						and YEAR(NhanCVKhoa.TimeBĐ)<=@nam and (YEAR(NhanCVKhoa.TimeKT) is null or YEAR(NhanCVKhoa.TimeKT)>=@nam)) as k
				  where k.MaKhoa='Kh01' and k.MaHocHam='HH1005' and k.nam<=@nam) as h) as db1,

		(select (select ROW_NUMBER() over(order by Khoa.MaKhoa)) STT,Khoa.MaKhoa
		    from Khoa
	        where Khoa.MaKhoa=@makhoa) as db2
	where db1.STT=db2.STT

	--Lấy ra tổng giáo viên trong 1 khoa
	declare @total table(makhoa varchar(15),TenKhoa nvarchar(max),Tong int)
	insert into @total
	select db2.MaKhoa,db2.TenKhoa,db1.SL
	from
	(select (select row_number() over(order by m.SLCNK+n.SLGVBM)) STT ,m.SLCNK+n.SLGVBM as SL
		from (select COUNT(GiaoVien.MaGV) as 'SLCNK'
			from GiaoVien join NhanCVKhoa on NhanCVKhoa.MaGV=GiaoVien.MaGV join BoMon on BoMon.MaBM=GiaoVien.MaBM
			join Khoa on Khoa.MaKhoa=BoMon.MaKhoa
			where Khoa.MaKhoa=@makhoa and YEAR(NhanCVKhoa.TimeBĐ) <=@nam and ((YEAR(NhanCVKhoa.TimeKT) is null or YEAR(NhanCVKhoa.TimeKT)>@nam))) as m,
			(select COUNT(GiaoVien.MaGV) as 'SLGVBM'
			from GiaoVien join NhanCVBM on GiaoVien.MaGV=NhanCVBM.MaGV join BoMon on BoMon.MaBM=GiaoVien.MaBM
			join Khoa on Khoa.MaKhoa=BoMon.MaKhoa
			where Khoa.MaKhoa=@makhoa and YEAR(NhanCVBM.TimeBĐ) <= @nam and (YEAR(NhanCVBM.TimeKT) is null or YEAR(NhanCVBM.TimeKT) >@nam)) as n) as db1,

	(select row_number() over(order by Khoa.MaKhoa) stt,Khoa.MaKhoa,Khoa.TenKhoa
			from Khoa) as db2
	where db1.STT=db2.stt
	
	select total.TenKhoa, GS.SoGS as soGS, PGS.SPGS as soPGS, TSKH.STSKH as soTSKH, TS.STS as soTS,
			ThS.SThS as soThS, GVCC.SGVCC as soGVCC, GV.SGV as soGV, GVC.SGVC as soGVC, TrG.STrG as soTrG, total.Tong as N'Tổng'
	from @GS as GS JOIN @PGS as PGS ON GS.makhoa=PGS.makhoa JOIN @TSKH as TSKH ON TSKH.makhoa=PGS.makhoa JOIN @TS as TS ON TS.makhoa=TSKH.makhoa
		JOIN @ThS as ThS ON ThS.makhoa=TS.makhoa join @GVCC as GVCC on GVCC.makhoa=ThS.makhoa join 
		@GV as GV on GVCC.makhoa=GV.makhoa join @GVC as GVC on GVC.makhoa=GV.makhoa join @TrG as TrG on GVC.makhoa=TrG.makhoa
		join @total  as total on TrG.makhoa=total.makhoa
	
end

NhanLucKhoa'Kh01','2013'

drop procedure NhanLucKhoa

	  
--(select COUNT(*) as SL
--from (select i.MaGV,NhanHocVi.MaHocVi,i.nam,NhanCVBM.MaBM,Khoa.MaKhoa
--      from (select MaGV,Max(year(ThoiGian)) as nam
--	        from NhanHocVi where YEAR(NhanHocVi.ThoiGian) <= 2014
--	        group by MaGV) as i, NhanHocVi, NhanCVBM,BoMon,Khoa
--      where i.nam=YEAR(NhanHocVi.ThoiGian) and i.MaGV=NhanHocVi.MaGV and NhanCVBM.MaGV=i.MaGV 
--	  and BoMon.MaBM=NhanCVBM.MaBM and Khoa.MaKhoa=BoMon.MaKhoa
--	  and YEAR(NhanCVBM.TimeBĐ)<=2014 and (YEAR(NhanCVBM.TimeKT) is null or YEAR(NhanCVBM.TimeKT)>=2014)) as k
--where k.MaKhoa='Kh01' and k.MaHocVi='HV3003' and k.nam<=2014) 

--(select COUNT(*) as SL
--from (select i.MaGV,NhanHocVi.MaHocVi,i.nam,NhanCVKhoa.MaKhoa
--      from (select MaGV,Max(year(ThoiGian)) as nam
--	        from NhanHocVi where YEAR(NhanHocVi.ThoiGian) <= 2013
--	        group by MaGV) as i, NhanHocVi, NhanCVKhoa,Khoa
--      where i.nam=YEAR(NhanHocVi.ThoiGian) and i.MaGV=NhanHocVi.MaGV and NhanCVKhoa.MaGV=i.MaGV and Khoa.MaKhoa=NhanCVKhoa.MaKhoa
--	  and YEAR(NhanCVKhoa.TimeBĐ)<=2014 and (YEAR(NhanCVKhoa.TimeKT) is null or YEAR(NhanCVKhoa.TimeKT)>=2014)) as k
--where k.MaKhoa='Kh01' and k.MaHocVi='HV3003' and k.nam<=2014) 