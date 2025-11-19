CREATE TABLE Categories (
    Category_Id INT PRIMARY KEY AUTO_INCREMENT,
    Category_Name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Suppliers (
    Supplier_Id INT PRIMARY KEY AUTO_INCREMENT,
    Supplier_Name VARCHAR(150) NOT NULL,
    Contact_Email VARCHAR(100),
    Phone VARCHAR(20)
);

CREATE TABLE Products (
    Product_Id INT PRIMARY KEY AUTO_INCREMENT,
    Product_Name VARCHAR(200) NOT NULL,
    Category_Id INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Stock_Qty INT NOT NULL DEFAULT 0,
    Supplier_Id INT,
    FOREIGN KEY (Category_Id) REFERENCES Categories(Category_Id) ON DELETE RESTRICT,
    FOREIGN KEY (Supplier_Id) REFERENCES Suppliers(Supplier_Id) ON DELETE SET NULL
);

CREATE TABLE Sales (
    Sale_Id INT PRIMARY KEY AUTO_INCREMENT,
    Product_Id INT NOT NULL,
    Sale_Date DATE NOT NULL,
    Quantity_Sold INT NOT NULL,
    Total_Amount DECIMAL(12, 2) NOT NULL,
    FOREIGN KEY (Product_Id) REFERENCES Products(Product_Id) ON DELETE RESTRICT
);

-- INSERT DATA
INSERT INTO Categories (Category_Name) VALUES
('Sembako'),
('Minuman'),
('Snack & Makanan Ringan'),
('Mie Instan'),
('Susu & Dairy'),
('Bumbu & Penyedap'),
('Sabun & Deterjen'),
('Perawatan Pribadi');


INSERT INTO Suppliers (Supplier_Name, Contact_Email, Phone) VALUES
('PT test1', 'supp@test1.co.id', '021-29345888'),
('PT test2', 'supp@test2.co.id', '031-7508555'),
('PT test3', 'supp@test3.co.id', '021-5245555'),
('PT test4', 'supp@test4.co.id', '021-5307222'),
('PT test5', 'supp@test5.co.id', '021-5366066');


INSERT INTO Products (Product_Name, Category_Id, Price, Stock_Qty, Supplier_Id) VALUES
('Beras Rojolele 5kg', 1, 65000, 25, 1),
('Minyak Goreng Bimoli 2L', 1, 32000, 8, 1),
('Gula Pasir Gulaku 1kg', 1, 15000, 40, 1),
('Telur Ayam Negeri 1kg', 1, 28000, 6, 1),
('Tepung Terigu Segitiga Biru 1kg', 1, 12000, 30, 5),

('Aqua Botol 600ml', 2, 3500, 150, 3),
('Teh Pucuk Harum 350ml', 2, 4000, 120, 1),
('Coca Cola 390ml', 2, 5500, 80, 1),
('Fanta Strawberry 390ml', 2, 5500, 9, 1),
('Pocari Sweat 350ml', 2, 7000, 45, 3),

('Tango Wafer Coklat', 3, 2500, 60, 4),
('Roma Kelapa 300g', 3, 11000, 7, 4),
('Chitato Sapi Panggang 68g', 3, 10500, 35, 5),
('Beng-Beng Coklat', 3, 2500, 85, 4),
('Biskuit Khong Guan Kaleng', 3, 35000, 5, 4),

('Indomie Goreng', 4, 3000, 200, 5),
('Mie Sedaap Goreng', 4, 3000, 180, 2),
('Indomie Soto', 4, 3000, 9, 5),
('Supermie Ayam Bawang', 4, 2500, 150, 5),
('Pop Mie Rasa Ayam', 4, 5500, 8, 5),

('Susu Ultra Milk 1L', 5, 18000, 30, 3),
('Dancow Putih 800g', 5, 56000, 6, 1),
('Indomilk Coklat 190ml', 5, 5000, 95, 5),

('Royco Ayam 100g', 6, 9000, 50, 3),
('Kecap Bango 220ml', 6, 11000, 8, 3),

('Rinso Molto 900g', 7, 24000, 25, 3),
('Sabun Lifebuoy 85g', 7, 4500, 70, 3),
('Soklin Liquid 800ml', 7, 18000, 9, 2),

('Pasta Gigi Pepsodent 190g', 8, 12000, 45, 3),
('Shampo Clear Sachet', 8, 2000, 200, 3);


INSERT INTO Sales (Product_Id, Sale_Date, Quantity_Sold, Total_Amount) VALUES
(1, '2025-09-02', 3, 195000), 
(16, '2025-09-03', 10, 30000), 
(6, '2025-09-03', 12, 42000), 
(7, '2025-09-05', 6, 24000),  
(14, '2025-09-05', 5, 12500), 

(1, '2025-10-01', 2, 130000), 
(16, '2025-10-02', 15, 45000),
(6, '2025-10-04', 24, 84000), 
(2, '2025-10-05', 2, 64000),  
(11, '2025-10-07', 10, 25000),
(26, '2025-10-08', 3, 72000), 
(3, '2025-10-10', 5, 75000),  
(21, '2025-10-12', 8, 144000),
(7, '2025-10-15', 12, 48000), 

(1, '2025-11-01', 4, 260000), 
(16, '2025-11-02', 20, 60000),
(17, '2025-11-03', 15, 45000),
(6, '2025-11-04', 36, 126000),
(14, '2025-11-05', 12, 30000), 
(8, '2025-11-06', 8, 44000),  
(27, '2025-11-07', 5, 22500), 
(24, '2025-11-08', 4, 36000), 
(7, '2025-11-09', 10, 40000), 
(3, '2025-11-10', 8, 120000), 
(13, '2025-11-11', 5, 52500), 
(30, '2025-11-12', 15, 30000),
(19, '2025-11-13', 4, 10000), 
(21, '2025-11-14', 6, 108000),
(29, '2025-11-15', 8, 96000), 
(16, '2025-11-16', 25, 75000); 



