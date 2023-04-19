--1--
CREATE TRIGGER tr_Nhap_Insert
ON Nhap
AFTER INSERT
AS
BEGIN
IF NOT EXISTS (SELECT masp FROM Sanpham WHERE masp IN (SELECT masp FROM inserted))
BEGIN
RAISERROR('Mã sản phẩm không tồn tại trong bảng sản phẩm!', 16, 1)
ROLLBACK TRANSACTION
RETURN
END

IF NOT EXISTS (SELECT manv FROM Nhanvien WHERE manv IN (SELECT manv FROM inserted))
BEGIN
    RAISERROR('Mã nhân viên không tồn tại trong bảng nhân viên!', 16, 1)
    ROLLBACK TRANSACTION
    RETURN
END

IF EXISTS (SELECT soluongN, dongiaN FROM inserted WHERE soluongN <= 0 OR dongiaN <= 0)
BEGIN
    RAISERROR('Số lượng và đơn giá nhập phải lớn hơn 0!', 16, 1)
    ROLLBACK TRANSACTION
    RETURN
END

UPDATE Sanpham
SET soluong = soluong + inserted.soluongN
FROM Sanpham
INNER JOIN inserted ON Sanpham.masp = inserted.masp
END

--2--
CREATE TRIGGER tr_Xuat_Insert
ON Xuat
AFTER INSERT
AS
BEGIN
IF NOT EXISTS (SELECT masp FROM Sanpham WHERE masp IN (SELECT masp FROM inserted))
BEGIN
RAISERROR('Mã sản phẩm không tồn tại trong bảng sản phẩm!', 16, 1)
ROLLBACK TRANSACTION
RETURN
END

IF NOT EXISTS (SELECT manv FROM Nhanvien WHERE manv IN (SELECT manv FROM inserted))
BEGIN
    RAISERROR('Mã nhân viên không tồn tại trong bảng nhân viên!', 16, 1)
    ROLLBACK TRANSACTION
    RETURN
END

IF EXISTS (SELECT soluongX, Sanpham.soluong FROM inserted INNER JOIN Sanpham ON inserted.masp = Sanpham.masp WHERE soluongX > Sanpham.soluong)
BEGIN
    RAISERROR('Số lượng xuất không được lớn hơn số lượng trong kho!', 16, 1)
    ROLLBACK TRANSACTION
    RETURN
END

UPDATE Sanpham
SET soluong = soluong - inserted.soluongX
FROM Sanpham
INNER JOIN inserted ON Sanpham.masp = inserted.masp
END

--3--
CREATE TRIGGER tr_Xuat_Delete
ON Xuat
AFTER DELETE
AS
BEGIN
UPDATE Sanpham
SET soluong = soluong + deleted.soluongX
FROM Sanpham
INNER JOIN deleted ON Sanpham.masp = deleted.masp
END

--4--
CREATE TRIGGER tr_Xuat_Update
ON Xuat
AFTER UPDATE
AS
BEGIN
IF (SELECT COUNT(*) FROM inserted) > 1
BEGIN
RAISERROR('Chỉ được cập nhật một bản ghi tại một thời điểm!', 16, 1)
ROLLBACK TRANSACTION
RETURN
END

IF EXISTS (SELECT inserted.soluongX, Sanpham.soluong FROM inserted INNER JOIN Sanpham ON inserted.masp = Sanpham.masp WHERE inserted.soluongX > Sanpham.soluong)
BEGIN
    RAISERROR('Số lượng xuất không được lớn hơn số lượng trong kho!', 16, 1)
    ROLLBACK TRANSACTION
    RETURN
END

UPDATE Sanpham
SET soluong = soluong + deleted.soluongX - inserted.soluongX
FROM Sanpham
INNER JOIN deleted ON Sanpham.masp = deleted.masp
INNER JOIN inserted ON Sanpham.masp = inserted.masp
END

--5--
CREATE TRIGGER tr_Nhap_Update
ON Nhap
AFTER UPDATE
AS
BEGIN
IF (SELECT COUNT(*) FROM inserted) > 1
BEGIN
RAISERROR('Chỉ được cập nhật một bản ghi tại một thời điểm!', 16, 1)
ROLLBACK TRANSACTION
RETURN
END

IF EXISTS (SELECT inserted.soluongN, Sanpham.soluong FROM inserted INNER JOIN Sanpham ON inserted.masp = Sanpham.masp WHERE inserted.soluongN > Sanpham.soluong)
BEGIN
    RAISERROR('Số lượng nhập không được lớn hơn số lượng trong kho!', 16, 1)
    ROLLBACK TRANSACTION
    RETURN
END

UPDATE Sanpham
SET soluong = soluong + deleted.soluongN - inserted.soluongN
FROM Sanpham
INNER JOIN deleted ON Sanpham.masp = deleted.masp
INNER JOIN inserted ON Sanpham.masp = inserted.masp
END

--6--
CREATE TRIGGER tr_Nhap_Delete
ON Nhap
AFTER DELETE
AS
BEGIN
UPDATE Sanpham
SET soluong = soluong - deleted.soluongN
FROM Sanpham
INNER JOIN deleted ON Sanpham.masp = deleted.masp
END