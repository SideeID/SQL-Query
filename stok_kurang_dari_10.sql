SELECT 
	p.Product_Id,
    p.Product_Name,
    c.Category_Name,
    p.Stock_Qty AS 'Stock Tersisa',
    CONCAT('Rp ', FORMAT(p.Price, 0)) AS 'Harga Satuan',
    s.Supplier_Name AS 'Nama Supplier',
    s.Phone AS 'Telp Supplier'
FROM Products p 
JOIN Categories c ON p.Category_Id = c.Category_Id 
LEFT JOIN Suppliers s ON p.Supplier_Id = s.Supplier_Id 
WHERE p.Stock_Qty < 10
ORDER BY p.Stock_Qty ASC;