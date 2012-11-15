/*
Navicat MySQL Data Transfer

Source Server         : home
Source Server Version : 50523
Source Host           : localhost:3306
Source Database       : salesagent

Target Server Type    : MYSQL
Target Server Version : 50523
File Encoding         : 65001

Date: 2012-11-16 02:05:56
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
