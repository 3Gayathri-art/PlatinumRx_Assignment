-- Q1: Last booked room
SELECT user_id, room_no
FROM (
    SELECT user_id, room_no,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY booking_date DESC) rn
    FROM bookings
) t
WHERE rn = 1;

-- Q2: Total billing in Nov 2021
SELECT bc.booking_id,
SUM(bc.item_quantity * i.item_rate) AS total_bill
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE EXTRACT(MONTH FROM bc.bill_date)=11
AND EXTRACT(YEAR FROM bc.bill_date)=2021
GROUP BY bc.booking_id;

-- Q3: Bills >1000 in Oct
SELECT bc.bill_id,
SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE EXTRACT(MONTH FROM bc.bill_date)=10
AND EXTRACT(YEAR FROM bc.bill_date)=2021
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate)>1000;

-- Q4: Most & Least ordered items
WITH item_orders AS (
SELECT EXTRACT(MONTH FROM bill_date) month,
item_id,
SUM(item_quantity) total_qty
FROM booking_commercials
WHERE EXTRACT(YEAR FROM bill_date)=2021
GROUP BY month,item_id
),
ranked AS (
SELECT *,
RANK() OVER (PARTITION BY month ORDER BY total_qty DESC) r1,
RANK() OVER (PARTITION BY month ORDER BY total_qty ASC) r2
FROM item_orders
)
SELECT * FROM ranked WHERE r1=1 OR r2=1;

-- Q5: 2nd highest bill
WITH bills AS (
SELECT b.user_id,
bc.bill_id,
EXTRACT(MONTH FROM bc.bill_date) month,
SUM(bc.item_quantity*i.item_rate) total_bill
FROM booking_commercials bc
JOIN bookings b ON bc.booking_id=b.booking_id
JOIN items i ON bc.item_id=i.item_id
WHERE EXTRACT(YEAR FROM bc.bill_date)=2021
GROUP BY b.user_id,bc.bill_id,month
),
ranked AS (
SELECT *,
DENSE_RANK() OVER (PARTITION BY month ORDER BY total_bill DESC) rnk
FROM bills
)
SELECT * FROM ranked WHERE rnk=2;
