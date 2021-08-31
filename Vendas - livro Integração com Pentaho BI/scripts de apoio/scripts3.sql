update tbstgclientes
set telefone = '48-00000090'
where codigo = 1

select * from dimtempo;

select * from tbstgclientes

select * from tbstgcategorias

desc projetomysqldw.dimclientes

select * from projetomysqldw.dimclientes

select * from projetomysqldw.dimcategorias

select * from projetomysqldw.dimprodutos

select * from projetomysqldw.dimtempo

delete from projetomysqldw.dimclientes

SELECT 
    codigo,
    Nome,
    Endereco,
    Telefone,
    Email,
    DataNascimento,
    CAST(DATE_FORMAT(DataNascimento, '%Y-%m-%d') AS CHAR) AS 'DataNascimento'
FROM
    tbstgclientes
    
alter table tbstgclientes
modify column DataNascimento datetime

SELECT *, AUTO_INCREMENT FROM information_schema.tables
WHERE table_name = 'dimclientes' AND table_schema = 'projetomysqldw';

ALTER TABLE projetomysqldw.dimclientes AUTO_INCREMENT = 0;



update information_schema.tables
set auto_increment = 0
where table_schema = 'projetomysql' and table_name = 'dimclientes';

GRANT SELECT, INSERT, UPDATE, DELETE ON projetomysql.* TO 'root'@'localhost' WITH GRANT OPTION;

DROP TABLE IF EXISTS dimclientes;

use mysql;

select * from user;

truncate table user;

flush privileges;

grant all privileges on *.* to root@localhost identified by 'Plutao@20' with grant option;
