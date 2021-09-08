USE `essentialmode`;

CREATE TABLE `shops` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`store` varchar(100) NOT NULL,
	`item` varchar(100) NOT NULL,
	`price` int(11) NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `shops` (
s `store`, `item`, `price`) VALUES
(1, 'TwentyFourSeven', 'bread', 30),
(2, 'TwentyFourSeven', 'water', 15),
(3, 'RobsLiquor', 'bread', 30),
(4, 'RobsLiquor', 'water', 15),
(5, 'LTDgasoline', 'bread', 30),
(6, 'LTDgasoline', 'water', 15),
(7, 'Bar', 'beer', 30),
(8, 'Bar', 'wine', 25),
(9, 'Bar', 'vodka', 60),
(10, 'Bar', 'tequila', 40),
(11, 'Bar', 'whisky', 50),
(12, 'Bar', 'cigarett', 30),
(13, 'Bar', 'lighter', 25),
(14, 'Disco', 'beer', 30),
(15, 'Disco', 'wine', 25),
(16, 'Disco', 'vodka', 60),
(17, 'Disco', 'tequila', 40),
(18, 'Disco', 'whisky', 50),
(19, 'Disco', 'gintonic', 70),
(20, 'Disco', 'absinthe', 100),
(21, 'Disco', 'champagne', 150),
(22, 'Disco', 'cigarett', 30),
(23, 'Disco', 'lighter', 25),
(24, 'TwentyFourSeven','drill',1000),
(25, 'RobsLiquor','drill',1000),
(26, 'LTDgasoline','drill',1000),
(27, 'TwentyFourSeven','licenseplate',999999999),
(28, 'RobsLiquor','licenseplate',999999999),
(29, 'LTDgasoline','licenseplate',999999999),
(30, 'TwentyFourSeven','scuba_suit',10000),
(31, 'RobsLiquor','scuba_suit',10000),
(32, 'LTDgasoline','scuba_suit',10000),
;
