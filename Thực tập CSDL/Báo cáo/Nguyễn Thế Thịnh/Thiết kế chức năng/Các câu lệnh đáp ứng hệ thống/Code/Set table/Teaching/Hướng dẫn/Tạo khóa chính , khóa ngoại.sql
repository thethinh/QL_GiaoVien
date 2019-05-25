Alter table HocVien add constraint HV_LCN foreign key (MaLopCN) references LopChuyenNganh (MaLopCN)
Alter table HuongDanHV add constraint HDHV_GV foreign key (MaGV) references GiaoVien (MaGV)
Alter table HuongDanHV add constraint HDHV_HV foreign key (MaHV) references HocVien(MaHV)
Alter table DeTai_CĐ add constraint DT_LoaiDT foreign key (MaLoaiDT) references LoaiDT (MaLoaiDT)
Alter table DMhuongdan add constraint DMHD_LoaiDT foreign key(MaLoaiDT) references LoaiDT (MaLoaiDT)
Alter table DMhuongdan add constraint DMHD_LoaiDMHD foreign key (LoaiDMHD) references LoaiDMHD (MaLoaiDMHD)
Alter table ChonDT add constraint ChonDT_HV foreign key (MaHV) references HocVien(MaHV)
Alter table ChonDT add constraint ChonDT_DT foreign key (MaDT) references DeTai_CĐ (MaDT)

Create table DMhuongdan
(
	MaLoaiDT varchar(15),
	TenCongViec nvarchar(max),
	GioChuan float,
	DonVi nvarchar(50),
	LoaiDMHD varchar(15),
	GhiChu nvarchar(max)
)

