Alter table HoiDong add constraint HĐ_LoaiHD foreign key (MaLoaiHD) references LoaiHD (MaLoaiHD)
Alter table ThamGiaHD add constraint TGHĐ_GV foreign key (MaGV) references GiaoVien (MaGV)
Alter table ThamGiaHD add constraint TGHĐ_HĐ foreign key (MaHD) references HoiDong (MaHD)
Alter table DMthamgiaHD add constraint DMTGHD_HĐ foreign key (MaHD) references HoiDong (MaHD)
