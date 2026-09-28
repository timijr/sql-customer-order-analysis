# Customer & Order Sales Analysis (SQL Server)

## Business Problem
A retail business sells electronics, furniture and accessories in Nigeria, Ghana, Kenya, South Africa and Cameroon. This project uses SQL to answer: which customers and countries bring in the most revenue, how are sales trending month by month, and which product categories perform best?

## Dataset
Two related tables that I designed and filled with sample data myself:
- **Customers** (50 records): name, contact details, join date, country
- **Orders** (100 records): product, category, quantity, price and order date, linked to customers by a foreign key

The data is sample data I created for practice. It is not from a real company.

## Tools
SQL Server (T-SQL)

## Skills Used
- Table design with primary keys, foreign keys and data types
- INNER JOIN and LEFT JOIN
- SUM, COUNT, AVG and GROUP BY
- Window functions: running total (SUM OVER) and ranking (RANK OVER PARTITION BY)
- Monthly trends using FORMAT()

## Queries and the Questions They Answer
| Query | Question |
|---|---|
| Revenue per customer | Who are the most valuable customers? |
| Top 5 customers | Who should be prioritised for retention? |
| Monthly revenue trend | Is revenue growing month by month? |
| Revenue by category | Which product lines earn the most? |
| Revenue by country | Which markets are strongest, and what is the revenue per customer in each? |
| Running total of revenue | How does revenue build up over time? |
| Customer rank within country | Who is the top customer in each market? |
| Customers with no orders | Who signed up but never bought? |
| Average order value by category | Which categories have the biggest orders? |

## Findings
- Electronics brings in about 10.6M of the roughly 14M total revenue, with an average order value of about 208,000.
- Accessories has the smallest average order value, about 58,000.
- Suggestion: promote accessories together with electronics purchases to raise the value of each order.

## Files
- `Customer_Order_Analysis.sql`: the full script (tables, sample data and all queries)

## Author
Bello Ridwan Oluwadamilare, Data Analyst (University of Ilorin)
