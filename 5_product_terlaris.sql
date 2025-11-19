SELECT
	p.Product_Id,
	p.Product_Name,
	c.Category_Name,
	SUM(s.Quantity_Sold) AS Total_Terjual,
	CONCAT('Rp ', FORMAT(SUM(s.Total_Amount), 0)) AS Total_Pendapatan
FROM Sales s
JOIN Products p ON s.Product_Id = p.Product_Id 
JOIN Categories c ON p.Category_Id = c.Category_Id 
GROUP BY p.Product_Id, p.Product_Name, c.Category_Name 
ORDER BY Total_Terjual DESC 
LIMIT 5;

-- Tabel view 