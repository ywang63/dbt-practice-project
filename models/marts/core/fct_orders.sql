WITH 

orders AS(
SELECT * FROM {{ref('stg_orders')}}
),

payments AS(
    SELECT * FROM {{ref('stg_payments')}}
),

order_payments AS(
    SELECT order_id,
    SUM(CASE WHEN status = 'success' THEN amount ELSE 0 END) AS amount
    FROM payments
    GROUP BY 1
),

final AS (
    SELECT 
    orders.order_id, 
    orders.customer_id, 
    orders.order_date, 
    order_payments.amount
FROM orders, order_payments
WHERE orders.order_id = order_payments.order_id
)

SELECT * FROM final