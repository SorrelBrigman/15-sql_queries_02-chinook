-- Use the Chinook Database and the DB Browser for SQLite we downloaded in the ERD exercise.

-- For each of the following exercises, provide the appropriate query.

-- Keep your successful queries in a chinook-queries.sql file.

-- Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT firstName || " " || lastname AS Name, customerId, Country
FROM Customer
WHERE Country <> "USA"
-- Provide a query only showing the Customers from Brazil.
SELECT firstName || " " || lastname AS Name, customerId, Country
FROM Customer
WHERE Country = "Brazil"
-- Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT c.firstName || " " || c.lastname AS Name, invoiceID, BillingCountry
FROM Customer c, invoice
WHERE c.Country = "Brazil"
-- Provide a query showing only the Employees who are Sales Agents.
SELECT firstname || " " || lastName AS "Employee Name", title
FROM Employee
Where title = "Sales Support Agent"
-- Provide a query showing a unique list of billing countries from the Invoice table.
SELECT BillingCountry
FROM Invoice
GROUP BY BillingCountry
-- Provide a query showing the invoices of customers who are from Brazil.
SELECT * FROM invoice
JOIN Customer ON invoice.customerId = Customer.customerId
WHERE customer.country = "Brazil"
-- Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT  *, employee.firstName || " " || employee.lastName AS "Sales Agent"
FROM Invoice
JOIN customer ON customer.customerId = invoice.customerId
LEFT JOIN Employee ON customer.supportrepId = employee.employeeId
ORDER BY employee.lastName
-- Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
SELECT  invoice.total AS "Invoice Total", customer.FirstName || " " || customer.lastname AS "Customer Name", customer.country, employee.firstName || " " || employee.lastName AS "Sales Agent"
FROM Invoice
JOIN customer ON customer.customerId = invoice.customerID
LEFT JOIN Employee ON customer.supportrepId = employee.employeeId
ORDER BY customer.lastName
-- How many Invoices were there in 2009 and 2011? What are the respective total sales for each of those years?
SELECT strftime('%Y', invoiceDate) AS "Year",  COUNT(invoiceId) AS "Number of Invoices", SUM(Total) AS "Total Sales"
FROM invoice
WHERE (invoice.invoicedate LIKE '2009%'  OR invoice.invoicedate LIKE '2011%')
GROUP BY  DATE(invoice.invoicedate, 'start of year');
-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
SELECT COUNT(invoiceLineId) AS "Number of line item", invoiceId AS "Invoice Number"
FROM invoiceline
WHERE invoiceId = "37"
-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY
-- Provide a query that includes the track name with each invoice line item.
-- Provide a query that includes the purchased track name AND artist name with each invoice line item.
-- Provide a query that shows the # of invoices per country. HINT: GROUP BY
-- Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resultant table.
-- Provide a query that shows all the Tracks, but displays no IDs. The resultant table should include the Album name, Media type and Genre.
-- Provide a query that shows all Invoices but includes the # of invoice line items.
-- Provide a query that shows total sales made by each sales agent.
-- Which sales agent made the most in sales in 2009?
-- Which sales agent made the most in sales in 2010?
-- Which sales agent made the most in sales over all?
-- Provide a query that shows the # of customers assigned to each sales agent.
-- Provide a query that shows the total sales per country. Which country's customers spent the most?
-- Provide a query that shows the most purchased track of 2013.
-- Provide a query that shows the top 5 most purchased tracks over all.
-- Provide a query that shows the top 3 best selling artists.
-- Provide a query that shows the most purchased Media Type.
