use projetomysql;

show tables;

select * from tbcategorias;

select * from tbclientes;


select * from tbprodutos;

select * from tbpedidos;

select * from tbitenspedidos;

SELECT 
    p.datavenda,
    i.quantidade,
    i.valorvenda,
    (i.quantidade * i.valorvenda) AS total
FROM
    tbpedidos p
        JOIN
    tbitenspedidos i ON p.codigo = i.pedido;
    
use projetomysql;
use projetomysqlstage;
use projetomysqldw;

show tables;

select * from dimtempo;

select * from tbcategorias;

select * from tbitenspedidos;

select * from tbpedidos;

select * from tbprodutos;

select * from tbstgprodutos;

select * from tbstgclientes;

select * from projetomysqldw.dimclientes;

start transaction
update tbstgclientes
set telefone = '48-32334568'
where codigo = 1

desc tbstgclientes

rollback

