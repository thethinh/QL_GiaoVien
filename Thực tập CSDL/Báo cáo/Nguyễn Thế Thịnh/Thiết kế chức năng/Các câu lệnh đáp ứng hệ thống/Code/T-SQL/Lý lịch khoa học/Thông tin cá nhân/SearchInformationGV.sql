create proc SearchGV(@tengv nvarchar(max))
as
begin
	select MaGV,TenGV
	from GiaoVien
	where GiaoVien.TenGV like '%'+@tengv
end

select * from GiaoVien

