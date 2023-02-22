--I) Câu lệnh SELECT sử dụng các hàm thống kê với các mệnh đề Group by và Having
--1) Liệt kê danh sách các hóa đơn (SalesOrderID) lặp trong tháng 6 năm 2008 có tổng tiền >70000, thông tin gồm SalesOrderID, Orderdate, SubTotal, trong đó SubTotal =sum(OrderQty*UnitPrice).
select SOH.SalesOrderID, SOH.Orderdate, Sum(SOD.OrderQty * SOD.UnitPrice) as 'Sub Total'
From Sales.SalesOrderHeader as SOH join Sales.SalesOrderDetail As SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
Where month(soh.OrderDate) = 6 and year(soh.OrderDate) = 2008
Group By SOH.SalesOrderID, SOH.OrderDate
Having SUM(SOD.OrderQty * SOD.UnitPrice) > 70000

--2) Đếm tổng số khách hàng và tổng tiền của những khách hàng thuộc các quốc gia có mã vùng là US (lấy thông tin từ các bảng SalesTerritory, Sales.Customer, Sales.SalesOrderHeader, Sales.SalesOrderDetail). Thông tin bao gồm TerritoryID, tổng số khách hàng (countofCus), tổng tiền (Subtotal) với Subtotal = SUM(OrderQty*UnitPrice)
Select SST.TerritoryID, count(SC.CustomerID) as 'CountOfCust', SUM(SSOD.OrderQty * SSOD.UnitPrice) As 'Subtotal'
from Sales.SalesTerritory as SST join Sales.Customer as SC
ON SST.TerritoryID = SC.TerritoryID join Sales.SalesOrderHeader as SSOH
ON SSOH.TerritoryID = SC.TerritoryID join Sales.SalesOrderDetail as SSOD
ON SSOD.SalesOrderID = SSOH.SalesOrderID
Where SST.CountryRegionCode = 'US'
Group By SST.TerritoryID

--3) Tính tổng trị giá của những hóa đơn với Mã theo dõi giao hàng (CarrierTrackingNumber) có 3 ký tự đầu là 4BD, thông tin bao gồm SalesOrderID, CarrierTrackingNumber, SubTotal=sum(OrderQty*UnitPrice)
Select ssod.SalesOrderID, ssod.CarrierTrackingNumber, Sum(OrderQty*UnitPrice) as 'SubTotal'
from sales.SalesOrderDetail as ssod
group by ssod.SalesOrderID, ssod.CarrierTrackingNumber
having ssod.CarrierkingNumber like '4BD%'

--4) Liệt kê các sản phẩm (product) có đơn giá (unitPrice)<25 và số lượng bán trung bình >5, thông tin gồm ProductID, name, AverageofQty
select pp.ProductID, pp.Name, AVG(ssod.UnitPrice) as 'AverageOfQty'
from Production.Product as pp join sales.SalesOrderDetail as ssod
ON pp.ProductID = ssod.ProductID
Where ssod.Unitprice < 25
group by pp.ProductID, pp.Name
having avg(ssod.OrderQty) > 5

--5) Liệt kê các công việc (JobTitle) có tổng số nhân viên >20 người, thông tin gồm JobTitle, countofPerson=count(*)
select hre.JobTittle, count(hre.BusinessEntilyID) 'CountOfPerson'
from HumanResources.Employee hre
group by hre.JobTitle
having count(hre.BusinessEntilyID) > 20

--6) Tính tổng số lượng và tổng trị giá của các sản phẩm do các nhà cung cấp có tên kết thúc bằng ‘Bicycles’ và tổng trị giá >800000, thông tin gồm BusinessEntityID, Vendor_name, ProductID, sumofQty, SubTotal (sử dụng các bảng [Purchasing].[Vendor] [Purchasing].[PurchaseOrderHeader] và [Purchasing].[PurchaseOrderDetail])
select pv.BusinessEntityId, pv.Name, ppod.ProductID,
   SumOfQty = Sum(ppod.OrderQty), SubTotal = Sum(ppod.OrderQty * ppod.UnitPrice)
