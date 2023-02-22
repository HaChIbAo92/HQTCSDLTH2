--2. Trong CSDL vừa tạo, sử dụng câu lệnh SQL để thiết kế cấu trúc các bảng có khóa chính, khóa ngoại và kiểu dữ liệu theo lược đồ sau:
---Tạo database
create database QLDA2
go 
use QLDA2
go


---Tạo bảng
--Nhân viên
create table NHANVIEN
(
MaNV varchar(9) NOT NULL,
HoNV nvarchar(15),
TenLot nvarchar(30),
TenNV nvarchar(30),
NgSinh smalldatetime,
DiaChi nvarchar(150),
Phai nvarchar(3),
Luong numeric(18, 0),
Phong varchar(2),
)

--Thân nhân
create table THANNHAN
(
MaNV varchar(9) Not null,
TenTN varchar(20) not null,
NgaySinh smalldatetime,
Phai varchar(3),
Quanhe varchar(15),
)

--Đề án
create table DEAN
(
MaDA varchar(2) not null,
TenDA nvarchar(50),
DDiemDA varchar(20),
)

--Phân công
create table PHANCONG
(
MaNV varchar(9) not null,
MaDA varchar(2) not null,
ThoiGian numeric(18, 0),
)

--Phòng ban
create table PHONGBAN
(
MaPhg varchar(2) not null,
TenPhg nvarchar(20),
)


---Thiết kế khóa chính, khóa ngoại:
--Nhân viên
ALTER TABLE NHANVIEN ADD CONSTRAINT Pk_Nhanvien PRIMARY KEY (MaNV);
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_Pbnv FOREIGN KEY (Phong) REFERENCES PHONGBAN(MaPhg);

--Thân nhân
ALTER TABLE THANNHAN ADD CONSTRAINT FK_Thannhana FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV);
ALTER TABLE THANNHAN ADD CONSTRAINT PK_Thannhanb PRIMARY KEY (TenTN);

--Đê án
ALTER TABLE DEAN ADD CONSTRAINT PK_Dean PRIMARY KEY (MaDA);

--phân công
ALTER TABLE PHANCONG ADD CONSTRAINT FK_Phanconga FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV);
ALTER TABLE PHANCONG ADD CONSTRAINT FK_Phancongb FOREIGN KEY (MaDA) REFERENCES DEAN(MaDA);
ALTER TABLE PHANCONG ADD CONSTRAINT PK_Phancongc PRIMARY KEY (MaNV,MaDA);

--phòng ban
ALTER TABLE PHONGBAN ADD CONSTRAINT PK_Phongban PRIMARY KEY (MaPhg);



---4. Sử dụng câu lệnh SQL để thực hiện các yêu cầu sau:
--- Trong bảng PHONGBAN, chỉnh sửa kiểu dữ liệu của cột TenPhg thành nvarchar(30)
ALTER TABLE PHONGBAN
ALTER COLUMN TenPhg NVARCHAR(30)

--- Trong bảng DEAN, chỉnh sửa kiểu dữ liệu của cột DDiemDA thành nvarchar(20)
ALTER TABLE DEAN
ALTER COLUMN DDiemDA NVARCHAR(20)

--- Trong bảng THANNHAN, chỉnh sửa kiểu dữ liệu của cột TenTN thành nvarchar(20), kiểu dữ liệu của cột Phai thành nvarchar(3), kiểu dữ liệu của cột QuanHe thành nvarchar(15)
ALTER TABLE THANNHAN
ALTER COLUMN TenTN NVARCHAR(20)
ALTER TABLE THANNHAN
ALTER COLUMN Phai NVARCHAR(3)
ALTER TABLE THANNHAN
ALTER COLUMN QuanHe NVARCHAR(15)

---Trong bảng NHANVIEN, thêm cột SoDienThoai với kiểu dữ liệu varchar(15)
ALTER TABLE NHANVIEN
ADD SoDienThoai varchar(15)

--- Trong bảng NHANVIEN, xóa cột SoDienThoai vừa tạo.
ALTER TABLE NHANVIEN
DROP column SoDienThoai


