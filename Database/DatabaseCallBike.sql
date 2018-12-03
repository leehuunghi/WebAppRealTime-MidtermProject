/*
 Navicat Premium Data Transfer

 Source Server         : DatabaseCallBike
 Source Server Type    : MySQL
 Source Server Version : 80013
 Source Host           : localhost:3306
 Source Schema         : DatabaseCallBike

 Target Server Type    : MySQL
 Target Server Version : 80013
 File Encoding         : 65001

 Date: 03/12/2018 16:58:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for BookingBike
-- ----------------------------
DROP TABLE IF EXISTS `BookingBike`;
CREATE TABLE `BookingBike` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `time` varchar(20) DEFAULT NULL,
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'waiting',
  `guest_lat` decimal(30,15) DEFAULT NULL,
  `guest_lng` decimal(30,15) DEFAULT NULL,
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `driverID` int(11) DEFAULT NULL,
  `driverUsername` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Driver_BookingBIke_usernameDriver` (`driverUsername`),
  CONSTRAINT `Driver_BookingBIke_usernameDriver` FOREIGN KEY (`driverUsername`) REFERENCES `driver` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of BookingBike
-- ----------------------------
BEGIN;
INSERT INTO `BookingBike` VALUES (1, 'le huu nghi', '1048 võ văn kiệt', '0981673403', '1542697054', 'waiting', 10.750709533691406, 106.670547485351560, 'nhớ đem nón bảo hiểm', NULL, NULL);
INSERT INTO `BookingBike` VALUES (2, 'Lê Hữu Nghị', '1048 võ văn kiệt', '0981673403', '1542697093', 'waiting', 10.750710000000000, 106.670550000000000, 'nhớ đem nón bảo hiểm', 1, 'driver1');
INSERT INTO `BookingBike` VALUES (3, 'myproject_quicknote', '221 Nguyễn Biểu', '43526346', '1542697826', 'waiting', 10.762621879577637, 106.660171508789060, 'Họa mie', NULL, NULL);
INSERT INTO `BookingBike` VALUES (4, 'Nhã', '56 Tân Khai', '43526346', '1542697895', 'waiting', 10.762621879577637, 106.660171508789060, 'Họa mie', NULL, NULL);
INSERT INTO `BookingBike` VALUES (5, 'Nhã', '56 Tân Khai', '43526346', '1542704153', 'waiting', 10.762621879577637, 106.660171508789060, 'Họa mie', NULL, NULL);
INSERT INTO `BookingBike` VALUES (6, 'Nhã', '56 Tân Khai', '43526346', '1542704181', 'waiting', 10.762621879577637, 106.660171508789060, 'Họa mie', NULL, NULL);
INSERT INTO `BookingBike` VALUES (7, 'Nhã Trần', '112 Cống Quỳnh', '43526346', '1542708437', 'waiting', 10.762621879577637, 106.660171508789060, 'Họa mie', 1, NULL);
INSERT INTO `BookingBike` VALUES (8, 'Nhã Trần', '112 Cống Quỳnh', '43526346', '1542715012', 'waiting', 10.762621879577637, 106.660171508789060, 'Họa mie', NULL, NULL);
INSERT INTO `BookingBike` VALUES (9, 'Nhã Trần', '112 Cống Quỳnh', '43526346', '1542715013', 'waiting', 10.762621879577637, 106.660171508789060, 'Họa mie', NULL, NULL);
INSERT INTO `BookingBike` VALUES (10, 'Nhã Trần', '112 Cống Quỳnh', '43526346', '1542715013', 'waiting', 10.762621879577637, 106.660171508789060, 'Họa mie', NULL, NULL);
INSERT INTO `BookingBike` VALUES (11, 'Nhã Trần', '112 Cống Quỳnh', '43526346', '1542715014', 'waiting', 10.765009880065918, 106.690422058105470, 'Họa mie', NULL, NULL);
INSERT INTO `BookingBike` VALUES (12, 'Nhã Trần', '112 Cống Quỳnh', '43526346', '1542715014', 'waiting', 10.765009880065918, 106.690422058105470, 'Họa mie', NULL, NULL);
INSERT INTO `BookingBike` VALUES (13, 'Nhã Trần', '112 Cống Quỳnh', '43526346', '1542715014', 'waiting', 10.765009880065918, 106.690422058105470, 'Họa mie', NULL, NULL);
INSERT INTO `BookingBike` VALUES (14, 'Nhã Trần', '112 Cống Quỳnh', '43526346', '1542715014', 'waiting', 10.762621879577637, 106.660171508789060, 'Họa mie', NULL, NULL);
INSERT INTO `BookingBike` VALUES (15, 'Nhã Trần', '112 Cống Quỳnh', '43526346', '1542715014', 'waiting', 10.762621879577637, 106.660171508789060, 'Họa mie', NULL, NULL);
INSERT INTO `BookingBike` VALUES (16, 'Nhã Trần', '112 Cống Quỳnh', '43526346', '1542715015', 'waiting', 10.762621879577637, 106.660171508789060, 'Họa mie', NULL, NULL);
INSERT INTO `BookingBike` VALUES (17, 'Nhã Trần', '112 Cống Quỳnh', '43526346', '1542715015', 'waiting', 10.762621879577637, 106.660171508789060, 'Họa mie', NULL, NULL);
INSERT INTO `BookingBike` VALUES (18, 'Nhã', '185 CMT8', '0981673403', '1542726877', 'waiting', 10.762621879577637, 106.660171508789060, 'Đừng đón', NULL, NULL);
INSERT INTO `BookingBike` VALUES (19, 'Nhã', '2a', '0981673403', '1542726926', 'waiting', 1.602699995040894, 110.433959960937500, 'K rõ', NULL, NULL);
INSERT INTO `BookingBike` VALUES (20, 'Nhã', 'BJNKANDFMD', '0981673403', '1542726952', 'waiting', 10.762621879577637, 106.660171508789060, 'K rõ', NULL, NULL);
INSERT INTO `BookingBike` VALUES (21, 'myproject_quicknote', '221 Nguyễn Biểu', '32331', '1542810212', 'waiting', 10.757650375366211, 106.683036804199220, 'Cổng xanh', NULL, NULL);
INSERT INTO `BookingBike` VALUES (22, 'Hà', '15 Ngô Gia Tự', '111', '1542810254', 'waiting', 10.762621879577637, 106.660171508789060, 'Cổng đỏ', NULL, NULL);
INSERT INTO `BookingBike` VALUES (23, 'Hà', '16 Thanh Trì', '111', '1542810292', 'waiting', 10.762621879577637, 106.660171508789060, 'Cổng vàng', NULL, NULL);
INSERT INTO `BookingBike` VALUES (24, 'Nga', '223 Trần Hưng Đạo', '111', '1542810483', 'waiting', 10.762621879577637, 106.660171508789060, 'Cổng tím', NULL, NULL);
INSERT INTO `BookingBike` VALUES (25, 'Nga', '131 Trần Hưng Đạo', '111', '1542811116', 'waiting', 10.767180442810059, 106.694847106933600, 'Cổng hồng plè', NULL, NULL);
INSERT INTO `BookingBike` VALUES (26, 'Nga', '131 Trần Hưng Đạo', '111', '1542811366', 'waiting', 10.767180442810059, 106.694847106933600, 'Cổng hồng plè', NULL, NULL);
INSERT INTO `BookingBike` VALUES (27, 'Nga', '101 Trần Hưng Đạo', '111', '1542811413', 'waiting', 10.767550000000000, 106.695170000000000, 'Cổng ', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (28, 'Nga', '101 Nguyễn Huệ', '111', '1542812146', 'waiting', 10.762621879577637, 106.660171508789060, 'Cổng trắng', NULL, NULL);
INSERT INTO `BookingBike` VALUES (29, 'Nga', '101 Nguyễn Huệ', '111', '1542812221', 'waiting', 10.762621879577637, 106.660171508789060, 'Cổng trắng', NULL, NULL);
INSERT INTO `BookingBike` VALUES (30, 'Nga', '19 Nguyễn Huệ', '111', '1542812294', 'waiting', 10.762621879577637, 106.660171508789060, 'Cổng trắng', NULL, NULL);
INSERT INTO `BookingBike` VALUES (31, 'Nga', '19 Nguyễn Huệ', '111', '1542812323', 'waiting', 10.771900000000000, 106.705690000000000, 'Cổng trắng', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (32, 'Nga', '19 Nguyễn Trãi', '111', '1542812357', 'waiting', 10.762621879577637, 106.660171508789060, 'Cổng trắng', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (33, 'Nga', '19 Nguyễn Trãi', '111', '1542812592', 'waiting', 10.762621879577637, 106.660171508789060, 'Cổng trắng', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (34, 'Nga', '19 Nguyễn Đình Chiểu', '111', '1542812639', 'waiting', 10.762621879577637, 106.660171508789060, 'Cổng trắng', NULL, NULL);
INSERT INTO `BookingBike` VALUES (35, 'Nga', '19 Nguyễn Đình Chiểu', '111', '1542813670', 'waiting', 10.769240000000000, 106.682060000000000, 'Cổng trắng', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (36, 'Nga', '19 Nguyễn Đình Chiểu', '111', '1542820462', 'waiting', 10.769240000000000, 106.682060000000000, 'Cổng trắng', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (37, 'Nga', '19 Nguyễn Đình Chiểu', '111', '1542820464', 'waiting', 10.762621879577637, 106.660171508789060, 'Cổng trắng', NULL, NULL);
INSERT INTO `BookingBike` VALUES (38, 'undefined', 'undefined', 'undefined', '1542822814', 'waiting', NULL, NULL, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (39, 'undefined', 'undefined', 'undefined', '1542822932', 'waiting', 10.768010000000000, 106.661440000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (40, 'Do Nguyen', '184 Lê Văn Lương', '0765991264', '1542898240', 'waiting', 10.746820000000000, 106.704540000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (41, 'Do Nguyen1', '100 Trần Hưng Đạo', '0765991264', '1542898277', 'waiting', 10.765970000000000, 106.693430000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (42, 'Do Nguyen2', '200 Trần Hưng Đạo', '0765991264', '1542898285', 'waiting', 10.762830000000000, 106.690690000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (43, 'Do Nguyen3', '300 Trần Hưng Đạo', '0765991264', '1542898290', 'waiting', 10.757379531860352, 106.685890197753900, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (44, 'Do Nguyen3', '227 Nguyễn Văn Cừ', '0765991264', '1542898297', 'waiting', 10.762980000000000, 106.682480000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (45, 'Do Nguyen4', '36 Nguyễn Văn Cừ', '0765991264', '1542898304', 'waiting', 21.040240000000000, 105.867679600000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (46, 'Do Nguyen5', '36 Nguyễn Thiện Thuật', '0765991264', '1542898313', 'waiting', 21.037260000000000, 105.850680000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (47, 'Do Nguyen6', '1048 Võ Văn Kiệt', '0765991264', '1542898324', 'waiting', 10.750710000000000, 106.670550000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (48, 'Do Nguyen7', '125/32 Nguyễn Cửu Vân, phường 17, quận Bình Thạnh, thành phố Hồ Chí Minh', '0765991264', '1542898338', 'waiting', NULL, NULL, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (49, 'Do Nguyen8', '34 Thành Thái', '0765991264', '1542898356', 'waiting', 10.768540000000000, 106.666780000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (50, 'Do Nguyen9', '134 Thành Thái', '0765991264', '1542898362', 'waiting', 10.774820000000000, 106.664270000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (51, 'Do Nguyen10', '134 Lý Thường Kiệt', '0765991264', '1542898372', 'waiting', 9.173281600000000, 105.155139300000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (52, 'Do Nguyen11', '5 Lý Thường Kiệt', '0765991264', '1542898379', 'waiting', 10.824470000000000, 106.685380000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (53, 'Do Nguyen12', '19 Lý Thường Kiệt', '0765991264', '1542898384', 'waiting', 10.758710000000000, 106.661410000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (54, 'Do Nguyen12', '52 Võ Văn Ngân', '0765991264', '1542898400', 'waiting', 10.850910000000000, 106.758100000000000, 'undefined', 1, 'driver1');
INSERT INTO `BookingBike` VALUES (55, 'Do Nguyen12', '124 Võ Văn Ngân', '0765991264', '1542898405', 'waiting', 10.850460052490234, 106.760841369628900, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (56, 'Do Nguyen14', '1024 Võ Văn Ngân', '0765991264', '1542898421', 'waiting', 10.850550000000000, 106.766040000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (57, 'Do Nguyen15', '89 Kha Vạn Cân', '0765991264', '1542898433', 'waiting', 10.826730000000000, 106.711960000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (58, 'Do Nguyen16', '92 Phạm Văn Đồng', '0765991264', '1542898443', 'waiting', 21.077110000000000, 105.786490000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (59, 'Do Nguyen17', '200 Nguyễn Tri Phương', '0765991264', '1542898557', 'waiting', 10.760760000000000, 106.668730000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (60, 'Thi Nha - Dung', '184 Lê Văn Lương', '2389', '1542944882', 'waiting', 10.746820000000000, 106.704540000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (61, 'Thi Nha - Dung', '100 Tran Hung Dao', '2389', '1542944893', 'waiting', 10.765970000000000, 106.693430000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (62, 'Thi Nha - Dung', '10 Ly Thuong Kiet', '2389', '1542944909', 'waiting', 10.762621879577637, 106.660171508789060, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (63, 'Thi Nha - Dung', '29 Nguyen Thien Thuat', '2389', '1542944975', 'waiting', 10.762621879577637, 106.660171508789060, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (64, 'Thi Nha - Dung', '189 Nguyen Thi Minh Khai', '2389', '1542944984', 'verify', 10.769150000000000, 106.685270000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (65, 'Thi Nha - Dung', '1 Nguyen Thi Minh Khai', '2389', '1542944992', 'verify', 15.877035100000000, 108.325754300000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (66, 'Do Nguyen - Dung', '125/32 Nguyễn Cửu Vân, phường 17, quận Bình Thạnh, thành phố Hồ Chí Minh', '1978412', '1542945081', 'waiting', 10.762621879577637, 106.660171508789060, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (67, 'Do Nguyen', '1 Nguyen Thi Minh Khai', '1978412', '1542945133', 'waiting', 15.877035100000000, 108.325754300000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (68, 'Do Nguyen', '232 Nguyen Thi Minh Khai', '1978412', '1542945144', 'verify', 10.774320000000000, 106.689990000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (69, 'Do Nguyen', '2 Nguyen Thi Minh Khai', '1978412', '1542945150', 'verify', 10.790470000000000, 106.705150000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (70, 'Do Nguyen', '230 Nguyen Thi Minh Khai', '1978412', '1542945154', 'verify', 10.774340000000000, 106.690000000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (71, 'Do Nguyen', '3 Nguyen Thi Minh Khai', '1978412', '1542945164', 'verify', 10.790050000000000, 106.704940000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (72, 'Do Nguyen', '190 Nguyen Thi Minh Khai', '1978412', '1542945177', 'verify', 10.775640000000000, 106.691220000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (73, 'Do Nguyen', '5 Nguyen Thi Minh Khai', '1978412', '1542945181', 'verify', 10.789250000000000, 106.704190000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (74, 'Do Nguyen', '189 Nguyen Thi Minh Khai', '1978412', '1542945186', 'verify', 10.769150000000000, 106.685270000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (75, 'Do Nguyen', '6 Nguyen Thi Minh Khai', '1978412', '1542945191', 'verify', 10.788760000000000, 106.703560000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (76, 'Thi Nha', '10 Nguyen Thi Minh Khai', '13124212', '1542945284', 'waiting', 10.788390000000000, 106.703190000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (77, 'Thi Nha', '150 Nguyen Thi Minh Khai', '13124212', '1542945397', 'waiting', 10.776930000000000, 106.692460000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (78, 'Thi Nha', '20 Nguyen Thi Minh Khai', '13124212', '1542945404', 'verify', 10.784860000000000, 106.699870000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (79, 'Thi Nha', '140 Nguyen Thi Minh Khai', '13124212', '1542945407', 'verify', 10.777200000000000, 106.692710000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (80, 'Thi Nha', '30 Nguyen Thi Minh Khai', '13124212', '1542945414', 'verify', 10.784350000000000, 106.699380000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (81, 'Thi Nha', '130 Nguyen Thi Minh Khai', '13124212', '1542945421', 'waiting', 10.777470000000000, 106.692970000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (82, 'Thi Nha', '50 Nguyen Thi Minh Khai', '13124212', '1542945427', 'verify', 15.878108700000000, 108.324169600000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (83, 'Thi Nha', '100 Nguyen Thi Minh Khai', '13124212', '1542945436', 'verify', 10.780020000000000, 106.695310000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (84, 'Thi Nha', '100 Nguyen Thi Minh Khai', '13124212', '1542945503', 'moving', 10.780020000000000, 106.695310000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (85, 'Do Nguyen', '100 Nguyen Thi Minh Khai', '3891242', '1542945524', 'moving', 10.780020000000000, 106.695310000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (86, 'D', '4135231', '453513', '1542945561', 'waiting', 10.762621879577637, 106.660171508789060, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (87, 'Do Nguyen17', '125/32 Nguyễn Cửu Vân, phường 17, quận Bình Thạnh, thành phố Hồ Chí Minh', '21412', '1542945649', 'waiting', 10.762621879577637, 106.660171508789060, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (88, 'Do Nguyen17', '4128o47128942', '21412', '1542945832', 'waiting', 10.762621879577637, 106.660171508789060, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (89, 'Do Nguyen17', '20 Thành Thái', '21412', '1542946207', 'verify', 10.768350000000000, 106.666870000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (90, 'Do Nguyen17', '12 Võ Văn Kiệt', '21412', '1542947704', 'verify', 12.643404400000000, 108.015380600000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (91, 'Do Nguyen17', '124 Võ Văn Kiệt', '21412', '1542947711', 'moving', 10.747700000000000, 106.656470000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (92, 'Do Nguyen17', '5 Võ Văn Kiệt', '21412', '1542947721', 'verify', 10.752230000000000, 106.681750000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (93, 'Do Nguyen17', '120 Võ Văn Kiệt', '21412', '1542947726', 'verify', 10.765040000000000, 106.699280000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (94, 'Do Nguyen17', '10 Võ Văn Kiệt', '21412', '1542947730', 'verify', 10.768830000000000, 106.703320000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (95, 'Do Nguyen17', '115 Võ Văn Kiệt', '21412', '1542947734', 'verify', 10.765110000000000, 106.699390000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (96, 'Do Nguyen17', '20 Võ Văn Kiệt', '21412', '1542947744', 'verify', 12.643211100000000, 108.015208100000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (97, 'Do Nguyen17', '110 Võ Văn Kiệt', '21412', '1542947751', 'verify', 10.765290000000000, 106.699680000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (98, 'Do Nguyen17', '25 Võ Văn Kiệt', '21412', '1542947756', 'verify', 10.750085700000000, 106.662609800000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (99, 'Do Nguyen17', '105 Võ Văn Kiệt', '21412', '1542947760', 'verify', 10.765420000000000, 106.699880000000000, 'undefined', NULL, 'driver2');
INSERT INTO `BookingBike` VALUES (100, 'Do Nguyen17', '40 Võ Văn Kiệt', '21412', '1542947764', 'verify', 12.642605200000000, 108.014627000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (101, 'Do Nguyen17', '100 Võ Văn Kiệt', '21412', '1542947768', 'verify', 10.765650000000000, 106.700170000000000, 'undefined', NULL, NULL);
INSERT INTO `BookingBike` VALUES (102, 'Do Nguyen17', '55 Võ Văn Kiệt', '21412', '1542947774', 'moving', 10.767000000000000, 106.701190000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (103, 'Do Nguyen17', '95 Võ Văn Kiệt', '21412', '1542947778', 'moving', 10.765750000000000, 106.700340000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (104, 'Do Nguyen17', '60 Võ Văn Kiệt', '21412', '1542947782', 'moving', 10.766810000000000, 106.701100000000000, 'undefined', 1, 'driver1');
INSERT INTO `BookingBike` VALUES (105, 'Do Nguyen17', '90 Võ Văn Kiệt', '21412', '1542947786', 'moving', 10.765830000000000, 106.700480000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (106, 'Do Nguyen17', '65 Võ Văn Kiệt', '21412', '1542947822', 'moving', 10.766630000000000, 106.701010000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (107, 'Do Nguyen17', '80 Võ Văn Kiệt', '21412', '1542947830', 'moving', 10.748610000000000, 106.658620000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (108, 'Do Nguyen17', '70 Võ Văn Kiệt', '21412', '1542947841', 'moving', 10.766470000000000, 106.700930000000000, 'undefined', 2, 'driver2');
INSERT INTO `BookingBike` VALUES (109, 'Do Nguyen17', '75 Võ Văn Kiệt', '21412', '1542947847', 'hasBike', 10.722100000000000, 106.611750000000000, 'undefined', NULL, 'driver2');
COMMIT;

-- ----------------------------
-- Table structure for Driver
-- ----------------------------
DROP TABLE IF EXISTS `Driver`;
CREATE TABLE `Driver` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `lat` decimal(30,10) DEFAULT NULL,
  `lng` decimal(30,10) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `displayName` varchar(255) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `codeBike` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of Driver
-- ----------------------------
BEGIN;
INSERT INTO `Driver` VALUES (1, 'driver1', 'uFrvCGCBgNudTdrTiuQFRQ==', 'READY', 10.7675769000, 106.6532589000, NULL, 'Lê Hữu Nghị', '0909090909', '94M1 - 7425');
INSERT INTO `Driver` VALUES (2, 'driver2', '2VeE+qZZegJT5IPlAM7T7g==', 'BUSY', 10.7661031000, 106.6641400000, NULL, 'Nha', '000987', '12M-7425');
COMMIT;

-- ----------------------------
-- Table structure for Employee
-- ----------------------------
DROP TABLE IF EXISTS `Employee`;
CREATE TABLE `Employee` (
  `ID` int(30) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of Employee
-- ----------------------------
BEGIN;
INSERT INTO `Employee` VALUES (1, 'admin', 'ISMvKXpXpadDiUoOSoAfww==', NULL);
INSERT INTO `Employee` VALUES (2, 'admin1', '4AzyWtQmg7PfZ4xh9Cxr2g==', NULL);
INSERT INTO `Employee` VALUES (3, 'admin2', 'yEJY6cOQWaiat32Ebdq5CQ==', NULL);
INSERT INTO `Employee` VALUES (4, 'admin3', 'admin3', NULL);
COMMIT;

-- ----------------------------
-- Table structure for userRefreshTokenExt
-- ----------------------------
DROP TABLE IF EXISTS `userRefreshTokenExt`;
CREATE TABLE `userRefreshTokenExt` (
  `userId` int(11) NOT NULL,
  `rfToken` varchar(255) DEFAULT NULL,
  `rdt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of userRefreshTokenExt
-- ----------------------------
BEGIN;
INSERT INTO `userRefreshTokenExt` VALUES (1, 'KrVH5LFm7kj7Hozn55c4VbVfYUQVhHf2u81VZzeZCHJxu8Q8yh3793eivG6kkmnOq2eDiXA4myl8P8X4', '2018-11-30 20:06:20');
INSERT INTO `userRefreshTokenExt` VALUES (2, '0t30MAjCWSq3lvVXzplfMA4KaxGIcqDp940fhE6Ew2QIT5mousV7JFQSxEUDNSQOx8AvOJWRsTr2EOCU', '2018-11-30 20:03:23');
INSERT INTO `userRefreshTokenExt` VALUES (3, 'jNfk0IjPr7Mz9RtNzQBQ4pGEtcwuFd5IULeDaTNCsbpkC9QVd1kuiiJbDaurWxwEImUNEBY99mObY4fX', '2018-11-20 17:50:42');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
