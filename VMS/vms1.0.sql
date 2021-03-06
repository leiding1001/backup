SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `vms` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `vms` ;

-- -----------------------------------------------------
-- Table `vms`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vms`.`user` (
  `userid` VARCHAR(45) NOT NULL COMMENT '用户ID',
  `name` VARCHAR(45) NOT NULL COMMENT '用户名称',
  `nickname` VARCHAR(100) NULL COMMENT '用户昵称',
  `email` VARCHAR(45) NULL COMMENT '邮箱',
  `phonenumber` VARCHAR(45) NULL COMMENT '手机号码',
  `role` VARCHAR(45) NOT NULL COMMENT '角色\n1、管理员\n2、维护人',
  `dept` VARCHAR(200) NOT NULL COMMENT '部门\n',
  `password` VARCHAR(45) NOT NULL COMMENT '密码',
  `company` VARCHAR(200) NOT NULL COMMENT '公司\n',
  PRIMARY KEY (`userid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = '管理员和维护人';


-- -----------------------------------------------------
-- Table `vms`.`car`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vms`.`car` (
  `carid` VARCHAR(45) NOT NULL COMMENT '序号',
  `name` VARCHAR(45) NOT NULL COMMENT '设备名称',
  `plate_num` VARCHAR(45) NOT NULL COMMENT '车牌号',
  `type` VARCHAR(45) NOT NULL COMMENT '型号',
  `status` VARCHAR(45) NOT NULL COMMENT '状态\n是否被租\n	Y,N',
  `from` VARCHAR(45) NOT NULL COMMENT '来自\n	自有非生产\n	自有生产',
  PRIMARY KEY (`carid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = '出租的车辆表';


-- -----------------------------------------------------
-- Table `vms`.`sbook`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vms`.`sbook` (
  `idsbook` VARCHAR(45) NOT NULL COMMENT '流水号，主键',
  `userid` VARCHAR(45) NOT NULL,
  `carid` VARCHAR(45) NOT NULL,
  `lessee` VARCHAR(45) NOT NULL COMMENT '乘租方',
  `lease` VARCHAR(45) NOT NULL COMMENT '出租放方\n租出车辆的公司',
  `startdate` DATE NOT NULL COMMENT '起租时间',
  `enddate` DATE NOT NULL COMMENT '到期时间',
  `usedept` VARCHAR(200) NOT NULL COMMENT '使用部门',
  `isexpire` VARCHAR(45) NOT NULL DEFAULT 'N' COMMENT '是否过期\nY，N',
  PRIMARY KEY (`idsbook`),
  INDEX `fk_sbook_1_idx` (`carid` ASC),
  INDEX `fk_sbook_userid_idx` (`userid` ASC),
  CONSTRAINT `fk_sbook_carid`
    FOREIGN KEY (`carid`)
    REFERENCES `vms`.`car` (`carid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sbook_userid`
    FOREIGN KEY (`userid`)
    REFERENCES `vms`.`user` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'standing book 台账表';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
