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
SELECT COUNT(invoiceLineId) AS "Number of line item", invoiceId AS "Invoice Number"
FROM invoiceline
GROUP BY invoiceid
-- Provide a query that includes the track name with each invoice line item.
SELECT invL.invoiceLineId AS "Invoice line", t.name AS "Track Name"
FROM InvoiceLine invL
JOIN track t ON t.trackId = invL.trackId
ORDER BY invL.invoiceLineId
-- Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT invL.invoiceLineId AS "Invoice line", t.name AS "Track Name", art.Name AS "Artist"
FROM InvoiceLine invL
JOIN track t ON t.trackId = invL.trackId
JOIN album ON t.albumId = album.albumId
JOIN artist art ON art.artistId = album.artistId
ORDER BY invL.invoiceLineId
-- Provide a query that shows the # of invoices per country. HINT: GROUP BY
SELECT COUNT(invoice.invoiceId) AS "Number of Invoices", c.country AS "Country"
FROM invoice
JOIN customer c ON invoice.customerid = c.customerid
GROUP BY c.country
-- Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resultant table.
SELECT p.name AS "Playlist Name",  COUNT(pt.trackId)
FROM playlist p
JOIN playlistTrack pt on pt.playlistId = p.playlistId
GROUP BY p.name
-- Provide a query that shows all the Tracks, but displays no IDs. The resultant table should include the Album name, Media type and Genre.
SELECT t.name AS "Track Name", a.Title AS "Album", g.name AS "Genre", m.name AS "Media Type"
FROM Track t
JOIN album a ON t.albumID = a.albumId
JOIN genre g ON t.genreId = g.genreId
JOIN mediatype m ON t.mediaTypeId = m.mediaTypeId
-- Provide a query that shows all Invoices but includes the # of invoice line items.
SELECT Invoice.invoiceId AS "Invoice #", COUNT(invoiceLine.invoiceLineId) AS "Number of Invoice Lines"
FROM Invoice
JOIN invoiceLine ON Invoice.invoiceId = invoiceline.invoiceId
GROUP BY Invoice.invoiceId
-- Provide a query that shows total sales made by each sales agent.
SELECT E.firstname || " " || E.lastName AS "Employee", SUM(Inv.Total)
FROM Employee E
JOIN Customer C ON C.SupportRepId = E.EmployeeId
JOIN Invoice Inv ON Inv.customerId = C.customerID
Group By E.lastName
-- Which sales agent made the most in sales in 2009?
SELECT E.firstname || " " || E.lastName AS "Employee", SUM(Inv.Total) AS "Total Sales"
FROM Employee E
JOIN Customer C ON C.SupportRepId = E.EmployeeId
JOIN Invoice Inv ON Inv.customerId = C.customerID
WHERE inv.invoiceDate LIKE '2009%'
Group By E.lastName
ORDER BY SUM(inv.Total) DESC
LIMIT 1
-- Which sales agent made the most in sales in 2010?
SELECT E.firstname || " " || E.lastName AS "Employee", SUM(Inv.Total) AS "Total Sales"
FROM Employee E
JOIN Customer C ON C.SupportRepId = E.EmployeeId
JOIN Invoice Inv ON Inv.customerId = C.customerID
WHERE inv.invoiceDate LIKE '2010%'
Group By E.lastName
ORDER BY SUM(inv.Total) DESC
LIMIT 1
-- Which sales agent made the most in sales over all?
SELECT E.firstname || " " || E.lastName AS "Employee", SUM(Inv.Total) AS "Total Sales"
FROM Employee E
JOIN Customer C ON C.SupportRepId = E.EmployeeId
JOIN Invoice Inv ON Inv.customerId = C.customerID
Group By E.lastName
ORDER BY SUM(inv.Total) DESC
LIMIT 1
-- Provide a query that shows the # of customers assigned to each sales agent.
SELECT E.employeeId, E.firstName || " " || E.LastName AS "Sales Agent", COUNT(C.CustomerId) AS "Number of Customers"
FROM Employee E
JOIN Customer C ON C.supportRepId = E.employeeId
GROUP BY E.lastName
-- Provide a query that shows the total sales per country. Which country's customers spent the most?
SELECT C.Country, SUM(I.total)
FROM Customer C
JOIN Invoice I ON I.customerid = c.customerId
GROUP BY C.Country
ORDER BY SUM(I.total) DESC
LIMIT 1
--LIMIT 1 shows the country whose customers spend the most


-- Provide a query that shows the most purchased track of 2013.
SELECT t.Name, SUM(Inv.Quantity)
FROM track t
JOIN InvoiceLine Inv ON Inv.trackId = t.trackId
JOIN Invoice ON Inv.invoiceId = invoice.invoiceId
WHERE invoice.invoiceDate LIKE '2013%'
GROUP BY t.Name
-- Provide a query that shows the top 5 most purchased tracks over all.
SELECT t.Name, SUM(Inv.Quantity)
FROM track t
JOIN InvoiceLine Inv ON Inv.trackId = t.trackId
JOIN Invoice ON Inv.invoiceId = invoice.invoiceId
GROUP BY t.Name
ORDER BY SUM(Inv.Quantity) DESC
LIMIT 5
-- Provide a query that shows the top 3 best selling artists.
SELECT a.NAME AS 'Artist', SUM(Inv.Quantity) AS 'Tracks Sold'
FROM artist a
JOIN album ON Album.artistID = a.artistId
JOIN track ON Album.albumId = track.albumId
JOIN InvoiceLine Inv ON Inv.trackId = track.trackId
JOIN Invoice ON Inv.invoiceId = invoice.invoiceId
GROUP BY a.Name
ORDER BY SUM(Inv.Quantity) DESC
LIMIT 3
-- Provide a query that shows the most purchased Media Type.
SELECT m.NAME AS 'media type', SUM(Inv.Quantity) AS 'Units Sold'
FROM MediaType m
JOIN Track ON Track.mediaTypeId = m.mediatypeId
JOIN InvoiceLine Inv ON Inv.trackId = track.trackId
JOIN Invoice ON Inv.invoiceId = invoice.invoiceId
GROUP BY m.Name
ORDER BY SUM(Inv.Quantity) DESC
LIMIT 1
