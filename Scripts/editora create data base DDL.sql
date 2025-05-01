-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema editora
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema editora
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `editora` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `editora` ;

-- -----------------------------------------------------
-- Table `editora`.`areasconhecimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora`.`areasconhecimento` (
  `cod_area` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cod_area`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `editora`.`autores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora`.`autores` (
  `cod_autor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `biografia` TEXT NULL DEFAULT NULL,
  `nacionalidade` VARCHAR(50) NULL DEFAULT NULL,
  `data_nascimento` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`cod_autor`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `editora`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora`.`clientes` (
  `cod_cliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(20) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `endereco` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`cod_cliente`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `editora`.`departamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora`.`departamentos` (
  `cod_departamento` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `responsavel` VARCHAR(100) NULL DEFAULT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`cod_departamento`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `editora`.`livros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora`.`livros` (
  `isbn` VARCHAR(20) NOT NULL,
  `titulo` VARCHAR(200) NOT NULL,
  `data_publicacao` DATE NULL DEFAULT NULL,
  `genero` VARCHAR(50) NULL DEFAULT NULL,
  `num_paginas` INT NULL DEFAULT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `cod_area` INT NULL DEFAULT NULL,
  PRIMARY KEY (`isbn`),
  INDEX `cod_area` (`cod_area` ASC) VISIBLE,
  INDEX `idx_livros_titulo` (`titulo` ASC) VISIBLE,
  CONSTRAINT `livros_ibfk_1`
    FOREIGN KEY (`cod_area`)
    REFERENCES `editora`.`areasconhecimento` (`cod_area`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `editora`.`exemplares`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora`.`exemplares` (
  `num_serie` VARCHAR(50) NOT NULL,
  `isbn` VARCHAR(20) NOT NULL,
  `estado` ENUM('disponível', 'reservado', 'danificado', 'vendido') NOT NULL DEFAULT 'disponível',
  `localizacao` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`num_serie`),
  INDEX `isbn` (`isbn` ASC) VISIBLE,
  CONSTRAINT `exemplares_ibfk_1`
    FOREIGN KEY (`isbn`)
    REFERENCES `editora`.`livros` (`isbn`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `editora`.`funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora`.`funcionarios` (
  `cod_funcionario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cargo` VARCHAR(50) NOT NULL,
  `telefone` VARCHAR(20) NULL DEFAULT NULL,
  `endereco` VARCHAR(200) NULL DEFAULT NULL,
  `cod_departamento` INT NULL DEFAULT NULL,
  PRIMARY KEY (`cod_funcionario`),
  INDEX `cod_departamento` (`cod_departamento` ASC) VISIBLE,
  CONSTRAINT `funcionarios_ibfk_1`
    FOREIGN KEY (`cod_departamento`)
    REFERENCES `editora`.`departamentos` (`cod_departamento`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `editora`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora`.`pedidos` (
  `cod_pedido` INT NOT NULL AUTO_INCREMENT,
  `cod_cliente` INT NOT NULL,
  `data_pedido` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` ENUM('pendente', 'processando', 'enviado', 'entregue', 'cancelado') NOT NULL DEFAULT 'pendente',
  `forma_pagamento` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`cod_pedido`),
  INDEX `cod_cliente` (`cod_cliente` ASC) VISIBLE,
  CONSTRAINT `pedidos_ibfk_1`
    FOREIGN KEY (`cod_cliente`)
    REFERENCES `editora`.`clientes` (`cod_cliente`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `editora`.`itenspedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora`.`itenspedido` (
  `cod_pedido` INT NOT NULL,
  `num_serie` VARCHAR(50) NOT NULL,
  `preco_unitario` DECIMAL(10,2) NOT NULL,
  `quantidade` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`cod_pedido`, `num_serie`),
  INDEX `num_serie` (`num_serie` ASC) VISIBLE,
  CONSTRAINT `itenspedido_ibfk_1`
    FOREIGN KEY (`cod_pedido`)
    REFERENCES `editora`.`pedidos` (`cod_pedido`),
  CONSTRAINT `itenspedido_ibfk_2`
    FOREIGN KEY (`num_serie`)
    REFERENCES `editora`.`exemplares` (`num_serie`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `editora`.`livrosautores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora`.`livrosautores` (
  `isbn` VARCHAR(20) NOT NULL,
  `cod_autor` INT NOT NULL,
  PRIMARY KEY (`isbn`, `cod_autor`),
  INDEX `cod_autor` (`cod_autor` ASC) VISIBLE,
  CONSTRAINT `livrosautores_ibfk_1`
    FOREIGN KEY (`isbn`)
    REFERENCES `editora`.`livros` (`isbn`),
  CONSTRAINT `livrosautores_ibfk_2`
    FOREIGN KEY (`cod_autor`)
    REFERENCES `editora`.`autores` (`cod_autor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `editora`.`palavraschave`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora`.`palavraschave` (
  `cod_palavra` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cod_palavra`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `editora`.`livrospalavraschave`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora`.`livrospalavraschave` (
  `isbn` VARCHAR(20) NOT NULL,
  `cod_palavra` INT NOT NULL,
  PRIMARY KEY (`isbn`, `cod_palavra`),
  INDEX `cod_palavra` (`cod_palavra` ASC) VISIBLE,
  CONSTRAINT `livrospalavraschave_ibfk_1`
    FOREIGN KEY (`isbn`)
    REFERENCES `editora`.`livros` (`isbn`),
  CONSTRAINT `livrospalavraschave_ibfk_2`
    FOREIGN KEY (`cod_palavra`)
    REFERENCES `editora`.`palavraschave` (`cod_palavra`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
