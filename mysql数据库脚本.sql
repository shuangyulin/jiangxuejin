-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(30)  NOT NULL COMMENT 'user_name',
  `password` varchar(30)  NOT NULL COMMENT '登录密码',
  `colleageObj` int(11) NOT NULL COMMENT '所在学院',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `userPhoto` varchar(60)  NOT NULL COMMENT '学生照片',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `email` varchar(50)  NOT NULL COMMENT '邮箱',
  `address` varchar(80)  NULL COMMENT '家庭地址',
  `regTime` varchar(20)  NULL COMMENT '注册时间',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_colleage` (
  `collleageId` int(11) NOT NULL AUTO_INCREMENT COMMENT '学院id',
  `colleageName` varchar(20)  NOT NULL COMMENT '学院名称',
  `colleageMemo` varchar(800)  NULL COMMENT '学院备注',
  PRIMARY KEY (`collleageId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_fdy` (
  `fdyUserName` varchar(30)  NOT NULL COMMENT 'fdyUserName',
  `password` varchar(30)  NOT NULL COMMENT '登录密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `email` varchar(50)  NOT NULL COMMENT '邮箱',
  `fdyMemo` varchar(800)  NULL COMMENT '辅导员备注',
  PRIMARY KEY (`fdyUserName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_jxjType` (
  `typeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '类别id',
  `typeName` varchar(20)  NOT NULL COMMENT '类别名称',
  `jxjMoney` float NOT NULL COMMENT '奖学金金额',
  `pdbz` varchar(800)  NOT NULL COMMENT '评定标准',
  `addTime` varchar(20)  NULL COMMENT '添加时间',
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_score` (
  `scoreId` int(11) NOT NULL AUTO_INCREMENT COMMENT '成绩id',
  `termObj` int(11) NOT NULL COMMENT '所在学期',
  `userObj` varchar(30)  NOT NULL COMMENT '学生',
  `colleageObj` int(11) NOT NULL COMMENT '所在学院',
  `zhcj` float NOT NULL COMMENT '综合成绩',
  `scoreDesc` varchar(8000)  NOT NULL COMMENT '详细成绩',
  `scoreMemo` varchar(800)  NULL COMMENT '成绩备注',
  PRIMARY KEY (`scoreId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_termInfo` (
  `termId` int(11) NOT NULL AUTO_INCREMENT COMMENT '学期id',
  `termName` varchar(20)  NOT NULL COMMENT '学期名称',
  PRIMARY KEY (`termId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_family` (
  `familyId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录id',
  `userObj` varchar(30)  NOT NULL COMMENT '学生',
  `familyDesc` varchar(8000)  NOT NULL COMMENT '家庭情况',
  `updateTime` varchar(20)  NULL COMMENT '更新时间',
  PRIMARY KEY (`familyId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_jxj` (
  `jxjId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录id',
  `jxjTypeObj` int(11) NOT NULL COMMENT '奖学金类型',
  `title` varchar(80)  NOT NULL COMMENT '申请标题',
  `content` varchar(800)  NOT NULL COMMENT '申请描述',
  `sqcl` varchar(60)  NOT NULL COMMENT '申请材料',
  `userObj` varchar(30)  NOT NULL COMMENT '申请学生',
  `fdyState` varchar(20)  NOT NULL COMMENT '辅导员审核状态',
  `fdyUserName` varchar(20)  NOT NULL COMMENT '审核的辅导员',
  `glState` varchar(20)  NOT NULL COMMENT '管理员审核状态',
  `glResult` varchar(500)  NOT NULL COMMENT '管理员审核结果',
  PRIMARY KEY (`jxjId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_userInfo ADD CONSTRAINT FOREIGN KEY (colleageObj) REFERENCES t_colleage(collleageId);
ALTER TABLE t_score ADD CONSTRAINT FOREIGN KEY (termObj) REFERENCES t_termInfo(termId);
ALTER TABLE t_score ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_score ADD CONSTRAINT FOREIGN KEY (colleageObj) REFERENCES t_colleage(collleageId);
ALTER TABLE t_family ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_jxj ADD CONSTRAINT FOREIGN KEY (jxjTypeObj) REFERENCES t_jxjType(typeId);
ALTER TABLE t_jxj ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


