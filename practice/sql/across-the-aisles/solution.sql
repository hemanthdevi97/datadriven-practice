/*
SELECT users.user_id,
COUNT(distinct products.category) as category_count
FROM users
JOIN transactions ON users.user_id = transactions.user_id
JOIN products ON transactions.product_id = products.product_id
WHERE products.category is not null
GROUP BY users.user_id
HAVING COUNT(distinct products.category) > 1
ORDER BY users.signup_date asc, category_count desc
*/


SELECT u.user_id, count(distinct p.category) as category_count
FROM users  u
join transactions t on t.user_id=u.user_id
join products p on p.product_id=t.product_id
where p.category is not null
group by u.user_id
having category_count>1
order by u.signup_date asc, category_count desc
