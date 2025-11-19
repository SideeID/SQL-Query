-- Table View 1: Produk Terlaris
CREATE OR REPLACE VIEW vw_produk_terlaris AS
SELECT
    p.Product_Id,
    p.Product_Name,
    c.Category_Name,
    SUM(s.Quantity_Sold) AS Total_Terjual,
    SUM(s.Total_Amount) AS Total_Pendapatan_Raw,
    CONCAT('Rp ', FORMAT(SUM(s.Total_Amount), 0)) AS Total_Pendapatan
FROM Sales s
JOIN Products p ON s.Product_Id = p.Product_Id 
JOIN Categories c ON p.Category_Id = c.Category_Id 
GROUP BY p.Product_Id, p.Product_Name, c.Category_Name 
ORDER BY Total_Terjual DESC;
-- SELECT * FROM vw_produk_terlaris LIMIT 5;

-- Table View 2: Pendapatan Bulanan
CREATE OR REPLACE VIEW vw_pendapatan_bulanan AS
SELECT 
    DATE_FORMAT(Sale_Date, '%Y-%m') AS Periode,
    DATE_FORMAT(Sale_Date, '%M %Y') AS Bulan,
    YEAR(Sale_Date) AS Tahun,
    MONTH(Sale_Date) AS Bulan_Num,
    COUNT(Sale_Id) AS Jumlah_Transaksi,
    SUM(Quantity_Sold) AS Total_Item_Terjual,
    SUM(Total_Amount) AS Total_Pendapatan_Raw,
    CONCAT('Rp ', FORMAT(SUM(Total_Amount), 0)) AS Total_Pendapatan,
    CONCAT('Rp ', FORMAT(AVG(Total_Amount), 0)) AS Rata2_Per_Transaksi
FROM Sales
GROUP BY 
    DATE_FORMAT(Sale_Date, '%Y-%m'), 
    DATE_FORMAT(Sale_Date, '%M %Y'),
    YEAR(Sale_Date),
    MONTH(Sale_Date)
ORDER BY Periode;
-- SELECT * FROM vw_pendapatan_bulanan;
-- SELECT * FROM vw_pendapatan_bulanan WHERE Tahun = 2025;

-- Table View 3: Produk Perlu Restock
CREATE OR REPLACE VIEW vw_produk_perlu_restock AS
SELECT 
    p.Product_Id,
    p.Product_Name,
    c.Category_Name,
    p.Stock_Qty AS Stock_Tersisa,
    p.Price AS Harga_Satuan_Raw,
    CONCAT('Rp ', FORMAT(p.Price, 0)) AS Harga_Satuan,
    s.Supplier_Name AS Nama_Supplier,
    s.Contact_Email AS Email_Supplier,
    s.Phone AS Telp_Supplier,
    CASE 
        WHEN p.Stock_Qty = 0 THEN 'HABIS - URGENT!'
        WHEN p.Stock_Qty <= 5 THEN 'KRITIS'
        WHEN p.Stock_Qty < 10 THEN 'RENDAH'
    END AS Status_Stock
FROM Products p 
JOIN Categories c ON p.Category_Id = c.Category_Id 
LEFT JOIN Suppliers s ON p.Supplier_Id = s.Supplier_Id 
WHERE p.Stock_Qty < 10
ORDER BY p.Stock_Qty ASC;
-- SELECT * FROM vw_produk_perlu_restock;
-- SELECT * FROM vw_produk_perlu_restock WHERE Status_Stock = 'HABIS - URGENT!';


-- Table View 4: Rata-rata Penjualan per Kategori
CREATE OR REPLACE VIEW vw_analisis_per_kategori AS
SELECT 
    c.Category_Id,
    c.Category_Name AS Kategori,
    COUNT(DISTINCT p.Product_Id) AS Jumlah_Jenis_Produk,
    COUNT(s.Sale_Id) AS Total_Transaksi,
    COALESCE(SUM(s.Quantity_Sold), 0) AS Total_Item_Terjual,
    COALESCE(ROUND(AVG(s.Quantity_Sold), 2), 0) AS Rata2_Qty_Per_Transaksi,
    COALESCE(SUM(s.Total_Amount), 0) AS Total_Pendapatan_Raw,
    CONCAT('Rp ', FORMAT(COALESCE(SUM(s.Total_Amount), 0), 0)) AS Total_Pendapatan,
    CONCAT('Rp ', FORMAT(COALESCE(AVG(s.Total_Amount), 0), 0)) AS Rata2_Pendapatan_Per_Transaksi,
    CASE 
        WHEN COALESCE(SUM(s.Total_Amount), 0) = 0 THEN 'Tidak Ada Penjualan'
        WHEN COALESCE(SUM(s.Total_Amount), 0) < 100000 THEN 'Low Performer'
        WHEN COALESCE(SUM(s.Total_Amount), 0) BETWEEN 100000 AND 500000 THEN 'Medium Performer'
        ELSE 'Top Performer'
    END AS Performance_Status
FROM Categories c
LEFT JOIN Products p ON c.Category_Id = p.Category_Id
LEFT JOIN Sales s ON p.Product_Id = s.Product_Id
GROUP BY c.Category_Id, c.Category_Name
ORDER BY Total_Pendapatan_Raw DESC;
-- SELECT * FROM vw_analisis_per_kategori;