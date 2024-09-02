--Crear una vista que retorne el listado todos los autores junto con su libro m�s popular
--(debe retornarlo seg�n el total de ventas). Debe incluir adem�s aquellos autores que no han vendido ning�n 
--libro. La vista debe retornar la siguiente informaci�n el id del libro, autor, libro m�s vendido y las unidades vendidas.

create view dbo.ListadoAutores
as
select
	b.BookID,
	b.Author,
	b.Title,
	coalesce(sum(od.Quantity), 0) as UnidadesVendidas
from Books b
left join OrderDetails od on b.BookID = od.BookID
group by b.BookID, b.Author, b.Title

select * from dbo.ListadoAutores order by Author desc