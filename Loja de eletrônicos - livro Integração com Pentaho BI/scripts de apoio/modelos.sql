-- OLTP

DROP SCHEMA IF EXISTS projetomysql;
CREATE SCHEMA IF NOT EXISTS projetomysql
DEFAULT CHARACTER SET utf8mb4;

USE projetomysql;

DROP TABLE IF EXISTS projetomysql.tblcategorias;

CREATE TABLE IF NOT EXISTS projetomysql.tbcategorias(
   codigo INT NOT NULL AUTO_INCREMENT,
   descricao VARCHAR (150) NULL DEFAULT NULL,
   PRIMARY KEY (codigo)
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

DROP TABLE IF EXISTS projetomysql.tbclientes;

CREATE TABLE IF NOT EXISTS projetomysql.tbclientes(
   codigo INT NOT NULL AUTO_INCREMENT,
   nome VARCHAR(100) NULL DEFAULT NULL,
   endereco VARCHAR(250) NULL DEFAULT NULL,
   telefone VARCHAR(25) NULL DEFAULT NULL,
   email VARCHAR(100) NULL DEFAULT NULL,
   datanascimento timestamp NULL DEFAULT NULL,
   PRIMARY KEY (codigo)) ENGINE = InnoDB
   DEFAULT CHARACTER SET = utf8mb4;
   
DROP TABLE IF EXISTS projetomysql.tbprodutos;

CREATE TABLE IF NOT EXISTS projetomysql.tbprodutos(
   codigo INT NOT NULL AUTO_INCREMENT,
   descricao VARCHAR(150) NULL DEFAULT NULL,
   valorvenda DECIMAL (18,2) NULL DEFAULT NULL,
   ativo INT NULL DEFAULT NULL, 
   categoria INT NULL DEFAULT NULL,
   PRIMARY KEY (codigo),
   INDEX fkprodutocategoria(categoria ASC),
   CONSTRAINT fkprodutocategoria
   FOREIGN KEY (categoria)
   REFERENCES projetomysql.tbcategorias(codigo)
   ON DELETE SET NULL
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

DROP TABLE IF EXISTS projetomysql.tbpedidos;

CREATE TABLE IF NOT EXISTS projetomysql.tbpedidos(
   codigo INT NOT NULL AUTO_INCREMENT,
   cliente INT NULL DEFAULT NULL,
   datavenda timestamp NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (codigo),
   CONSTRAINT fkpedidocliente
   FOREIGN KEY (cliente)
   REFERENCES projetomysql.tbclientes (codigo)
   ON DELETE SET NULL)
   ENGINE = InnoDB
   DEFAULT CHARACTER SET = utf8mb4;
	

DROP TABLE IF EXISTS projetomysql.tbitenspedidos;

CREATE TABLE IF NOT EXISTS projetomysql.tbitenspedidos(
   produto INT NULL DEFAULT NULL,
   pedido INT NULL DEFAULT NULL,
   quantidade INT NULL DEFAULT NULL,
   valorvenda DECIMAL (18,2) NULL DEFAULT NULL,
   INDEX fkprodutoitens (produto ASC),
   INDEX fkPedido (pedido ASC),
   CONSTRAINT fkprodutoitens
   FOREIGN KEY (produto)
   REFERENCES projetomysql.tbprodutos(codigo)
   ON DELETE SET NULL,
   CONSTRAINT fkPedido
      FOREIGN KEY (pedido)
      REFERENCES projetomysql.tbpedidos(codigo)
      ON DELETE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- STAGE

SET
@OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS,
UNIQUE_CHECKS = 0;

SET
@OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS,
FOREIGN_KEY_CHECKS = 0;

SET @OLD_SQL_MODE=@@SQL_MODE,
SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS projetomysqlstage;
CREATE SCHEMA IF NOT EXISTS projetomysqlstage
DEFAULT CHARACTER SET utf8mb4;

USE projetomysqlstage;

DROP TABLE IF EXISTS projetomysql.tbstgcategorias;

CREATE TABLE IF NOT EXISTS projetomysqlstage.tbstgcategorias(
   codigo INT,
   descricao VARCHAR(150) NULL DEFAULT NULL)
ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8mb4;

DROP TABLE IF EXISTS projetomysqlstage.tbstgclientes;

CREATE TABLE IF NOT EXISTS projetomysqlstage.tbstgclientes(
    codigo INT,
    Nome VARCHAR(100) NULL DEFAULT NULL,
    Endereco VARCHAR(250) NULL DEFAULT NULL,
    Telefone VARCHAR(25) NULL DEFAULT NULL,
    Email VARCHAR(100) NULL DEFAULT NULL,
    DataNascimento timestamp NULL DEFAULT NULL
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

DROP TABLE IF EXISTS projetomysqlstage.tbstgprodutos;

CREATE TABLE IF NOT EXISTS projetomysqlstage.tbstgprodutos(
    codigo INT,
    descricao VARCHAR(150) NULL DEFAULT NULL,
    valorvenda DECIMAL(18,2) NULL DEFAULT NULL,
    ativo INT NULL DEFAULT '1',
    categoria INT NULL DEFAULT NULL,
    INDEX fkprodutocategoria(categoria ASC)
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

DROP TABLE IF EXISTS projetomysqlstage.tbstgpedidos;

CREATE TABLE IF NOT EXISTS projetomysqlstage.tbstgpedidos(
   codigo INT,
   cliente INT NULL DEFAULT NULL,
   datavenda timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

DROP TABLE IF EXISTS projetomysqlstage.tbstgitenspedidos;

CREATE TABLE IF NOT EXISTS projetomysqlstage.tbstgitenspedidos(
    produto INT NULL DEFAULT NULL,
    pedido INT NULL DEFAULT NULL,
    quantidade INT NULL DEFAULT NULL,
    valorvenda DECIMAL(18,2) NULL DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

SET SQL_MODE = @OLD_SQL_MODE;
SET
FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- DATA WAREHOUSE

SET 
@OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, 
UNIQUE_CHECKS=0;
SET
@OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS,
FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE,
SQL_MODE='ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS projetomysqldw;

CREATE DATABASE IF NOT EXISTS projetomysqldw;

USE projetomysqldw;

CREATE TABLE IF NOT EXISTS dimtempo(
    codigo bigint unsigned NOT NULL,
    data date DEFAULT NULL,
    diadomes tinyint unsigned DEFAULT NULL,
    diaano smallint unsigned DEFAULT NULL,
    diadasemana tinyint unsigned DEFAULT NULL,
    diasemananome VARCHAR(10) DEFAULT NULL,
    mes tinyint unsigned DEFAULT NULL,
    mesnome VARCHAR(10) DEFAULT NULL,
    ano smallint unsigned DEFAULT NULL,
    quarto tinyint unsigned DEFAULT NULL,
    datastr varchar(10) as (data),
    PRIMARY KEY(codigo)
)ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS dimcategorias(
    codigo INT NOT NULL AUTO_INCREMENT,
    codigoext INT DEFAULT NULL,
    descricao VARCHAR(150) DEFAULT NULL,
    datainicio datetime DEFAULT NULL,
    datafim DATETIME DEFAULT NULL,
    version INT DEFAULT NULL,
    PRIMARY KEY(codigo)
)ENGINE=InnoDB
DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS dimclientes(
    codigo int NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(100) DEFAULT NULL,
    Endereco VARCHAR(250) DEFAULT NULL,
    Telefone VARCHAR(25) DEFAULT NULL,
    Email varchar(100) DEFAULT NULL,
    DataNascimento timestamp DEFAULT 0,
    codigoext int DEFAULT NULL,
    datainicio datetime DEFAULT NULL,
    datafim datetime DEFAULT NULL,
    version INT DEFAULT NULL,
    tempo bigint unsigned DEFAULT NULL,
    PRIMARY KEY(codigo),
    KEY fkclientetempo(tempo),
    CONSTRAINT fkclientetempo FOREIGN KEY 
    (tempo) REFERENCES dimtempo(codigo)
    ON DELETE NO ACTION)
    ENGINE=InnoDB DEFAULT CHARSET =utf8mb4;

CREATE TABLE IF NOT EXISTS dimprodutos(
    codigo int NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(150) DEFAULT NULL,
    valorvenda DECIMAL(18,2) DEFAULT NULL,
    ativo INT DEFAULT '1',
    categoria INT DEFAULT NULL,
    codigoext INT DEFAULT NULL,
    datainicio datetime DEFAULT NULL,
    datafim datetime DEFAULT NULL,
    version INT DEFAULT NULL,
    PRIMARY KEY(codigo),
    KEY fkprodutocategoria(categoria),
    CONSTRAINT fkprodutocategoria foreign key (categoria)
    REFERENCES dimcategorias(codigo) ON DELETE NO ACTION
    ) ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4;
    
CREATE TABLE IF NOT EXISTS factpedidos(
    cliente INT DEFAULT NULL,
    datavenda timestamp DEFAULT 0,
    produto int DEFAULT NULL,
    pedido int DEFAULT NULL,
    quantidade int DEFAULT NULL,
	valorvenda decimal(18,2) DEFAULT NULL,
    valorvendaoriginal decimal(18,2) DEFAULT NULL,
    percdesconto decimal(18,2) as ((100*(coalesce(valorvenda,0)-
    coalesce(valorvendaoriginal,0)))/valorvendaoriginal) VIRTUAL,
    tempo bigint unsigned DEFAULT NULL,
    key fkprodutoitens(produto),
    key fkpedido(pedido),
    key fkclientes(cliente),
    key fkpedidostempo(tempo),
    CONSTRAINT fkprodutoitens FOREIGN KEY (produto) 
    REFERENCES dimprodutos(codigo) ON DELETE NO ACTION,
    CONSTRAINT fkclientes FOREIGN KEY (cliente)
    REFERENCES dimclientes(codigo) ON DELETE NO ACTION,
    CONSTRAINT fkpedidostempo FOREIGN KEY(tempo)
    REFERENCES dimtempo(codigo) ON DELETE NO ACTION)
    ENGINE=InnoDB
    DEFAULT CHARSET =utf8mb4;



