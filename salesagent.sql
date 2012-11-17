/*
Navicat MySQL Data Transfer

Source Server         : SalesAgent
Source Server Version : 50528
Source Host           : localhost:3333
Source Database       : saleagent

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2012-11-17 22:59:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `authority`
-- ----------------------------
DROP TABLE IF EXISTS `authority`;
CREATE TABLE `authority` (
  `sa_user_id` int(11) NOT NULL,
  `sa_user_role_id` int(11) NOT NULL,
  KEY `user_id` (`sa_user_id`),
  KEY `role_id` (`sa_user_role_id`),
  CONSTRAINT `role_id` FOREIGN KEY (`sa_user_role_id`) REFERENCES `sa_user_role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_id` FOREIGN KEY (`sa_user_id`) REFERENCES `sa_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authority
-- ----------------------------
INSERT INTO `authority` VALUES ('1', '1');

-- ----------------------------
-- Table structure for `balance`
-- ----------------------------
DROP TABLE IF EXISTS `balance`;
CREATE TABLE `balance` (
  `balance_id` int(11) NOT NULL DEFAULT '0',
  `amount` int(11) DEFAULT NULL,
  `prod_id` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  PRIMARY KEY (`balance_id`),
  KEY `R_34` (`prod_id`),
  KEY `R_35` (`warehouse_id`),
  CONSTRAINT `balance_ibfk_1` FOREIGN KEY (`prod_id`) REFERENCES `product` (`prod_id`),
  CONSTRAINT `balance_ibfk_2` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of balance
-- ----------------------------

-- ----------------------------
-- Table structure for `brand`
-- ----------------------------
DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand` (
  `brand_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `brand_cagent_id` int(11) NOT NULL,
  PRIMARY KEY (`brand_id`),
  KEY `R_31` (`brand_cagent_id`),
  CONSTRAINT `brand_ibfk_1` FOREIGN KEY (`brand_cagent_id`) REFERENCES `counteragent` (`counteragent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of brand
-- ----------------------------

-- ----------------------------
-- Table structure for `counteragent`
-- ----------------------------
DROP TABLE IF EXISTS `counteragent`;
CREATE TABLE `counteragent` (
  `counteragent_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`counteragent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of counteragent
-- ----------------------------

-- ----------------------------
-- Table structure for `doc`
-- ----------------------------
DROP TABLE IF EXISTS `doc`;
CREATE TABLE `doc` (
  `doc_id` int(11) NOT NULL DEFAULT '0',
  `date` datetime DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `shop_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`doc_id`),
  KEY `R_17` (`warehouse_id`),
  KEY `R_18` (`shop_id`),
  KEY `doc_ibfk_3` (`user_id`),
  CONSTRAINT `doc_ibfk_1` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`warehouse_id`),
  CONSTRAINT `doc_ibfk_2` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`shop_id`),
  CONSTRAINT `doc_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `sa_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of doc
-- ----------------------------

-- ----------------------------
-- Table structure for `doc_element`
-- ----------------------------
DROP TABLE IF EXISTS `doc_element`;
CREATE TABLE `doc_element` (
  `doc_element_id` int(11) NOT NULL DEFAULT '0',
  `amount` int(11) DEFAULT NULL,
  `doc_id` int(11) NOT NULL,
  `prod_id` int(11) NOT NULL,
  PRIMARY KEY (`doc_element_id`),
  KEY `R_16` (`doc_id`),
  KEY `R_36` (`prod_id`),
  CONSTRAINT `doc_element_ibfk_1` FOREIGN KEY (`doc_id`) REFERENCES `doc` (`doc_id`),
  CONSTRAINT `doc_element_ibfk_2` FOREIGN KEY (`prod_id`) REFERENCES `product` (`prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of doc_element
-- ----------------------------

-- ----------------------------
-- Table structure for `product`
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `prod_id` int(11) NOT NULL DEFAULT '0',
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `ban` int(11) DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  `sub_group_id` int(11) DEFAULT NULL,
  `brand_id` int(11) NOT NULL,
  `special_offer` int(11) DEFAULT NULL,
  PRIMARY KEY (`prod_id`),
  KEY `R_5` (`group_id`),
  KEY `R_8` (`sub_group_id`,`group_id`),
  KEY `R_10` (`brand_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `product_group` (`group_id`),
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`sub_group_id`, `group_id`) REFERENCES `product_sub_group` (`sub_group_id`, `group_id`),
  CONSTRAINT `product_ibfk_3` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------

-- ----------------------------
-- Table structure for `product_group`
-- ----------------------------
DROP TABLE IF EXISTS `product_group`;
CREATE TABLE `product_group` (
  `group_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product_group
-- ----------------------------

-- ----------------------------
-- Table structure for `product_sub_group`
-- ----------------------------
DROP TABLE IF EXISTS `product_sub_group`;
CREATE TABLE `product_sub_group` (
  `sub_group_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`sub_group_id`,`group_id`),
  KEY `R_6` (`group_id`),
  CONSTRAINT `product_sub_group_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `product_group` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product_sub_group
-- ----------------------------

-- ----------------------------
-- Table structure for `sa_user`
-- ----------------------------
DROP TABLE IF EXISTS `sa_user`;
CREATE TABLE `sa_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(20) NOT NULL,
  `pass` varchar(20) NOT NULL,
  `surname` varchar(20) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sa_user
-- ----------------------------
INSERT INTO `sa_user` VALUES ('1', 'admin', 'root', 'QWERTY', '1');

-- ----------------------------
-- Table structure for `sa_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `sa_user_role`;
CREATE TABLE `sa_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sa_user_role
-- ----------------------------
INSERT INTO `sa_user_role` VALUES ('1', 'ROLE_USER');

-- ----------------------------
-- Table structure for `shop`
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop` (
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `shop_cagent_id` int(11) NOT NULL,
  PRIMARY KEY (`shop_id`),
  KEY `R_30` (`shop_cagent_id`),
  CONSTRAINT `shop_ibfk_1` FOREIGN KEY (`shop_cagent_id`) REFERENCES `counteragent` (`counteragent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop
-- ----------------------------

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `login` varchar(20) DEFAULT NULL,
  `pass` varchar(20) DEFAULT NULL,
  `surname` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------

-- ----------------------------
-- Table structure for `warehouse`
-- ----------------------------
DROP TABLE IF EXISTS `warehouse`;
CREATE TABLE `warehouse` (
  `warehouse_id` int(11) NOT NULL DEFAULT '0',
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of warehouse
-- ----------------------------
