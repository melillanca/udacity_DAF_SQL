SELECT c.name AS category
      ,DATE_TRUNC('month', r.rental_date) AS mon
      ,COUNT(c.category_id) AS rents_by_month
  FROM category c
  JOIN film_category fc
    ON c.category_id = fc.category_id
  JOIN film f
    ON fc.film_id = f.film_id
  JOIN inventory i
    ON f.film_id = i.film_id
  JOIN rental r
    ON i.inventory_id = r.inventory_id
 GROUP BY 1,2