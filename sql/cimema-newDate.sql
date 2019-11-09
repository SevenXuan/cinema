create database if not exists `cinema-new` default character set utf8;

use `cinema-new`;

drop table if exists `t_sellinformation`;
drop table if exists `t_schedule`;
drop table if exists `t_movie`;
drop table if exists `t_movietype`;
drop table if exists `t_room`;
drop table if exists `t_languagetype`;

create table `t_languagetype` (
  `lt_id` int(20) not null auto_increment,
  `lt_type` varchar(20) not null comment '语言类别',
  primary key (`lt_id`)
) engine=innodb auto_increment=4 default charset=utf8;

insert  into `t_languagetype`(`lt_id`,`lt_type`) values (1,'中文');
insert  into `t_languagetype`(`lt_id`,`lt_type`) values (2,'英文');
insert  into `t_languagetype`(`lt_id`,`lt_type`) values (3,'日文');

create table `t_movietype` (
  `mt_id` int(20) not null auto_increment comment '影片类别编号',
  `mt_name` varchar(20) not null comment '影片类别名称',
  primary key (`mt_id`)
) engine=innodb auto_increment=5 default charset=utf8;

insert  into `t_movietype`(`mt_id`,`mt_name`) values (1,'悬疑');
insert  into `t_movietype`(`mt_id`,`mt_name`) values (2,'科幻');
insert  into `t_movietype`(`mt_id`,`mt_name`) values (3,'爱情');
insert  into `t_movietype`(`mt_id`,`mt_name`) values (4,'动作');

create table `t_movie` (
  `m_id` int(20) not null auto_increment comment '影片编号',
  `m_name` varchar(50) not null comment '影片名称',
  `m_intro` varchar(200) not null comment '影片简介',
  `m_score` double not null comment '影片评分',
  `m_lTid` int(20) not null comment '影片语言编号',
  `m_mTid` int(20) not null comment '影片类别编号',
  `m_producer` varchar(50) default null comment '制片方',
  `m_issuer` varchar(50) default null comment '发行方',
  `m_director` varchar(50) not null comment '导演',
  `m_actor` varchar(50) not null comment '主演',
  `m_duration` int(20) not null comment '影片时长',
  `m_time` datetime not null comment '上映时间',
  `m_expiringDate` datetime not null comment '影片版权到期时间',
  `m_picture` varchar(50) default null comment '海报的路径',
  `m_count` int(11) not null comment '数量',
  `m_condition` tinyint(4) not null comment '状态，0或1',
  primary key (`m_id`),
  key `m_mTid` (`m_mTid`),
  constraint `t_movie_ibfk_1` foreign key (`m_mTid`) references `t_movietype` (`mt_id`)
) engine=innodb auto_increment=5 default charset=utf8;

/*Data for the table `t_movie` */

insert  into `t_movie`(`m_id`,`m_name`,`m_intro`,`m_score`,`m_lTid`,`m_mTid`,`m_producer`,`m_issuer`,`m_director`,`m_actor`,`m_duration`,`m_time`,`m_expiringDate`,`m_picture`,`m_count`,`m_condition`) values (1,'复仇者联盟3','该片讲述复仇者联盟和他们的超级英雄盟友们必须愿意牺牲一切，才能在灭霸毁灭宇宙之前将其击败。',8,2,2,'漫威影业公司','华特·迪士尼电影公司','安东尼·罗素','小罗伯特·唐尼',150,'2018-05-11 11:18:59','2018-06-01 11:19:14','1.jpg',1,1);
insert  into `t_movie`(`m_id`,`m_name`,`m_intro`,`m_score`,`m_lTid`,`m_mTid`,`m_producer`,`m_issuer`,`m_director`,`m_actor`,`m_duration`,`m_time`,`m_expiringDate`,`m_picture`,`m_count`,`m_condition`) values (2,'羞羞的铁拳','主要讲述了一个搏击选手艾迪生和一个体育女记者马小，因为一场意外的电击灵魂互换的爱情故事。',8.5,1,4,'开心麻花影业','中国大陆','宋阳','艾伦，马丽',99,'2017-12-01 11:22:14','2018-01-31 11:22:24','2.jpg',1,0);
insert  into `t_movie`(`m_id`,`m_name`,`m_intro`,`m_score`,`m_lTid`,`m_mTid`,`m_producer`,`m_issuer`,`m_director`,`m_actor`,`m_duration`,`m_time`,`m_expiringDate`,`m_picture`,`m_count`,`m_condition`) values (3,'头号玩家','讲述了一个现实生活中无所寄托、沉迷游戏的大男孩，凭着对虚拟游戏设计者的深入剖析，历经磨难，找到隐藏在关卡里的三把钥匙，成功通关游戏，并且还收获了网恋女友的故事',9,2,2,'美国华纳兄弟影业','美国华纳兄弟影业','史蒂文·斯皮尔伯格','泰伊·谢里丹',140,'2018-03-01 11:25:27','2018-04-27 11:25:30','3.jpg',1,1);
insert  into `t_movie`(`m_id`,`m_name`,`m_intro`,`m_score`,`m_lTid`,`m_mTid`,`m_producer`,`m_issuer`,`m_director`,`m_actor`,`m_duration`,`m_time`,`m_expiringDate`,`m_picture`,`m_count`,`m_condition`) values (4,'阿萨德','啊实打实的',5,2,2,'阿萨德','阿萨德','阿萨德','阿萨德',90,'2018-01-03 00:05:00','2018-01-16 00:05:00',null,1,1);

