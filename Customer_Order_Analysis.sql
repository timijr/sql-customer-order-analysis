/* ============================================================
   CUSTOMER & ORDER SALES ANALYSIS (SQL Server)
   Author: Bello Ridwan Oluwadamilare
   Purpose: Demonstrate schema design, data population, and
   business-driven analytical querying (joins, aggregation,
   window functions, date logic) using a customer/orders model.
   ============================================================ */


/* ------------------------------------------------------------
   1. SCHEMA DESIGN
   ------------------------------------------------------------ */

CREATE TABLE Customers (
    CustomerID   INT PRIMARY KEY,
    Full_Name    VARCHAR(100) NOT NULL,
    Email        VARCHAR(100),
    Phone        VARCHAR(20),
    JoinDate     DATE,
    Country      VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID      INT PRIMARY KEY,
    CustomerID   INT,
    OrderDate    DATE,
    Product      VARCHAR(100),
    Category     VARCHAR(50),
    Quantity     INT,
    Price        DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


/* ------------------------------------------------------------
   2. SAMPLE DATA: 50 customers across African markets
   ------------------------------------------------------------ */

INSERT INTO Customers (CustomerID, Full_Name, Email, Phone, JoinDate, Country) VALUES
(1,  'John Doe',        'john.doe@gmail.com',        '08012345678', '2023-01-12', 'Nigeria'),
(2,  'Jane Smith',      'jane.smith@yahoo.com',       '08023456789', '2023-03-05', 'Ghana'),
(3,  'Michael Brown',   'michael.brown@outlook.com',  '08034567890', '2023-05-20', 'Kenya'),
(4,  'Emily Johnson',   'emily.johnson@gmail.com',    '08045678901', '2023-07-15', 'South Africa'),
(5,  'David Wilson',    'david.wilson@gmail.com',     '08056789012', '2023-09-01', 'Cameroon'),
(6,  'Grace Adeyemi',   'grace.adeyemi@gmail.com',    '08067891234', '2023-01-22', 'Nigeria'),
(7,  'Kwame Mensah',    'kwame.mensah@yahoo.com',     '08078912345', '2023-02-14', 'Ghana'),
(8,  'Amina Yusuf',     'amina.yusuf@gmail.com',      '08089123456', '2023-02-28', 'Nigeria'),
(9,  'Peter Njoroge',   'peter.njoroge@outlook.com',  '08091234567', '2023-03-10', 'Kenya'),
(10, 'Thandiwe Nkosi',  'thandiwe.nkosi@gmail.com',   '08102345678', '2023-03-19', 'South Africa'),
(11, 'Chidi Okafor',    'chidi.okafor@gmail.com',     '08113456789', '2023-04-02', 'Nigeria'),
(12, 'Efua Boateng',    'efua.boateng@yahoo.com',     '08124567890', '2023-04-16', 'Ghana'),
(13, 'Samuel Kariuki',  'samuel.kariuki@gmail.com',   '08135678901', '2023-04-29', 'Kenya'),
(14, 'Nomvula Dube',    'nomvula.dube@outlook.com',   '08146789012', '2023-05-11', 'South Africa'),
(15, 'Ibrahim Musa',    'ibrahim.musa@gmail.com',     '08157890123', '2023-05-24', 'Nigeria'),
(16, 'Akosua Owusu',    'akosua.owusu@gmail.com',     '08168901234', '2023-06-07', 'Ghana'),
(17, 'Wanjiru Kamau',   'wanjiru.kamau@yahoo.com',    '08179012345', '2023-06-20', 'Kenya'),
(18, 'Lindiwe Zulu',    'lindiwe.zulu@gmail.com',     '08180123456', '2023-07-03', 'South Africa'),
(19, 'Emeka Nwosu',     'emeka.nwosu@outlook.com',    '08191234567', '2023-07-16', 'Nigeria'),
(20, 'Ama Asante',      'ama.asante@gmail.com',       '08202345678', '2023-07-29', 'Ghana'),
(21, 'Faith Wanjiku',   'faith.wanjiku@gmail.com',    '08213456789', '2023-08-11', 'Kenya'),
(22, 'Sipho Mahlangu',  'sipho.mahlangu@yahoo.com',   '08224567890', '2023-08-24', 'South Africa'),
(23, 'Fatima Bello',    'fatima.bello@gmail.com',     '08235678901', '2023-09-06', 'Nigeria'),
(24, 'Kofi Asare',      'kofi.asare@outlook.com',     '08246789012', '2023-09-19', 'Ghana'),
(25, 'Grace Mutua',     'grace.mutua@gmail.com',      '08257890123', '2023-10-02', 'Kenya'),
(26, 'Precious Dlamini','precious.dlamini@gmail.com', '08268901234', '2023-10-15', 'South Africa'),
(27, 'Tunde Bakare',    'tunde.bakare@yahoo.com',     '08279012345', '2023-10-28', 'Nigeria'),
(28, 'Abena Darko',     'abena.darko@gmail.com',      '08280123456', '2023-11-10', 'Ghana'),
(29, 'James Otieno',    'james.otieno@outlook.com',   '08291234567', '2023-11-23', 'Kenya'),
(30, 'Zanele Khumalo',  'zanele.khumalo@gmail.com',   '08302345678', '2023-12-06', 'South Africa'),
(31, 'Uche Eze',        'uche.eze@gmail.com',         '08313456789', '2023-12-19', 'Nigeria'),
(32, 'Yaw Boadi',       'yaw.boadi@yahoo.com',        '08324567890', '2024-01-01', 'Ghana'),
(33, 'Mercy Wambui',    'mercy.wambui@gmail.com',     '08335678901', '2024-01-14', 'Kenya'),
(34, 'Bongani Ndlovu',  'bongani.ndlovu@outlook.com', '08346789012', '2024-01-27', 'South Africa'),
(35, 'Ngozi Chukwu',    'ngozi.chukwu@gmail.com',     '08357890123', '2024-02-09', 'Nigeria'),
(36, 'Adjoa Frimpong',  'adjoa.frimpong@gmail.com',   '08368901234', '2024-02-22', 'Ghana'),
(37, 'Brian Kiptoo',    'brian.kiptoo@yahoo.com',     '08379012345', '2024-03-06', 'Kenya'),
(38, 'Nomsa Khoza',     'nomsa.khoza@gmail.com',      '08380123456', '2024-03-19', 'South Africa'),
(39, 'Segun Afolabi',   'segun.afolabi@outlook.com',  '08391234567', '2024-04-01', 'Nigeria'),
(40, 'Esi Appiah',      'esi.appiah@gmail.com',       '08402345678', '2024-04-14', 'Ghana'),
(41, 'Caroline Achieng','caroline.achieng@gmail.com', '08413456789', '2024-04-27', 'Kenya'),
(42, 'Themba Cele',     'themba.cele@yahoo.com',      '08424567890', '2024-05-10', 'South Africa'),
(43, 'Blessing Okonkwo','blessing.okonkwo@gmail.com', '08435678901', '2024-05-23', 'Nigeria'),
(44, 'Kwaku Antwi',     'kwaku.antwi@outlook.com',    '08446789012', '2024-06-05', 'Ghana'),
(45, 'Lucy Nyambura',   'lucy.nyambura@gmail.com',    '08457890123', '2024-06-18', 'Kenya'),
(46, 'Andile Mokoena',  'andile.mokoena@gmail.com',   '08468901234', '2024-07-01', 'South Africa'),
(47, 'Chinedu Obi',     'chinedu.obi@yahoo.com',      '08479012345', '2024-07-14', 'Nigeria'),
(48, 'Abla Sarpong',    'abla.sarpong@gmail.com',     '08480123456', '2024-07-27', 'Ghana'),
(49, 'Dennis Mwangi',   'dennis.mwangi@outlook.com',  '08491234567', '2024-08-09', 'Kenya'),
(50, 'Nokuthula Mkhize','nokuthula.mkhize@gmail.com', '08502345678', '2024-08-22', 'South Africa');


/* ------------------------------------------------------------
   3. SAMPLE DATA: 100 orders from 2023 to 2024
   ------------------------------------------------------------ */

INSERT INTO Orders (OrderID, CustomerID, OrderDate, Product, Category, Quantity, Price) VALUES
(101, 1,  '2023-02-10', 'Laptop',       'Electronics', 1, 350000.00),
(102, 2,  '2023-03-15', 'Smartphone',   'Electronics', 2, 180000.00),
(103, 1,  '2023-04-05', 'Headphones',   'Accessories', 1, 25000.00),
(104, 3,  '2023-06-12', 'Tablet',       'Electronics', 1, 120000.00),
(105, 4,  '2023-08-20', 'Smartwatch',   'Accessories', 3, 45000.00),
(106, 5,  '2023-09-10', 'Monitor',      'Electronics', 2, 80000.00),
(107, 6,  '2023-02-01', 'Laptop',       'Electronics', 1, 360000.00),
(108, 7,  '2023-02-20', 'Office Chair', 'Furniture',   2, 55000.00),
(109, 8,  '2023-03-05', 'Smartphone',   'Electronics', 1, 190000.00),
(110, 9,  '2023-03-25', 'Desk',         'Furniture',   1, 75000.00),
(111, 10, '2023-04-08', 'Headphones',   'Accessories', 2, 26000.00),
(112, 11, '2023-04-22', 'Laptop',       'Electronics', 1, 355000.00),
(113, 12, '2023-05-05', 'Tablet',       'Electronics', 2, 118000.00),
(114, 13, '2023-05-19', 'Monitor',      'Electronics', 1, 82000.00),
(115, 14, '2023-06-02', 'Smartwatch',   'Accessories', 1, 46000.00),
(116, 15, '2023-06-16', 'Office Chair', 'Furniture',   1, 57000.00),
(117, 16, '2023-06-30', 'Smartphone',   'Electronics', 1, 185000.00),
(118, 17, '2023-07-14', 'Desk',         'Furniture',   1, 78000.00),
(119, 18, '2023-07-28', 'Laptop',       'Electronics', 1, 358000.00),
(120, 19, '2023-08-11', 'Headphones',   'Accessories', 3, 24500.00),
(121, 20, '2023-08-25', 'Tablet',       'Electronics', 1, 122000.00),
(122, 1,  '2023-09-08', 'Monitor',      'Electronics', 1, 81000.00),
(123, 2,  '2023-09-22', 'Smartwatch',   'Accessories', 2, 44500.00),
(124, 3,  '2023-10-06', 'Smartphone',   'Electronics', 1, 192000.00),
(125, 4,  '2023-10-20', 'Office Chair', 'Furniture',   3, 54000.00),
(126, 5,  '2023-11-03', 'Laptop',       'Electronics', 1, 362000.00),
(127, 21, '2023-11-17', 'Desk',         'Furniture',   1, 76000.00),
(128, 22, '2023-12-01', 'Headphones',   'Accessories', 1, 25500.00),
(129, 23, '2023-12-15', 'Tablet',       'Electronics', 1, 119000.00),
(130, 24, '2023-12-29', 'Monitor',      'Electronics', 2, 79500.00),
(131, 25, '2024-01-05', 'Smartphone',   'Electronics', 1, 195000.00),
(132, 26, '2024-01-19', 'Smartwatch',   'Accessories', 1, 47000.00),
(133, 27, '2024-02-02', 'Laptop',       'Electronics', 1, 365000.00),
(134, 28, '2024-02-16', 'Office Chair', 'Furniture',   1, 56000.00),
(135, 29, '2024-03-01', 'Desk',         'Furniture',   2, 77000.00),
(136, 30, '2024-03-15', 'Headphones',   'Accessories', 2, 26500.00),
(137, 6,  '2024-03-29', 'Tablet',       'Electronics', 1, 121000.00),
(138, 7,  '2024-04-12', 'Monitor',      'Electronics', 1, 83000.00),
(139, 8,  '2024-04-26', 'Smartphone',   'Electronics', 2, 188000.00),
(140, 9,  '2024-05-10', 'Smartwatch',   'Accessories', 1, 45500.00),
(141, 31, '2024-05-24', 'Laptop',       'Electronics', 1, 359000.00),
(142, 32, '2024-06-07', 'Office Chair', 'Furniture',   1, 58000.00),
(143, 33, '2024-06-21', 'Desk',         'Furniture',   1, 79000.00),
(144, 34, '2024-07-05', 'Headphones',   'Accessories', 3, 25000.00),
(145, 35, '2024-07-19', 'Tablet',       'Electronics', 1, 123000.00),
(146, 36, '2024-08-02', 'Monitor',      'Electronics', 1, 80500.00),
(147, 37, '2024-08-16', 'Smartphone',   'Electronics', 1, 191000.00),
(148, 38, '2024-08-30', 'Smartwatch',   'Accessories', 2, 46500.00),
(149, 39, '2024-09-13', 'Laptop',       'Electronics', 1, 361000.00),
(150, 40, '2024-09-27', 'Office Chair', 'Furniture',   1, 55500.00),
(151, 10, '2024-01-08', 'Desk',         'Furniture',   1, 74000.00),
(152, 11, '2024-01-22', 'Headphones',   'Accessories', 1, 25000.00),
(153, 12, '2024-02-05', 'Tablet',       'Electronics', 1, 117000.00),
(154, 13, '2024-02-19', 'Monitor',      'Electronics', 1, 82500.00),
(155, 14, '2024-03-04', 'Smartphone',   'Electronics', 1, 193000.00),
(156, 41, '2024-03-18', 'Smartwatch',   'Accessories', 1, 44000.00),
(157, 42, '2024-04-01', 'Laptop',       'Electronics', 1, 357000.00),
(158, 43, '2024-04-15', 'Office Chair', 'Furniture',   2, 56500.00),
(159, 44, '2024-04-29', 'Desk',         'Furniture',   1, 78500.00),
(160, 45, '2024-05-13', 'Headphones',   'Accessories', 2, 24000.00),
(161, 15, '2024-05-27', 'Tablet',       'Electronics', 1, 120500.00),
(162, 16, '2024-06-10', 'Monitor',      'Electronics', 1, 81500.00),
(163, 17, '2024-06-24', 'Smartphone',   'Electronics', 1, 189000.00),
(164, 18, '2024-07-08', 'Smartwatch',   'Accessories', 1, 45000.00),
(165, 46, '2024-07-22', 'Laptop',       'Electronics', 1, 363000.00),
(166, 47, '2024-08-05', 'Office Chair', 'Furniture',   1, 57500.00),
(167, 48, '2024-08-19', 'Desk',         'Furniture',   1, 76500.00),
(168, 49, '2024-09-02', 'Headphones',   'Accessories', 3, 25500.00),
(169, 50, '2024-09-16', 'Tablet',       'Electronics', 1, 118500.00),
(170, 19, '2024-09-30', 'Monitor',      'Electronics', 1, 80000.00),
(171, 20, '2023-01-15', 'Smartphone',   'Electronics', 1, 178000.00),
(172, 21, '2023-01-29', 'Smartwatch',   'Accessories', 2, 43500.00),
(173, 22, '2023-02-12', 'Laptop',       'Electronics', 1, 352000.00),
(174, 23, '2023-02-26', 'Office Chair', 'Furniture',   1, 54500.00),
(175, 24, '2023-03-12', 'Desk',         'Furniture',   1, 75500.00),
(176, 25, '2023-03-26', 'Headphones',   'Accessories', 1, 24800.00),
(177, 26, '2023-04-09', 'Tablet',       'Electronics', 1, 119500.00),
(178, 27, '2023-04-23', 'Monitor',      'Electronics', 2, 81200.00),
(179, 28, '2023-05-07', 'Smartphone',   'Electronics', 1, 187000.00),
(180, 29, '2023-05-21', 'Smartwatch',   'Accessories', 1, 44800.00),
(181, 30, '2023-06-04', 'Laptop',       'Electronics', 1, 356000.00),
(182, 31, '2023-06-18', 'Office Chair', 'Furniture',   1, 55800.00),
(183, 32, '2023-07-02', 'Desk',         'Furniture',   2, 76800.00),
(184, 33, '2023-07-16', 'Headphones',   'Accessories', 1, 25200.00),
(185, 34, '2023-07-30', 'Tablet',       'Electronics', 1, 120200.00),
(186, 35, '2023-08-13', 'Monitor',      'Electronics', 1, 80800.00),
(187, 36, '2023-08-27', 'Smartphone',   'Electronics', 1, 190500.00),
(188, 37, '2023-09-10', 'Smartwatch',   'Accessories', 2, 45200.00),
(189, 38, '2023-09-24', 'Laptop',       'Electronics', 1, 360500.00),
(190, 39, '2023-10-08', 'Office Chair', 'Furniture',   1, 56200.00),
(191, 40, '2023-10-22', 'Desk',         'Furniture',   1, 77200.00),
(192, 41, '2023-11-05', 'Headphones',   'Accessories', 3, 24600.00),
(193, 42, '2023-11-19', 'Tablet',       'Electronics', 1, 121500.00),
(194, 43, '2023-12-03', 'Monitor',      'Electronics', 1, 79800.00),
(195, 44, '2023-12-17', 'Smartphone',   'Electronics', 1, 194000.00),
(196, 45, '2023-12-31', 'Smartwatch',   'Accessories', 1, 46200.00),
(197, 46, '2024-10-01', 'Laptop',       'Electronics', 1, 364000.00),
(198, 47, '2024-10-15', 'Office Chair', 'Furniture',   1, 58500.00),
(199, 48, '2024-10-29', 'Desk',         'Furniture',   1, 79200.00),
(200, 49, '2024-11-12', 'Headphones',   'Accessories', 2, 25800.00);


/* ============================================================
   4. ANALYTICAL QUERIES
   ============================================================ */

-- 4.1 Total revenue and order count per customer, highest first
SELECT
    c.CustomerID,
    c.Full_Name,
    c.Country,
    COUNT(o.OrderID)                    AS TotalOrders,
    SUM(o.Quantity * o.Price)           AS TotalRevenue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Full_Name, c.Country
ORDER BY TotalRevenue DESC;


-- 4.2 Top 5 customers by revenue
SELECT TOP 5
    c.Full_Name,
    c.Country,
    SUM(o.Quantity * o.Price) AS TotalRevenue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Full_Name, c.Country
ORDER BY TotalRevenue DESC;


-- 4.3 Monthly revenue trend (business question: is revenue growing?)
SELECT
    FORMAT(o.OrderDate, 'yyyy-MM') AS OrderMonth,
    SUM(o.Quantity * o.Price)      AS MonthlyRevenue,
    COUNT(o.OrderID)               AS OrdersPlaced
FROM Orders o
GROUP BY FORMAT(o.OrderDate, 'yyyy-MM')
ORDER BY OrderMonth;


-- 4.4 Revenue and order count by product category
SELECT
    o.Category,
    COUNT(o.OrderID)          AS OrdersPlaced,
    SUM(o.Quantity)           AS UnitsSold,
    SUM(o.Quantity * o.Price) AS TotalRevenue,
    AVG(o.Price)              AS AvgUnitPrice
FROM Orders o
GROUP BY o.Category
ORDER BY TotalRevenue DESC;


-- 4.5 Revenue by country (market comparison)
SELECT
    c.Country,
    COUNT(DISTINCT c.CustomerID) AS CustomerCount,
    SUM(o.Quantity * o.Price)    AS TotalRevenue,
    SUM(o.Quantity * o.Price) / COUNT(DISTINCT c.CustomerID) AS RevenuePerCustomer
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Country
ORDER BY TotalRevenue DESC;


-- 4.6 Running total of revenue over time, using a window function
SELECT
    o.OrderDate,
    o.OrderID,
    o.Quantity * o.Price AS OrderRevenue,
    SUM(o.Quantity * o.Price) OVER (ORDER BY o.OrderDate ROWS UNBOUNDED PRECEDING) AS RunningTotalRevenue
FROM Orders o
ORDER BY o.OrderDate;


-- 4.7 Rank customers by revenue within their own country
SELECT
    c.Full_Name,
    c.Country,
    SUM(o.Quantity * o.Price) AS TotalRevenue,
    RANK() OVER (PARTITION BY c.Country ORDER BY SUM(o.Quantity * o.Price) DESC) AS RankInCountry
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Full_Name, c.Country
ORDER BY c.Country, RankInCountry;


-- 4.8 Customers who joined but have not placed a single order (LEFT JOIN)
SELECT
    c.CustomerID,
    c.Full_Name,
    c.Country,
    c.JoinDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;


-- 4.9 Average order value (AOV) overall and by category
SELECT
    o.Category,
    SUM(o.Quantity * o.Price) / COUNT(o.OrderID) AS AvgOrderValue
FROM Orders o
GROUP BY o.Category
ORDER BY AvgOrderValue DESC;
