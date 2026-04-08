-- Q1 Revenue by channel
SELECT sales_channel,
SUM(amount) total_revenue
FROM clinic_sales
WHERE EXTRACT(YEAR FROM datetime)=2021
GROUP BY sales_channel;

-- Q2 Top 10 customers
SELECT uid,
SUM(amount) total_spent
FROM clinic_sales
WHERE EXTRACT(YEAR FROM datetime)=2021
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;

-- Q3 Revenue, Expense, Profit
WITH r AS (
SELECT EXTRACT(MONTH FROM datetime) m,
SUM(amount) revenue
FROM clinic_sales
GROUP BY m
),
e AS (
SELECT EXTRACT(MONTH FROM datetime) m,
SUM(amount) expense
FROM expenses
GROUP BY m
)
SELECT r.m,
r.revenue,
e.expense,
(r.revenue-e.expense) profit,
CASE WHEN (r.revenue-e.expense)>0 THEN 'Profitable'
ELSE 'Loss'
END status
FROM r JOIN e ON r.m=e.m;

-- Q4 Most profitable clinic
WITH cte AS (
SELECT c.city,c.cid,
SUM(cs.amount)-COALESCE(SUM(e.amount),0) profit
FROM clinics c
JOIN clinic_sales cs ON c.cid=cs.cid
LEFT JOIN expenses e ON c.cid=e.cid
GROUP BY c.city,c.cid
),
ranked AS (
SELECT *,
RANK() OVER (PARTITION BY city ORDER BY profit DESC) rnk
FROM cte
)
SELECT * FROM ranked WHERE rnk=1;

-- Q5 2nd least profitable clinic
WITH cte AS (
SELECT c.state,c.cid,
SUM(cs.amount)-COALESCE(SUM(e.amount),0) profit
FROM clinics c
JOIN clinic_sales cs ON c.cid=cs.cid
LEFT JOIN expenses e ON c.cid=e.cid
GROUP BY c.state,c.cid
),
ranked AS (
SELECT *,
DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) rnk
FROM cte
)
SELECT * FROM ranked WHERE rnk=2;
