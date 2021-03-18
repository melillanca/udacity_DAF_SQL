SELECT DATE_PART('year', r.rental_date) AS rental_year
      ,DATE_PART('month', r.rental_date) AS rental_mon
      ,so.store_id, COUNT(*) as count_rentals
  FROM rental r
  JOIN staff sa
    ON r.staff_id = sa.staff_id
  JOIN store so
    ON sa.store_id = so.store_id
 GROUP BY year, mon, so.store_id
 ORDER BY count_rentals DESC