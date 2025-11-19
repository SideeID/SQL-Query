SELECT 
    DATE_FORMAT(Sale_Date, '%Y-%m') AS Periode,
    DATE_FORMAT(Sale_Date, '%M %Y') AS Bulan,
    COUNT(Sale_Id) AS Jumlah_Transaksi,
    SUM(Quantity_Sold) AS Total_Item_Terjual,
    CONCAT('Rp ', FORMAT(SUM(Total_Amount), 0)) AS Total_Pendapatan
FROM Sales
GROUP BY DATE_FORMAT(Sale_Date, '%Y-%m'), DATE_FORMAT(Sale_Date, '%M %Y')
ORDER BY Periode;