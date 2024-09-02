-- Crear una vista que retorne el listado de todos los clientes junto con los detalles de sus compras 
--(ordenes) siempre y cuando la compra este pendiente. Debe incluir también aquellos clientes que nunca
--han hecho una orden. La consulta debe retornar el id del cliente, el nombre del cliente, la orden (id) 
--y el monto total pendiente

create view dbo.ListadoClientes
as
select
	c.CustomerID,
	(c.FirstName + ' ' + c.LastName) as NombreCliente,
	o.OrderID,
	coalesce(sum(od.Quantity * od.UnitPrice), 0) as MontoTotalPendiente
from Customers c
left join Orders o on c.CustomerID = o.CustomerID and o.Status = 'Pending'
left join OrderDetails od on o.OrderID =od.OrderID
group by c.CustomerID, c.FirstName, c.LastName, o.OrderID

select * from dbo.ListadoClientes order by OrderID desc