from Purchasing .Vendor pv 
     join Purchasing.PurchaseOrderHeader ppoh on pv.BusinessEntityId = ppoh.VendorId
     join Purchasing.PurchaseOrderDetail ppoh on ppoh.PurchaseOrderId= ppoh.PurchaseOrderId
Where pv.Name likes 'Bicycles' 
group by pv.BusinessEntityId, pv.Name, ppod.ProductID
having Sum(ppod.OrderQty * ppod.UnitPrice) > 800000

--7) Liệt kê các sản phẩm có trên 500 đơn đặt hàng trong quí 1 năm 2008 và có tổng trị giá >10000, thông tin gồm ProductID, Product_name, countofOrderID và Subtotal
select pp.Product.Id, pp.Name, CountOfOrderId = count(ssod.SalesOrderId), SubTotal Sum(ssod.Qty * ssod.UnitPrice )
from Production.Product pp 
join sales.SalesOrderDetail ssod on ssod.ProductId = pp.ProductId
join sales SalesOrderHeadr ssoh on ssod.SalesOrderId = pp.SalesOrderId
WHERE DATEPART(q, ssoh.orderdate) - 1 and year(ssoh .orderDate) -2008
Group by pp.ProductId, pp.Name
Having Sum(ssohd.OrderQty * ssod.UnitPrice)>10000 and count(ssod.SalesOrderId) > 500

--8) Liệt kê danh sách các khách hàng có trên 25 hóa đơn đặt hàng từ năm 2007 đến 2008, thông tin gồm mã khách (PersonID) , họ tên (FirstName +' '+ LastName as fullname), Số hóa đơn (CountOfOrders).
select sc.PersonId, FullName = (pp.FirtName + ''+pp.Last), Count OfOrders = count(ssoh.SalesOrderId)
from Person.Person pp
join Sales .Customer sc on pp.BusinessEntityId = sc.CustomerId
Where year (ssoh .OrderDate) between 2007 and 2008
group by sc.PersonId , pp.FirstName + '' + pp.LastName
having count (ssohSalesOrderId)> 25

--9) Liệt kê những sản phẩm có tên bắt đầu với ‘Bike’ và ‘Sport’ có tổng số lượng bán trong mỗi mỗi năm trên 500 sản phẩm, thông tin gồm ProductID, Name, CountofOrderQty, year. (dữ liệu lấy từ các bảng Sales.SalesOrderHeader, Sales.SalesOrderDetail, and Production.Product)
select pp.ProductID, pp.Name, CountOfOderQty = sum(ssod.OrderQty), YearOfSale = year(ssoh.Orderdate)
from Production.Product pp
	join Sales.SalesOrderdetail ssod on ssod.ProductID = pp.ProductID
	join Sales.SalesOrderHeader ssoh on ssod.SalesOrderID = ssoh.SalesOrderID
where pp.Name like '%Bike' or pp.Name like '%Sport'
group by pp.ProductID, pp.name, year(ssoh.OrderDate)
having sum(ssod.OrderQty) > 50

--10)Liệt kê những phòng ban có lương (Rate: lương theo giờ) trung bình >30, thông tin gồm Mã phòng ban (DepartmentID), tên phòng ban (name), Lương trung bình (AvgofRate). Dữ liệu từ các bảng [HumanResources].[Department], [HumanResources].[EmployeeDepartmentHistory], [HumanResources].[EmployeePayHistory].
select hrd.DepartmentID, hrd.Name, AvgofRate = avg(heph.Rate)
from HumanResources.Department hrd
	join HumanResourcess.EmployeeDepartmentHistory hedh on hrd.DepartmentID = hedh.DepartmentID
	join HumanResourcess.EmployeePayHistory heph on hedh.BusinessEntityID = heph.BusinessEntityID
group by hrd.DepartmentID, hrd.Name
having avg(heph.Rate) > 30