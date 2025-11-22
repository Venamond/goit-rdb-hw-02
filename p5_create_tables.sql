-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema appdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema appdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `appdb` DEFAULT CHARACTER SET utf8 ;
USE `appdb` ;

-- -----------------------------------------------------
-- Table `appdb`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appdb`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'Товари';


-- -----------------------------------------------------
-- Table `appdb`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appdb`.`clients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Клієнти';


-- -----------------------------------------------------
-- Table `appdb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appdb`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `order_date` DATETIME NOT NULL,
  PRIMARY KEY (`id`, `client_id`),
  INDEX `fk_orders_clients_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_clients`
    FOREIGN KEY (`client_id`)
    REFERENCES `appdb`.`clients` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Замовлення';


-- -----------------------------------------------------
-- Table `appdb`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appdb`.`order_items` (
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT UNSIGNED NULL,
  PRIMARY KEY (`order_id`, `product_id`),
  INDEX `fk_order_items_producrts_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_items_producrts`
    FOREIGN KEY (`product_id`)
    REFERENCES `appdb`.`products` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `appdb`.`orders` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Замовлення - товари';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
