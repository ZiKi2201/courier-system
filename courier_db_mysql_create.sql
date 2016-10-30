CREATE TABLE `users` (
	`id` int NOT NULL,
	`login` varchar(255) NOT NULL UNIQUE,
	`password` varchar(32) NOT NULL UNIQUE,
	`description` TEXT NOT NULL,
	`name` varchar(255) NOT NULL,
	`company` varchar(255) NOT NULL,
	`session_hash` varchar(32) NOT NULL,
	`courier_status` tinyint NOT NULL,
	`phone` int NOT NULL,
	`courier_transport_id` int NOT NULL,
	`role_id` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `orders` (
	`id` int NOT NULL UNIQUE,
	`name` varchar NOT NULL,
	`courier_id` int NOT NULL,
	`date_create` DATE NOT NULL,
	`date_delivery` DATE NOT NULL,
	`status_id` int NOT NULL,
	`customer_id` int NOT NULL,
	`payment_method` varchar NOT NULL,
	`sender_id` int NOT NULL UNIQUE,
	`cargo_type` varchar NOT NULL,
	`cargo_weight` int NOT NULL,
	`cargo_length` int NOT NULL,
	`cargo_width` int NOT NULL,
	`cargo_height` int NOT NULL,
	`cargo_comment` TEXT NOT NULL,
	`recipient_id` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `transport` (
	`id` int NOT NULL UNIQUE,
	`type_name` varchar(255) NOT NULL UNIQUE,
	`parent_id` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `role` (
	`id` int NOT NULL UNIQUE,
	`name` varchar NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `priv` (
	`id` int NOT NULL UNIQUE,
	`name` varchar NOT NULL AUTO_INCREMENT UNIQUE,
	PRIMARY KEY (`id`)
);

CREATE TABLE `role_priv` (
	`role_id` int NOT NULL,
	`priv_id` int NOT NULL
);

CREATE TABLE `sender` (
	`id` int NOT NULL UNIQUE,
	`name` varchar NOT NULL,
	`phone` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `recipient` (
	`id` int NOT NULL UNIQUE,
	`name` varchar NOT NULL,
	`phone` int NOT NULL,
	`comment` TEXT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `statuses` (
	`id` int NOT NULL,
	`name` varchar NOT NULL,
	PRIMARY KEY (`id`)
);

ALTER TABLE `users` ADD CONSTRAINT `users_fk0` FOREIGN KEY (`courier_transport_id`) REFERENCES `transport`(`id`);

ALTER TABLE `users` ADD CONSTRAINT `users_fk1` FOREIGN KEY (`role_id`) REFERENCES `role`(`id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk0` FOREIGN KEY (`courier_id`) REFERENCES `users`(`id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk1` FOREIGN KEY (`status_id`) REFERENCES `statuses`(`id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk2` FOREIGN KEY (`customer_id`) REFERENCES `users`(`id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk3` FOREIGN KEY (`sender_id`) REFERENCES `sender`(`id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk4` FOREIGN KEY (`recipient_id`) REFERENCES `recipient`(`id`);

ALTER TABLE `role_priv` ADD CONSTRAINT `role_priv_fk0` FOREIGN KEY (`role_id`) REFERENCES `role`(`id`);

ALTER TABLE `role_priv` ADD CONSTRAINT `role_priv_fk1` FOREIGN KEY (`priv_id`) REFERENCES `priv`(`id`);

