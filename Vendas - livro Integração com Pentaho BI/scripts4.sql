select * from tbcategorias;
select * from tbclientes;
select * from tbpedidos;
select * from tbitenspedidos;
select * from tbprodutos;

delete from tbcategorias;
delete from tbclientes;
delete from tbpedidos;
delete from tbitenspedidos;
delete from tbprodutos;

select * from factpedidos;
desc factpedidos;

select * from tbstgpedidos;
select * from tbstgitenspedidos;

select * from projetomysqldw.dimclientes
where (('2016-04-25 10:37:22' between datainicio and datafim)
or (version=1)) and codigoext = 1
order by version desc;


SELECT 
    (SELECT 
            c.codigo
        FROM
            projetomysqldw.dimclientes c
        WHERE
            ((p.datavenda BETWEEN c.datainicio AND c.datafim)
                OR (c.version = 1))
                AND c.codigoext = 1
        ORDER BY version DESC
        LIMIT 1) AS cliente,
    datavenda,
    CAST(DATE_FORMAT(datavenda, '%Y-%m-%d') AS CHAR) AS 'data',
    (SELECT 
            p2.codigo
        FROM
            projetomysqldw.dimprodutos p2
        WHERE
            p2.codigoext = i.produto
                AND ((p.datavenda BETWEEN p2.datainicio AND p2.datafim)
                OR (p2.version = 1))
        ORDER BY version DESC
        LIMIT 1) AS 'produto',
    p.codigo AS pedido,
    i.quantidade,
    i.valorvenda
FROM
    projetomysqlstage.tbstgpedidos p
        JOIN
    projetomysqlstage.tbstgitenspedidos i ON (p.codigo = i.pedido)


select * from factpedidos;
delete from factpedidos;

select * from tbstgitenspedidos

select * from tbstgpedidos

select * from tbitenspedidos

select * from tbpedidos

select * from tbstgprodutos

select * from dimprodutos

SELECT *
FROM information_schema.`REFERENTIAL_CONSTRAINTS` a
WHERE a.`CONSTRAINT_SCHEMA` = 'projetomysqldw' AND a.`TABLE_NAME` = 'dimprodutos'

select * from dimprodutos

select * from dimtempo

select * from tbstgprodutos