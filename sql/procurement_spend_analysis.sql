CREATE DATABASE procurement_db;
USE procurement_db;
GO

CREATE TABLE Suppliers (
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierName VARCHAR(100),
    SupplierRating INT CHECK (SupplierRating BETWEEN 1 AND 5),
    Country VARCHAR(50)
);

INSERT INTO Suppliers (SupplierName, SupplierRating, Country)
VALUES
('Alpha Industries', 5, 'India'),
('GlobalTech Solutions', 4, 'USA'),
('Prime Components', 3, 'India'),
('Zenith Supplies', 2, 'China'),
('OmniSource Ltd', 4, 'Germany'),
('Vertex Traders', 1, 'India');

CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(100)
);

INSERT INTO Categories (CategoryName)
VALUES
('IT Hardware'),
('Office Supplies'),
('Raw Materials'),
('Logistics'),
('Maintenance');

CREATE TABLE ProcurementTransactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    TransactionDate DATE,
    SupplierID INT,
    CategoryID INT,
    ItemName VARCHAR(100),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    TotalAmount DECIMAL(12,2),
    CONSTRAINT FK_Supplier FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    CONSTRAINT FK_Category FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

INSERT INTO ProcurementTransactions
(TransactionDate, SupplierID, CategoryID, ItemName, Quantity, UnitPrice, TotalAmount)
VALUES
('2025-01-15', 1, 1, 'Laptops', 10, 55000, 550000),
('2025-01-20', 2, 1, 'Servers', 2, 250000, 500000),
('2025-02-05', 3, 2, 'Printer Paper', 200, 300, 60000),
('2025-02-12', 4, 3, 'Steel Sheets', 500, 1200, 600000),
('2025-02-20', 1, 5, 'AC Maintenance', 5, 15000, 75000),
('2025-03-01', 5, 4, 'Transportation', 1, 180000, 180000),
('2025-03-10', 2, 1, 'Network Switches', 6, 40000, 240000),
('2025-03-18', 6, 3, 'Plastic Granules', 800, 500, 400000),
('2025-04-05', 3, 2, 'Office Chairs', 30, 4500, 135000),
('2025-04-15', 4, 3, 'Aluminium Rods', 300, 2000, 600000),
('2025-05-02', 1, 1, 'Monitors', 15, 12000, 180000),
('2025-05-19', 5, 4, 'International Freight', 1, 220000, 220000);

SELECT
    s.SupplierName,
    s.SupplierRating,
    c.CategoryName,
    FORMAT(t.TransactionDate, 'yyyy-MM') AS Month,
    SUM(t.TotalAmount) AS TotalSpend
FROM ProcurementTransactions t
JOIN Suppliers s ON t.SupplierID = s.SupplierID
JOIN Categories c ON t.CategoryID = c.CategoryID
GROUP BY
    s.SupplierName,
    s.SupplierRating,
    c.CategoryName,
    FORMAT(t.TransactionDate, 'yyyy-MM')
ORDER BY TotalSpend DESC;

