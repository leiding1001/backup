-- MySQL Script generated by MySQL Workbench
-- 2015年01月05日 星期一 20时33分40秒
-- Model: New Model    Version: 1.0
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema washcar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `washcar` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
-- -----------------------------------------------------
-- Schema washcar
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS `washcar` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `washcar` ;

-- -----------------------------------------------------
-- Table `washcar`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`user` (
  `tokenid` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  `qq` VARCHAR(45) NULL,
  `sex` VARCHAR(2) NULL,
  `email` VARCHAR(45) NULL,
  `age` INT NULL,
  `address` VARCHAR(45) NULL,
  `createdtime` MEDIUMTEXT NOT NULL,
  `status` INT NOT NULL DEFAULT 0 COMMENT '用户状态',
  `latitude` DOUBLE NULL COMMENT '经度',
  `longitude` DOUBLE NULL COMMENT '纬度',
  PRIMARY KEY (`tokenid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `washcar`.`manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`manager` (
  `tokenid` VARCHAR(45) NOT NULL,
  `u_tokenid` VARCHAR(45) NOT NULL,
  INDEX `fk_admin_tokenid_idx` (`u_tokenid` ASC),
  PRIMARY KEY (`tokenid`),
  CONSTRAINT `fk_admin_u_tokenid`
    FOREIGN KEY (`u_tokenid`)
    REFERENCES `washcar`.`user` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '管理员';


-- -----------------------------------------------------
-- Table `washcar`.`business`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`business` (
  `tokenid` VARCHAR(45) NOT NULL,
  `u_tokenid` VARCHAR(45) NOT NULL,
  `m_tokenid` VARCHAR(45) NULL,
  PRIMARY KEY (`tokenid`),
  INDEX `fk_business_tokenid_idx` (`u_tokenid` ASC),
  CONSTRAINT `fk_business_u_tokenid`
    FOREIGN KEY (`u_tokenid`)
    REFERENCES `washcar`.`user` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_business_a_tokenid`
    FOREIGN KEY (`m_tokenid`)
    REFERENCES `washcar`.`manager` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `washcar`.`driver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`driver` (
  `tokenid` VARCHAR(45) NOT NULL,
  `u_tokenid` VARCHAR(45) NOT NULL,
  `identifing_code` VARCHAR(45) NULL,
  `money` FLOAT NULL DEFAULT 0,
  `integral` MEDIUMTEXT NULL,
  `m_tokenid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tokenid`),
  INDEX `fk_driver_token_idx` (`u_tokenid` ASC),
  INDEX `fk_driver_a_token_idx` (`m_tokenid` ASC),
  CONSTRAINT `fk_driver_u_token`
    FOREIGN KEY (`u_tokenid`)
    REFERENCES `washcar`.`user` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_driver_a_token`
    FOREIGN KEY (`m_tokenid`)
    REFERENCES `washcar`.`manager` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `washcar`.`car`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`car` (
  `tokenid` VARCHAR(45) NOT NULL,
  `d_tokenid` VARCHAR(45) NOT NULL,
  `number` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NULL,
  `brand` VARCHAR(45) NULL,
  `color` VARCHAR(45) NULL,
  `pic` VARCHAR(45) NULL COMMENT '1.png,2.png,3png..',
  `buydate` MEDIUMTEXT NULL,
  PRIMARY KEY (`tokenid`),
  INDEX `fk_car_tokenid_idx` (`d_tokenid` ASC),
  CONSTRAINT `fk_car_tokenid`
    FOREIGN KEY (`d_tokenid`)
    REFERENCES `washcar`.`driver` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `washcar`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`address` (
  `tokenid` VARCHAR(45) NOT NULL,
  `address` VARCHAR(150) NOT NULL,
  `d_tokenid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tokenid`),
  INDEX `fk_address_tokenid_idx` (`d_tokenid` ASC),
  CONSTRAINT `fk_address_tokenid`
    FOREIGN KEY (`d_tokenid`)
    REFERENCES `washcar`.`driver` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `washcar`.`recharge_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`recharge_record` (
  `tokenid` INT NOT NULL,
  `d_tokenid` VARCHAR(45) NOT NULL,
  `money` FLOAT NOT NULL,
  `created_date` MEDIUMTEXT NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`tokenid`),
  INDEX `fk_recharg_record_token_idx` (`d_tokenid` ASC),
  CONSTRAINT `fk_recharg_record_token`
    FOREIGN KEY (`d_tokenid`)
    REFERENCES `washcar`.`driver` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `washcar`.`service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`service` (
  `tokenid` VARCHAR(45) NOT NULL,
  `b_tokenid` VARCHAR(45) NOT NULL,
  `cotent` VARCHAR(200) NOT NULL,
  `pics` VARCHAR(45) NULL COMMENT '1.png,2.png,3.png.....',
  `price` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tokenid`),
  INDEX `fk_service_token_idx` (`b_tokenid` ASC),
  CONSTRAINT `fk_service_token`
    FOREIGN KEY (`b_tokenid`)
    REFERENCES `washcar`.`business` (`u_tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `washcar`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`orders` (
  `tokenid` VARCHAR(45) NOT NULL,
  `s_tokenid` VARCHAR(45) NOT NULL,
  `car_tokenid` VARCHAR(45) NOT NULL,
  `addr_tokenid` VARCHAR(45) NOT NULL,
  `created_date` MEDIUMTEXT NOT NULL,
  `description` VARCHAR(45) NULL,
  `d_tokenid` VARCHAR(45) NOT NULL,
  `b_tokenid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tokenid`),
  INDEX `fk_order_addr_token_idx` (`addr_tokenid` ASC),
  INDEX `fk_order_car_tokenid_idx` (`car_tokenid` ASC),
  INDEX `fk_order_s_tokenid_idx` (`s_tokenid` ASC),
  INDEX `fk_orders_d_tokenid_idx` (`d_tokenid` ASC),
  INDEX `fk_orders_b_tokenid_idx` (`b_tokenid` ASC),
  CONSTRAINT `fk_order_addr_tokenid`
    FOREIGN KEY (`addr_tokenid`)
    REFERENCES `washcar`.`address` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_car_tokenid`
    FOREIGN KEY (`car_tokenid`)
    REFERENCES `washcar`.`car` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_s_tokenid`
    FOREIGN KEY (`s_tokenid`)
    REFERENCES `washcar`.`service` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_d_tokenid`
    FOREIGN KEY (`d_tokenid`)
    REFERENCES `washcar`.`driver` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_b_tokenid`
    FOREIGN KEY (`b_tokenid`)
    REFERENCES `washcar`.`business` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `washcar`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`comment` (
  `tokenid` VARCHAR(45) NOT NULL COMMENT '主键唯一标识符',
  `o_tokenid` VARCHAR(45) NOT NULL COMMENT '外键，与订单关联',
  `comment` VARCHAR(200) NOT NULL COMMENT '评论内容',
  `createdtime` MEDIUMTEXT NOT NULL COMMENT '创建时间',
  `b_tokenid` VARCHAR(45) NOT NULL,
  `d_tokenid` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tokenid`),
  INDEX `fk_comment_o_tokenid_idx` (`o_tokenid` ASC),
  INDEX `fk_comment_b_tokenid_idx` (`b_tokenid` ASC),
  INDEX `fk_comment_d_tokenid_idx` (`d_tokenid` ASC),
  CONSTRAINT `fk_comment_o_tokenid`
    FOREIGN KEY (`o_tokenid`)
    REFERENCES `washcar`.`orders` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_b_tokenid`
    FOREIGN KEY (`b_tokenid`)
    REFERENCES `washcar`.`business` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_d_tokenid`
    FOREIGN KEY (`d_tokenid`)
    REFERENCES `washcar`.`driver` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `washcar`.`upgrade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`upgrade` (
  `tokenid` VARCHAR(45) NOT NULL,
  `versionname` VARCHAR(45) NOT NULL,
  `url` VARCHAR(45) NOT NULL,
  `update_content` VARCHAR(45) NOT NULL,
  `created_time` MEDIUMTEXT NOT NULL,
  `versioncode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tokenid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `washcar`.`feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`feedback` (
  `tokenid` INT NOT NULL,
  `username` VARCHAR(45) NULL,
  `userid` VARCHAR(45) NOT NULL,
  `content` VARCHAR(1000) NULL,
  `created_time` MEDIUMTEXT NOT NULL,
  `logfile` VARCHAR(45) NULL,
  PRIMARY KEY (`tokenid`))
ENGINE = InnoDB
COMMENT = '反馈表';


-- -----------------------------------------------------
-- Table `washcar`.`authority`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`authority` (
  `tokenid` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `created_time` MEDIUMTEXT NOT NULL,
  `modify_time` MEDIUMTEXT NULL,
  PRIMARY KEY (`tokenid`))
ENGINE = InnoDB
COMMENT = '权限表';


-- -----------------------------------------------------
-- Table `washcar`.`mgr_authority`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`mgr_authority` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `m_tokenid` VARCHAR(45) NOT NULL,
  `au_tokenid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_mgr_authority_m_tokenid_idx` (`m_tokenid` ASC),
  INDEX `fk_mgr_authority_au_tokenid_idx` (`au_tokenid` ASC),
  CONSTRAINT `fk_mgr_authority_m_tokenid`
    FOREIGN KEY (`m_tokenid`)
    REFERENCES `washcar`.`manager` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mgr_authority_au_tokenid`
    FOREIGN KEY (`au_tokenid`)
    REFERENCES `washcar`.`authority` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '管理员权限表';


-- -----------------------------------------------------
-- Table `washcar`.`driver_authority`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`driver_authority` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `d_tokenid` VARCHAR(45) NOT NULL,
  `au_tokenid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_driver_authority_d_tokenid_idx` (`d_tokenid` ASC),
  INDEX `fk_driver_authority_au_tokenid_idx` (`au_tokenid` ASC),
  CONSTRAINT `fk_driver_authority_d_tokenid`
    FOREIGN KEY (`d_tokenid`)
    REFERENCES `washcar`.`driver` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_driver_authority_au_tokenid`
    FOREIGN KEY (`au_tokenid`)
    REFERENCES `washcar`.`authority` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '司机权限表';


-- -----------------------------------------------------
-- Table `washcar`.`business_authority`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`business_authority` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `b_tokenid` VARCHAR(45) NOT NULL,
  `au_tokenid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_business_authority_b_tokenid_idx` (`b_tokenid` ASC),
  INDEX `fk_business_authority_au_tokenid_idx` (`au_tokenid` ASC),
  CONSTRAINT `fk_business_authority_b_tokenid`
    FOREIGN KEY (`b_tokenid`)
    REFERENCES `washcar`.`business` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_business_authority_au_tokenid`
    FOREIGN KEY (`au_tokenid`)
    REFERENCES `washcar`.`authority` (`tokenid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '商家权限表';

USE `washcar` ;
USE `washcar` ;

-- -----------------------------------------------------
-- Placeholder table for view `washcar`.`manager_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`manager_view` (`phone` INT, `password` INT, `name` INT, `qq` INT, `sex` INT, `email` INT, `age` INT, `address` INT, `createdtime` INT, `tokenid` INT);

-- -----------------------------------------------------
-- Placeholder table for view `washcar`.`business_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`business_view` (`phone` INT, `password` INT, `name` INT, `qq` INT, `sex` INT, `email` INT, `age` INT, `address` INT, `createdtime` INT, `tokenid` INT, `a_tokenid` INT);

-- -----------------------------------------------------
-- Placeholder table for view `washcar`.`driver_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`driver_view` (`phone` INT, `password` INT, `name` INT, `qq` INT, `sex` INT, `email` INT, `age` INT, `address` INT, `createdtime` INT, `tokenid` INT, `identifing_code` INT, `money` INT, `integral` INT, `a_tokenid` INT);

-- -----------------------------------------------------
-- Placeholder table for view `washcar`.`order_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `washcar`.`order_view` (`tokenid` INT, `created_date` INT, `description` INT, `d_tokenid` INT, `number` INT, `address` INT, `b_tokenid` INT, `content` INT, `price` INT);

-- -----------------------------------------------------
-- View `washcar`.`manager_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `washcar`.`manager_view`;
USE `washcar`;
--
-- View structure for view `film_list`
--

CREATE  OR REPLACE VIEW `manager_view`  AS
	SELECT
		user.phone,user.password,user.name,user.qq,user.sex,user.email
		,user.age,user.address,user.createdtime,manager.tokenid
	FROM manager left join user on  manager.u_tokenid = user.tokenid ;
		
	
;

-- -----------------------------------------------------
-- View `washcar`.`business_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `washcar`.`business_view`;
USE `washcar`;
--
-- View structure for view `business_view`
--
CREATE  OR REPLACE VIEW `business_view` AS
	SELECT   user.phone,user.password,user.name,user.qq,user.sex,user.email, user.age,user.address,user.createdtime,business.tokenid,business.a_tokenid
    FROM business left join user  on business.u_tokenid = user.tokenid ;
	
	;

-- -----------------------------------------------------
-- View `washcar`.`driver_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `washcar`.`driver_view`;
USE `washcar`;
--
-- View structure for view `driver_view`
--
CREATE  OR REPLACE VIEW `driver_view` AS
	SELECT 
		user.phone,user.password,user.name,user.qq,user.sex,user.email,
		user.age,user.address,user.createdtime,
		driver.tokenid,driver.identifing_code,driver.money,
		driver.integral,driver.a_tokenid
	FROM driver left join user  on
		driver.u_tokenid = user.tokenid ;
	
	;

-- -----------------------------------------------------
-- View `washcar`.`order_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `washcar`.`order_view`;
USE `washcar`;
CREATE  OR REPLACE VIEW `order_view` AS
	SELECT 	
			orders.tokenid,
			orders.created_date,
			orders.description,
			car.d_tokenid,
			car.number,
			address.address,
			service.b_tokenid,
			service.content,
			service.price
	FROM 
		orders  left join car on orders.car = car.tokenid
				left join address on orders.car_tokenid = address.tokenid
				left join service on orders.s_tokenid = service.tokenid ;
			
		;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;