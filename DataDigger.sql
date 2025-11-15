/*Database*/
CREATE DATABASE DataDigger;
USE DataDigger;

/*Customers Table*/
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL
);

/*Insert Sample Data*/
INSERT INTO Customers (Name, Email, Address) VALUES
('Khushi', 'khushinagar@gmail.com', 'Ahmedabad'),
('Rishi', 'rishi@gmail.com', 'Surat'),
('Pratham', 'pratham@gmail.com', 'Gandhinagar'),
('Manthan', 'manthan@gmail.com', 'Vapi'),
('Yash', 'yash@gmail.com', 'Vadodra'),
('Priya', 'priya@gmail.com', 'Kalol'),
('Alice', 'alice@gmail.com', 'Dehgam');

/*Retrieve all customers*/
SELECT * FROM Customers;

/*Update a customer’s address*/
SELECT * FROM Customers WHERE Name = 'Yash';
UPDATE Customers SET Address = 'Paris' WHERE CustomerID = 5;

/*Delete a customer using CustomerID*/
DELETE FROM Customers WHERE CustomerID = 6;

/*Display customers whose name is ‘Alice’*/
SELECT * FROM Customers WHERE Name = 'Alice';

/*Orders Table*/
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

/*Insert Sample Data*/
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2025-10-01', 1500),
(2, '2025-10-05', 2200),
(1, '2025-11-10', 800),
(3, '2025-11-12', 1800),
(5, '2025-09-01', 3500);

/*Retrieve all orders made by a specific customer*/
SELECT * FROM Orders WHERE CustomerID = 1;

/*Update order total amount*/
UPDATE Orders SET TotalAmount = 1200 WHERE OrderID = 3;

/*Delete order using OrderID*/
DELETE FROM Orders WHERE OrderID = 2;

/*Retrieve orders placed in last 30 days*/
SELECT * FROM Orders WHERE OrderDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

/*Highest, Lowest & Average Order Amount*/
SELECT MAX(TotalAmount) AS Highest, MIN(TotalAmount) AS Lowest, AVG(TotalAmount) AS AverageAmount FROM Orders; 

/*Products Table*/
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL
);

/*Insert Sample Products*/
INSERT INTO Products (ProductName, Price, Stock) VALUES
('Laptop', 45000, 10),
('Mouse', 500, 0),
('Keyboard', 1200, 25),
('Headphones', 2000, 15),
('Pendrive', 700, 40);

/*Retrieve products sorted by price DESC*/
SELECT * FROM Products ORDER BY Price DESC;

/*Update price of a product*/
UPDATE Products SET Price = 1500 WHERE ProductID = 3;

/*Delete a product if out of stock*/
DELETE FROM Products WHERE Stock = 0 LIMIT 1;

/*Retrieve products price between ₹500 and ₹2000*/
SELECT * FROM Products WHERE Price BETWEEN 500 AND 2000;

/*Retrieve most expensive + cheapest product*/
SELECT MAX(Price) AS MaxPrice, MIN(Price) AS MinPrice FROM Products;

/*OrderDetails Table*/
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

/*Insert Sample Records*/
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, SubTotal) VALUES
(1, 1, 1, 45000),
(1, 4, 2, 4000),
(3, 3, 1, 1200),
(4, 5, 3, 2100),
(5, 1, 1, 45000);

/*Retrieve all order details for a specific order*/
SELECT * FROM OrderDetails WHERE OrderID = 1;

/*Calculate total revenue from all orders*/
SELECT SUM(SubTotal) AS TotalRevenue FROM OrderDetails;

/*Retrieve top 3 most ordered products*/
SELECT ProductID, SUM(Quantity) AS TotalQty FROM OrderDetails GROUP BY ProductID ORDER BY TotalQty DESC LIMIT 3;

/*Count how many times a product has been sold*/
SELECT ProductID, COUNT(*) AS TimesSold FROM OrderDetails WHERE ProductID = 1;

