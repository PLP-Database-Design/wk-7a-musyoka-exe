--Question 1: Achieving 1NF (First Normal Form)--
-- Achieving 1NF by breaking the Products column into individual rows
WITH ProductList AS (
    SELECT 101 AS OrderID, 'John Doe' AS CustomerName, 'Laptop' AS Product
    UNION ALL
    SELECT 101, 'John Doe', 'Mouse'
    UNION ALL
    SELECT 102, 'Jane Smith', 'Tablet'
    UNION ALL
    SELECT 102, 'Jane Smith', 'Keyboard'
    UNION ALL
    SELECT 102, 'Jane Smith', 'Mouse'
    UNION ALL
    SELECT 103, 'Emily Clark', 'Phone'
)

-- Final result in 1NF
SELECT OrderID, CustomerName, Product
FROM ProductList;


--Question 2: Achieving 2NF (Second Normal Form)--
-- Step 1: Create the Orders table to remove partial dependency
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create the OrderItems table to store product-related information
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Insert data into the Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Step 4: Insert data into the OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
