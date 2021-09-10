WITH customers AS (
    SELECT * FROM {{ ref('stage_customers') }}
),

orders AS (
    SELECT * FROM {{ ref('stage_orders') }}
),

customer_orders AS (
    SELECT 
        customer_id,
        MIN(order_delivered_customer_date) AS first_order_date,
        MAX(order_delivered_customer_date) AS most_recent_order_date,
        COUNT(order_id) AS number_of_orders
    FROM
        orders
    GROUP BY
        customer_id
),

final AS (
    SELECT
        customers.customer_id,
        customers.customer_zip_code_prefix,
        customers.customer_city,
        customers.customer_state,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        COALESCE(customer_orders.number_of_orders, 0) AS number_of_orders
    FROM
        customers
    LEFT JOIN
        customer_orders USING (customer_id)
)

SELECT * FROM final