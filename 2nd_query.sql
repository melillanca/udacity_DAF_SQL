SELECT DATE_TRUNC('month', p.payment_date) pay_mon
      ,t.fullname as fullname
      ,COUNT(p.*) AS pay_countpermonth
      ,SUM(p.amount) AS pay_amount
  FROM payment p
  JOIN (
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
 GROUP BY pay_mon, fullname
 ORDER BY fullname ASC