---5. Sử dụng câu lệnh SQL để nhập liệu vào các bảng như sau:
--Nhân viên:
insert into NHANVIEN
values ('123', N'Đinh', N'Bá', N'Tiến', '1982-2-27', 'Mộ Đức', 'Nam', '', '4')
insert into NHANVIEN
values ('234', N'Nguyễn', N'Thanh', N'Tùng', '1956-8-12', 'Sơn Tịnh', 'Nam', '', '5')
insert into NHANVIEN
values ('345', N'Bùi', N'Thúy', N'Vũ', 'null', 'Tư Nghĩa', N'Nữ', '', '4')
insert into NHANVIEN
values ('456', N'Lê', N'Thị', N'Nhàn', '1962-7-12', 'Mộ Đức', N'Nữ', '', '4')
insert into NHANVIEN
values ('567', N'Nguyễn', N'Mạnh', N'Hùng', '1985-3-25', 'Sơn Tịnh', 'Nam', '', '5')
insert into NHANVIEN
values ('678', N'Trần', N'Hồng', N'Quang', 'null', 'bình Sơn', 'Nam', '', '5')
insert into NHANVIEN
values ('789', N'Trần', N'Thanh', N'Tâm', '1972-6-17', 'Quãng Ngãi', 'Nam', '', '5')
insert into NHANVIEN
values ('890', N'Cao', N'Thanh', N'Huyền', 'null', 'Tư Nghĩa', N'Nữ', '', '1')
insert into NHANVIEN
values ('901', N'Vương', N'Ngọc', N'Quyền', '1987-12-12', 'Mộ Đức', N'Nam', '', '1')

--thân nhân:
insert into THANNHAN
values ('123', N'Châu', '2005-10-30', N'Nữ', N'Con gái')
insert into THANNHAN
values ('123', N'Duy', '2001-10-25', N'Nam', N'Con trai')
insert into THANNHAN
values ('123', N'Phương', '1985-10-30', N'Nữ', N'Vợ chồng')
insert into THANNHAN
values ('234', N'Thanh', '1980-04-05', N'Nữ', N'Con gái')
insert into THANNHAN
values ('345', N'Dương', '1956-10-30', N'Nam', N'Vợ chồng')
insert into THANNHAN
values ('345', N'Khang', '1982-10-25', N'Nam', N'Con trai')
insert into THANNHAN
values ('456', N'Hùng', '1987-01-01', N'Nam', N'Con trai')
insert into THANNHAN
values ('901', N'Thương', '1984-04-05', N'Nữ', N'Vợ chồng')

--Đê án:
insert into DEAN
values ('1', N'Nâng cao chất lượng muối', N'Sa Huỳnh')
insert into DEAN
values ('10', N'Xây dựng nhà máy chế biến thủy sản', N'Dung Quất')
insert into DEAN
values ('2', N'Phát triẻn hạ tầng mạng', N'Quảng Ngãi')
insert into DEAN
values ('20', N'Truyền tải cáp quang', N'Quảng Ngãi')
insert into DEAN
values ('3', N'Tin học hóa trường học', N'Ba Tơ')
insert into DEAN
values ('30', N'Đào tạo nhân lực', N'Tịnh Phong')

--Phân công:
insert into PHANCONG
values ('123', '1', '30')
insert into PHANCONG
values ('123', '2', '8')
insert into PHANCONG
values ('345', '10', '10')
insert into PHANCONG
values ('345', '20', '10')
insert into PHANCONG
values ('345', '3', '10')
insert into PHANCONG
values ('456', '1', '20')
insert into PHANCONG
values ('456', '2', '20')
insert into PHANCONG
values ('678', '3', '40')
insert into PHANCONG
values ('789', '10', '35')
insert into PHANCONG
values ('789', '20', '30')
insert into PHANCONG
values ('789', '30', '5')

--Phòng ban
insert into PHONGBAN
values ('1', N'Quản lý')
insert into PHONGBAN
values ('4', N'Điều hành')
insert into PHONGBAN
values ('5', N'Nghiên cứu')
