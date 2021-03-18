SELECT p.customer_id
      ,TO_CHAR(p.payment_date, 'MM') AS mon
      ,t.fullname, SUM(p.amount) AS monthly_amount
      ,SUM(p.amount) - LAG(SUM(p.amount)) OVER (PARTITION BY p.customer_id ORDER BY 2) AS diff
  FROM payment p
 RIGHT JOIN (
 	SELECT p.customer_id
          ,CONCAT(c.first_name, ' ', c.last_name) AS fullname
          ,SUM(p.amount) AS pay_amount
  	  FROM payment p
  	  JOIN customer c
  		ON c.customer_id = p.customer_id
  	 GROUP BY p.customer_id, fullname
  	 ORDER BY pay_amount DESC
  	 LIMIT 10
	) t
	ON p.customer_id = t.customer_id
 WHERE DATE_PART('year', p.payment_date) = 2007
 GROUP BY 1,2,3
 ORDER BY 1,2