USE `essentialmode`;

CREATE TABLE `dirtyshops` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`store` varchar(100) NOT NULL,
	`item` varchar(100) NOT NULL,
	`price` int(11) NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `dirtyshops` (`id`, `store`, `item`, `price`) VALUES
(1, ' ShopTienBan', 'bread', 30),
;
