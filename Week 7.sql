#Question 1
SELECT OrderID, CustomerName, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', numbers.n), ',', -1)) AS Product
FROM
  (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
   SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL
   SELECT 9 UNION ALL SELECT 10) numbers
JOIN ProductDetail
  ON CHAR_LENGTH(Products)
     -CHAR_LENGTH(REPLACE(Products, ',', '')) >= numbers.n - 1
ORDER BY OrderID, CustomerName, Product;

Question 2
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(255) NOT NULL
);
INSERT INTO Customers (CustomerName)
SELECT DISTINCT CustomerName FROM OrderDetails;
CREATE TABLE Orders (
    OrderID INT,
    CustomerID INT,
    Product VARCHAR(255) NOT NULL,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
INSERT INTO Orders (OrderID, CustomerID, Product)
SELECT 
    OrderID, 
    (SELECT CustomerID FROM Customers WHERE CustomerName = OrderDetails.CustomerName) AS CustomerID,
    Product
FROM OrderDetails;