create table `t_room` (
  `r_id` int(20) not null auto_increment comment '影厅编号',
  `r_type` varchar(50) not null comment '影厅类型',
  `r_seat` int(20) not null comment '影厅座位',
  `r_seatId` varchar(500) default null comment '维护座位编号',
  `r_rows` tinyint(4) not null comment '影厅的行数',
  `r_cols` tinyint(4) not null comment '影厅的列数',
  primary key (`r_id`)
) engine=innodb auto_increment=7 default charset=utf8;

insert  into `t_room`(`r_id`,`r_type`,`r_seat`,`r_seatId`,`r_rows`,`r_cols`) values (1,'1号大厅',105,'1-1,1-2,7-1,7-2',7,15);
insert  into `t_room`(`r_id`,`r_type`,`r_seat`,`r_seatId`,`r_rows`,`r_cols`) values (2,'2号大厅',105,'2-1,2-2,3-1,3-2,7-1',7,15);
insert  into `t_room`(`r_id`,`r_type`,`r_seat`,`r_seatId`,`r_rows`,`r_cols`) values (3,'1号小厅',66,'3-1,3-2,3-3,3-4',6,11);
insert  into `t_room`(`r_id`,`r_type`,`r_seat`,`r_seatId`,`r_rows`,`r_cols`) values (4,'2号小厅',66,'4-1,4-2,5-1,5-2',6,11);
insert  into `t_room`(`r_id`,`r_type`,`r_seat`,`r_seatId`,`r_rows`,`r_cols`) values (5,'1号VIP厅',35,'1-1,1-2,2-1,2-2',5,7);
insert  into `t_room`(`r_id`,`r_type`,`r_seat`,`r_seatId`,`r_rows`,`r_cols`) values (6,'2号VIP厅',35,'5-1,5-2,5-3',5,7);

create table `t_schedule` (
  `s_id` int(20) not null auto_increment comment '排片编号',
  `s_mid` int(20) not null comment '影片编号',
  `s_rid` int(20) not null comment '影厅编号',
  `s_price` int(20) not null comment '影片价格',
  `s_startTime` datetime not null comment '影片播放时间',
  `s_endTime` datetime not null comment '影片结束时间',
  `s_sellSeat` varchar(500) default null comment '已售座位',
  `s_condition` tinyint(4) not null default '1' comment '影片状态，上映下映',
  primary key (`s_id`),
  key `s_mid` (`s_mid`),
  key `s_rid` (`s_rid`),
  constraint `t_schedule_ibfk_1` foreign key (`s_mid`) references `t_movie` (`m_id`),
  constraint `t_schedule_ibfk_2` foreign key (`s_rid`) references `t_room` (`r_id`)
) engine=innodb auto_increment=35 default charset=utf8;

/*Data for the table `t_schedule` */

insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (2,1,1,90,'2018-04-27 14:00:00','2018-04-27 16:00:00','5-3,5-4,5-8,1-3,1-4,5-5,5-6,5-7,3-8,4-8',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (5,1,6,80,'2018-04-27 15:00:00','2018-04-27 17:00:00','4-2,4-3,4-4',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (6,1,6,70,'2018-04-27 18:00:00','2018-04-27 20:00:00','5-6,5-7,5-8',0);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (8,3,4,50,'2018-04-29 10:00:00','2018-04-29 12:00:00','5-5,5-6',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (9,3,5,90,'2018-04-28 16:58:20','2018-04-28 18:58:24','5-9',0);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (10,2,2,60,'2018-04-28 16:58:51','2018-04-28 18:58:57','6-9,6-10',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (11,1,1,50,'2018-05-05 05:05:00','2018-05-05 07:35:00','5-9,5-10',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (12,2,5,88,'2018-05-05 15:00:00','2018-05-05 16:39:00','5-9,5-10',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (13,3,6,80,'2018-05-05 16:00:00','2018-05-05 18:20:00','5-9,5-10,4-4,4-5',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (15,1,1,50,'2018-05-06 20:00:00','2018-05-06 22:30:00','5-9,5-10,3-8,4-8,1-3,1-4,1-8,1-9,1-10,2-9,2-10,3-10,4-6,4-7',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (16,1,1,20,'2018-05-01 00:00:00','2018-05-01 02:30:00','5-9,5-10',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (17,1,1,80,'2018-05-06 13:00:00','2018-05-06 15:30:00','5-9,5-10,5-7,5-8,1-3,1-4,1-3,1-4,1-3,1-4,1-5,1-6,7-1,7-2',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (19,2,1,60,'2018-05-04 15:00:00','2018-05-04 16:39:00','5-9,5-10,2-1,2-2',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (20,2,6,80,'2018-05-02 15:00:00','2018-05-02 16:39:00','5-9,5-10',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (21,2,5,90,'2018-05-01 18:00:00','2018-05-01 19:39:00','5-9,5-10',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (22,3,2,90,'2018-05-03 14:00:00','2018-05-03 16:20:00','5-9,5-10',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (23,3,4,90,'2018-05-04 19:00:00','2018-05-04 21:20:00','5-9,5-10',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (24,3,3,60,'2018-05-09 15:00:00','2018-05-09 17:20:00','null,4-5,4-6',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (25,2,4,80,'2018-05-09 16:00:00','2018-05-09 17:39:00',null,1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (26,2,1,60,'2018-05-11 01:01:00','2018-05-11 02:40:00','n,u,l,l,4,-,7,4,-,8,4,-,9,5,-,7,5,-,8,5,-,9,4,-,5,4,-,6,3-7,3-8',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (27,3,5,50,'2018-05-11 18:00:00','2018-05-11 20:20:00','null,3-3,3-4,3-5,2-3,2-4,2-5',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (28,3,2,40,'2018-05-12 18:00:00','2018-05-12 20:20:00',null,0);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (29,1,2,50,'2018-05-12 18:00:00','2018-05-12 20:30:00',null,1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (30,1,2,60,'2018-05-12 21:00:00','2018-05-12 23:30:00','null,4-7,4-8,4-9,5-8,6-8',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (31,1,3,50,'2018-05-12 15:00:00','2018-05-12 17:30:00','null,4-5,4-6,4-7,5-7',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (32,1,3,60,'2018-05-12 16:00:00','2018-05-12 18:30:00',null,1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (33,3,1,40,'2018-05-13 21:00:00','2018-05-13 23:20:00','null,3-6,3-7,3-8',1);
insert  into `t_schedule`(`s_id`,`s_mid`,`s_rid`,`s_price`,`s_startTime`,`s_endTime`,`s_sellSeat`,`s_condition`) values (34,4,2,50,'2018-05-17 14:00:00','2018-05-17 15:30:00',null,1);

create table `t_sellinformation` (
  `si_id` int(20) not null auto_increment comment '销售订单号',
  `si_time` datetime not null comment '销售时间',
  `si_schedule` int(20) not null comment '场次',
  `si_adultNum` tinyint(4) default null comment '成人数量',
  `si_totalPrice` double not null comment '总价',
  `si_seatId` varchar(500) not null comment '座位编号',
  primary key (`si_id`),
  key `t_sellinformation_ibfk_3` (`si_schedule`),
  constraint `t_sellinformation_ibfk_3` foreign key (`si_schedule`) references `t_schedule` (`s_id`)
) engine=innodb auto_increment=29 default charset=utf8;

insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (1,'2018-05-09 15:06:07',25,2,160,'5-6,5-7,5-8');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (3,'2018-05-08 15:15:08',25,1,80,'5-10');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (4,'2018-05-02 15:15:39',11,3,150,'4-3,4-4,4-5');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (5,'2018-05-05 15:16:14',13,4,320,'5-5,5-6,5-7,5-8');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (7,'2018-05-10 11:24:48',17,2,160,'1-5,1-6');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (8,'2018-05-10 11:28:19',17,2,160,'7-1,7-2');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (9,'2018-05-10 13:27:18',19,2,120,'2-1,2-2');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (10,'2018-05-10 15:27:06',15,3,150,'1-8,1-9,1-10');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (12,'2018-05-11 15:33:24',13,2,160,'4-4,4-5');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (13,'2018-05-11 16:02:17',26,6,360,'4-7,4-8,4-9,5-7,5-8,5-9');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (14,'2018-05-11 16:07:08',26,2,120,'4-5,4-6');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (16,'2018-05-11 16:27:44',27,3,150,'3-3,3-4,3-5');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (17,'2018-05-11 23:38:43',15,3,150,'2-9,2-10,3-10');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (18,'2018-05-12 10:59:24',24,2,120,'4-5,4-6');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (19,'2018-05-12 11:00:08',27,2,100,'2-3,2-4');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (20,'2018-05-12 11:14:52',27,1,50,'2-5');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (21,'2018-05-12 17:32:38',30,3,180,'4-7,4-8,4-9');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (23,'2018-05-13 22:54:14',30,2,120,'5-8,6-8');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (24,'2018-05-14 15:46:37',31,2,100,'4-5,4-6');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (25,'2018-05-14 15:46:50',31,2,100,'4-7,5-7');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (26,'2018-05-14 16:27:23',26,2,120,'3-7,3-8');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (27,'2018-05-16 09:34:38',33,3,120,'3-6,3-7,3-8');
insert  into `t_sellinformation`(`si_id`,`si_time`,`si_schedule`,`si_adultNum`,`si_totalPrice`,`si_seatId`) values (28,'2018-05-16 09:51:01',15,2,100,'4-6,4-7');

