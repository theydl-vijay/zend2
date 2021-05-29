ALTER TABLE `deleted_orders_details` ADD `discount_type` TINYINT(1)  NULL  DEFAULT NULL  AFTER `discount`;
ALTER TABLE `deleted_orders_details` CHANGE `discount_type` `discount_type` TINYINT(1)  NOT NULL  DEFAULT '1';
