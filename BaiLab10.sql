--1a--
INSERT INTO Nhanvien (manv, tennv, gioitinh, diachi, sodt, email, phong)
VALUES
('NV05', 'Trần Thị Hương', 'Nữ', 'Hải Phòng', '0912345678', 'huong@gmail.com', 'Kế toán');

BACKUP DATABASE QLBanHang TO DISK = 'D:\HocTap\HQT CSDL\backup\QLBanhang.bak' 

--1b--
INSERT INTO Nhanvien (manv, tennv, gioitinh, diachi, sodt, email, phong)
VALUES
('NV06', 'Trần Thị Huệ', 'Nữ', 'Nam Định', '0123654987', 'hue@gmail.com', 'Kế toán');

BACKUP DATABASE QLBanHang TO DISK = 'D:\HocTap\HQT CSDL\backup\QLBanhang_differential.bak' WITH DIFFERENTIAL

--1c--
INSERT INTO Nhanvien (manv, tennv, gioitinh, diachi, sodt, email, phong)
VALUES
('NV07', 'Lê Văn Luyện', 'Nam', 'Quãng Ngãi', '0325648974', 'levanluyen@gmail.com', 'Marketing');

BACKUP LOG QLBanHang TO DISK = 'D:\HocTap\HQT CSDL\backup\QLBanhang.trn' 


--1d--
INSERT INTO Nhanvien (manv, tennv, gioitinh, diachi, sodt, email, phong)
VALUES
('NV08', 'Huỳnh Công Hoàng', 'Nam', 'Củ Chi', '0135452232', 'conghoang@gmail.com', 'Kinh Doanh');

BACKUP LOG QLBanHang TO DISK = 'D:\HocTap\HQT CSDL\backup\QLBanhang.trn' 

--2a--
DROP DATABASE QLBanHang

--2b--
RESTORE DATABASE QLBanHang FROM DISK = 'D:\HocTap\HQT CSDL\backup\QLBanhang.bak' WITH STANDBY = 'D:\HocTap\HQT CSDL\backup\QLBanhang_undo.bak'