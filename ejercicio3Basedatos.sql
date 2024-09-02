--Crear una vista que contenga todos los clientes junto con los detalles de la última orden realizada.
--Debe incluir aquellos clientes que no han realizado compras (ordenes). La consulta debe retornar el 
--id del cliente, el nombre del cliente, la fecha de la última orden y el total de esa orden.

create view dbo.ListadoClientesUltimaOrden
as
select
    c.CustomerID,
    (c.FirstName + ' ' + c.LastName) as NombreCliente,
    o.OrderDate as FechaUltimaOrden,
    coalesce(sum(od.Quantity * od.UnitPrice), 0) as TotalUltimaOrden
from Customers c
left join Orders o on c.CustomerID = o.CustomerID 
left join OrderDetails od on o.OrderID = od.OrderID
group by c.CustomerID, c.FirstName, c.LastName, o.OrderDate;

select * from dbo.ListadoClientesUltimaOrden order by CustomerID desc