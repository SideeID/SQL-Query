SELECT 
	c.Category_Name AS 'Kategori',
    COUNT(DISTINCT p.Product_Id) AS 'Jumlah Jenis Produk',
    COUNT(s.Sale_Id) AS 'Total Transaksi',
    COALESCE(SUM(s.Quantity_Sold), 0) AS 'Total Item Terjual',
    COALESCE(ROUND(AVG(s.Quantity_Sold), 2), 0) AS 'Rata-rata QTY/Transaksi',
    CONCAT('Rp ', FORMAT(COALESCE(SUM(s.Total_Amount), 0), 0)) AS 'Total Pendapatan',
    CONCAT('Rp ', FORMAT(COALESCE(AVG(s.Total_Amount), 0), 0)) AS 'Rata-rata Pendapatan/Transaksi'
FROM Categories c
LEFT JOIN Products p ON c.Category_Id = p.Category_Id
LEFT JOIN Sales s ON p.Product_Id = s.Product_Id
GROUP BY c.Category_Id, c.Category_Name
ORDER BY SUM(s.Total_Amount) DESC;