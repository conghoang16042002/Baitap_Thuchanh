CREATE TABLE Sanpham (
masp nchar(10) PRIMARY KEY,
mahangsx nchar(10),
tensp nvarchar(20),
soluong INT,
mausac nvarchar(20),
giaban money,
donvitinh nchar(10),
mota nvarchar(max)
);

CREATE TABLE Hangsx (
mahangsx nchar(10) PRIMARY KEY,
tenhang nvarchar(20),
diachi nvarchar(30),
sodt nvarchar(20),
email nvarchar(30)
);

CREATE TABLE Nhanvien (
manv nchar(10) PRIMARY KEY,
tennv nvarchar(20),
gioitinh nchar(10),
diachi nvarchar(30),
sodt nvarchar(20),
email nvarchar(30),
phong nvarchar(30)
);

CREATE TABLE Nhap (
sohdn nchar(10) PRIMARY KEY,
masp nchar(10),
manv nchar(10),
ngaynhap DATE,
soluongN INT,
dongiaN money,
FOREIGN KEY (masp) REFERENCES Sanpham(masp),
FOREIGN KEY (manv) REFERENCES Nhanvien(manv)
);

CREATE TABLE Xuat (
sohdx nchar(10) PRIMARY KEY,
masp nchar(10),
manv nchar(10),
ngayxuat DATE,
soluongX INT,
FOREIGN KEY (masp) REFERENCES Sanpham(masp),
FOREIGN KEY (manv) REFERENCES Nhanvien(manv)
);

ALTER TABLE Sanpham ADD CONSTRAINT FK_Sanpham_Hangsx FOREIGN KEY (mahangsx) REFERENCES Hangsx(mahangsx);
ALTER TABLE Nhap ADD CONSTRAINT FK_Nhap_Sanpham FOREIGN KEY (masp) REFERENCES Sanpham(masp);
ALTER TABLE Nhap ADD CONSTRAINT FK_Nhap_Nhanvien FOREIGN KEY (manv) REFERENCES Nhanvien(manv);
ALTER TABLE Xuat ADD CONSTRAINT FK_Xuat_Sanpham FOREIGN KEY (masp) REFERENCES Sanpham(masp);
ALTER TABLE Xuat ADD CONSTRAINT FK_Xuat_Nhanvien FOREIGN KEY (manv) REFERENCES Nhanvien(manv);