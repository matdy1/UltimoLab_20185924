-- MySQL Script generated by MySQL Workbench
-- Thu Nov 16 20:25:19 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bicicentro
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bicicentro
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bicicentro` DEFAULT CHARACTER SET utf8mb3 ;
USE `bicicentro` ;

-- -----------------------------------------------------
-- Table `bicicentro`.`marcas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicicentro`.`marcas` ;

CREATE TABLE IF NOT EXISTS `bicicentro`.`marcas` (
  `idmarca` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idmarca`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bicicentro`.`sedes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicicentro`.`sedes` ;

CREATE TABLE IF NOT EXISTS `bicicentro`.`sedes` (
  `idsede` INT NOT NULL AUTO_INCREMENT,
  `nombreSede` VARCHAR(45) NULL DEFAULT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idsede`))
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bicicentro`.`tipos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicicentro`.`tipos` ;

CREATE TABLE IF NOT EXISTS `bicicentro`.`tipos` (
  `idtipo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idtipo`))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bicicentro`.`inventario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicicentro`.`inventario` ;

CREATE TABLE IF NOT EXISTS `bicicentro`.`inventario` (
  `idinventario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `idtipo` INT NOT NULL,
  `numeroserie` VARCHAR(45) NULL DEFAULT NULL,
  `idsede` INT NOT NULL,
  `idmarca` INT NOT NULL,
  `estado` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idinventario`),
  INDEX `fk_inventario_tipoEquipo_idx` (`idtipo` ASC) VISIBLE,
  INDEX `fk_inventario_sedes1_idx` (`idsede` ASC) VISIBLE,
  INDEX `fk_inventario_marcas1_idx` (`idmarca` ASC) VISIBLE,
  CONSTRAINT `fk_inventario_marcas1`
    FOREIGN KEY (`idmarca`)
    REFERENCES `bicicentro`.`marcas` (`idmarca`),
  CONSTRAINT `fk_inventario_sedes1`
    FOREIGN KEY (`idsede`)
    REFERENCES `bicicentro`.`sedes` (`idsede`),
  CONSTRAINT `fk_inventario_tipoEquipo`
    FOREIGN KEY (`idtipo`)
    REFERENCES `bicicentro`.`tipos` (`idtipo`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bicicentro`.`pedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicicentro`.`pedidos` ;

CREATE TABLE IF NOT EXISTS `bicicentro`.`pedidos` (
  `idpedido` INT NOT NULL AUTO_INCREMENT,
  `codigoOrden` VARCHAR(45) NULL DEFAULT NULL,
  `nombreCliente` VARCHAR(45) NULL DEFAULT NULL,
  `dniCliente` VARCHAR(45) NULL DEFAULT NULL,
  `apellidoCliente` VARCHAR(45) NULL DEFAULT NULL,
  `id_inventario` INT NOT NULL,
  PRIMARY KEY (`idpedido`),
  INDEX `fk_pedido_inventario1_idx` (`id_inventario` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_inventario1`
    FOREIGN KEY (`id_inventario`)
    REFERENCES `bicicentro`.`inventario` (`idinventario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bicicentro`.`trabajadores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicicentro`.`trabajadores` ;

CREATE TABLE IF NOT EXISTS `bicicentro`.`trabajadores` (
  `nombres` VARCHAR(45) NULL DEFAULT NULL,
  `apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `correo` VARCHAR(45) NULL DEFAULT NULL,
  `dni` VARCHAR(45) NOT NULL,
  `idsede` INT NOT NULL,
  PRIMARY KEY (`dni`),
  INDEX `fk_trabajadores_sedes1_idx` (`idsede` ASC) VISIBLE,
  CONSTRAINT `fk_trabajadores_sedes1`
    FOREIGN KEY (`idsede`)
    REFERENCES `bicicentro`.`sedes` (`idsede`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bicicentro`.`ventas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicicentro`.`ventas` ;

CREATE TABLE IF NOT EXISTS `bicicentro`.`ventas` (
  `idventa` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NULL DEFAULT NULL,
  `id_inventario` INT NOT NULL,
  `dniTrabajador` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idventa`, `dniTrabajador`),
  UNIQUE INDEX `id_venta_UNIQUE` (`idventa` ASC) VISIBLE,
  INDEX `fk_ventas_inventario1_idx` (`id_inventario` ASC) VISIBLE,
  INDEX `fk_ventas_trabajadores1_idx` (`dniTrabajador` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_inventario1`
    FOREIGN KEY (`id_inventario`)
    REFERENCES `bicicentro`.`inventario` (`idinventario`),
  CONSTRAINT `fk_ventas_trabajadores1`
    FOREIGN KEY (`dniTrabajador`)
    REFERENCES `bicicentro`.`trabajadores` (`dni`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
