DROP TABLE 1customers;CREATE TABLE `1customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(50) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COMMENT='trigger: dont allow delete of records, if deleted, mark them as inactive';INSERT INTO 1customers VALUES("1","test company","","","","","","","","","","","","","","","","","","");INSERT INTO 1customers VALUES("8","customer","customer","customer","customer","customer","customer","customer","customer","customer","customer","customer","customer@customer.com","customer","customer123","PHPMyAdmin Test/Debug","","2017-12-09 10:21:11","","N");


DROP TABLE 2_1rfq_request_attachments;CREATE TABLE `2_1rfq_request_attachments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `rfq_request_id` int(11) NOT NULL,
  `upload_file_path` varchar(500) NOT NULL DEFAULT '',
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rfq_request_id` (`rfq_request_id`),
  CONSTRAINT `fk_rfq_request_id` FOREIGN KEY (`rfq_request_id`) REFERENCES `2rfq_request` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;INSERT INTO 2_1rfq_request_attachments VALUES("1","1","test.jpg","","","","","");


DROP TABLE 2rfq_request;CREATE TABLE `2rfq_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `quote_requested_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `quote_required_date` date NOT NULL,
  `equivalent_cables` varchar(255) DEFAULT NULL,
  `equivalent_connectors` varchar(255) DEFAULT NULL,
  `equivalent_terminal` tinyint(1) NOT NULL DEFAULT '0',
  `equivalent_shrinktube` tinyint(1) NOT NULL DEFAULT '0',
  `equivalent_sleeve` tinyint(1) NOT NULL DEFAULT '0',
  `equivalent_other` varchar(255) DEFAULT NULL,
  `allow_partial_shipments` tinyint(1) NOT NULL DEFAULT '0',
  `packaging_requirements` varchar(255) DEFAULT NULL,
  `testing_level` varchar(255) DEFAULT NULL,
  `testing_additional_requirements` varchar(500) DEFAULT NULL,
  `testing_upload_document` varchar(500) DEFAULT NULL,
  `target_price_suggestion` varchar(255) DEFAULT NULL,
  `mfg_location_usa` tinyint(1) NOT NULL DEFAULT '0',
  `mfg_location_india` tinyint(1) NOT NULL DEFAULT '0',
  `quote_based_on` enum('Best Price','Best Lead Time') DEFAULT NULL,
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rfq_request_custid` (`customer_id`),
  CONSTRAINT `fk_rfq_request_custid` FOREIGN KEY (`customer_id`) REFERENCES `1customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;INSERT INTO 2rfq_request VALUES("1","1","2017-12-08 07:28:21","0000-00-00","","","1","0","0","","0","","","","","","0","0","","","","","","");INSERT INTO 2rfq_request VALUES("3","","2017-12-09 10:30:31","2017-12-09","0","0","1","1","1","0","1","test","testing 2","test","[{\"name\":\"rfq_testing_files\\/Screen Shot 2017-12-09 at 9.50.23 AM_epe1ntmh.png\",\"usrName\":\"Screen Shot 2017-12-09 at 9.50.23 AM.png\",\"size\":730297,\"type\":\"image\\/png\",\"searchStr\":\"Screen Shot 2017-12-09 at 9.50.23 AM.png,!Screen Shot 2017-12-09 at 9.50.17 AM.png,!Screen Shot 2017-12-09 at 9.47.34 AM.png,!:sStrEnd\"},{\"name\":\"rfq_testing_files\\/Screen Shot 2017-12-09 at 9.50.17 AM_cj3gp01m.png\",\"usrName\":\"Screen Shot 2017-12-09 at 9.50.17 AM.png\",\"size\":1468329,\"type\":\"image\\/png\"},{\"name\":\"rfq_te","$22","1","1","Best Lead Time","PHPMyAdmin Test/Debug","","2017-12-09 10:32:19","","N");


DROP TABLE 3_1rfq_items;CREATE TABLE `3_1rfq_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfq_request_id` int(11) NOT NULL,
  `rfq_id` int(11) NOT NULL COMMENT 'trigger: update this value based on rfq_request_id table',
  `item_id` varchar(255) NOT NULL DEFAULT '',
  `item_name` varchar(255) NOT NULL DEFAULT '',
  `rev` varchar(5) NOT NULL DEFAULT 'A',
  `rfq_items_release_qtys` varchar(255) DEFAULT NULL COMMENT 'trigger entered comma seperated from rfq_items_qty.qty tqble',
  `estimated_annual_usage` varchar(50) DEFAULT NULL,
  `quote_required_date` date DEFAULT NULL,
  `equivalent_cables` varchar(255) DEFAULT NULL,
  `equivalent_connectors` varchar(255) DEFAULT NULL,
  `equivalent_terminal` tinyint(1) NOT NULL DEFAULT '0',
  `equivalent_shrinktube` tinyint(1) NOT NULL DEFAULT '0',
  `equivalent_sleeve` tinyint(1) NOT NULL DEFAULT '0',
  `equivalent_other` varchar(255) DEFAULT NULL,
  `allow_partial_shipments` tinyint(1) NOT NULL DEFAULT '0',
  `packaging_requirements` varchar(255) DEFAULT NULL,
  `testing_level` varchar(255) DEFAULT NULL,
  `testing_additional_requirements` varchar(500) DEFAULT NULL,
  `testing_upload_document` varchar(500) DEFAULT NULL,
  `target_price_suggestion` varchar(255) DEFAULT NULL,
  `mfg_location_usa` tinyint(1) NOT NULL DEFAULT '0',
  `mfg_location_india` tinyint(1) NOT NULL DEFAULT '0',
  `bom_upload_document` varchar(500) DEFAULT NULL,
  `progress_dwg_percentage` int(11) DEFAULT NULL,
  `progress_bom_percentage` int(11) DEFAULT NULL,
  `progress_labor_percentage` int(11) DEFAULT NULL,
  `pushed_to_us_erp_datetime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pushed_to_us_erp_request_log_dump` text,
  `pushed_to_us_erp_response_log_dump` text,
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rfqid` (`rfq_request_id`),
  KEY `fk_rfqid_id` (`rfq_id`),
  CONSTRAINT `fk_rfqid` FOREIGN KEY (`rfq_request_id`) REFERENCES `2rfq_request` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rfqid_id` FOREIGN KEY (`rfq_id`) REFERENCES `3rfq` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;INSERT INTO 3_1rfq_items VALUES("1","1","1","mainassembleid","main assembly name","A","100,20,30,15","2000","","","","0","0","0","","0","","","","","","0","0","","","","","0000-00-00 00:00:00","","","","PHPMyAdmin Test/Debug","","","N");INSERT INTO 3_1rfq_items VALUES("2","1","1","mainasseblytwo","main assemble two (2)","A","100,20,30,15","1000","","","","0","0","0","","0","","","","","","0","0","","","","","0000-00-00 00:00:00","","","","PHPMyAdmin Test/Debug","","","N");


DROP TABLE 3_2rfq_items__qty;CREATE TABLE `3_2rfq_items__qty` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `rfq_items_id` int(11) NOT NULL,
  `rfq_id` int(11) NOT NULL COMMENT 'trigger: get rfq.id from rfq_items_id = rfq_items.id',
  `release_qty` int(11) DEFAULT NULL,
  `release_group` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'trigger: group small quantities of same rfq together and leave the largest one out (if available)',
  `total_material_value` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT 'trigger: calculate this value from rfq_consolidated_bom_costing table',
  `total_labor_cost` decimal(9,2) NOT NULL DEFAULT '0.00',
  `unit_price_sell_usa` decimal(9,2) NOT NULL DEFAULT '0.00',
  `unit_price_sell_india` decimal(9,2) NOT NULL DEFAULT '0.00',
  `extended_value_price_usa` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT 'trigger: release_qty x unit_price_sell_usa',
  `extended_value_price_india` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT 'trigger: release_qty x unit_price_sell_india',
  `excess_material_price` decimal(9,2) NOT NULL DEFAULT '0.00',
  `lead_time_material_in_days` int(11) NOT NULL DEFAULT '0' COMMENT 'trigger: auto calculate based on most days out of all material',
  `lead_time_material_in_days_manual_override` int(11) NOT NULL DEFAULT '0',
  `lead_time_labor_production_time_in_days` int(11) NOT NULL DEFAULT '0' COMMENT 'trigger: auto calculate days based on 8 hours per day',
  `lead_time_labor_production_time_in_days_manual_override` int(11) NOT NULL DEFAULT '0',
  `lead_time_first_article` int(11) NOT NULL DEFAULT '0',
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rfq_items_qtyid` (`rfq_items_id`),
  KEY `fk_qty_rfqid_id` (`rfq_id`),
  CONSTRAINT `fk_qty_rfqid_id` FOREIGN KEY (`rfq_id`) REFERENCES `3rfq` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rfq_items_qtyid` FOREIGN KEY (`rfq_items_id`) REFERENCES `3_1rfq_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;INSERT INTO 3_2rfq_items__qty VALUES("1","1","1","100","1","255.00","0.00","0.00","0.00","0.00","0.00","0.00","0","0","0","0","0","","PHPMyAdmin Test/Debug","","","");INSERT INTO 3_2rfq_items__qty VALUES("2","1","1","20","2","333.00","0.00","0.00","0.00","0.00","0.00","0.00","0","0","0","0","0","","PHPMyAdmin Test/Debug","","","");INSERT INTO 3_2rfq_items__qty VALUES("3","1","1","30","0","0.00","0.00","0.00","0.00","0.00","0.00","0.00","0","0","0","0","0","","PHPMyAdmin Test/Debug","","","");INSERT INTO 3_2rfq_items__qty VALUES("11","1","1","15","0","0.00","0.00","0.00","0.00","0.00","0.00","0.00","0","0","0","0","0","PHPMyAdmin Test/Debug","","","","");


DROP TABLE 3_2rfq_items__qty_clone;CREATE TABLE `3_2rfq_items__qty_clone` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `rfq_items_id` int(11) NOT NULL,
  `rfq_id` int(11) NOT NULL COMMENT 'done-trigger: get rfq.id from rfq_items_id = rfq_items.id',
  `release_qty` int(11) DEFAULT NULL,
  `release_group` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'trigger: group small quantities of same rfq together and leave the largest one out (if available)',
  `total_material_value` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT 'trigger: calculate this value from rfq_consolidated_bom_costing table',
  `total_labor_cost` decimal(9,2) NOT NULL DEFAULT '0.00',
  `unit_price_sell_usa` decimal(9,2) NOT NULL DEFAULT '0.00',
  `unit_price_sell_india` decimal(9,2) NOT NULL DEFAULT '0.00',
  `extended_value_price_usa` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT 'trigger: release_qty x unit_price_sell_usa',
  `extended_value_price_india` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT 'trigger: release_qty x unit_price_sell_india',
  `excess_material_price` decimal(9,2) NOT NULL DEFAULT '0.00',
  `lead_time_material_in_days` int(11) NOT NULL DEFAULT '0' COMMENT 'trigger: auto calculate based on most days out of all material',
  `lead_time_material_in_days_manual_override` int(11) NOT NULL DEFAULT '0',
  `lead_time_labor_production_time_in_days` int(11) NOT NULL DEFAULT '0' COMMENT 'trigger: auto calculate days based on 8 hours per day',
  `lead_time_labor_production_time_in_days_manual_override` int(11) NOT NULL DEFAULT '0',
  `lead_time_first_article` int(11) NOT NULL DEFAULT '0',
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rfq_items_qtyid` (`rfq_items_id`),
  KEY `fk_qty_rfqid_id` (`rfq_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;INSERT INTO 3_2rfq_items__qty_clone VALUES("1","1","1","100","1","255.00","0.00","0.00","0.00","0.00","0.00","0.00","0","0","0","0","0","","PHPMyAdmin Test/Debug","","","N");INSERT INTO 3_2rfq_items__qty_clone VALUES("2","1","1","20","2","333.00","0.00","0.00","0.00","0.00","0.00","0.00","0","0","0","0","0","","PHPMyAdmin Test/Debug","","","N");INSERT INTO 3_2rfq_items__qty_clone VALUES("3","1","1","30","0","0.00","0.00","0.00","0.00","0.00","0.00","0.00","0","0","0","0","0","","PHPMyAdmin Test/Debug","","","N");INSERT INTO 3_2rfq_items__qty_clone VALUES("11","1","1","15","0","0.00","0.00","0.00","0.00","0.00","0.00","0.00","0","0","0","0","0","PHPMyAdmin Test/Debug","","2017-12-12 13:16:06","","N");


DROP TABLE 3rfq;CREATE TABLE `3rfq` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfq_request_id` int(11) NOT NULL,
  `customer_name` varchar(255) DEFAULT NULL COMMENT 'trigger auto enter from rfq_request.customers_id.company_name',
  `priority` varchar(50) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `progress_dwg_percentage` int(11) DEFAULT NULL,
  `progress_bom_percentage` int(11) DEFAULT NULL,
  `progress_labor_percentage` int(11) DEFAULT NULL,
  `manager_user_id` int(11) DEFAULT NULL,
  `engineer_user_id` int(11) DEFAULT NULL,
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rfqiddd` (`rfq_request_id`),
  CONSTRAINT `fk_rfqiddd` FOREIGN KEY (`rfq_request_id`) REFERENCES `2rfq_request` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;INSERT INTO 3rfq VALUES("1","1","test company","Medium","2017-12-18","","","","","","","","","","");


DROP TABLE 4rfq_items_drawing;CREATE TABLE `4rfq_items_drawing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfq_items_id` int(11) NOT NULL,
  `rfq_id` int(11) NOT NULL COMMENT 'trigger: get value based on rfq_items_id',
  `version_number` int(11) NOT NULL COMMENT 'trigger: add version auto based on last value',
  `dwg_description` varchar(255) DEFAULT NULL,
  `default_rev` tinyint(1) NOT NULL DEFAULT '0',
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_drawing_rfq_items` (`rfq_items_id`),
  KEY `fk_itesmdwg_rfqid` (`rfq_id`),
  CONSTRAINT `fk_drawing_rfq_items` FOREIGN KEY (`rfq_items_id`) REFERENCES `3_1rfq_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_itesmdwg_rfqid` FOREIGN KEY (`rfq_id`) REFERENCES `3rfq` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE 5_1_1_1rfq_consolidated_bom_costing;CREATE TABLE `5_1_1_1rfq_consolidated_bom_costing` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `rfq_id` int(11) NOT NULL,
  `rfq_consolidated_bom_id` int(11) DEFAULT NULL,
  `release_qtys` varchar(50) NOT NULL DEFAULT '' COMMENT 'trigger: select release_group,group_concat(rfq_items_id) as rfq_item_ids, group_concat(release_qty) as release_qtys from `3.2rfq_items__qty` \\nwhere rfq_id = 1\\ngroup by release_group',
  `rfq_items_ids` varchar(50) NOT NULL DEFAULT '' COMMENT 'trigger: SAME AS ABOVE',
  `release_group` int(11) NOT NULL COMMENT 'trigger: SAME AS ABOVE',
  `required_qty` int(11) NOT NULL COMMENT 'trigger: ASK FORMULA - COMPLEX ALERT!',
  `source_type_auto` enum('erp1','octaparts','manual') NOT NULL DEFAULT 'manual' COMMENT 'trigger: change to erp1 if entry found in erp1_items table that has enough quantity, if part not found it will change to octaparts.  cron script to change to octaparts if part found in octaparts with dump of data.  if octaparts cron cannot find it, it will change the type to manual',
  `source_type_manual` enum('erp1','octaparts','manual') DEFAULT NULL,
  `octa_parts_api_response_json_dump` text,
  `octa_parts_api_response_datetime` datetime DEFAULT '0000-00-00 00:00:00',
  `unit_price_purchase` decimal(9,2) NOT NULL DEFAULT '0.00',
  `marked_price_calculate` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT 'trigger: calculate this based on unit_price, markup_price_percentage and market_price_dollar fields',
  `purchase_qty` int(11) NOT NULL DEFAULT '0' COMMENT 'trigger: calculate this based on MOQ and MULTI and compare with required_qty',
  `excess_qty` int(11) NOT NULL DEFAULT '0' COMMENT 'trigger: calculate based purchase_qty - required_qty',
  `price_line_total_purchase` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT 'trigger: required_qty x unit_price',
  `price_line_total_customer` decimal(9,2) NOT NULL DEFAULT '0.00',
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rfq_consolidated_bom_cost` (`rfq_consolidated_bom_id`),
  KEY `fk_consolidated_rfqid` (`rfq_id`),
  CONSTRAINT `fk_consolidated_rfqid` FOREIGN KEY (`rfq_id`) REFERENCES `3rfq` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rfq_consolidated_bom_cost` FOREIGN KEY (`rfq_consolidated_bom_id`) REFERENCES `5_1_1rfq_consolidated_bom` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;INSERT INTO 5_1_1_1rfq_consolidated_bom_costing VALUES("1","1","1","10,5","1,2","1","60","manual","","","","0.00","0.00","0","0","0.00","0.00","","","","","");INSERT INTO 5_1_1_1rfq_consolidated_bom_costing VALUES("2","1","1","20,15","1,2","2","130","manual","","","","0.00","0.00","0","0","0.00","0.00","","","","","");INSERT INTO 5_1_1_1rfq_consolidated_bom_costing VALUES("4","1","1","30","1","3","150","manual","","","","0.00","0.00","0","0","0.00","0.00","","","","","");INSERT INTO 5_1_1_1rfq_consolidated_bom_costing VALUES("5","1","4","10,5","1,2","1","15","manual","","","","0.00","0.00","0","0","0.00","0.00","","","","","");INSERT INTO 5_1_1_1rfq_consolidated_bom_costing VALUES("6","1","4","20,15","1,2","2","45","manual","","","","0.00","0.00","0","0","0.00","0.00","","","","","");INSERT INTO 5_1_1_1rfq_consolidated_bom_costing VALUES("7","1","4","30","1","3","0","manual","","","","0.00","0.00","0","0","0.00","0.00","","","","","");INSERT INTO 5_1_1_1rfq_consolidated_bom_costing VALUES("8","1","5","10,5","1,2","1","40","manual","","","","0.00","0.00","0","0","0.00","0.00","","","","","");INSERT INTO 5_1_1_1rfq_consolidated_bom_costing VALUES("9","1","5","20,15","1,2","2","120","manual","","","","0.00","0.00","0","0","0.00","0.00","","","","","");INSERT INTO 5_1_1_1rfq_consolidated_bom_costing VALUES("10","1","5","30","1","3","0","manual","","","","0.00","0.00","0","0","0.00","0.00","","","","","");INSERT INTO 5_1_1_1rfq_consolidated_bom_costing VALUES("12","1","2","10,5","1,2","1","10","manual","","","","0.00","0.00","0","0","0.00","0.00","","","","","");INSERT INTO 5_1_1_1rfq_consolidated_bom_costing VALUES("13","1","2","20,15","1,2","2","20","manual","","","","0.00","0.00","0","0","0.00","0.00","","","","","");INSERT INTO 5_1_1_1rfq_consolidated_bom_costing VALUES("14","1","2","30","1","3","30","manual","","","","0.00","0.00","0","0","0.00","0.00","","","","","");


DROP TABLE 5_1_1_2rfq_consolidated_bom_required_vendor;CREATE TABLE `5_1_1_2rfq_consolidated_bom_required_vendor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfq_consolidated_bom_id` int(11) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `vendor_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'trigger: entered via m_vendors table',
  `vendor_email` varchar(255) NOT NULL DEFAULT '' COMMENT 'trigger: entered via m_vendors table',
  `requested_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `requested_message` text,
  `vendor_response_datetime` datetime DEFAULT '0000-00-00 00:00:00',
  `vendor_response_upload_file` varchar(500) DEFAULT NULL,
  `vendor_response_price` decimal(9,2) NOT NULL DEFAULT '0.00',
  `vendor_response_price_for_qty` int(11) NOT NULL DEFAULT '0' COMMENT 'UI will show multiple required qty, then it would loop through those qty, and insert multiple rows in this table',
  `vendor_visit_read_stats` int(11) NOT NULL DEFAULT '0' COMMENT 'trigger: count() number of entries for this row in vendor_visit_read_stats table',
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_vendorid_consolidatedbom` (`rfq_consolidated_bom_id`),
  KEY `fk_consolidatedbom_vendorid` (`vendor_id`),
  CONSTRAINT `fk_consolidatedbom_vendorid` FOREIGN KEY (`vendor_id`) REFERENCES `m_vendors` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_vendorid_consolidatedbom` FOREIGN KEY (`rfq_consolidated_bom_id`) REFERENCES `5_1_1rfq_consolidated_bom` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE 5_1_1_2rfq_consolidated_bom_required_vendor_stats;CREATE TABLE `5_1_1_2rfq_consolidated_bom_required_vendor_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfq_consolidated_bom_required_vendor_id` int(11) NOT NULL,
  `vendor_ip_address` varchar(50) NOT NULL DEFAULT '',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_vendorvisitstats` (`rfq_consolidated_bom_required_vendor_id`),
  CONSTRAINT `fk_vendorvisitstats` FOREIGN KEY (`rfq_consolidated_bom_required_vendor_id`) REFERENCES `5_1_1_2rfq_consolidated_bom_required_vendor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE 5_1_1rfq_consolidated_bom;CREATE TABLE `5_1_1rfq_consolidated_bom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfq_id` int(11) NOT NULL COMMENT 'trigger entered',
  `rfq_items_bom_items_ids` varchar(100) DEFAULT NULL,
  `item_no` varchar(255) NOT NULL DEFAULT '' COMMENT 'trigger entered',
  `item_desc` varchar(255) DEFAULT '' COMMENT 'trigger entered',
  `mfg_partnumber` varchar(255) DEFAULT NULL COMMENT 'trigger entered',
  `cypress_partnumber` varchar(255) DEFAULT NULL COMMENT 'trigger entered',
  `rev` varchar(5) DEFAULT NULL COMMENT 'trigger entered',
  `bom_level` varchar(50) NOT NULL DEFAULT '0' COMMENT 'trigger entered',
  `equivalent` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'trigger entered',
  `quantity_for_one_piece` int(11) NOT NULL DEFAULT '0' COMMENT 'trigger entered - SUM() the values from 5.1rfq_items_bom_items.qty for_one_piece',
  `uom` varchar(255) NOT NULL DEFAULT '' COMMENT 'trigger entered',
  `vendor_id` int(11) DEFAULT NULL,
  `vendor_name` varchar(255) DEFAULT NULL,
  `available_stock` int(11) DEFAULT NULL,
  `country_of_origin` varchar(255) DEFAULT NULL,
  `lead_time_in_days` int(11) DEFAULT NULL,
  `moq` int(11) NOT NULL DEFAULT '1',
  `multiples` int(11) NOT NULL DEFAULT '1',
  `requested_vendor` tinyint(4) DEFAULT NULL,
  `markup_percentage` decimal(9,2) NOT NULL DEFAULT '0.00',
  `markup_dollars` decimal(9,2) NOT NULL DEFAULT '0.00',
  `note` varchar(255) DEFAULT NULL COMMENT 'trigger entered',
  `rfq_items_bom_ids` varchar(255) DEFAULT NULL COMMENT 'trigger entered - concat the id columns comma seperated here',
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rcb_rfqid` (`rfq_id`),
  CONSTRAINT `rcb_rfqid` FOREIGN KEY (`rfq_id`) REFERENCES `3rfq` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COMMENT='trigger: this table is auto populated based on rfq_items_bom table, all entries from rfq_items_bom table are auto entered in this table by keeping item_no as unique, i.e. if item_no repeats, then total the qty and concat notes';INSERT INTO 5_1_1rfq_consolidated_bom VALUES("1","1","","bomitem1","bom item 1","","","","0","0","7","","","","","","","0","0","","0.00","0.00","","","","","","","");INSERT INTO 5_1_1rfq_consolidated_bom VALUES("2","1","","subofbomitem1","","","","","0","0","3","","","","","","","0","0","","0.00","0.00","","","","PHPMyAdmin Test/Debug","","","N");INSERT INTO 5_1_1rfq_consolidated_bom VALUES("4","1","","bomitem2","","","","","0","0","3","","","","","","","0","0","","0.00","0.00","","","","","","","");INSERT INTO 5_1_1rfq_consolidated_bom VALUES("5","1","","bomitem3","","","","","0","0","8","","","","","","","0","0","","0.00","0.00","","","","","","","");


DROP TABLE 5_1rfq_items_bom_items;CREATE TABLE `5_1rfq_items_bom_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfq_items_bom_id` int(11) NOT NULL,
  `rfq_items_bom_items_id` int(11) DEFAULT NULL COMMENT 'this field is to check if BOM item has a parent assembly',
  `rfq_id` int(11) NOT NULL COMMENT 'trigger: enter based on rfq_items_bom_id table',
  `item_no` varchar(255) DEFAULT NULL,
  `item_desc` varchar(255) DEFAULT NULL,
  `mfg_part_number` varchar(255) DEFAULT NULL,
  `equivalent` tinyint(1) NOT NULL DEFAULT '0',
  `qty` int(11) NOT NULL DEFAULT '0',
  `uom` varchar(255) NOT NULL DEFAULT 'Each',
  `rev` varchar(5) DEFAULT NULL,
  `inbound_freight` tinyint(1) NOT NULL DEFAULT '0',
  `note` varchar(255) DEFAULT NULL,
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `item_no` (`item_no`,`rfq_items_bom_id`),
  KEY `rfq_items_bom_itemsid` (`rfq_items_bom_id`),
  KEY `fk_parentbomid` (`rfq_items_bom_items_id`),
  CONSTRAINT `fk_parentbomid` FOREIGN KEY (`rfq_items_bom_items_id`) REFERENCES `5_1rfq_items_bom_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rfq_items_bom_itemsid` FOREIGN KEY (`rfq_items_bom_id`) REFERENCES `5rfq_items_bom` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;INSERT INTO 5_1rfq_items_bom_items VALUES("4","1","","0","bomitem1","bom item 1","","0","5","Each","","0","","","","","","");INSERT INTO 5_1rfq_items_bom_items VALUES("5","1","10","0","subofbomitem1","sub of bom item 1","","0","3","Each","","0","","","PHPMyAdmin Test/Debug","","","N");INSERT INTO 5_1rfq_items_bom_items VALUES("6","1","","0","bomitem2","bom item 2","","0","3","Each","","0","","","","","","");INSERT INTO 5_1rfq_items_bom_items VALUES("8","2","","0","bomitem1","bom item 1","","0","2","Each","","0","","","","","","");INSERT INTO 5_1rfq_items_bom_items VALUES("9","2","","0","bomitem3","bom item 3","","0","8","Each","","0","","","","","","");INSERT INTO 5_1rfq_items_bom_items VALUES("10","1","","0","bomitem22","bom item 2 for item 1","","0","1","Each","","0","","","","","","");


DROP TABLE 5rfq_items_bom;CREATE TABLE `5rfq_items_bom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfq_items_id` int(11) NOT NULL,
  `rfq_id` int(11) NOT NULL COMMENT 'trigger: get value based on rfq_items_id',
  `version_number` int(11) NOT NULL COMMENT 'trigger: add version auto based on last value',
  `bom_desc` varchar(255) DEFAULT NULL,
  `bom_upload_document` varchar(500) DEFAULT NULL,
  `default_rev` tinyint(1) DEFAULT NULL COMMENT 'trigger: only 1 rev per rfq_items_id is allowed, so if new is set, unset others',
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rfq_items_bom` (`rfq_items_id`),
  KEY `fk_itemsbom_rfqid` (`rfq_id`),
  CONSTRAINT `fk_itemsbom_rfqid` FOREIGN KEY (`rfq_id`) REFERENCES `3rfq` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rfq_items_bom` FOREIGN KEY (`rfq_items_id`) REFERENCES `3_1rfq_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;INSERT INTO 5rfq_items_bom VALUES("1","1","1","1","","","1","","","","","");INSERT INTO 5rfq_items_bom VALUES("2","2","1","1","","","1","","","","","");


DROP TABLE 6_1rfq_items_labor_summary;CREATE TABLE `6_1rfq_items_labor_summary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfq_items_id` int(11) NOT NULL COMMENT 'trigger: get this from rfq_tiems_labor table',
  `rfq_id` int(11) NOT NULL COMMENT 'trigger: get this based on rfq_items_labor table',
  `total_labor_hours` decimal(9,4) NOT NULL DEFAULT '0.0000' COMMENT 'trigger: sum of all rows of rfq_items_labor based on rfq_items_id',
  `margin_of_error_percentage` decimal(9,2) NOT NULL DEFAULT '0.00',
  `setup_of_hours_percentage` decimal(9,2) NOT NULL DEFAULT '0.00',
  `gross_labor_hours` decimal(9,4) NOT NULL DEFAULT '0.0000' COMMENT 'trigger: ASK FORMULA: ',
  `labor_rate_usa` decimal(9,2) NOT NULL DEFAULT '0.00',
  `labor_rate_india` decimal(9,2) NOT NULL DEFAULT '0.00',
  `total_labor_cost_usa` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT 'trigger: ASK FORMULA: ',
  `total_labor_cost_india` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT 'trigger: same as above, except input is _india fields',
  `labor_margin` int(2) NOT NULL DEFAULT '0',
  `gross_labor_cost_usa` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT 'trigger: ASK FORMULA: ',
  `gross_labor_cost_india` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT 'trigger: same as above, except input is _india fields',
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rfq_id` (`rfq_id`,`rfq_items_id`),
  KEY `fk_rfqitemslabor_rfq_itemsid` (`rfq_items_id`),
  CONSTRAINT `fk_rfqitemslabor_rfq_itemsid` FOREIGN KEY (`rfq_items_id`) REFERENCES `3_1rfq_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE 6rfq_items_labor;CREATE TABLE `6rfq_items_labor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfq_items_id` int(11) NOT NULL,
  `rfq_id` int(11) NOT NULL COMMENT 'trigger: get this based on rfq_items_id',
  `item_no` varchar(255) NOT NULL DEFAULT '' COMMENT 'this could be main assemble AND all items from rfq_items_bom_items that is parent assembly',
  `activity_name` varchar(255) NOT NULL DEFAULT '',
  `driver` varchar(255) DEFAULT NULL,
  `activity_per_part` int(11) NOT NULL DEFAULT '0',
  `time_in_seconds` int(11) NOT NULL DEFAULT '0',
  `hour` decimal(9,4) NOT NULL DEFAULT '0.0000' COMMENT 'trigger: convert seconds in hours format',
  `total_per_piece_in_hours` decimal(9,4) NOT NULL DEFAULT '0.0000' COMMENT 'trigger: activity_per_part x hour',
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_labor_rfq_items` (`rfq_items_id`),
  CONSTRAINT `fk_labor_rfq_items` FOREIGN KEY (`rfq_items_id`) REFERENCES `3_1rfq_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE 7rfq_items_nre_tools;CREATE TABLE `7rfq_items_nre_tools` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfq_items_id` int(11) NOT NULL,
  `nre_desc` varchar(255) DEFAULT NULL,
  `nre_charge` decimal(9,2) NOT NULL DEFAULT '0.00',
  `input_margin` decimal(9,2) NOT NULL DEFAULT '0.00',
  `total_charge` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT 'trigger calculated: ASK FORMULA',
  `remarks` varchar(500) DEFAULT NULL,
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_nretools_rfq_items` (`rfq_items_id`),
  CONSTRAINT `fk_nretools_rfq_items` FOREIGN KEY (`rfq_items_id`) REFERENCES `3_1rfq_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE 8rfq_items_assumptions;CREATE TABLE `8rfq_items_assumptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfq_items_id` int(11) NOT NULL,
  `rfq_id` int(11) NOT NULL COMMENT 'trigger: get this value based on rfq_items_id column',
  `assumption_text` varchar(500) NOT NULL DEFAULT '',
  `assumption_entered_by_user` varchar(255) NOT NULL DEFAULT '' COMMENT 'trigger: enter based on the SET @username defined',
  `customer_agreed` tinyint(1) NOT NULL DEFAULT '0',
  `customer_agreed_timestamp` datetime DEFAULT NULL,
  `customer_remarks` varchar(500) DEFAULT NULL,
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assumptions_rfq_items` (`rfq_items_id`),
  CONSTRAINT `fk_assumptions_rfq_items` FOREIGN KEY (`rfq_items_id`) REFERENCES `3_1rfq_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE 9rfq_outboundfreight;CREATE TABLE `9rfq_outboundfreight` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfq_items_id` int(11) NOT NULL,
  `rfq_id` int(11) NOT NULL COMMENT 'trigger: auto enter based on rfq_items_id',
  `ship_qty` int(11) NOT NULL DEFAULT '0',
  `weight_approximate_in_kg` decimal(9,2) NOT NULL,
  `ship_method` varchar(100) DEFAULT NULL,
  `freight_time_in_days` tinyint(5) NOT NULL DEFAULT '0',
  `usd_per_kg` decimal(9,2) NOT NULL DEFAULT '0.00',
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_outboundfright_rfid` (`rfq_id`),
  CONSTRAINT `fk_outboundfright_rfid` FOREIGN KEY (`rfq_id`) REFERENCES `3rfq` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE erp1_items;CREATE TABLE `erp1_items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='this is replica of live web cables db, setup sync from cypress local lan';


DROP TABLE m_labor_activity;CREATE TABLE `m_labor_activity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `activity_name` varchar(255) NOT NULL DEFAULT '',
  `time_in_seconds` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='trigger: dont allow delete of records, if deleted, mark them as inactive';


DROP TABLE m_user_roles;CREATE TABLE `m_user_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `audit_created_by` varchar(50) NOT NULL,
  `audit_created_date` datetime NOT NULL,
  `audit_updated_by` varchar(50) NOT NULL,
  `audit_updated_date` datetime NOT NULL,
  `audit_ip` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;INSERT INTO m_user_roles VALUES("29","Admin - all rights","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");


DROP TABLE m_user_roles_assigned;CREATE TABLE `m_user_roles_assigned` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `audit_created_by` varchar(50) NOT NULL,
  `audit_created_date` datetime NOT NULL,
  `audit_updated_by` varchar(50) NOT NULL,
  `audit_updated_date` datetime NOT NULL,
  `audit_ip` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=258 DEFAULT CHARSET=latin1;


DROP TABLE m_user_roles_permissions;CREATE TABLE `m_user_roles_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `rule` varchar(50) NOT NULL,
  `audit_created_by` varchar(50) NOT NULL,
  `audit_created_date` datetime NOT NULL,
  `audit_updated_by` varchar(50) NOT NULL,
  `audit_updated_date` datetime NOT NULL,
  `audit_ip` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=latin1;


DROP TABLE m_user_rules;CREATE TABLE `m_user_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `audit_created_by` varchar(50) NOT NULL,
  `audit_created_date` datetime NOT NULL,
  `audit_updated_by` varchar(50) NOT NULL,
  `audit_updated_date` datetime NOT NULL,
  `audit_ip` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=134648 DEFAULT CHARSET=latin1;INSERT INTO m_user_rules VALUES("1","user_can_edit_order_qty","testuser2","2014-12-04 15:34:52","","2014-12-04 15:34:52","186.22.4.95");INSERT INTO m_user_rules VALUES("134564","user_can_copy_paste","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134565","user_can_edit_order_notes","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134566","user_can_edit_order_wear_date","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134567","user_can_adj_style_stock","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134568","user_can_edit_order_discount","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134569","user_can_edit_invoice_discount","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134570","user_can_return_invoice_qty","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134571","user_can_delete_factory_payment","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134572","user_can_advance_payment_for_store","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134573","user_can_approve_new_sites_requests","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134574","user_can_approve_artwork_request_download","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134575","user_can_approve_images_download_request","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134576","user_can_edit_order_customer_po","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134577","user_can_edit_request_customer_po","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134578","user_can_delete_order_line","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134579","user_can_edit_bridal","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134580","user_can_delete_request_line","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134581","user_can_see_other_calendar","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134582","user_can_see_calendar","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134583","user_can_approve_free_days","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134584","user_can_edit_orders","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134585","user_can_set_store_categories","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134586","user_can_set_order_qualifying_category","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134587","user_can_edit_store_address","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134588","user_can_delete_invoice_lines","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134589","user_can_edit_invoice","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134590","user_can_edit_invoice_customer_po","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134591","user_can_edit_po","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134592","user_can_view_invoices","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134593","user_can_view_orders","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134594","user_can_view_bridalorders","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134595","user_can_view_payments","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134596","user_can_receive_packings","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134597","user_can_view_po","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134598","user_can_manage_style_images","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134599","user_can_create_po","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134600","user_can_view_production_manager","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134601","user_can_create_packinglist","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134602","user_can_edit_packinglist","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134603","user_can_see_packing_tracking_number","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134604","user_can_manage_rush_list","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134605","user_can_view_rush","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134606","user_can_view_storeapplicants","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134607","user_can_view_requests","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134608","user_can_view_returns","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134609","user_can_view_dashboard","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134610","user_can_view_factory","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134611","user_can_search","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134612","user_can_view_packing_itemproduction","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134613","user_can_view_po_orderrequest","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134614","user_can_create_invoice","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134615","user_can_view_market_admin","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134616","user_can_set_market_show_runway_link","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134617","user_can_edit_market_runway_style","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134618","user_can_delete_market","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134619","user_can_edit_market","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134620","user_can_configure_market_runway","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134621","user_can_manage_style_bodytypes","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134622","user_can_delete_any_user_notes","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134623","user_can_set_store_account_status","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134624","user_can_set_order_line_urgent_ship","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134625","user_can_lock_shipments","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134626","user_can_set_store_payment_methods","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134627","user_can_edit_store_ups_number","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134628","user_can_set_store_default_payment_method","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134629","user_can_edit_coop_orders","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134630","user_can_set_store_payment_terms","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134631","user_can_delete_stores_cc","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134632","user_can_view_db_log","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134633","user_can_edit_cc_label","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134634","user_can_edit_invoice_qty","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134635","user_can_set_invoice_as_old_return","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134636","user_can_edit_invoice_sell_price","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134637","user_can_view_eod_report","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134638","user_can_view_cod_report","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134639","user_can_send_post_to_top","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134640","user_can_add_eod_transactions","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134641","user_can_link_sample_to_style","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134642","user_can_see_style_factory_cost","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134643","user_can_see_order_total","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134644","user_can_edit_style_ship_from_date","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134645","user_can_view_images","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134646","user_can_view_po_total","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");INSERT INTO m_user_rules VALUES("134647","user_can_manage_ruWC_list","","0000-00-00 00:00:00","","0000-00-00 00:00:00","");


DROP TABLE m_users;CREATE TABLE `m_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `user_type` enum('manager','enginner','csv') DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='trigger: dont allow delete of records, if deleted, mark them as inactive';


DROP TABLE m_vendors;CREATE TABLE `m_vendors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vendor_name` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `audit_created_by` varchar(50) DEFAULT NULL,
  `audit_updated_by` varchar(50) DEFAULT NULL,
  `audit_created_date` timestamp NULL DEFAULT NULL,
  `audit_updated_date` timestamp NULL DEFAULT NULL,
  `audit_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='trigger: dont allow delete of records, if deleted, mark them as inactive';



/*
CREATE TRIGGER `1customers_before_insert` BEFORE INSERT ON `1customers`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;
IF NEW.audit_created_by NOT LIKE '%trigger' THEN
SET NEW.audit_created_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
SET NEW.audit_created_date=CURRENT_TIMESTAMP();

IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;
SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='1customers_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `1customers_after_insert` AFTER INSERT ON `1customers`
BEGIN 

/*audit_sql*/
IF (NEW.company_name) THEN
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='company_name',record_id=NEW.id, old_data='', new_data=NEW.company_name,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.contact_number) THEN
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='contact_number',record_id=NEW.id, old_data='', new_data=NEW.contact_number,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.address1) THEN
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='address1',record_id=NEW.id, old_data='', new_data=NEW.address1,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.address2) THEN
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='address2',record_id=NEW.id, old_data='', new_data=NEW.address2,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.city) THEN
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='city',record_id=NEW.id, old_data='', new_data=NEW.city,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.state) THEN
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='state',record_id=NEW.id, old_data='', new_data=NEW.state,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.zip) THEN
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='zip',record_id=NEW.id, old_data='', new_data=NEW.zip,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.country) THEN
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='country',record_id=NEW.id, old_data='', new_data=NEW.country,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.first_name) THEN
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='first_name',record_id=NEW.id, old_data='', new_data=NEW.first_name,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.last_name) THEN
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='last_name',record_id=NEW.id, old_data='', new_data=NEW.last_name,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.designation) THEN
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='designation',record_id=NEW.id, old_data='', new_data=NEW.designation,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.email) THEN
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='email',record_id=NEW.id, old_data='', new_data=NEW.email,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.username) THEN
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='username',record_id=NEW.id, old_data='', new_data=NEW.username,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.password) THEN
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='password',record_id=NEW.id, old_data='', new_data=NEW.password,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='1customers_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `1customers_before_update` BEFORE UPDATE ON `1customers`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='1customers_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `1customers_after_update` AFTER UPDATE ON `1customers`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.company_name,'')<>'' THEN
IF (OLD.company_name <> NEW.company_name) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='company_name',record_id=NEW.id, old_data=OLD.company_name, new_data=NEW.company_name,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.contact_number,'')<>'' THEN
IF (OLD.contact_number <> NEW.contact_number) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='contact_number',record_id=NEW.id, old_data=OLD.contact_number, new_data=NEW.contact_number,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.address1,'')<>'' THEN
IF (OLD.address1 <> NEW.address1) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='address1',record_id=NEW.id, old_data=OLD.address1, new_data=NEW.address1,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.address2,'')<>'' THEN
IF (OLD.address2 <> NEW.address2) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='address2',record_id=NEW.id, old_data=OLD.address2, new_data=NEW.address2,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.city,'')<>'' THEN
IF (OLD.city <> NEW.city) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='city',record_id=NEW.id, old_data=OLD.city, new_data=NEW.city,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.state,'')<>'' THEN
IF (OLD.state <> NEW.state) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='state',record_id=NEW.id, old_data=OLD.state, new_data=NEW.state,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.zip,'')<>'' THEN
IF (OLD.zip <> NEW.zip) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='zip',record_id=NEW.id, old_data=OLD.zip, new_data=NEW.zip,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.country,'')<>'' THEN
IF (OLD.country <> NEW.country) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='country',record_id=NEW.id, old_data=OLD.country, new_data=NEW.country,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.first_name,'')<>'' THEN
IF (OLD.first_name <> NEW.first_name) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='first_name',record_id=NEW.id, old_data=OLD.first_name, new_data=NEW.first_name,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.last_name,'')<>'' THEN
IF (OLD.last_name <> NEW.last_name) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='last_name',record_id=NEW.id, old_data=OLD.last_name, new_data=NEW.last_name,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.designation,'')<>'' THEN
IF (OLD.designation <> NEW.designation) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='designation',record_id=NEW.id, old_data=OLD.designation, new_data=NEW.designation,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.email,'')<>'' THEN
IF (OLD.email <> NEW.email) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='email',record_id=NEW.id, old_data=OLD.email, new_data=NEW.email,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.username,'')<>'' THEN
IF (OLD.username <> NEW.username) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='username',record_id=NEW.id, old_data=OLD.username, new_data=NEW.username,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.password,'')<>'' THEN
IF (OLD.password <> NEW.password) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='password',record_id=NEW.id, old_data=OLD.password, new_data=NEW.password,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='1customers_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `1customers_before_delete` BEFORE DELETE ON `1customers`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='1customers_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `1customers_after_delete` AFTER DELETE ON `1customers`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='company_name',record_id=OLD.id, old_data=OLD.company_name, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='contact_number',record_id=OLD.id, old_data=OLD.contact_number, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='address1',record_id=OLD.id, old_data=OLD.address1, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='address2',record_id=OLD.id, old_data=OLD.address2, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='city',record_id=OLD.id, old_data=OLD.city, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='state',record_id=OLD.id, old_data=OLD.state, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='zip',record_id=OLD.id, old_data=OLD.zip, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='country',record_id=OLD.id, old_data=OLD.country, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='first_name',record_id=OLD.id, old_data=OLD.first_name, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='last_name',record_id=OLD.id, old_data=OLD.last_name, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='designation',record_id=OLD.id, old_data=OLD.designation, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='email',record_id=OLD.id, old_data=OLD.email, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='username',record_id=OLD.id, old_data=OLD.username, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='1customers', field_name='password',record_id=OLD.id, old_data=OLD.password, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='1customers_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `2_1rfq_request_attachments_before_insert` BEFORE INSERT ON `2_1rfq_request_attachments`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;
IF NEW.audit_created_by NOT LIKE '%trigger' THEN
SET NEW.audit_created_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
SET NEW.audit_created_date=CURRENT_TIMESTAMP();

IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;
SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='2_1rfq_request_attachments_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `2_1rfq_request_attachments_after_insert` AFTER INSERT ON `2_1rfq_request_attachments`
BEGIN 

/*audit_sql*/
IF (NEW.rfq_request_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2_1rfq_request_attachments', field_name='rfq_request_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_request_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.upload_file_path) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2_1rfq_request_attachments', field_name='upload_file_path',record_id=NEW.id, old_data='', new_data=NEW.upload_file_path,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='2_1rfq_request_attachments_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `2_1rfq_request_attachments_before_update` BEFORE UPDATE ON `2_1rfq_request_attachments`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='2_1rfq_request_attachments_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `2_1rfq_request_attachments_after_update` AFTER UPDATE ON `2_1rfq_request_attachments`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.rfq_request_id,'')<>'' THEN
IF (OLD.rfq_request_id <> NEW.rfq_request_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2_1rfq_request_attachments', field_name='rfq_request_id',record_id=NEW.id, old_data=OLD.rfq_request_id, new_data=NEW.rfq_request_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.upload_file_path,'')<>'' THEN
IF (OLD.upload_file_path <> NEW.upload_file_path) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2_1rfq_request_attachments', field_name='upload_file_path',record_id=NEW.id, old_data=OLD.upload_file_path, new_data=NEW.upload_file_path,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='2_1rfq_request_attachments_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `2_1rfq_request_attachments_before_delete` BEFORE DELETE ON `2_1rfq_request_attachments`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='2_1rfq_request_attachments_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `2_1rfq_request_attachments_after_delete` AFTER DELETE ON `2_1rfq_request_attachments`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='2_1rfq_request_attachments', field_name='rfq_request_id',record_id=OLD.id, old_data=OLD.rfq_request_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2_1rfq_request_attachments', field_name='upload_file_path',record_id=OLD.id, old_data=OLD.upload_file_path, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='2_1rfq_request_attachments_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `2rfq_request_before_insert` BEFORE INSERT ON `2rfq_request`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;
IF NEW.audit_created_by NOT LIKE '%trigger' THEN
SET NEW.audit_created_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
SET NEW.audit_created_date=CURRENT_TIMESTAMP();

IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;
SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='2rfq_request_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `2rfq_request_after_insert` AFTER INSERT ON `2rfq_request`
BEGIN 

/*audit_sql*/
IF (NEW.customer_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='customer_id',record_id=NEW.id, old_data='', new_data=NEW.customer_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.quote_requested_date) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='quote_requested_date',record_id=NEW.id, old_data='', new_data=NEW.quote_requested_date,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.quote_required_date) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='quote_required_date',record_id=NEW.id, old_data='', new_data=NEW.quote_required_date,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.equivalent_cables) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_cables',record_id=NEW.id, old_data='', new_data=NEW.equivalent_cables,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.equivalent_connectors) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_connectors',record_id=NEW.id, old_data='', new_data=NEW.equivalent_connectors,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.equivalent_terminal) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_terminal',record_id=NEW.id, old_data='', new_data=NEW.equivalent_terminal,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.equivalent_shrinktube) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_shrinktube',record_id=NEW.id, old_data='', new_data=NEW.equivalent_shrinktube,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.equivalent_sleeve) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_sleeve',record_id=NEW.id, old_data='', new_data=NEW.equivalent_sleeve,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.equivalent_other) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_other',record_id=NEW.id, old_data='', new_data=NEW.equivalent_other,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.allow_partial_shipments) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='allow_partial_shipments',record_id=NEW.id, old_data='', new_data=NEW.allow_partial_shipments,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.packaging_requirements) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='packaging_requirements',record_id=NEW.id, old_data='', new_data=NEW.packaging_requirements,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.testing_level) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='testing_level',record_id=NEW.id, old_data='', new_data=NEW.testing_level,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.testing_additional_requirements) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='testing_additional_requirements',record_id=NEW.id, old_data='', new_data=NEW.testing_additional_requirements,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.testing_upload_document) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='testing_upload_document',record_id=NEW.id, old_data='', new_data=NEW.testing_upload_document,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.target_price_suggestion) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='target_price_suggestion',record_id=NEW.id, old_data='', new_data=NEW.target_price_suggestion,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.mfg_location_usa) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='mfg_location_usa',record_id=NEW.id, old_data='', new_data=NEW.mfg_location_usa,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.mfg_location_india) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='mfg_location_india',record_id=NEW.id, old_data='', new_data=NEW.mfg_location_india,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.quote_based_on) THEN
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='quote_based_on',record_id=NEW.id, old_data='', new_data=NEW.quote_based_on,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='2rfq_request_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `2rfq_request_before_update` BEFORE UPDATE ON `2rfq_request`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='2rfq_request_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `2rfq_request_after_update` AFTER UPDATE ON `2rfq_request`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.customer_id,'')<>'' THEN
IF (OLD.customer_id <> NEW.customer_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='customer_id',record_id=NEW.id, old_data=OLD.customer_id, new_data=NEW.customer_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.quote_requested_date,'')<>'' THEN
IF (OLD.quote_requested_date <> NEW.quote_requested_date) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='quote_requested_date',record_id=NEW.id, old_data=OLD.quote_requested_date, new_data=NEW.quote_requested_date,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.quote_required_date,'')<>'' THEN
IF (OLD.quote_required_date <> NEW.quote_required_date) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='quote_required_date',record_id=NEW.id, old_data=OLD.quote_required_date, new_data=NEW.quote_required_date,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.equivalent_cables,'')<>'' THEN
IF (OLD.equivalent_cables <> NEW.equivalent_cables) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_cables',record_id=NEW.id, old_data=OLD.equivalent_cables, new_data=NEW.equivalent_cables,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.equivalent_connectors,'')<>'' THEN
IF (OLD.equivalent_connectors <> NEW.equivalent_connectors) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_connectors',record_id=NEW.id, old_data=OLD.equivalent_connectors, new_data=NEW.equivalent_connectors,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.equivalent_terminal,'')<>'' THEN
IF (OLD.equivalent_terminal <> NEW.equivalent_terminal) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_terminal',record_id=NEW.id, old_data=OLD.equivalent_terminal, new_data=NEW.equivalent_terminal,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.equivalent_shrinktube,'')<>'' THEN
IF (OLD.equivalent_shrinktube <> NEW.equivalent_shrinktube) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_shrinktube',record_id=NEW.id, old_data=OLD.equivalent_shrinktube, new_data=NEW.equivalent_shrinktube,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.equivalent_sleeve,'')<>'' THEN
IF (OLD.equivalent_sleeve <> NEW.equivalent_sleeve) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_sleeve',record_id=NEW.id, old_data=OLD.equivalent_sleeve, new_data=NEW.equivalent_sleeve,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.equivalent_other,'')<>'' THEN
IF (OLD.equivalent_other <> NEW.equivalent_other) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_other',record_id=NEW.id, old_data=OLD.equivalent_other, new_data=NEW.equivalent_other,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.allow_partial_shipments,'')<>'' THEN
IF (OLD.allow_partial_shipments <> NEW.allow_partial_shipments) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='allow_partial_shipments',record_id=NEW.id, old_data=OLD.allow_partial_shipments, new_data=NEW.allow_partial_shipments,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.packaging_requirements,'')<>'' THEN
IF (OLD.packaging_requirements <> NEW.packaging_requirements) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='packaging_requirements',record_id=NEW.id, old_data=OLD.packaging_requirements, new_data=NEW.packaging_requirements,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.testing_level,'')<>'' THEN
IF (OLD.testing_level <> NEW.testing_level) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='testing_level',record_id=NEW.id, old_data=OLD.testing_level, new_data=NEW.testing_level,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.testing_additional_requirements,'')<>'' THEN
IF (OLD.testing_additional_requirements <> NEW.testing_additional_requirements) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='testing_additional_requirements',record_id=NEW.id, old_data=OLD.testing_additional_requirements, new_data=NEW.testing_additional_requirements,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.testing_upload_document,'')<>'' THEN
IF (OLD.testing_upload_document <> NEW.testing_upload_document) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='testing_upload_document',record_id=NEW.id, old_data=OLD.testing_upload_document, new_data=NEW.testing_upload_document,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.target_price_suggestion,'')<>'' THEN
IF (OLD.target_price_suggestion <> NEW.target_price_suggestion) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='target_price_suggestion',record_id=NEW.id, old_data=OLD.target_price_suggestion, new_data=NEW.target_price_suggestion,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.mfg_location_usa,'')<>'' THEN
IF (OLD.mfg_location_usa <> NEW.mfg_location_usa) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='mfg_location_usa',record_id=NEW.id, old_data=OLD.mfg_location_usa, new_data=NEW.mfg_location_usa,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.mfg_location_india,'')<>'' THEN
IF (OLD.mfg_location_india <> NEW.mfg_location_india) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='mfg_location_india',record_id=NEW.id, old_data=OLD.mfg_location_india, new_data=NEW.mfg_location_india,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.quote_based_on,'')<>'' THEN
IF (OLD.quote_based_on <> NEW.quote_based_on) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='quote_based_on',record_id=NEW.id, old_data=OLD.quote_based_on, new_data=NEW.quote_based_on,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='2rfq_request_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `2rfq_request_before_delete` BEFORE DELETE ON `2rfq_request`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='2rfq_request_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `2rfq_request_after_delete` AFTER DELETE ON `2rfq_request`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='customer_id',record_id=OLD.id, old_data=OLD.customer_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='quote_requested_date',record_id=OLD.id, old_data=OLD.quote_requested_date, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='quote_required_date',record_id=OLD.id, old_data=OLD.quote_required_date, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_cables',record_id=OLD.id, old_data=OLD.equivalent_cables, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_connectors',record_id=OLD.id, old_data=OLD.equivalent_connectors, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_terminal',record_id=OLD.id, old_data=OLD.equivalent_terminal, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_shrinktube',record_id=OLD.id, old_data=OLD.equivalent_shrinktube, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_sleeve',record_id=OLD.id, old_data=OLD.equivalent_sleeve, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='equivalent_other',record_id=OLD.id, old_data=OLD.equivalent_other, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='allow_partial_shipments',record_id=OLD.id, old_data=OLD.allow_partial_shipments, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='packaging_requirements',record_id=OLD.id, old_data=OLD.packaging_requirements, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='testing_level',record_id=OLD.id, old_data=OLD.testing_level, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='testing_additional_requirements',record_id=OLD.id, old_data=OLD.testing_additional_requirements, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='testing_upload_document',record_id=OLD.id, old_data=OLD.testing_upload_document, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='target_price_suggestion',record_id=OLD.id, old_data=OLD.target_price_suggestion, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='mfg_location_usa',record_id=OLD.id, old_data=OLD.mfg_location_usa, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='mfg_location_india',record_id=OLD.id, old_data=OLD.mfg_location_india, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='2rfq_request', field_name='quote_based_on',record_id=OLD.id, old_data=OLD.quote_based_on, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='2rfq_request_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `3_1rfq_items_before_insert` BEFORE INSERT ON `3_1rfq_items`
BEGIN 


SET NEW.rfq_id = (SELECT id FROM 3rfq WHERE rfq_request_id=NEW.rfq_request_id);

SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_1rfq_items_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `3_1rfq_items_after_insert` AFTER INSERT ON `3_1rfq_items`
BEGIN 

/*audit_sql*/
IF (NEW.rfq_request_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='rfq_request_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_request_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rfq_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='rfq_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.item_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='item_id',record_id=NEW.id, old_data='', new_data=NEW.item_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.item_name) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='item_name',record_id=NEW.id, old_data='', new_data=NEW.item_name,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rev) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='rev',record_id=NEW.id, old_data='', new_data=NEW.rev,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rfq_items_release_qtys) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='rfq_items_release_qtys',record_id=NEW.id, old_data='', new_data=NEW.rfq_items_release_qtys,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.estimated_annual_usage) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='estimated_annual_usage',record_id=NEW.id, old_data='', new_data=NEW.estimated_annual_usage,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.quote_required_date) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='quote_required_date',record_id=NEW.id, old_data='', new_data=NEW.quote_required_date,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.equivalent_cables) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_cables',record_id=NEW.id, old_data='', new_data=NEW.equivalent_cables,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.equivalent_connectors) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_connectors',record_id=NEW.id, old_data='', new_data=NEW.equivalent_connectors,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.equivalent_terminal) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_terminal',record_id=NEW.id, old_data='', new_data=NEW.equivalent_terminal,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.equivalent_shrinktube) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_shrinktube',record_id=NEW.id, old_data='', new_data=NEW.equivalent_shrinktube,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.equivalent_sleeve) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_sleeve',record_id=NEW.id, old_data='', new_data=NEW.equivalent_sleeve,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.equivalent_other) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_other',record_id=NEW.id, old_data='', new_data=NEW.equivalent_other,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.allow_partial_shipments) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='allow_partial_shipments',record_id=NEW.id, old_data='', new_data=NEW.allow_partial_shipments,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.packaging_requirements) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='packaging_requirements',record_id=NEW.id, old_data='', new_data=NEW.packaging_requirements,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.testing_level) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='testing_level',record_id=NEW.id, old_data='', new_data=NEW.testing_level,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.testing_additional_requirements) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='testing_additional_requirements',record_id=NEW.id, old_data='', new_data=NEW.testing_additional_requirements,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.testing_upload_document) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='testing_upload_document',record_id=NEW.id, old_data='', new_data=NEW.testing_upload_document,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.target_price_suggestion) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='target_price_suggestion',record_id=NEW.id, old_data='', new_data=NEW.target_price_suggestion,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.mfg_location_usa) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='mfg_location_usa',record_id=NEW.id, old_data='', new_data=NEW.mfg_location_usa,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.mfg_location_india) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='mfg_location_india',record_id=NEW.id, old_data='', new_data=NEW.mfg_location_india,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.bom_upload_document) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='bom_upload_document',record_id=NEW.id, old_data='', new_data=NEW.bom_upload_document,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.progress_dwg_percentage) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='progress_dwg_percentage',record_id=NEW.id, old_data='', new_data=NEW.progress_dwg_percentage,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.progress_bom_percentage) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='progress_bom_percentage',record_id=NEW.id, old_data='', new_data=NEW.progress_bom_percentage,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.progress_labor_percentage) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='progress_labor_percentage',record_id=NEW.id, old_data='', new_data=NEW.progress_labor_percentage,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.pushed_to_us_erp_datetime) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='pushed_to_us_erp_datetime',record_id=NEW.id, old_data='', new_data=NEW.pushed_to_us_erp_datetime,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.pushed_to_us_erp_request_log_dump) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='pushed_to_us_erp_request_log_dump',record_id=NEW.id, old_data='', new_data=NEW.pushed_to_us_erp_request_log_dump,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.pushed_to_us_erp_response_log_dump) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='pushed_to_us_erp_response_log_dump',record_id=NEW.id, old_data='', new_data=NEW.pushed_to_us_erp_response_log_dump,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_1rfq_items_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `3_1rfq_items_before_update` BEFORE UPDATE ON `3_1rfq_items`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_1rfq_items_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `3_1rfq_items_after_update` AFTER UPDATE ON `3_1rfq_items`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.rfq_request_id,'')<>'' THEN
IF (OLD.rfq_request_id <> NEW.rfq_request_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='rfq_request_id',record_id=NEW.id, old_data=OLD.rfq_request_id, new_data=NEW.rfq_request_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_id,'')<>'' THEN
IF (OLD.rfq_id <> NEW.rfq_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='rfq_id',record_id=NEW.id, old_data=OLD.rfq_id, new_data=NEW.rfq_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.item_id,'')<>'' THEN
IF (OLD.item_id <> NEW.item_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='item_id',record_id=NEW.id, old_data=OLD.item_id, new_data=NEW.item_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.item_name,'')<>'' THEN
IF (OLD.item_name <> NEW.item_name) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='item_name',record_id=NEW.id, old_data=OLD.item_name, new_data=NEW.item_name,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rev,'')<>'' THEN
IF (OLD.rev <> NEW.rev) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='rev',record_id=NEW.id, old_data=OLD.rev, new_data=NEW.rev,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_items_release_qtys,'')<>'' THEN
IF (OLD.rfq_items_release_qtys <> NEW.rfq_items_release_qtys) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='rfq_items_release_qtys',record_id=NEW.id, old_data=OLD.rfq_items_release_qtys, new_data=NEW.rfq_items_release_qtys,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.estimated_annual_usage,'')<>'' THEN
IF (OLD.estimated_annual_usage <> NEW.estimated_annual_usage) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='estimated_annual_usage',record_id=NEW.id, old_data=OLD.estimated_annual_usage, new_data=NEW.estimated_annual_usage,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.quote_required_date,'')<>'' THEN
IF (OLD.quote_required_date <> NEW.quote_required_date) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='quote_required_date',record_id=NEW.id, old_data=OLD.quote_required_date, new_data=NEW.quote_required_date,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.equivalent_cables,'')<>'' THEN
IF (OLD.equivalent_cables <> NEW.equivalent_cables) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_cables',record_id=NEW.id, old_data=OLD.equivalent_cables, new_data=NEW.equivalent_cables,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.equivalent_connectors,'')<>'' THEN
IF (OLD.equivalent_connectors <> NEW.equivalent_connectors) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_connectors',record_id=NEW.id, old_data=OLD.equivalent_connectors, new_data=NEW.equivalent_connectors,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.equivalent_terminal,'')<>'' THEN
IF (OLD.equivalent_terminal <> NEW.equivalent_terminal) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_terminal',record_id=NEW.id, old_data=OLD.equivalent_terminal, new_data=NEW.equivalent_terminal,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.equivalent_shrinktube,'')<>'' THEN
IF (OLD.equivalent_shrinktube <> NEW.equivalent_shrinktube) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_shrinktube',record_id=NEW.id, old_data=OLD.equivalent_shrinktube, new_data=NEW.equivalent_shrinktube,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.equivalent_sleeve,'')<>'' THEN
IF (OLD.equivalent_sleeve <> NEW.equivalent_sleeve) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_sleeve',record_id=NEW.id, old_data=OLD.equivalent_sleeve, new_data=NEW.equivalent_sleeve,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.equivalent_other,'')<>'' THEN
IF (OLD.equivalent_other <> NEW.equivalent_other) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_other',record_id=NEW.id, old_data=OLD.equivalent_other, new_data=NEW.equivalent_other,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.allow_partial_shipments,'')<>'' THEN
IF (OLD.allow_partial_shipments <> NEW.allow_partial_shipments) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='allow_partial_shipments',record_id=NEW.id, old_data=OLD.allow_partial_shipments, new_data=NEW.allow_partial_shipments,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.packaging_requirements,'')<>'' THEN
IF (OLD.packaging_requirements <> NEW.packaging_requirements) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='packaging_requirements',record_id=NEW.id, old_data=OLD.packaging_requirements, new_data=NEW.packaging_requirements,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.testing_level,'')<>'' THEN
IF (OLD.testing_level <> NEW.testing_level) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='testing_level',record_id=NEW.id, old_data=OLD.testing_level, new_data=NEW.testing_level,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.testing_additional_requirements,'')<>'' THEN
IF (OLD.testing_additional_requirements <> NEW.testing_additional_requirements) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='testing_additional_requirements',record_id=NEW.id, old_data=OLD.testing_additional_requirements, new_data=NEW.testing_additional_requirements,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.testing_upload_document,'')<>'' THEN
IF (OLD.testing_upload_document <> NEW.testing_upload_document) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='testing_upload_document',record_id=NEW.id, old_data=OLD.testing_upload_document, new_data=NEW.testing_upload_document,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.target_price_suggestion,'')<>'' THEN
IF (OLD.target_price_suggestion <> NEW.target_price_suggestion) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='target_price_suggestion',record_id=NEW.id, old_data=OLD.target_price_suggestion, new_data=NEW.target_price_suggestion,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.mfg_location_usa,'')<>'' THEN
IF (OLD.mfg_location_usa <> NEW.mfg_location_usa) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='mfg_location_usa',record_id=NEW.id, old_data=OLD.mfg_location_usa, new_data=NEW.mfg_location_usa,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.mfg_location_india,'')<>'' THEN
IF (OLD.mfg_location_india <> NEW.mfg_location_india) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='mfg_location_india',record_id=NEW.id, old_data=OLD.mfg_location_india, new_data=NEW.mfg_location_india,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.bom_upload_document,'')<>'' THEN
IF (OLD.bom_upload_document <> NEW.bom_upload_document) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='bom_upload_document',record_id=NEW.id, old_data=OLD.bom_upload_document, new_data=NEW.bom_upload_document,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.progress_dwg_percentage,'')<>'' THEN
IF (OLD.progress_dwg_percentage <> NEW.progress_dwg_percentage) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='progress_dwg_percentage',record_id=NEW.id, old_data=OLD.progress_dwg_percentage, new_data=NEW.progress_dwg_percentage,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.progress_bom_percentage,'')<>'' THEN
IF (OLD.progress_bom_percentage <> NEW.progress_bom_percentage) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='progress_bom_percentage',record_id=NEW.id, old_data=OLD.progress_bom_percentage, new_data=NEW.progress_bom_percentage,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.progress_labor_percentage,'')<>'' THEN
IF (OLD.progress_labor_percentage <> NEW.progress_labor_percentage) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='progress_labor_percentage',record_id=NEW.id, old_data=OLD.progress_labor_percentage, new_data=NEW.progress_labor_percentage,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.pushed_to_us_erp_datetime,'')<>'' THEN
IF (OLD.pushed_to_us_erp_datetime <> NEW.pushed_to_us_erp_datetime) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='pushed_to_us_erp_datetime',record_id=NEW.id, old_data=OLD.pushed_to_us_erp_datetime, new_data=NEW.pushed_to_us_erp_datetime,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.pushed_to_us_erp_request_log_dump,'')<>'' THEN
IF (OLD.pushed_to_us_erp_request_log_dump <> NEW.pushed_to_us_erp_request_log_dump) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='pushed_to_us_erp_request_log_dump',record_id=NEW.id, old_data=OLD.pushed_to_us_erp_request_log_dump, new_data=NEW.pushed_to_us_erp_request_log_dump,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.pushed_to_us_erp_response_log_dump,'')<>'' THEN
IF (OLD.pushed_to_us_erp_response_log_dump <> NEW.pushed_to_us_erp_response_log_dump) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='pushed_to_us_erp_response_log_dump',record_id=NEW.id, old_data=OLD.pushed_to_us_erp_response_log_dump, new_data=NEW.pushed_to_us_erp_response_log_dump,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_1rfq_items_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `3_1rfq_items_before_delete` BEFORE DELETE ON `3_1rfq_items`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_1rfq_items_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `3_1rfq_items_after_delete` AFTER DELETE ON `3_1rfq_items`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='rfq_request_id',record_id=OLD.id, old_data=OLD.rfq_request_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='rfq_id',record_id=OLD.id, old_data=OLD.rfq_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='item_id',record_id=OLD.id, old_data=OLD.item_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='item_name',record_id=OLD.id, old_data=OLD.item_name, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='rev',record_id=OLD.id, old_data=OLD.rev, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='rfq_items_release_qtys',record_id=OLD.id, old_data=OLD.rfq_items_release_qtys, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='estimated_annual_usage',record_id=OLD.id, old_data=OLD.estimated_annual_usage, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='quote_required_date',record_id=OLD.id, old_data=OLD.quote_required_date, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_cables',record_id=OLD.id, old_data=OLD.equivalent_cables, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_connectors',record_id=OLD.id, old_data=OLD.equivalent_connectors, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_terminal',record_id=OLD.id, old_data=OLD.equivalent_terminal, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_shrinktube',record_id=OLD.id, old_data=OLD.equivalent_shrinktube, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_sleeve',record_id=OLD.id, old_data=OLD.equivalent_sleeve, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='equivalent_other',record_id=OLD.id, old_data=OLD.equivalent_other, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='allow_partial_shipments',record_id=OLD.id, old_data=OLD.allow_partial_shipments, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='packaging_requirements',record_id=OLD.id, old_data=OLD.packaging_requirements, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='testing_level',record_id=OLD.id, old_data=OLD.testing_level, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='testing_additional_requirements',record_id=OLD.id, old_data=OLD.testing_additional_requirements, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='testing_upload_document',record_id=OLD.id, old_data=OLD.testing_upload_document, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='target_price_suggestion',record_id=OLD.id, old_data=OLD.target_price_suggestion, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='mfg_location_usa',record_id=OLD.id, old_data=OLD.mfg_location_usa, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='mfg_location_india',record_id=OLD.id, old_data=OLD.mfg_location_india, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='bom_upload_document',record_id=OLD.id, old_data=OLD.bom_upload_document, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='progress_dwg_percentage',record_id=OLD.id, old_data=OLD.progress_dwg_percentage, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='progress_bom_percentage',record_id=OLD.id, old_data=OLD.progress_bom_percentage, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='progress_labor_percentage',record_id=OLD.id, old_data=OLD.progress_labor_percentage, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='pushed_to_us_erp_datetime',record_id=OLD.id, old_data=OLD.pushed_to_us_erp_datetime, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='pushed_to_us_erp_request_log_dump',record_id=OLD.id, old_data=OLD.pushed_to_us_erp_request_log_dump, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_1rfq_items', field_name='pushed_to_us_erp_response_log_dump',record_id=OLD.id, old_data=OLD.pushed_to_us_erp_response_log_dump, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_1rfq_items_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `3_2rfq_items__qty_before_insert` BEFORE INSERT ON `3_2rfq_items__qty`
BEGIN 


SET NEW.rfq_id = (SELECT rfq_id FROM 3_1rfq_items WHERE id=NEW.rfq_items_id);
SET NEW.extended_value_price_usa = NEW.release_qty*NEW.unit_price_sell_usa;
SET NEW.extended_value_price_india = NEW.release_qty*NEW.extended_value_price_india;

SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_2rfq_items__qty_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `3_2rfq_items__qty_after_insert` AFTER INSERT ON `3_2rfq_items__qty`
BEGIN 


DECLARE rfq_items_release_qtys VARCHAR(255);
SET rfq_items_release_qtys = (SELECT GROUP_CONCAT(release_qty) FROM 3_2rfq_items__qty WHERE rfq_items_id=NEW.rfq_items_id AND rfq_id=NEW.rfq_id);
UPDATE 3_1rfq_items SET 3_1rfq_items.rfq_items_release_qtys=rfq_items_release_qtys;

IF (NEW.rfq_items_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='rfq_items_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_items_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rfq_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='rfq_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.release_qty) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='release_qty',record_id=NEW.id, old_data='', new_data=NEW.release_qty,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.release_group) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='release_group',record_id=NEW.id, old_data='', new_data=NEW.release_group,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.total_material_value) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='total_material_value',record_id=NEW.id, old_data='', new_data=NEW.total_material_value,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.total_labor_cost) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='total_labor_cost',record_id=NEW.id, old_data='', new_data=NEW.total_labor_cost,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.unit_price_sell_usa) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='unit_price_sell_usa',record_id=NEW.id, old_data='', new_data=NEW.unit_price_sell_usa,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.unit_price_sell_india) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='unit_price_sell_india',record_id=NEW.id, old_data='', new_data=NEW.unit_price_sell_india,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.extended_value_price_usa) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='extended_value_price_usa',record_id=NEW.id, old_data='', new_data=NEW.extended_value_price_usa,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.extended_value_price_india) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='extended_value_price_india',record_id=NEW.id, old_data='', new_data=NEW.extended_value_price_india,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.excess_material_price) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='excess_material_price',record_id=NEW.id, old_data='', new_data=NEW.excess_material_price,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.lead_time_material_in_days) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='lead_time_material_in_days',record_id=NEW.id, old_data='', new_data=NEW.lead_time_material_in_days,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.lead_time_material_in_days_manual_override) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='lead_time_material_in_days_manual_override',record_id=NEW.id, old_data='', new_data=NEW.lead_time_material_in_days_manual_override,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.lead_time_labor_production_time_in_days) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='lead_time_labor_production_time_in_days',record_id=NEW.id, old_data='', new_data=NEW.lead_time_labor_production_time_in_days,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.lead_time_labor_production_time_in_days_manual_override) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='lead_time_labor_production_time_in_days_manual_override',record_id=NEW.id, old_data='', new_data=NEW.lead_time_labor_production_time_in_days_manual_override,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.lead_time_first_article) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='lead_time_first_article',record_id=NEW.id, old_data='', new_data=NEW.lead_time_first_article,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

INSERT INTO 3_2rfq_items__qty_clone SELECT * FROM 3_2rfq_items__qty WHERE id = NEW.id;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_2rfq_items__qty_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `3_2rfq_items__qty_before_update` BEFORE UPDATE ON `3_2rfq_items__qty`
BEGIN 


SET NEW.extended_value_price_usa = NEW.release_qty*NEW.unit_price_sell_usa;
SET NEW.extended_value_price_india = NEW.release_qty*NEW.extended_value_price_india;


IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_2rfq_items__qty_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `3_2rfq_items__qty_after_update` AFTER UPDATE ON `3_2rfq_items__qty`
BEGIN 


DECLARE rfq_items_release_qtys VARCHAR(255);
SET rfq_items_release_qtys = (SELECT GROUP_CONCAT(release_qty) FROM 3_2rfq_items__qty WHERE rfq_items_id=NEW.rfq_items_id AND rfq_id=NEW.rfq_id);
UPDATE 3_1rfq_items SET 3_1rfq_items.rfq_items_release_qtys=rfq_items_release_qtys;

IF IFNULL(NEW.rfq_items_id,'')<>'' THEN
IF (OLD.rfq_items_id <> NEW.rfq_items_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='rfq_items_id',record_id=NEW.id, old_data=OLD.rfq_items_id, new_data=NEW.rfq_items_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_id,'')<>'' THEN
IF (OLD.rfq_id <> NEW.rfq_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='rfq_id',record_id=NEW.id, old_data=OLD.rfq_id, new_data=NEW.rfq_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.release_qty,'')<>'' THEN
IF (OLD.release_qty <> NEW.release_qty) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='release_qty',record_id=NEW.id, old_data=OLD.release_qty, new_data=NEW.release_qty,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.total_material_value,'')<>'' THEN
IF (OLD.total_material_value <> NEW.total_material_value) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='total_material_value',record_id=NEW.id, old_data=OLD.total_material_value, new_data=NEW.total_material_value,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
IF IFNULL(NEW.release_group,'')<>'' THEN
IF (OLD.release_group <> NEW.release_group) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='release_group',record_id=NEW.id, old_data=OLD.release_group, new_data=NEW.release_group,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;


IF IFNULL(NEW.total_labor_cost,'')<>'' THEN
IF (OLD.total_labor_cost <> NEW.total_labor_cost) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='total_labor_cost',record_id=NEW.id, old_data=OLD.total_labor_cost, new_data=NEW.total_labor_cost,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.unit_price_sell_usa,'')<>'' THEN
IF (OLD.unit_price_sell_usa <> NEW.unit_price_sell_usa) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='unit_price_sell_usa',record_id=NEW.id, old_data=OLD.unit_price_sell_usa, new_data=NEW.unit_price_sell_usa,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.unit_price_sell_india,'')<>'' THEN
IF (OLD.unit_price_sell_india <> NEW.unit_price_sell_india) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='unit_price_sell_india',record_id=NEW.id, old_data=OLD.unit_price_sell_india, new_data=NEW.unit_price_sell_india,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.extended_value_price_usa,'')<>'' THEN
IF (OLD.extended_value_price_usa <> NEW.extended_value_price_usa) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='extended_value_price_usa',record_id=NEW.id, old_data=OLD.extended_value_price_usa, new_data=NEW.extended_value_price_usa,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.extended_value_price_india,'')<>'' THEN
IF (OLD.extended_value_price_india <> NEW.extended_value_price_india) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='extended_value_price_india',record_id=NEW.id, old_data=OLD.extended_value_price_india, new_data=NEW.extended_value_price_india,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.excess_material_price,'')<>'' THEN
IF (OLD.excess_material_price <> NEW.excess_material_price) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='excess_material_price',record_id=NEW.id, old_data=OLD.excess_material_price, new_data=NEW.excess_material_price,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.lead_time_material_in_days,'')<>'' THEN
IF (OLD.lead_time_material_in_days <> NEW.lead_time_material_in_days) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='lead_time_material_in_days',record_id=NEW.id, old_data=OLD.lead_time_material_in_days, new_data=NEW.lead_time_material_in_days,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.lead_time_material_in_days_manual_override,'')<>'' THEN
IF (OLD.lead_time_material_in_days_manual_override <> NEW.lead_time_material_in_days_manual_override) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='lead_time_material_in_days_manual_override',record_id=NEW.id, old_data=OLD.lead_time_material_in_days_manual_override, new_data=NEW.lead_time_material_in_days_manual_override,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.lead_time_labor_production_time_in_days,'')<>'' THEN
IF (OLD.lead_time_labor_production_time_in_days <> NEW.lead_time_labor_production_time_in_days) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='lead_time_labor_production_time_in_days',record_id=NEW.id, old_data=OLD.lead_time_labor_production_time_in_days, new_data=NEW.lead_time_labor_production_time_in_days,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.lead_time_labor_production_time_in_days_manual_override,'')<>'' THEN
IF (OLD.lead_time_labor_production_time_in_days_manual_override <> NEW.lead_time_labor_production_time_in_days_manual_override) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='lead_time_labor_production_time_in_days_manual_override',record_id=NEW.id, old_data=OLD.lead_time_labor_production_time_in_days_manual_override, new_data=NEW.lead_time_labor_production_time_in_days_manual_override,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.lead_time_first_article,'')<>'' THEN
IF (OLD.lead_time_first_article <> NEW.lead_time_first_article) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='lead_time_first_article',record_id=NEW.id, old_data=OLD.lead_time_first_article, new_data=NEW.lead_time_first_article,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_items_id,'')<>'' THEN
IF (OLD.rfq_items_id <> NEW.rfq_items_id) THEN 
UPDATE 3_2rfq_items__qty_clone SET rfq_items_id = NEW.rfq_items_id WHERE id = NEW.id;
END IF;
END IF;

IF IFNULL(NEW.rfq_id,'')<>'' THEN
IF (OLD.rfq_id <> NEW.rfq_id) THEN 
UPDATE 3_2rfq_items__qty_clone SET rfq_id = NEW.rfq_id WHERE id = NEW.id;
END IF;
END IF;

IF IFNULL(NEW.release_qty,'')<>'' THEN
IF (OLD.release_qty <> NEW.release_qty) THEN 
UPDATE 3_2rfq_items__qty_clone SET release_qty = NEW.release_qty WHERE id = NEW.id;
END IF;
END IF;


IF IFNULL(NEW.total_material_value,'')<>'' THEN
IF (OLD.total_material_value <> NEW.total_material_value) THEN 
UPDATE 3_2rfq_items__qty_clone SET total_material_value = NEW.total_material_value WHERE id = NEW.id;
END IF;
END IF;

IF IFNULL(NEW.total_labor_cost,'')<>'' THEN
IF (OLD.total_labor_cost <> NEW.total_labor_cost) THEN 
UPDATE 3_2rfq_items__qty_clone SET total_labor_cost = NEW.total_labor_cost WHERE id = NEW.id;
END IF;
END IF;

IF IFNULL(NEW.unit_price_sell_usa,'')<>'' THEN
IF (OLD.unit_price_sell_usa <> NEW.unit_price_sell_usa) THEN 
UPDATE 3_2rfq_items__qty_clone SET unit_price_sell_usa = NEW.unit_price_sell_usa WHERE id = NEW.id;
END IF;
END IF;

IF IFNULL(NEW.unit_price_sell_india,'')<>'' THEN
IF (OLD.unit_price_sell_india <> NEW.unit_price_sell_india) THEN 
UPDATE 3_2rfq_items__qty_clone SET unit_price_sell_india = NEW.unit_price_sell_india WHERE id = NEW.id;
END IF;
END IF;

IF IFNULL(NEW.extended_value_price_usa,'')<>'' THEN
IF (OLD.extended_value_price_usa <> NEW.extended_value_price_usa) THEN 
UPDATE 3_2rfq_items__qty_clone SET extended_value_price_usa = NEW.extended_value_price_usa WHERE id = NEW.id;
END IF;
END IF;

IF IFNULL(NEW.extended_value_price_india,'')<>'' THEN
IF (OLD.extended_value_price_india <> NEW.extended_value_price_india) THEN 
UPDATE 3_2rfq_items__qty_clone SET extended_value_price_india = NEW.extended_value_price_india WHERE id = NEW.id;
END IF;
END IF;

IF IFNULL(NEW.excess_material_price,'')<>'' THEN
IF (OLD.excess_material_price <> NEW.excess_material_price) THEN 
UPDATE 3_2rfq_items__qty_clone SET excess_material_price = NEW.excess_material_price WHERE id = NEW.id;
END IF;
END IF;

IF IFNULL(NEW.lead_time_material_in_days,'')<>'' THEN
IF (OLD.lead_time_material_in_days <> NEW.lead_time_material_in_days) THEN 
UPDATE 3_2rfq_items__qty_clone SET lead_time_material_in_days = NEW.lead_time_material_in_days WHERE id = NEW.id;
END IF;
END IF;

IF IFNULL(NEW.lead_time_material_in_days_manual_override,'')<>'' THEN
IF (OLD.lead_time_material_in_days_manual_override <> NEW.lead_time_material_in_days_manual_override) THEN 
UPDATE 3_2rfq_items__qty_clone SET lead_time_material_in_days_manual_override = NEW.lead_time_material_in_days_manual_override WHERE id = NEW.id;
END IF;
END IF;

IF IFNULL(NEW.lead_time_labor_production_time_in_days,'')<>'' THEN
IF (OLD.lead_time_labor_production_time_in_days <> NEW.lead_time_labor_production_time_in_days) THEN 
UPDATE 3_2rfq_items__qty_clone SET lead_time_labor_production_time_in_days = NEW.lead_time_labor_production_time_in_days WHERE id = NEW.id;
END IF;
END IF;

IF IFNULL(NEW.lead_time_labor_production_time_in_days_manual_override,'')<>'' THEN
IF (OLD.lead_time_labor_production_time_in_days_manual_override <> NEW.lead_time_labor_production_time_in_days_manual_override) THEN 
UPDATE 3_2rfq_items__qty_clone SET lead_time_labor_production_time_in_days_manual_override = NEW.lead_time_labor_production_time_in_days_manual_override WHERE id = NEW.id;
END IF;
END IF;

IF IFNULL(NEW.lead_time_first_article,'')<>'' THEN
IF (OLD.lead_time_first_article <> NEW.lead_time_first_article) THEN 
UPDATE 3_2rfq_items__qty_clone SET lead_time_first_article = NEW.lead_time_first_article WHERE id = NEW.id;
END IF;
END IF;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_2rfq_items__qty_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `3_2rfq_items__qty_before_delete` BEFORE DELETE ON `3_2rfq_items__qty`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_2rfq_items__qty_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `3_2rfq_items__qty_after_delete` AFTER DELETE ON `3_2rfq_items__qty`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='rfq_items_id',record_id=OLD.id, old_data=OLD.rfq_items_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='rfq_id',record_id=OLD.id, old_data=OLD.rfq_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='release_qty',record_id=OLD.id, old_data=OLD.release_qty, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='release_group',record_id=OLD.id, old_data=OLD.release_group, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='total_material_value',record_id=OLD.id, old_data=OLD.total_material_value, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='total_labor_cost',record_id=OLD.id, old_data=OLD.total_labor_cost, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='unit_price_sell_usa',record_id=OLD.id, old_data=OLD.unit_price_sell_usa, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='unit_price_sell_india',record_id=OLD.id, old_data=OLD.unit_price_sell_india, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='extended_value_price_usa',record_id=OLD.id, old_data=OLD.extended_value_price_usa, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='extended_value_price_india',record_id=OLD.id, old_data=OLD.extended_value_price_india, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='excess_material_price',record_id=OLD.id, old_data=OLD.excess_material_price, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='lead_time_material_in_days',record_id=OLD.id, old_data=OLD.lead_time_material_in_days, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='lead_time_material_in_days_manual_override',record_id=OLD.id, old_data=OLD.lead_time_material_in_days_manual_override, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='lead_time_labor_production_time_in_days',record_id=OLD.id, old_data=OLD.lead_time_labor_production_time_in_days, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='lead_time_labor_production_time_in_days_manual_override',record_id=OLD.id, old_data=OLD.lead_time_labor_production_time_in_days_manual_override, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty', field_name='lead_time_first_article',record_id=OLD.id, old_data=OLD.lead_time_first_article, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_2rfq_items__qty_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `3_2rfq_items__qty_clone_before_insert` BEFORE INSERT ON `3_2rfq_items__qty_clone`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;
IF NEW.audit_created_by NOT LIKE '%trigger' THEN
SET NEW.audit_created_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
SET NEW.audit_created_date=CURRENT_TIMESTAMP();

IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;
SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_2rfq_items__qty_clone_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `3_2rfq_items__qty_clone_after_insert` AFTER INSERT ON `3_2rfq_items__qty_clone`
BEGIN 

/*audit_sql*/
IF (NEW.rfq_items_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='rfq_items_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_items_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rfq_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='rfq_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.release_qty) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='release_qty',record_id=NEW.id, old_data='', new_data=NEW.release_qty,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.release_group) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='release_group',record_id=NEW.id, old_data='', new_data=NEW.release_group,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.total_material_value) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='total_material_value',record_id=NEW.id, old_data='', new_data=NEW.total_material_value,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.total_labor_cost) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='total_labor_cost',record_id=NEW.id, old_data='', new_data=NEW.total_labor_cost,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.unit_price_sell_usa) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='unit_price_sell_usa',record_id=NEW.id, old_data='', new_data=NEW.unit_price_sell_usa,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.unit_price_sell_india) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='unit_price_sell_india',record_id=NEW.id, old_data='', new_data=NEW.unit_price_sell_india,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.extended_value_price_usa) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='extended_value_price_usa',record_id=NEW.id, old_data='', new_data=NEW.extended_value_price_usa,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.extended_value_price_india) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='extended_value_price_india',record_id=NEW.id, old_data='', new_data=NEW.extended_value_price_india,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.excess_material_price) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='excess_material_price',record_id=NEW.id, old_data='', new_data=NEW.excess_material_price,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.lead_time_material_in_days) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='lead_time_material_in_days',record_id=NEW.id, old_data='', new_data=NEW.lead_time_material_in_days,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.lead_time_material_in_days_manual_override) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='lead_time_material_in_days_manual_override',record_id=NEW.id, old_data='', new_data=NEW.lead_time_material_in_days_manual_override,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.lead_time_labor_production_time_in_days) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='lead_time_labor_production_time_in_days',record_id=NEW.id, old_data='', new_data=NEW.lead_time_labor_production_time_in_days,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.lead_time_labor_production_time_in_days_manual_override) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='lead_time_labor_production_time_in_days_manual_override',record_id=NEW.id, old_data='', new_data=NEW.lead_time_labor_production_time_in_days_manual_override,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.lead_time_first_article) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='lead_time_first_article',record_id=NEW.id, old_data='', new_data=NEW.lead_time_first_article,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_2rfq_items__qty_clone_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `3_2rfq_items__qty_clone_before_update` BEFORE UPDATE ON `3_2rfq_items__qty_clone`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_2rfq_items__qty_clone_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `3_2rfq_items__qty_clone_after_update` AFTER UPDATE ON `3_2rfq_items__qty_clone`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.rfq_items_id,'')<>'' THEN
IF (OLD.rfq_items_id <> NEW.rfq_items_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='rfq_items_id',record_id=NEW.id, old_data=OLD.rfq_items_id, new_data=NEW.rfq_items_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_id,'')<>'' THEN
IF (OLD.rfq_id <> NEW.rfq_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='rfq_id',record_id=NEW.id, old_data=OLD.rfq_id, new_data=NEW.rfq_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.release_qty,'')<>'' THEN
IF (OLD.release_qty <> NEW.release_qty) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='release_qty',record_id=NEW.id, old_data=OLD.release_qty, new_data=NEW.release_qty,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.release_group,'')<>'' THEN
IF (OLD.release_group <> NEW.release_group) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='release_group',record_id=NEW.id, old_data=OLD.release_group, new_data=NEW.release_group,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.total_material_value,'')<>'' THEN
IF (OLD.total_material_value <> NEW.total_material_value) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='total_material_value',record_id=NEW.id, old_data=OLD.total_material_value, new_data=NEW.total_material_value,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.total_labor_cost,'')<>'' THEN
IF (OLD.total_labor_cost <> NEW.total_labor_cost) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='total_labor_cost',record_id=NEW.id, old_data=OLD.total_labor_cost, new_data=NEW.total_labor_cost,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.unit_price_sell_usa,'')<>'' THEN
IF (OLD.unit_price_sell_usa <> NEW.unit_price_sell_usa) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='unit_price_sell_usa',record_id=NEW.id, old_data=OLD.unit_price_sell_usa, new_data=NEW.unit_price_sell_usa,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.unit_price_sell_india,'')<>'' THEN
IF (OLD.unit_price_sell_india <> NEW.unit_price_sell_india) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='unit_price_sell_india',record_id=NEW.id, old_data=OLD.unit_price_sell_india, new_data=NEW.unit_price_sell_india,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.extended_value_price_usa,'')<>'' THEN
IF (OLD.extended_value_price_usa <> NEW.extended_value_price_usa) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='extended_value_price_usa',record_id=NEW.id, old_data=OLD.extended_value_price_usa, new_data=NEW.extended_value_price_usa,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.extended_value_price_india,'')<>'' THEN
IF (OLD.extended_value_price_india <> NEW.extended_value_price_india) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='extended_value_price_india',record_id=NEW.id, old_data=OLD.extended_value_price_india, new_data=NEW.extended_value_price_india,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.excess_material_price,'')<>'' THEN
IF (OLD.excess_material_price <> NEW.excess_material_price) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='excess_material_price',record_id=NEW.id, old_data=OLD.excess_material_price, new_data=NEW.excess_material_price,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.lead_time_material_in_days,'')<>'' THEN
IF (OLD.lead_time_material_in_days <> NEW.lead_time_material_in_days) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='lead_time_material_in_days',record_id=NEW.id, old_data=OLD.lead_time_material_in_days, new_data=NEW.lead_time_material_in_days,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.lead_time_material_in_days_manual_override,'')<>'' THEN
IF (OLD.lead_time_material_in_days_manual_override <> NEW.lead_time_material_in_days_manual_override) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='lead_time_material_in_days_manual_override',record_id=NEW.id, old_data=OLD.lead_time_material_in_days_manual_override, new_data=NEW.lead_time_material_in_days_manual_override,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.lead_time_labor_production_time_in_days,'')<>'' THEN
IF (OLD.lead_time_labor_production_time_in_days <> NEW.lead_time_labor_production_time_in_days) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='lead_time_labor_production_time_in_days',record_id=NEW.id, old_data=OLD.lead_time_labor_production_time_in_days, new_data=NEW.lead_time_labor_production_time_in_days,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.lead_time_labor_production_time_in_days_manual_override,'')<>'' THEN
IF (OLD.lead_time_labor_production_time_in_days_manual_override <> NEW.lead_time_labor_production_time_in_days_manual_override) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='lead_time_labor_production_time_in_days_manual_override',record_id=NEW.id, old_data=OLD.lead_time_labor_production_time_in_days_manual_override, new_data=NEW.lead_time_labor_production_time_in_days_manual_override,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.lead_time_first_article,'')<>'' THEN
IF (OLD.lead_time_first_article <> NEW.lead_time_first_article) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='lead_time_first_article',record_id=NEW.id, old_data=OLD.lead_time_first_article, new_data=NEW.lead_time_first_article,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 
IF IFNULL(NEW.release_group,'')<>'' THEN
IF (OLD.release_group <> NEW.release_group) THEN 
UPDATE 3_2rfq_items__qty SET release_group = NEW.release_group WHERE id = NEW.id;
END IF;
END IF;


IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_2rfq_items__qty_clone_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `3_2rfq_items__qty_clone_before_delete` BEFORE DELETE ON `3_2rfq_items__qty_clone`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_2rfq_items__qty_clone_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `3_2rfq_items__qty_clone_after_delete` AFTER DELETE ON `3_2rfq_items__qty_clone`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='rfq_items_id',record_id=OLD.id, old_data=OLD.rfq_items_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='rfq_id',record_id=OLD.id, old_data=OLD.rfq_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='release_qty',record_id=OLD.id, old_data=OLD.release_qty, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='release_group',record_id=OLD.id, old_data=OLD.release_group, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='total_material_value',record_id=OLD.id, old_data=OLD.total_material_value, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='total_labor_cost',record_id=OLD.id, old_data=OLD.total_labor_cost, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='unit_price_sell_usa',record_id=OLD.id, old_data=OLD.unit_price_sell_usa, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='unit_price_sell_india',record_id=OLD.id, old_data=OLD.unit_price_sell_india, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='extended_value_price_usa',record_id=OLD.id, old_data=OLD.extended_value_price_usa, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='extended_value_price_india',record_id=OLD.id, old_data=OLD.extended_value_price_india, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='excess_material_price',record_id=OLD.id, old_data=OLD.excess_material_price, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='lead_time_material_in_days',record_id=OLD.id, old_data=OLD.lead_time_material_in_days, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='lead_time_material_in_days_manual_override',record_id=OLD.id, old_data=OLD.lead_time_material_in_days_manual_override, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='lead_time_labor_production_time_in_days',record_id=OLD.id, old_data=OLD.lead_time_labor_production_time_in_days, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='lead_time_labor_production_time_in_days_manual_override',record_id=OLD.id, old_data=OLD.lead_time_labor_production_time_in_days_manual_override, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3_2rfq_items__qty_clone', field_name='lead_time_first_article',record_id=OLD.id, old_data=OLD.lead_time_first_article, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3_2rfq_items__qty_clone_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `3rfq_before_insert` BEFORE INSERT ON `3rfq`
BEGIN 


SET NEW.customer_name = (SELECT company_name FROM 1customers INNER JOIN 2rfq_request ON 2rfq_request.customer_id=1customers.id WHERE 2rfq_request.id=NEW.rfq_request_id);

SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3rfq_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `3rfq_after_insert` AFTER INSERT ON `3rfq`
BEGIN 

/*audit_sql*/
IF (NEW.rfq_request_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='rfq_request_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_request_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.customer_name) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='customer_name',record_id=NEW.id, old_data='', new_data=NEW.customer_name,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.priority) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='priority',record_id=NEW.id, old_data='', new_data=NEW.priority,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.start_date) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='start_date',record_id=NEW.id, old_data='', new_data=NEW.start_date,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.progress_dwg_percentage) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='progress_dwg_percentage',record_id=NEW.id, old_data='', new_data=NEW.progress_dwg_percentage,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.progress_bom_percentage) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='progress_bom_percentage',record_id=NEW.id, old_data='', new_data=NEW.progress_bom_percentage,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.progress_labor_percentage) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='progress_labor_percentage',record_id=NEW.id, old_data='', new_data=NEW.progress_labor_percentage,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.manager_user_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='manager_user_id',record_id=NEW.id, old_data='', new_data=NEW.manager_user_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.engineer_user_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='engineer_user_id',record_id=NEW.id, old_data='', new_data=NEW.engineer_user_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3rfq_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `3rfq_before_update` BEFORE UPDATE ON `3rfq`
BEGIN 


SET NEW.customer_name = (SELECT company_name FROM 1customers INNER JOIN 2rfq_request ON 2rfq_request.customer_id=1customers.id WHERE 2rfq_request.id=NEW.rfq_request_id);


IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3rfq_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `3rfq_after_update` AFTER UPDATE ON `3rfq`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.rfq_request_id,'')<>'' THEN
IF (OLD.rfq_request_id <> NEW.rfq_request_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='rfq_request_id',record_id=NEW.id, old_data=OLD.rfq_request_id, new_data=NEW.rfq_request_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.customer_name,'')<>'' THEN
IF (OLD.customer_name <> NEW.customer_name) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='customer_name',record_id=NEW.id, old_data=OLD.customer_name, new_data=NEW.customer_name,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.priority,'')<>'' THEN
IF (OLD.priority <> NEW.priority) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='priority',record_id=NEW.id, old_data=OLD.priority, new_data=NEW.priority,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.start_date,'')<>'' THEN
IF (OLD.start_date <> NEW.start_date) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='start_date',record_id=NEW.id, old_data=OLD.start_date, new_data=NEW.start_date,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.progress_dwg_percentage,'')<>'' THEN
IF (OLD.progress_dwg_percentage <> NEW.progress_dwg_percentage) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='progress_dwg_percentage',record_id=NEW.id, old_data=OLD.progress_dwg_percentage, new_data=NEW.progress_dwg_percentage,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.progress_bom_percentage,'')<>'' THEN
IF (OLD.progress_bom_percentage <> NEW.progress_bom_percentage) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='progress_bom_percentage',record_id=NEW.id, old_data=OLD.progress_bom_percentage, new_data=NEW.progress_bom_percentage,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.progress_labor_percentage,'')<>'' THEN
IF (OLD.progress_labor_percentage <> NEW.progress_labor_percentage) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='progress_labor_percentage',record_id=NEW.id, old_data=OLD.progress_labor_percentage, new_data=NEW.progress_labor_percentage,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.manager_user_id,'')<>'' THEN
IF (OLD.manager_user_id <> NEW.manager_user_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='manager_user_id',record_id=NEW.id, old_data=OLD.manager_user_id, new_data=NEW.manager_user_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.engineer_user_id,'')<>'' THEN
IF (OLD.engineer_user_id <> NEW.engineer_user_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='engineer_user_id',record_id=NEW.id, old_data=OLD.engineer_user_id, new_data=NEW.engineer_user_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3rfq_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `3rfq_before_delete` BEFORE DELETE ON `3rfq`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3rfq_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `3rfq_after_delete` AFTER DELETE ON `3rfq`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='rfq_request_id',record_id=OLD.id, old_data=OLD.rfq_request_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='customer_name',record_id=OLD.id, old_data=OLD.customer_name, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='priority',record_id=OLD.id, old_data=OLD.priority, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='start_date',record_id=OLD.id, old_data=OLD.start_date, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='progress_dwg_percentage',record_id=OLD.id, old_data=OLD.progress_dwg_percentage, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='progress_bom_percentage',record_id=OLD.id, old_data=OLD.progress_bom_percentage, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='progress_labor_percentage',record_id=OLD.id, old_data=OLD.progress_labor_percentage, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='manager_user_id',record_id=OLD.id, old_data=OLD.manager_user_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='3rfq', field_name='engineer_user_id',record_id=OLD.id, old_data=OLD.engineer_user_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='3rfq_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `4rfq_items_drawing_before_insert` BEFORE INSERT ON `4rfq_items_drawing`
BEGIN 


SET NEW.rfq_id = (SELECT rfq_id FROM 3_1rfq_items WHERE id=NEW.rfq_items_id);
SET NEW.version_number = (SELECT IFNULL(MAX(version_number),0)+1 FROM 4rfq_items_drawing WHERE rfq_items_id=NEW.rfq_items_id);

SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='4rfq_items_drawing_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `4rfq_items_drawing_after_insert` AFTER INSERT ON `4rfq_items_drawing`
BEGIN 

/*audit_sql*/
IF (NEW.rfq_items_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='4rfq_items_drawing', field_name='rfq_items_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_items_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rfq_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='4rfq_items_drawing', field_name='rfq_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.version_number) THEN
INSERT INTO webcables20_log.log_sql SET table_name='4rfq_items_drawing', field_name='version_number',record_id=NEW.id, old_data='', new_data=NEW.version_number,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.dwg_description) THEN
INSERT INTO webcables20_log.log_sql SET table_name='4rfq_items_drawing', field_name='dwg_description',record_id=NEW.id, old_data='', new_data=NEW.dwg_description,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.default_rev) THEN
INSERT INTO webcables20_log.log_sql SET table_name='4rfq_items_drawing', field_name='default_rev',record_id=NEW.id, old_data='', new_data=NEW.default_rev,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='4rfq_items_drawing_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `4rfq_items_drawing_before_update` BEFORE UPDATE ON `4rfq_items_drawing`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='4rfq_items_drawing_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `4rfq_items_drawing_after_update` AFTER UPDATE ON `4rfq_items_drawing`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.rfq_items_id,'')<>'' THEN
IF (OLD.rfq_items_id <> NEW.rfq_items_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='4rfq_items_drawing', field_name='rfq_items_id',record_id=NEW.id, old_data=OLD.rfq_items_id, new_data=NEW.rfq_items_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_id,'')<>'' THEN
IF (OLD.rfq_id <> NEW.rfq_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='4rfq_items_drawing', field_name='rfq_id',record_id=NEW.id, old_data=OLD.rfq_id, new_data=NEW.rfq_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.version_number,'')<>'' THEN
IF (OLD.version_number <> NEW.version_number) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='4rfq_items_drawing', field_name='version_number',record_id=NEW.id, old_data=OLD.version_number, new_data=NEW.version_number,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.dwg_description,'')<>'' THEN
IF (OLD.dwg_description <> NEW.dwg_description) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='4rfq_items_drawing', field_name='dwg_description',record_id=NEW.id, old_data=OLD.dwg_description, new_data=NEW.dwg_description,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.default_rev,'')<>'' THEN
IF (OLD.default_rev <> NEW.default_rev) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='4rfq_items_drawing', field_name='default_rev',record_id=NEW.id, old_data=OLD.default_rev, new_data=NEW.default_rev,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='4rfq_items_drawing_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `4rfq_items_drawing_before_delete` BEFORE DELETE ON `4rfq_items_drawing`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='4rfq_items_drawing_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `4rfq_items_drawing_after_delete` AFTER DELETE ON `4rfq_items_drawing`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='4rfq_items_drawing', field_name='rfq_items_id',record_id=OLD.id, old_data=OLD.rfq_items_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='4rfq_items_drawing', field_name='rfq_id',record_id=OLD.id, old_data=OLD.rfq_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='4rfq_items_drawing', field_name='version_number',record_id=OLD.id, old_data=OLD.version_number, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='4rfq_items_drawing', field_name='dwg_description',record_id=OLD.id, old_data=OLD.dwg_description, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='4rfq_items_drawing', field_name='default_rev',record_id=OLD.id, old_data=OLD.default_rev, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='4rfq_items_drawing_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1_1rfq_consolidated_bom_costing_before_insert` BEFORE INSERT ON `5_1_1_1rfq_consolidated_bom_costing`
BEGIN 


SET NEW.release_qtys = (SELECT group_concat(release_qty) AS release_qtys FROM 3_2rfq_items__qty WHERE rfq_id = 1 GROUP BY release_group);

SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_1rfq_consolidated_bom_costing_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `5_1_1_1rfq_consolidated_bom_costing_after_insert` AFTER INSERT ON `5_1_1_1rfq_consolidated_bom_costing`
BEGIN 

/*audit_sql*/
IF (NEW.rfq_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='rfq_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rfq_consolidated_bom_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='rfq_consolidated_bom_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_consolidated_bom_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.release_qtys) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='release_qtys',record_id=NEW.id, old_data='', new_data=NEW.release_qtys,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rfq_items_ids) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='rfq_items_ids',record_id=NEW.id, old_data='', new_data=NEW.rfq_items_ids,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.release_group) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='release_group',record_id=NEW.id, old_data='', new_data=NEW.release_group,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.required_qty) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='required_qty',record_id=NEW.id, old_data='', new_data=NEW.required_qty,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.source_type_auto) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='source_type_auto',record_id=NEW.id, old_data='', new_data=NEW.source_type_auto,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.source_type_manual) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='source_type_manual',record_id=NEW.id, old_data='', new_data=NEW.source_type_manual,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.octa_parts_api_response_json_dump) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='octa_parts_api_response_json_dump',record_id=NEW.id, old_data='', new_data=NEW.octa_parts_api_response_json_dump,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.octa_parts_api_response_datetime) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='octa_parts_api_response_datetime',record_id=NEW.id, old_data='', new_data=NEW.octa_parts_api_response_datetime,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.unit_price_purchase) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='unit_price_purchase',record_id=NEW.id, old_data='', new_data=NEW.unit_price_purchase,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.marked_price_calculate) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='marked_price_calculate',record_id=NEW.id, old_data='', new_data=NEW.marked_price_calculate,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.purchase_qty) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='purchase_qty',record_id=NEW.id, old_data='', new_data=NEW.purchase_qty,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.excess_qty) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='excess_qty',record_id=NEW.id, old_data='', new_data=NEW.excess_qty,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.price_line_total_purchase) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='price_line_total_purchase',record_id=NEW.id, old_data='', new_data=NEW.price_line_total_purchase,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.price_line_total_customer) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='price_line_total_customer',record_id=NEW.id, old_data='', new_data=NEW.price_line_total_customer,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_1rfq_consolidated_bom_costing_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1_1rfq_consolidated_bom_costing_before_update` BEFORE UPDATE ON `5_1_1_1rfq_consolidated_bom_costing`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_1rfq_consolidated_bom_costing_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1_1rfq_consolidated_bom_costing_after_update` AFTER UPDATE ON `5_1_1_1rfq_consolidated_bom_costing`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.rfq_id,'')<>'' THEN
IF (OLD.rfq_id <> NEW.rfq_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='rfq_id',record_id=NEW.id, old_data=OLD.rfq_id, new_data=NEW.rfq_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_consolidated_bom_id,'')<>'' THEN
IF (OLD.rfq_consolidated_bom_id <> NEW.rfq_consolidated_bom_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='rfq_consolidated_bom_id',record_id=NEW.id, old_data=OLD.rfq_consolidated_bom_id, new_data=NEW.rfq_consolidated_bom_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.release_qtys,'')<>'' THEN
IF (OLD.release_qtys <> NEW.release_qtys) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='release_qtys',record_id=NEW.id, old_data=OLD.release_qtys, new_data=NEW.release_qtys,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_items_ids,'')<>'' THEN
IF (OLD.rfq_items_ids <> NEW.rfq_items_ids) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='rfq_items_ids',record_id=NEW.id, old_data=OLD.rfq_items_ids, new_data=NEW.rfq_items_ids,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.release_group,'')<>'' THEN
IF (OLD.release_group <> NEW.release_group) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='release_group',record_id=NEW.id, old_data=OLD.release_group, new_data=NEW.release_group,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.required_qty,'')<>'' THEN
IF (OLD.required_qty <> NEW.required_qty) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='required_qty',record_id=NEW.id, old_data=OLD.required_qty, new_data=NEW.required_qty,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.source_type_auto,'')<>'' THEN
IF (OLD.source_type_auto <> NEW.source_type_auto) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='source_type_auto',record_id=NEW.id, old_data=OLD.source_type_auto, new_data=NEW.source_type_auto,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.source_type_manual,'')<>'' THEN
IF (OLD.source_type_manual <> NEW.source_type_manual) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='source_type_manual',record_id=NEW.id, old_data=OLD.source_type_manual, new_data=NEW.source_type_manual,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.octa_parts_api_response_json_dump,'')<>'' THEN
IF (OLD.octa_parts_api_response_json_dump <> NEW.octa_parts_api_response_json_dump) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='octa_parts_api_response_json_dump',record_id=NEW.id, old_data=OLD.octa_parts_api_response_json_dump, new_data=NEW.octa_parts_api_response_json_dump,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.octa_parts_api_response_datetime,'')<>'' THEN
IF (OLD.octa_parts_api_response_datetime <> NEW.octa_parts_api_response_datetime) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='octa_parts_api_response_datetime',record_id=NEW.id, old_data=OLD.octa_parts_api_response_datetime, new_data=NEW.octa_parts_api_response_datetime,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.unit_price_purchase,'')<>'' THEN
IF (OLD.unit_price_purchase <> NEW.unit_price_purchase) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='unit_price_purchase',record_id=NEW.id, old_data=OLD.unit_price_purchase, new_data=NEW.unit_price_purchase,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.marked_price_calculate,'')<>'' THEN
IF (OLD.marked_price_calculate <> NEW.marked_price_calculate) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='marked_price_calculate',record_id=NEW.id, old_data=OLD.marked_price_calculate, new_data=NEW.marked_price_calculate,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.purchase_qty,'')<>'' THEN
IF (OLD.purchase_qty <> NEW.purchase_qty) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='purchase_qty',record_id=NEW.id, old_data=OLD.purchase_qty, new_data=NEW.purchase_qty,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.excess_qty,'')<>'' THEN
IF (OLD.excess_qty <> NEW.excess_qty) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='excess_qty',record_id=NEW.id, old_data=OLD.excess_qty, new_data=NEW.excess_qty,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.price_line_total_purchase,'')<>'' THEN
IF (OLD.price_line_total_purchase <> NEW.price_line_total_purchase) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='price_line_total_purchase',record_id=NEW.id, old_data=OLD.price_line_total_purchase, new_data=NEW.price_line_total_purchase,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.price_line_total_customer,'')<>'' THEN
IF (OLD.price_line_total_customer <> NEW.price_line_total_customer) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='price_line_total_customer',record_id=NEW.id, old_data=OLD.price_line_total_customer, new_data=NEW.price_line_total_customer,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_1rfq_consolidated_bom_costing_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1_1rfq_consolidated_bom_costing_before_delete` BEFORE DELETE ON `5_1_1_1rfq_consolidated_bom_costing`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_1rfq_consolidated_bom_costing_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1_1rfq_consolidated_bom_costing_after_delete` AFTER DELETE ON `5_1_1_1rfq_consolidated_bom_costing`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='rfq_id',record_id=OLD.id, old_data=OLD.rfq_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='rfq_consolidated_bom_id',record_id=OLD.id, old_data=OLD.rfq_consolidated_bom_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='release_qtys',record_id=OLD.id, old_data=OLD.release_qtys, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='rfq_items_ids',record_id=OLD.id, old_data=OLD.rfq_items_ids, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='release_group',record_id=OLD.id, old_data=OLD.release_group, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='required_qty',record_id=OLD.id, old_data=OLD.required_qty, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='source_type_auto',record_id=OLD.id, old_data=OLD.source_type_auto, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='source_type_manual',record_id=OLD.id, old_data=OLD.source_type_manual, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='octa_parts_api_response_json_dump',record_id=OLD.id, old_data=OLD.octa_parts_api_response_json_dump, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='octa_parts_api_response_datetime',record_id=OLD.id, old_data=OLD.octa_parts_api_response_datetime, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='unit_price_purchase',record_id=OLD.id, old_data=OLD.unit_price_purchase, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='marked_price_calculate',record_id=OLD.id, old_data=OLD.marked_price_calculate, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='purchase_qty',record_id=OLD.id, old_data=OLD.purchase_qty, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='excess_qty',record_id=OLD.id, old_data=OLD.excess_qty, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='price_line_total_purchase',record_id=OLD.id, old_data=OLD.price_line_total_purchase, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_1rfq_consolidated_bom_costing', field_name='price_line_total_customer',record_id=OLD.id, old_data=OLD.price_line_total_customer, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_1rfq_consolidated_bom_costing_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1_2rfq_consolidated_bom_required_vendor_before_insert` BEFORE INSERT ON `5_1_1_2rfq_consolidated_bom_required_vendor`
BEGIN 


DECLARE item_no VARCHAR(255);
SET NEW.vendor_name = (SELECT vendor_name FROM m_vendors WHERE id=NEW.vendor_id);
SET NEW.vendor_email = (SELECT vendor_email FROM m_vendors WHERE id=NEW.vendor_id);
SET NEW.vendor_visit_read_stats = (SELECT COUNT(id) FROM 5_1_1_2rfq_consolidated_bom_required_vendor_stats WHERE rfq_consolidated_bom_required_vendor_id=NEW.id);


SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_2rfq_consolidated_bom_required_vendor_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `5_1_1_2rfq_consolidated_bom_required_vendor_after_insert` AFTER INSERT ON `5_1_1_2rfq_consolidated_bom_required_vendor`
BEGIN 

/*audit_sql*/
IF (NEW.rfq_consolidated_bom_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='rfq_consolidated_bom_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_consolidated_bom_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.vendor_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_id',record_id=NEW.id, old_data='', new_data=NEW.vendor_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.vendor_name) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_name',record_id=NEW.id, old_data='', new_data=NEW.vendor_name,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.vendor_email) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_email',record_id=NEW.id, old_data='', new_data=NEW.vendor_email,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.requested_datetime) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='requested_datetime',record_id=NEW.id, old_data='', new_data=NEW.requested_datetime,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.requested_message) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='requested_message',record_id=NEW.id, old_data='', new_data=NEW.requested_message,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.vendor_response_datetime) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_response_datetime',record_id=NEW.id, old_data='', new_data=NEW.vendor_response_datetime,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.vendor_response_upload_file) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_response_upload_file',record_id=NEW.id, old_data='', new_data=NEW.vendor_response_upload_file,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.vendor_response_price) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_response_price',record_id=NEW.id, old_data='', new_data=NEW.vendor_response_price,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.vendor_response_price_for_qty) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_response_price_for_qty',record_id=NEW.id, old_data='', new_data=NEW.vendor_response_price_for_qty,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.vendor_visit_read_stats) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_visit_read_stats',record_id=NEW.id, old_data='', new_data=NEW.vendor_visit_read_stats,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_2rfq_consolidated_bom_required_vendor_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1_2rfq_consolidated_bom_required_vendor_before_update` BEFORE UPDATE ON `5_1_1_2rfq_consolidated_bom_required_vendor`
BEGIN 


IF(OLD.vendor_id<>NEW.vendor_id) THEN
SET NEW.vendor_name = (SELECT vendor_name FROM m_vendors WHERE id=NEW.vendor_id);
SET NEW.vendor_email = (SELECT vendor_email FROM m_vendors WHERE id=NEW.vendor_id);
END IF;


IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_2rfq_consolidated_bom_required_vendor_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `5_1_1_2rfq_consolidated_bom_required_vendor_after_update` AFTER UPDATE ON `5_1_1_2rfq_consolidated_bom_required_vendor`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.rfq_consolidated_bom_id,'')<>'' THEN
IF (OLD.rfq_consolidated_bom_id <> NEW.rfq_consolidated_bom_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='rfq_consolidated_bom_id',record_id=NEW.id, old_data=OLD.rfq_consolidated_bom_id, new_data=NEW.rfq_consolidated_bom_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.vendor_id,'')<>'' THEN
IF (OLD.vendor_id <> NEW.vendor_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_id',record_id=NEW.id, old_data=OLD.vendor_id, new_data=NEW.vendor_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.vendor_name,'')<>'' THEN
IF (OLD.vendor_name <> NEW.vendor_name) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_name',record_id=NEW.id, old_data=OLD.vendor_name, new_data=NEW.vendor_name,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.vendor_email,'')<>'' THEN
IF (OLD.vendor_email <> NEW.vendor_email) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_email',record_id=NEW.id, old_data=OLD.vendor_email, new_data=NEW.vendor_email,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.requested_datetime,'')<>'' THEN
IF (OLD.requested_datetime <> NEW.requested_datetime) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='requested_datetime',record_id=NEW.id, old_data=OLD.requested_datetime, new_data=NEW.requested_datetime,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.requested_message,'')<>'' THEN
IF (OLD.requested_message <> NEW.requested_message) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='requested_message',record_id=NEW.id, old_data=OLD.requested_message, new_data=NEW.requested_message,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.vendor_response_datetime,'')<>'' THEN
IF (OLD.vendor_response_datetime <> NEW.vendor_response_datetime) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_response_datetime',record_id=NEW.id, old_data=OLD.vendor_response_datetime, new_data=NEW.vendor_response_datetime,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.vendor_response_upload_file,'')<>'' THEN
IF (OLD.vendor_response_upload_file <> NEW.vendor_response_upload_file) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_response_upload_file',record_id=NEW.id, old_data=OLD.vendor_response_upload_file, new_data=NEW.vendor_response_upload_file,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.vendor_response_price,'')<>'' THEN
IF (OLD.vendor_response_price <> NEW.vendor_response_price) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_response_price',record_id=NEW.id, old_data=OLD.vendor_response_price, new_data=NEW.vendor_response_price,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.vendor_response_price_for_qty,'')<>'' THEN
IF (OLD.vendor_response_price_for_qty <> NEW.vendor_response_price_for_qty) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_response_price_for_qty',record_id=NEW.id, old_data=OLD.vendor_response_price_for_qty, new_data=NEW.vendor_response_price_for_qty,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.vendor_visit_read_stats,'')<>'' THEN
IF (OLD.vendor_visit_read_stats <> NEW.vendor_visit_read_stats) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_visit_read_stats',record_id=NEW.id, old_data=OLD.vendor_visit_read_stats, new_data=NEW.vendor_visit_read_stats,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_2rfq_consolidated_bom_required_vendor_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1_2rfq_consolidated_bom_required_vendor_before_delete` BEFORE DELETE ON `5_1_1_2rfq_consolidated_bom_required_vendor`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_2rfq_consolidated_bom_required_vendor_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1_2rfq_consolidated_bom_required_vendor_after_delete` AFTER DELETE ON `5_1_1_2rfq_consolidated_bom_required_vendor`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='rfq_consolidated_bom_id',record_id=OLD.id, old_data=OLD.rfq_consolidated_bom_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_id',record_id=OLD.id, old_data=OLD.vendor_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_name',record_id=OLD.id, old_data=OLD.vendor_name, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_email',record_id=OLD.id, old_data=OLD.vendor_email, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='requested_datetime',record_id=OLD.id, old_data=OLD.requested_datetime, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='requested_message',record_id=OLD.id, old_data=OLD.requested_message, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_response_datetime',record_id=OLD.id, old_data=OLD.vendor_response_datetime, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_response_upload_file',record_id=OLD.id, old_data=OLD.vendor_response_upload_file, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_response_price',record_id=OLD.id, old_data=OLD.vendor_response_price, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_response_price_for_qty',record_id=OLD.id, old_data=OLD.vendor_response_price_for_qty, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor', field_name='vendor_visit_read_stats',record_id=OLD.id, old_data=OLD.vendor_visit_read_stats, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_2rfq_consolidated_bom_required_vendor_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1_2rfq_consolidated_bom_required_vendor_stats_before_insert` BEFORE INSERT ON `5_1_1_2rfq_consolidated_bom_required_vendor_stats`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;
IF NEW.audit_created_by NOT LIKE '%trigger' THEN
SET NEW.audit_created_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
SET NEW.audit_created_date=CURRENT_TIMESTAMP();

IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;
SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_2rfq_consolidated_bom_required_vendor_stats_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1_2rfq_consolidated_bom_required_vendor_stats_after_insert` AFTER INSERT ON `5_1_1_2rfq_consolidated_bom_required_vendor_stats`
BEGIN 


DECLARE visit_count INT(11);
SET visit_count = (SELECT COUNT(id) FROM 5_1_1_2rfq_consolidated_bom_required_vendor_stats WHERE rfq_consolidated_bom_required_vendor_id=NEW.rfq_consolidated_bom_required_vendor_id);
UPDATE 5_1_1_2rfq_consolidated_bom_required_vendor SET vendor_visit_read_stats=visit_count;

IF (NEW.rfq_consolidated_bom_required_vendor_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor_stats', field_name='rfq_consolidated_bom_required_vendor_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_consolidated_bom_required_vendor_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.vendor_ip_address) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor_stats', field_name='vendor_ip_address',record_id=NEW.id, old_data='', new_data=NEW.vendor_ip_address,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.timestamp) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor_stats', field_name='timestamp',record_id=NEW.id, old_data='', new_data=NEW.timestamp,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_2rfq_consolidated_bom_required_vendor_stats_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `5_1_1_2rfq_consolidated_bom_required_vendor_stats_before_update` BEFORE UPDATE ON `5_1_1_2rfq_consolidated_bom_required_vendor_stats`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_2rfq_consolidated_bom_required_vendor_stats_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1_2rfq_consolidated_bom_required_vendor_stats_after_update` AFTER UPDATE ON `5_1_1_2rfq_consolidated_bom_required_vendor_stats`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.rfq_consolidated_bom_required_vendor_id,'')<>'' THEN
IF (OLD.rfq_consolidated_bom_required_vendor_id <> NEW.rfq_consolidated_bom_required_vendor_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor_stats', field_name='rfq_consolidated_bom_required_vendor_id',record_id=NEW.id, old_data=OLD.rfq_consolidated_bom_required_vendor_id, new_data=NEW.rfq_consolidated_bom_required_vendor_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.vendor_ip_address,'')<>'' THEN
IF (OLD.vendor_ip_address <> NEW.vendor_ip_address) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor_stats', field_name='vendor_ip_address',record_id=NEW.id, old_data=OLD.vendor_ip_address, new_data=NEW.vendor_ip_address,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.timestamp,'')<>'' THEN
IF (OLD.timestamp <> NEW.timestamp) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor_stats', field_name='timestamp',record_id=NEW.id, old_data=OLD.timestamp, new_data=NEW.timestamp,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_2rfq_consolidated_bom_required_vendor_stats_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1_2rfq_consolidated_bom_required_vendor_stats_before_delete` BEFORE DELETE ON `5_1_1_2rfq_consolidated_bom_required_vendor_stats`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_2rfq_consolidated_bom_required_vendor_stats_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1_2rfq_consolidated_bom_required_vendor_stats_after_delete` AFTER DELETE ON `5_1_1_2rfq_consolidated_bom_required_vendor_stats`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor_stats', field_name='rfq_consolidated_bom_required_vendor_id',record_id=OLD.id, old_data=OLD.rfq_consolidated_bom_required_vendor_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor_stats', field_name='vendor_ip_address',record_id=OLD.id, old_data=OLD.vendor_ip_address, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1_2rfq_consolidated_bom_required_vendor_stats', field_name='timestamp',record_id=OLD.id, old_data=OLD.timestamp, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1_2rfq_consolidated_bom_required_vendor_stats_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1rfq_consolidated_bom_before_insert` BEFORE INSERT ON `5_1_1rfq_consolidated_bom`
BEGIN 


SET NEW.rfq_id = (SELECT rfq_id FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_ids);
SET NEW.item_no = (SELECT item_no FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_ids);
SET NEW.item_desc = (SELECT item_desc FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_ids);
SET NEW.mfg_partnumber = (SELECT mfg_part_number FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_ids);
SET NEW.rev = (SELECT rev FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_ids);
SET NEW.equivalent = (SELECT equivalent FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_ids);
SET NEW.uom = (SELECT uom FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_ids);
SET NEW.note = (SELECT note FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_ids);

SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1rfq_consolidated_bom_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `5_1_1rfq_consolidated_bom_after_insert` AFTER INSERT ON `5_1_1rfq_consolidated_bom`
BEGIN 

/*audit_sql*/
IF (NEW.rfq_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='rfq_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rfq_items_bom_items_ids) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='rfq_items_bom_items_ids',record_id=NEW.id, old_data='', new_data=NEW.rfq_items_bom_items_ids,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.item_no) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='item_no',record_id=NEW.id, old_data='', new_data=NEW.item_no,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.item_desc) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='item_desc',record_id=NEW.id, old_data='', new_data=NEW.item_desc,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.mfg_partnumber) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='mfg_partnumber',record_id=NEW.id, old_data='', new_data=NEW.mfg_partnumber,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.cypress_partnumber) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='cypress_partnumber',record_id=NEW.id, old_data='', new_data=NEW.cypress_partnumber,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rev) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='rev',record_id=NEW.id, old_data='', new_data=NEW.rev,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.bom_level) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='bom_level',record_id=NEW.id, old_data='', new_data=NEW.bom_level,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.equivalent) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='equivalent',record_id=NEW.id, old_data='', new_data=NEW.equivalent,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.quantity_for_one_piece) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='quantity_for_one_piece',record_id=NEW.id, old_data='', new_data=NEW.quantity_for_one_piece,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.uom) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='uom',record_id=NEW.id, old_data='', new_data=NEW.uom,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.vendor_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='vendor_id',record_id=NEW.id, old_data='', new_data=NEW.vendor_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.vendor_name) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='vendor_name',record_id=NEW.id, old_data='', new_data=NEW.vendor_name,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.available_stock) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='available_stock',record_id=NEW.id, old_data='', new_data=NEW.available_stock,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.country_of_origin) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='country_of_origin',record_id=NEW.id, old_data='', new_data=NEW.country_of_origin,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.lead_time_in_days) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='lead_time_in_days',record_id=NEW.id, old_data='', new_data=NEW.lead_time_in_days,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.moq) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='moq',record_id=NEW.id, old_data='', new_data=NEW.moq,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.multiples) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='multiples',record_id=NEW.id, old_data='', new_data=NEW.multiples,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.requested_vendor) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='requested_vendor',record_id=NEW.id, old_data='', new_data=NEW.requested_vendor,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.markup_percentage) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='markup_percentage',record_id=NEW.id, old_data='', new_data=NEW.markup_percentage,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.markup_dollars) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='markup_dollars',record_id=NEW.id, old_data='', new_data=NEW.markup_dollars,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.note) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='note',record_id=NEW.id, old_data='', new_data=NEW.note,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rfq_items_bom_ids) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='rfq_items_bom_ids',record_id=NEW.id, old_data='', new_data=NEW.rfq_items_bom_ids,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1rfq_consolidated_bom_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1rfq_consolidated_bom_before_update` BEFORE UPDATE ON `5_1_1rfq_consolidated_bom`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1rfq_consolidated_bom_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1rfq_consolidated_bom_after_update` AFTER UPDATE ON `5_1_1rfq_consolidated_bom`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.rfq_id,'')<>'' THEN
IF (OLD.rfq_id <> NEW.rfq_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='rfq_id',record_id=NEW.id, old_data=OLD.rfq_id, new_data=NEW.rfq_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_items_bom_items_ids,'')<>'' THEN
IF (OLD.rfq_items_bom_items_ids <> NEW.rfq_items_bom_items_ids) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='rfq_items_bom_items_ids',record_id=NEW.id, old_data=OLD.rfq_items_bom_items_ids, new_data=NEW.rfq_items_bom_items_ids,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.item_no,'')<>'' THEN
IF (OLD.item_no <> NEW.item_no) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='item_no',record_id=NEW.id, old_data=OLD.item_no, new_data=NEW.item_no,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.item_desc,'')<>'' THEN
IF (OLD.item_desc <> NEW.item_desc) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='item_desc',record_id=NEW.id, old_data=OLD.item_desc, new_data=NEW.item_desc,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.mfg_partnumber,'')<>'' THEN
IF (OLD.mfg_partnumber <> NEW.mfg_partnumber) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='mfg_partnumber',record_id=NEW.id, old_data=OLD.mfg_partnumber, new_data=NEW.mfg_partnumber,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.cypress_partnumber,'')<>'' THEN
IF (OLD.cypress_partnumber <> NEW.cypress_partnumber) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='cypress_partnumber',record_id=NEW.id, old_data=OLD.cypress_partnumber, new_data=NEW.cypress_partnumber,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rev,'')<>'' THEN
IF (OLD.rev <> NEW.rev) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='rev',record_id=NEW.id, old_data=OLD.rev, new_data=NEW.rev,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.bom_level,'')<>'' THEN
IF (OLD.bom_level <> NEW.bom_level) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='bom_level',record_id=NEW.id, old_data=OLD.bom_level, new_data=NEW.bom_level,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.equivalent,'')<>'' THEN
IF (OLD.equivalent <> NEW.equivalent) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='equivalent',record_id=NEW.id, old_data=OLD.equivalent, new_data=NEW.equivalent,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.quantity_for_one_piece,'')<>'' THEN
IF (OLD.quantity_for_one_piece <> NEW.quantity_for_one_piece) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='quantity_for_one_piece',record_id=NEW.id, old_data=OLD.quantity_for_one_piece, new_data=NEW.quantity_for_one_piece,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.uom,'')<>'' THEN
IF (OLD.uom <> NEW.uom) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='uom',record_id=NEW.id, old_data=OLD.uom, new_data=NEW.uom,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.vendor_id,'')<>'' THEN
IF (OLD.vendor_id <> NEW.vendor_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='vendor_id',record_id=NEW.id, old_data=OLD.vendor_id, new_data=NEW.vendor_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.vendor_name,'')<>'' THEN
IF (OLD.vendor_name <> NEW.vendor_name) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='vendor_name',record_id=NEW.id, old_data=OLD.vendor_name, new_data=NEW.vendor_name,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.available_stock,'')<>'' THEN
IF (OLD.available_stock <> NEW.available_stock) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='available_stock',record_id=NEW.id, old_data=OLD.available_stock, new_data=NEW.available_stock,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.country_of_origin,'')<>'' THEN
IF (OLD.country_of_origin <> NEW.country_of_origin) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='country_of_origin',record_id=NEW.id, old_data=OLD.country_of_origin, new_data=NEW.country_of_origin,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.lead_time_in_days,'')<>'' THEN
IF (OLD.lead_time_in_days <> NEW.lead_time_in_days) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='lead_time_in_days',record_id=NEW.id, old_data=OLD.lead_time_in_days, new_data=NEW.lead_time_in_days,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.moq,'')<>'' THEN
IF (OLD.moq <> NEW.moq) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='moq',record_id=NEW.id, old_data=OLD.moq, new_data=NEW.moq,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.multiples,'')<>'' THEN
IF (OLD.multiples <> NEW.multiples) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='multiples',record_id=NEW.id, old_data=OLD.multiples, new_data=NEW.multiples,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.requested_vendor,'')<>'' THEN
IF (OLD.requested_vendor <> NEW.requested_vendor) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='requested_vendor',record_id=NEW.id, old_data=OLD.requested_vendor, new_data=NEW.requested_vendor,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.markup_percentage,'')<>'' THEN
IF (OLD.markup_percentage <> NEW.markup_percentage) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='markup_percentage',record_id=NEW.id, old_data=OLD.markup_percentage, new_data=NEW.markup_percentage,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.markup_dollars,'')<>'' THEN
IF (OLD.markup_dollars <> NEW.markup_dollars) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='markup_dollars',record_id=NEW.id, old_data=OLD.markup_dollars, new_data=NEW.markup_dollars,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.note,'')<>'' THEN
IF (OLD.note <> NEW.note) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='note',record_id=NEW.id, old_data=OLD.note, new_data=NEW.note,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_items_bom_ids,'')<>'' THEN
IF (OLD.rfq_items_bom_ids <> NEW.rfq_items_bom_ids) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='rfq_items_bom_ids',record_id=NEW.id, old_data=OLD.rfq_items_bom_ids, new_data=NEW.rfq_items_bom_ids,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1rfq_consolidated_bom_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1rfq_consolidated_bom_before_delete` BEFORE DELETE ON `5_1_1rfq_consolidated_bom`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1rfq_consolidated_bom_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1_1rfq_consolidated_bom_after_delete` AFTER DELETE ON `5_1_1rfq_consolidated_bom`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='rfq_id',record_id=OLD.id, old_data=OLD.rfq_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='rfq_items_bom_items_ids',record_id=OLD.id, old_data=OLD.rfq_items_bom_items_ids, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='item_no',record_id=OLD.id, old_data=OLD.item_no, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='item_desc',record_id=OLD.id, old_data=OLD.item_desc, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='mfg_partnumber',record_id=OLD.id, old_data=OLD.mfg_partnumber, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='cypress_partnumber',record_id=OLD.id, old_data=OLD.cypress_partnumber, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='rev',record_id=OLD.id, old_data=OLD.rev, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='bom_level',record_id=OLD.id, old_data=OLD.bom_level, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='equivalent',record_id=OLD.id, old_data=OLD.equivalent, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='quantity_for_one_piece',record_id=OLD.id, old_data=OLD.quantity_for_one_piece, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='uom',record_id=OLD.id, old_data=OLD.uom, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='vendor_id',record_id=OLD.id, old_data=OLD.vendor_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='vendor_name',record_id=OLD.id, old_data=OLD.vendor_name, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='available_stock',record_id=OLD.id, old_data=OLD.available_stock, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='country_of_origin',record_id=OLD.id, old_data=OLD.country_of_origin, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='lead_time_in_days',record_id=OLD.id, old_data=OLD.lead_time_in_days, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='moq',record_id=OLD.id, old_data=OLD.moq, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='multiples',record_id=OLD.id, old_data=OLD.multiples, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='requested_vendor',record_id=OLD.id, old_data=OLD.requested_vendor, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='markup_percentage',record_id=OLD.id, old_data=OLD.markup_percentage, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='markup_dollars',record_id=OLD.id, old_data=OLD.markup_dollars, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='note',record_id=OLD.id, old_data=OLD.note, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1_1rfq_consolidated_bom', field_name='rfq_items_bom_ids',record_id=OLD.id, old_data=OLD.rfq_items_bom_ids, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1_1rfq_consolidated_bom_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1rfq_items_bom_items_before_insert` BEFORE INSERT ON `5_1rfq_items_bom_items`
BEGIN 


SET NEW.rfq_id = (SELECT rfq_id FROM 5rfq_items_bom WHERE id=NEW.rfq_items_bom_id);

SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1rfq_items_bom_items_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `5_1rfq_items_bom_items_after_insert` AFTER INSERT ON `5_1rfq_items_bom_items`
BEGIN 

/*audit_sql*/
IF (NEW.rfq_items_bom_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='rfq_items_bom_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_items_bom_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rfq_items_bom_items_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='rfq_items_bom_items_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_items_bom_items_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rfq_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='rfq_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.item_no) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='item_no',record_id=NEW.id, old_data='', new_data=NEW.item_no,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.item_desc) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='item_desc',record_id=NEW.id, old_data='', new_data=NEW.item_desc,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.mfg_part_number) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='mfg_part_number',record_id=NEW.id, old_data='', new_data=NEW.mfg_part_number,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.equivalent) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='equivalent',record_id=NEW.id, old_data='', new_data=NEW.equivalent,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.qty) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='qty',record_id=NEW.id, old_data='', new_data=NEW.qty,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.uom) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='uom',record_id=NEW.id, old_data='', new_data=NEW.uom,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rev) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='rev',record_id=NEW.id, old_data='', new_data=NEW.rev,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.inbound_freight) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='inbound_freight',record_id=NEW.id, old_data='', new_data=NEW.inbound_freight,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.note) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='note',record_id=NEW.id, old_data='', new_data=NEW.note,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1rfq_items_bom_items_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1rfq_items_bom_items_before_update` BEFORE UPDATE ON `5_1rfq_items_bom_items`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1rfq_items_bom_items_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1rfq_items_bom_items_after_update` AFTER UPDATE ON `5_1rfq_items_bom_items`
BEGIN 


UPDATE 5_1_1rfq_consolidated_bom SET 
rfq_id=NEW.rfq_id,
item_no=NEW.item_no,
item_desc=NEW.item_desc,
mfg_partnumber=NEW.mfg_part_number,
rev=NEW.rev,
equivalent=NEW.equivalent,
uom=NEW.uom,
note=NEW.note
WHERE rfq_items_bom_items_ids=NEW.id;

IF IFNULL(NEW.rfq_items_bom_id,'')<>'' THEN
IF (OLD.rfq_items_bom_id <> NEW.rfq_items_bom_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='rfq_items_bom_id',record_id=NEW.id, old_data=OLD.rfq_items_bom_id, new_data=NEW.rfq_items_bom_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_items_bom_items_id,'')<>'' THEN
IF (OLD.rfq_items_bom_items_id <> NEW.rfq_items_bom_items_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='rfq_items_bom_items_id',record_id=NEW.id, old_data=OLD.rfq_items_bom_items_id, new_data=NEW.rfq_items_bom_items_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_id,'')<>'' THEN
IF (OLD.rfq_id <> NEW.rfq_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='rfq_id',record_id=NEW.id, old_data=OLD.rfq_id, new_data=NEW.rfq_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.item_no,'')<>'' THEN
IF (OLD.item_no <> NEW.item_no) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='item_no',record_id=NEW.id, old_data=OLD.item_no, new_data=NEW.item_no,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.item_desc,'')<>'' THEN
IF (OLD.item_desc <> NEW.item_desc) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='item_desc',record_id=NEW.id, old_data=OLD.item_desc, new_data=NEW.item_desc,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.mfg_part_number,'')<>'' THEN
IF (OLD.mfg_part_number <> NEW.mfg_part_number) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='mfg_part_number',record_id=NEW.id, old_data=OLD.mfg_part_number, new_data=NEW.mfg_part_number,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.equivalent,'')<>'' THEN
IF (OLD.equivalent <> NEW.equivalent) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='equivalent',record_id=NEW.id, old_data=OLD.equivalent, new_data=NEW.equivalent,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.qty,'')<>'' THEN
IF (OLD.qty <> NEW.qty) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='qty',record_id=NEW.id, old_data=OLD.qty, new_data=NEW.qty,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.uom,'')<>'' THEN
IF (OLD.uom <> NEW.uom) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='uom',record_id=NEW.id, old_data=OLD.uom, new_data=NEW.uom,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rev,'')<>'' THEN
IF (OLD.rev <> NEW.rev) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='rev',record_id=NEW.id, old_data=OLD.rev, new_data=NEW.rev,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.inbound_freight,'')<>'' THEN
IF (OLD.inbound_freight <> NEW.inbound_freight) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='inbound_freight',record_id=NEW.id, old_data=OLD.inbound_freight, new_data=NEW.inbound_freight,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.note,'')<>'' THEN
IF (OLD.note <> NEW.note) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='note',record_id=NEW.id, old_data=OLD.note, new_data=NEW.note,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1rfq_items_bom_items_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `5_1rfq_items_bom_items_before_delete` BEFORE DELETE ON `5_1rfq_items_bom_items`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1rfq_items_bom_items_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5_1rfq_items_bom_items_after_delete` AFTER DELETE ON `5_1rfq_items_bom_items`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='rfq_items_bom_id',record_id=OLD.id, old_data=OLD.rfq_items_bom_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='rfq_items_bom_items_id',record_id=OLD.id, old_data=OLD.rfq_items_bom_items_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='rfq_id',record_id=OLD.id, old_data=OLD.rfq_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='item_no',record_id=OLD.id, old_data=OLD.item_no, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='item_desc',record_id=OLD.id, old_data=OLD.item_desc, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='mfg_part_number',record_id=OLD.id, old_data=OLD.mfg_part_number, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='equivalent',record_id=OLD.id, old_data=OLD.equivalent, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='qty',record_id=OLD.id, old_data=OLD.qty, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='uom',record_id=OLD.id, old_data=OLD.uom, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='rev',record_id=OLD.id, old_data=OLD.rev, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='inbound_freight',record_id=OLD.id, old_data=OLD.inbound_freight, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5_1rfq_items_bom_items', field_name='note',record_id=OLD.id, old_data=OLD.note, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5_1rfq_items_bom_items_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5rfq_items_bom_before_insert` BEFORE INSERT ON `5rfq_items_bom`
BEGIN 


SET NEW.rfq_id = (SELECT rfq_id FROM 3_1rfq_items WHERE id=NEW.rfq_items_id);
SET NEW.version_number = (SELECT IFNULL(MAX(version_number),0)+1 FROM 5rfq_items_bom WHERE rfq_items_id=NEW.rfq_items_id);

SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5rfq_items_bom_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `5rfq_items_bom_after_insert` AFTER INSERT ON `5rfq_items_bom`
BEGIN 

/*audit_sql*/
IF (NEW.rfq_items_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='rfq_items_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_items_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rfq_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='rfq_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.version_number) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='version_number',record_id=NEW.id, old_data='', new_data=NEW.version_number,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.bom_desc) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='bom_desc',record_id=NEW.id, old_data='', new_data=NEW.bom_desc,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.bom_upload_document) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='bom_upload_document',record_id=NEW.id, old_data='', new_data=NEW.bom_upload_document,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.default_rev) THEN
INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='default_rev',record_id=NEW.id, old_data='', new_data=NEW.default_rev,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5rfq_items_bom_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5rfq_items_bom_before_update` BEFORE UPDATE ON `5rfq_items_bom`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5rfq_items_bom_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5rfq_items_bom_after_update` AFTER UPDATE ON `5rfq_items_bom`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.rfq_items_id,'')<>'' THEN
IF (OLD.rfq_items_id <> NEW.rfq_items_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='rfq_items_id',record_id=NEW.id, old_data=OLD.rfq_items_id, new_data=NEW.rfq_items_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_id,'')<>'' THEN
IF (OLD.rfq_id <> NEW.rfq_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='rfq_id',record_id=NEW.id, old_data=OLD.rfq_id, new_data=NEW.rfq_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.version_number,'')<>'' THEN
IF (OLD.version_number <> NEW.version_number) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='version_number',record_id=NEW.id, old_data=OLD.version_number, new_data=NEW.version_number,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.bom_desc,'')<>'' THEN
IF (OLD.bom_desc <> NEW.bom_desc) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='bom_desc',record_id=NEW.id, old_data=OLD.bom_desc, new_data=NEW.bom_desc,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.bom_upload_document,'')<>'' THEN
IF (OLD.bom_upload_document <> NEW.bom_upload_document) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='bom_upload_document',record_id=NEW.id, old_data=OLD.bom_upload_document, new_data=NEW.bom_upload_document,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.default_rev,'')<>'' THEN
IF (OLD.default_rev <> NEW.default_rev) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='default_rev',record_id=NEW.id, old_data=OLD.default_rev, new_data=NEW.default_rev,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5rfq_items_bom_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5rfq_items_bom_before_delete` BEFORE DELETE ON `5rfq_items_bom`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5rfq_items_bom_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `5rfq_items_bom_after_delete` AFTER DELETE ON `5rfq_items_bom`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='rfq_items_id',record_id=OLD.id, old_data=OLD.rfq_items_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='rfq_id',record_id=OLD.id, old_data=OLD.rfq_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='version_number',record_id=OLD.id, old_data=OLD.version_number, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='bom_desc',record_id=OLD.id, old_data=OLD.bom_desc, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='bom_upload_document',record_id=OLD.id, old_data=OLD.bom_upload_document, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='5rfq_items_bom', field_name='default_rev',record_id=OLD.id, old_data=OLD.default_rev, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='5rfq_items_bom_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `6_1rfq_items_labor_summary_before_insert` BEFORE INSERT ON `6_1rfq_items_labor_summary`
BEGIN 


SET NEW.rfq_items_id = (SELECT rfq_items_id FROM 6rfq_items_labor WHERE id=NEW.rfq_items_labor_id);
SET NEW.rfq_id = (SELECT rfq_id FROM 6rfq_items_labor WHERE id=NEW.rfq_items_labor_id);
SET NEW.total_labor_hours = (SELECT SUM(hour) FROM 6rfq_items_labor WHERE rfq_items_id=NEW.rfq_items_id);

SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='6_1rfq_items_labor_summary_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `6_1rfq_items_labor_summary_after_insert` AFTER INSERT ON `6_1rfq_items_labor_summary`
BEGIN 

/*audit_sql*/
IF (NEW.rfq_items_labor_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='rfq_items_labor_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_items_labor_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rfq_items_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='rfq_items_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_items_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rfq_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='rfq_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.total_labor_hours) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='total_labor_hours',record_id=NEW.id, old_data='', new_data=NEW.total_labor_hours,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.margin_of_error_percentage) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='margin_of_error_percentage',record_id=NEW.id, old_data='', new_data=NEW.margin_of_error_percentage,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.setup_of_hours_percentage) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='setup_of_hours_percentage',record_id=NEW.id, old_data='', new_data=NEW.setup_of_hours_percentage,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.gross_labor_hours) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='gross_labor_hours',record_id=NEW.id, old_data='', new_data=NEW.gross_labor_hours,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.labor_rate_usa) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='labor_rate_usa',record_id=NEW.id, old_data='', new_data=NEW.labor_rate_usa,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.labor_rate_india) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='labor_rate_india',record_id=NEW.id, old_data='', new_data=NEW.labor_rate_india,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.total_labor_cost_usa) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='total_labor_cost_usa',record_id=NEW.id, old_data='', new_data=NEW.total_labor_cost_usa,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.total_labor_cost_india) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='total_labor_cost_india',record_id=NEW.id, old_data='', new_data=NEW.total_labor_cost_india,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.labor_margin) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='labor_margin',record_id=NEW.id, old_data='', new_data=NEW.labor_margin,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.gross_labor_cost_usa) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='gross_labor_cost_usa',record_id=NEW.id, old_data='', new_data=NEW.gross_labor_cost_usa,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.gross_labor_cost_india) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='gross_labor_cost_india',record_id=NEW.id, old_data='', new_data=NEW.gross_labor_cost_india,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='6_1rfq_items_labor_summary_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `6_1rfq_items_labor_summary_before_update` BEFORE UPDATE ON `6_1rfq_items_labor_summary`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='6_1rfq_items_labor_summary_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `6_1rfq_items_labor_summary_after_update` AFTER UPDATE ON `6_1rfq_items_labor_summary`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.rfq_items_labor_id,'')<>'' THEN
IF (OLD.rfq_items_labor_id <> NEW.rfq_items_labor_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='rfq_items_labor_id',record_id=NEW.id, old_data=OLD.rfq_items_labor_id, new_data=NEW.rfq_items_labor_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_items_id,'')<>'' THEN
IF (OLD.rfq_items_id <> NEW.rfq_items_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='rfq_items_id',record_id=NEW.id, old_data=OLD.rfq_items_id, new_data=NEW.rfq_items_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_id,'')<>'' THEN
IF (OLD.rfq_id <> NEW.rfq_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='rfq_id',record_id=NEW.id, old_data=OLD.rfq_id, new_data=NEW.rfq_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.total_labor_hours,'')<>'' THEN
IF (OLD.total_labor_hours <> NEW.total_labor_hours) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='total_labor_hours',record_id=NEW.id, old_data=OLD.total_labor_hours, new_data=NEW.total_labor_hours,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.margin_of_error_percentage,'')<>'' THEN
IF (OLD.margin_of_error_percentage <> NEW.margin_of_error_percentage) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='margin_of_error_percentage',record_id=NEW.id, old_data=OLD.margin_of_error_percentage, new_data=NEW.margin_of_error_percentage,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.setup_of_hours_percentage,'')<>'' THEN
IF (OLD.setup_of_hours_percentage <> NEW.setup_of_hours_percentage) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='setup_of_hours_percentage',record_id=NEW.id, old_data=OLD.setup_of_hours_percentage, new_data=NEW.setup_of_hours_percentage,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.gross_labor_hours,'')<>'' THEN
IF (OLD.gross_labor_hours <> NEW.gross_labor_hours) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='gross_labor_hours',record_id=NEW.id, old_data=OLD.gross_labor_hours, new_data=NEW.gross_labor_hours,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.labor_rate_usa,'')<>'' THEN
IF (OLD.labor_rate_usa <> NEW.labor_rate_usa) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='labor_rate_usa',record_id=NEW.id, old_data=OLD.labor_rate_usa, new_data=NEW.labor_rate_usa,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.labor_rate_india,'')<>'' THEN
IF (OLD.labor_rate_india <> NEW.labor_rate_india) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='labor_rate_india',record_id=NEW.id, old_data=OLD.labor_rate_india, new_data=NEW.labor_rate_india,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.total_labor_cost_usa,'')<>'' THEN
IF (OLD.total_labor_cost_usa <> NEW.total_labor_cost_usa) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='total_labor_cost_usa',record_id=NEW.id, old_data=OLD.total_labor_cost_usa, new_data=NEW.total_labor_cost_usa,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.total_labor_cost_india,'')<>'' THEN
IF (OLD.total_labor_cost_india <> NEW.total_labor_cost_india) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='total_labor_cost_india',record_id=NEW.id, old_data=OLD.total_labor_cost_india, new_data=NEW.total_labor_cost_india,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.labor_margin,'')<>'' THEN
IF (OLD.labor_margin <> NEW.labor_margin) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='labor_margin',record_id=NEW.id, old_data=OLD.labor_margin, new_data=NEW.labor_margin,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.gross_labor_cost_usa,'')<>'' THEN
IF (OLD.gross_labor_cost_usa <> NEW.gross_labor_cost_usa) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='gross_labor_cost_usa',record_id=NEW.id, old_data=OLD.gross_labor_cost_usa, new_data=NEW.gross_labor_cost_usa,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.gross_labor_cost_india,'')<>'' THEN
IF (OLD.gross_labor_cost_india <> NEW.gross_labor_cost_india) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='gross_labor_cost_india',record_id=NEW.id, old_data=OLD.gross_labor_cost_india, new_data=NEW.gross_labor_cost_india,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='6_1rfq_items_labor_summary_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `6_1rfq_items_labor_summary_before_delete` BEFORE DELETE ON `6_1rfq_items_labor_summary`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='6_1rfq_items_labor_summary_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `6_1rfq_items_labor_summary_after_delete` AFTER DELETE ON `6_1rfq_items_labor_summary`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='rfq_items_labor_id',record_id=OLD.id, old_data=OLD.rfq_items_labor_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='rfq_items_id',record_id=OLD.id, old_data=OLD.rfq_items_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='rfq_id',record_id=OLD.id, old_data=OLD.rfq_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='total_labor_hours',record_id=OLD.id, old_data=OLD.total_labor_hours, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='margin_of_error_percentage',record_id=OLD.id, old_data=OLD.margin_of_error_percentage, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='setup_of_hours_percentage',record_id=OLD.id, old_data=OLD.setup_of_hours_percentage, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='gross_labor_hours',record_id=OLD.id, old_data=OLD.gross_labor_hours, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='labor_rate_usa',record_id=OLD.id, old_data=OLD.labor_rate_usa, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='labor_rate_india',record_id=OLD.id, old_data=OLD.labor_rate_india, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='total_labor_cost_usa',record_id=OLD.id, old_data=OLD.total_labor_cost_usa, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='total_labor_cost_india',record_id=OLD.id, old_data=OLD.total_labor_cost_india, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='labor_margin',record_id=OLD.id, old_data=OLD.labor_margin, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='gross_labor_cost_usa',record_id=OLD.id, old_data=OLD.gross_labor_cost_usa, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6_1rfq_items_labor_summary', field_name='gross_labor_cost_india',record_id=OLD.id, old_data=OLD.gross_labor_cost_india, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='6_1rfq_items_labor_summary_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `6rfq_items_labor_before_insert` BEFORE INSERT ON `6rfq_items_labor`
BEGIN 


SET NEW.rfq_id = (SELECT rfq_id FROM 3_1rfq_items WHERE id=NEW.rfq_items_id);
SET NEW.hour = NEW.time_in_seconds/3600;
SET NEW.total_per_piece_in_hours = NEW.activity_per_part*NEW.time_in_seconds/3600;

SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='6rfq_items_labor_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `6rfq_items_labor_after_insert` AFTER INSERT ON `6rfq_items_labor`
BEGIN 

/*audit_sql*/
IF (NEW.rfq_items_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='rfq_items_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_items_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rfq_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='rfq_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.item_no) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='item_no',record_id=NEW.id, old_data='', new_data=NEW.item_no,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.activity_name) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='activity_name',record_id=NEW.id, old_data='', new_data=NEW.activity_name,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.driver) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='driver',record_id=NEW.id, old_data='', new_data=NEW.driver,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.activity_per_part) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='activity_per_part',record_id=NEW.id, old_data='', new_data=NEW.activity_per_part,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.time_in_seconds) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='time_in_seconds',record_id=NEW.id, old_data='', new_data=NEW.time_in_seconds,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.hour) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='hour',record_id=NEW.id, old_data='', new_data=NEW.hour,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.total_per_piece_in_hours) THEN
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='total_per_piece_in_hours',record_id=NEW.id, old_data='', new_data=NEW.total_per_piece_in_hours,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='6rfq_items_labor_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `6rfq_items_labor_before_update` BEFORE UPDATE ON `6rfq_items_labor`
BEGIN 


SET NEW.hour = NEW.time_in_seconds/3600;
SET NEW.total_per_piece_in_hours = NEW.activity_per_part*NEW.time_in_seconds/3600;


IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='6rfq_items_labor_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `6rfq_items_labor_after_update` AFTER UPDATE ON `6rfq_items_labor`
BEGIN 


DECLARE labour_hrs DECIMAL(9,4);
SET labour_hrs = (SELECT SUM(hour) FROM 6rfq_items_labor WHERE rfq_items_id=NEW.rfq_items_id);
UPDATE 6_1rfq_items_labor_summary SET total_labor_hours=labour_hrs;

IF IFNULL(NEW.rfq_items_id,'')<>'' THEN
IF (OLD.rfq_items_id <> NEW.rfq_items_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='rfq_items_id',record_id=NEW.id, old_data=OLD.rfq_items_id, new_data=NEW.rfq_items_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_id,'')<>'' THEN
IF (OLD.rfq_id <> NEW.rfq_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='rfq_id',record_id=NEW.id, old_data=OLD.rfq_id, new_data=NEW.rfq_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.item_no,'')<>'' THEN
IF (OLD.item_no <> NEW.item_no) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='item_no',record_id=NEW.id, old_data=OLD.item_no, new_data=NEW.item_no,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.activity_name,'')<>'' THEN
IF (OLD.activity_name <> NEW.activity_name) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='activity_name',record_id=NEW.id, old_data=OLD.activity_name, new_data=NEW.activity_name,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.driver,'')<>'' THEN
IF (OLD.driver <> NEW.driver) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='driver',record_id=NEW.id, old_data=OLD.driver, new_data=NEW.driver,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.activity_per_part,'')<>'' THEN
IF (OLD.activity_per_part <> NEW.activity_per_part) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='activity_per_part',record_id=NEW.id, old_data=OLD.activity_per_part, new_data=NEW.activity_per_part,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.time_in_seconds,'')<>'' THEN
IF (OLD.time_in_seconds <> NEW.time_in_seconds) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='time_in_seconds',record_id=NEW.id, old_data=OLD.time_in_seconds, new_data=NEW.time_in_seconds,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.hour,'')<>'' THEN
IF (OLD.hour <> NEW.hour) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='hour',record_id=NEW.id, old_data=OLD.hour, new_data=NEW.hour,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.total_per_piece_in_hours,'')<>'' THEN
IF (OLD.total_per_piece_in_hours <> NEW.total_per_piece_in_hours) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='total_per_piece_in_hours',record_id=NEW.id, old_data=OLD.total_per_piece_in_hours, new_data=NEW.total_per_piece_in_hours,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='6rfq_items_labor_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `6rfq_items_labor_before_delete` BEFORE DELETE ON `6rfq_items_labor`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='6rfq_items_labor_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `6rfq_items_labor_after_delete` AFTER DELETE ON `6rfq_items_labor`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='rfq_items_id',record_id=OLD.id, old_data=OLD.rfq_items_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='rfq_id',record_id=OLD.id, old_data=OLD.rfq_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='item_no',record_id=OLD.id, old_data=OLD.item_no, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='activity_name',record_id=OLD.id, old_data=OLD.activity_name, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='driver',record_id=OLD.id, old_data=OLD.driver, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='activity_per_part',record_id=OLD.id, old_data=OLD.activity_per_part, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='time_in_seconds',record_id=OLD.id, old_data=OLD.time_in_seconds, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='hour',record_id=OLD.id, old_data=OLD.hour, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='6rfq_items_labor', field_name='total_per_piece_in_hours',record_id=OLD.id, old_data=OLD.total_per_piece_in_hours, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='6rfq_items_labor_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `7rfq_items_nre_tools_before_insert` BEFORE INSERT ON `7rfq_items_nre_tools`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;
IF NEW.audit_created_by NOT LIKE '%trigger' THEN
SET NEW.audit_created_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
SET NEW.audit_created_date=CURRENT_TIMESTAMP();

IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;
SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='7rfq_items_nre_tools_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `7rfq_items_nre_tools_after_insert` AFTER INSERT ON `7rfq_items_nre_tools`
BEGIN 

/*audit_sql*/
IF (NEW.rfq_items_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='rfq_items_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_items_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.nre_desc) THEN
INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='nre_desc',record_id=NEW.id, old_data='', new_data=NEW.nre_desc,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.nre_charge) THEN
INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='nre_charge',record_id=NEW.id, old_data='', new_data=NEW.nre_charge,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.input_margin) THEN
INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='input_margin',record_id=NEW.id, old_data='', new_data=NEW.input_margin,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.total_charge) THEN
INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='total_charge',record_id=NEW.id, old_data='', new_data=NEW.total_charge,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.remarks) THEN
INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='remarks',record_id=NEW.id, old_data='', new_data=NEW.remarks,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='7rfq_items_nre_tools_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `7rfq_items_nre_tools_before_update` BEFORE UPDATE ON `7rfq_items_nre_tools`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='7rfq_items_nre_tools_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `7rfq_items_nre_tools_after_update` AFTER UPDATE ON `7rfq_items_nre_tools`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.rfq_items_id,'')<>'' THEN
IF (OLD.rfq_items_id <> NEW.rfq_items_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='rfq_items_id',record_id=NEW.id, old_data=OLD.rfq_items_id, new_data=NEW.rfq_items_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.nre_desc,'')<>'' THEN
IF (OLD.nre_desc <> NEW.nre_desc) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='nre_desc',record_id=NEW.id, old_data=OLD.nre_desc, new_data=NEW.nre_desc,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.nre_charge,'')<>'' THEN
IF (OLD.nre_charge <> NEW.nre_charge) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='nre_charge',record_id=NEW.id, old_data=OLD.nre_charge, new_data=NEW.nre_charge,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.input_margin,'')<>'' THEN
IF (OLD.input_margin <> NEW.input_margin) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='input_margin',record_id=NEW.id, old_data=OLD.input_margin, new_data=NEW.input_margin,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.total_charge,'')<>'' THEN
IF (OLD.total_charge <> NEW.total_charge) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='total_charge',record_id=NEW.id, old_data=OLD.total_charge, new_data=NEW.total_charge,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.remarks,'')<>'' THEN
IF (OLD.remarks <> NEW.remarks) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='remarks',record_id=NEW.id, old_data=OLD.remarks, new_data=NEW.remarks,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='7rfq_items_nre_tools_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `7rfq_items_nre_tools_before_delete` BEFORE DELETE ON `7rfq_items_nre_tools`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='7rfq_items_nre_tools_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `7rfq_items_nre_tools_after_delete` AFTER DELETE ON `7rfq_items_nre_tools`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='rfq_items_id',record_id=OLD.id, old_data=OLD.rfq_items_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='nre_desc',record_id=OLD.id, old_data=OLD.nre_desc, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='nre_charge',record_id=OLD.id, old_data=OLD.nre_charge, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='input_margin',record_id=OLD.id, old_data=OLD.input_margin, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='total_charge',record_id=OLD.id, old_data=OLD.total_charge, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='7rfq_items_nre_tools', field_name='remarks',record_id=OLD.id, old_data=OLD.remarks, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='7rfq_items_nre_tools_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `8rfq_items_assumptions_before_insert` BEFORE INSERT ON `8rfq_items_assumptions`
BEGIN 


SET NEW.rfq_id = (SELECT rfq_id FROM 3_1rfq_items WHERE id=NEW.rfq_items_id);

SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='8rfq_items_assumptions_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `8rfq_items_assumptions_after_insert` AFTER INSERT ON `8rfq_items_assumptions`
BEGIN 

/*audit_sql*/
IF (NEW.rfq_items_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='rfq_items_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_items_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rfq_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='rfq_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.assumption_text) THEN
INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='assumption_text',record_id=NEW.id, old_data='', new_data=NEW.assumption_text,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.assumption_entered_by_user) THEN
INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='assumption_entered_by_user',record_id=NEW.id, old_data='', new_data=NEW.assumption_entered_by_user,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.customer_agreed) THEN
INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='customer_agreed',record_id=NEW.id, old_data='', new_data=NEW.customer_agreed,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.customer_agreed_timestamp) THEN
INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='customer_agreed_timestamp',record_id=NEW.id, old_data='', new_data=NEW.customer_agreed_timestamp,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.customer_remarks) THEN
INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='customer_remarks',record_id=NEW.id, old_data='', new_data=NEW.customer_remarks,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='8rfq_items_assumptions_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `8rfq_items_assumptions_before_update` BEFORE UPDATE ON `8rfq_items_assumptions`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='8rfq_items_assumptions_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `8rfq_items_assumptions_after_update` AFTER UPDATE ON `8rfq_items_assumptions`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.rfq_items_id,'')<>'' THEN
IF (OLD.rfq_items_id <> NEW.rfq_items_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='rfq_items_id',record_id=NEW.id, old_data=OLD.rfq_items_id, new_data=NEW.rfq_items_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_id,'')<>'' THEN
IF (OLD.rfq_id <> NEW.rfq_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='rfq_id',record_id=NEW.id, old_data=OLD.rfq_id, new_data=NEW.rfq_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.assumption_text,'')<>'' THEN
IF (OLD.assumption_text <> NEW.assumption_text) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='assumption_text',record_id=NEW.id, old_data=OLD.assumption_text, new_data=NEW.assumption_text,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.assumption_entered_by_user,'')<>'' THEN
IF (OLD.assumption_entered_by_user <> NEW.assumption_entered_by_user) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='assumption_entered_by_user',record_id=NEW.id, old_data=OLD.assumption_entered_by_user, new_data=NEW.assumption_entered_by_user,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.customer_agreed,'')<>'' THEN
IF (OLD.customer_agreed <> NEW.customer_agreed) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='customer_agreed',record_id=NEW.id, old_data=OLD.customer_agreed, new_data=NEW.customer_agreed,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.customer_agreed_timestamp,'')<>'' THEN
IF (OLD.customer_agreed_timestamp <> NEW.customer_agreed_timestamp) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='customer_agreed_timestamp',record_id=NEW.id, old_data=OLD.customer_agreed_timestamp, new_data=NEW.customer_agreed_timestamp,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.customer_remarks,'')<>'' THEN
IF (OLD.customer_remarks <> NEW.customer_remarks) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='customer_remarks',record_id=NEW.id, old_data=OLD.customer_remarks, new_data=NEW.customer_remarks,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='8rfq_items_assumptions_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `8rfq_items_assumptions_before_delete` BEFORE DELETE ON `8rfq_items_assumptions`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='8rfq_items_assumptions_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `8rfq_items_assumptions_after_delete` AFTER DELETE ON `8rfq_items_assumptions`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='rfq_items_id',record_id=OLD.id, old_data=OLD.rfq_items_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='rfq_id',record_id=OLD.id, old_data=OLD.rfq_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='assumption_text',record_id=OLD.id, old_data=OLD.assumption_text, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='assumption_entered_by_user',record_id=OLD.id, old_data=OLD.assumption_entered_by_user, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='customer_agreed',record_id=OLD.id, old_data=OLD.customer_agreed, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='customer_agreed_timestamp',record_id=OLD.id, old_data=OLD.customer_agreed_timestamp, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='8rfq_items_assumptions', field_name='customer_remarks',record_id=OLD.id, old_data=OLD.customer_remarks, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='8rfq_items_assumptions_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `9rfq_outboundfreight_before_insert` BEFORE INSERT ON `9rfq_outboundfreight`
BEGIN 


SET NEW.rfq_id = (SELECT rfq_id FROM 3_1rfq_items WHERE id=NEW.rfq_items_id);

SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='9rfq_outboundfreight_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;


END
*/

/*
CREATE TRIGGER `9rfq_outboundfreight_after_insert` AFTER INSERT ON `9rfq_outboundfreight`
BEGIN 

/*audit_sql*/
IF (NEW.rfq_items_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='rfq_items_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_items_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.rfq_id) THEN
INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='rfq_id',record_id=NEW.id, old_data='', new_data=NEW.rfq_id,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.ship_qty) THEN
INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='ship_qty',record_id=NEW.id, old_data='', new_data=NEW.ship_qty,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.weight_approximate_in_kg) THEN
INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='weight_approximate_in_kg',record_id=NEW.id, old_data='', new_data=NEW.weight_approximate_in_kg,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.ship_method) THEN
INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='ship_method',record_id=NEW.id, old_data='', new_data=NEW.ship_method,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.freight_time_in_days) THEN
INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='freight_time_in_days',record_id=NEW.id, old_data='', new_data=NEW.freight_time_in_days,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.usd_per_kg) THEN
INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='usd_per_kg',record_id=NEW.id, old_data='', new_data=NEW.usd_per_kg,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='9rfq_outboundfreight_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `9rfq_outboundfreight_before_update` BEFORE UPDATE ON `9rfq_outboundfreight`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='9rfq_outboundfreight_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `9rfq_outboundfreight_after_update` AFTER UPDATE ON `9rfq_outboundfreight`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.rfq_items_id,'')<>'' THEN
IF (OLD.rfq_items_id <> NEW.rfq_items_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='rfq_items_id',record_id=NEW.id, old_data=OLD.rfq_items_id, new_data=NEW.rfq_items_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.rfq_id,'')<>'' THEN
IF (OLD.rfq_id <> NEW.rfq_id) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='rfq_id',record_id=NEW.id, old_data=OLD.rfq_id, new_data=NEW.rfq_id,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.ship_qty,'')<>'' THEN
IF (OLD.ship_qty <> NEW.ship_qty) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='ship_qty',record_id=NEW.id, old_data=OLD.ship_qty, new_data=NEW.ship_qty,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.weight_approximate_in_kg,'')<>'' THEN
IF (OLD.weight_approximate_in_kg <> NEW.weight_approximate_in_kg) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='weight_approximate_in_kg',record_id=NEW.id, old_data=OLD.weight_approximate_in_kg, new_data=NEW.weight_approximate_in_kg,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.ship_method,'')<>'' THEN
IF (OLD.ship_method <> NEW.ship_method) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='ship_method',record_id=NEW.id, old_data=OLD.ship_method, new_data=NEW.ship_method,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.freight_time_in_days,'')<>'' THEN
IF (OLD.freight_time_in_days <> NEW.freight_time_in_days) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='freight_time_in_days',record_id=NEW.id, old_data=OLD.freight_time_in_days, new_data=NEW.freight_time_in_days,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.usd_per_kg,'')<>'' THEN
IF (OLD.usd_per_kg <> NEW.usd_per_kg) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='usd_per_kg',record_id=NEW.id, old_data=OLD.usd_per_kg, new_data=NEW.usd_per_kg,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='9rfq_outboundfreight_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `9rfq_outboundfreight_before_delete` BEFORE DELETE ON `9rfq_outboundfreight`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='9rfq_outboundfreight_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `9rfq_outboundfreight_after_delete` AFTER DELETE ON `9rfq_outboundfreight`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='rfq_items_id',record_id=OLD.id, old_data=OLD.rfq_items_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='rfq_id',record_id=OLD.id, old_data=OLD.rfq_id, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='ship_qty',record_id=OLD.id, old_data=OLD.ship_qty, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='weight_approximate_in_kg',record_id=OLD.id, old_data=OLD.weight_approximate_in_kg, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='ship_method',record_id=OLD.id, old_data=OLD.ship_method, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='freight_time_in_days',record_id=OLD.id, old_data=OLD.freight_time_in_days, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='9rfq_outboundfreight', field_name='usd_per_kg',record_id=OLD.id, old_data=OLD.usd_per_kg, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='9rfq_outboundfreight_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `erp1_items_before_insert` BEFORE INSERT ON `erp1_items`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;
IF NEW.audit_created_by NOT LIKE '%trigger' THEN
SET NEW.audit_created_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
SET NEW.audit_created_date=CURRENT_TIMESTAMP();

IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;
SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='erp1_items_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `erp1_items_after_insert` AFTER INSERT ON `erp1_items`
BEGIN 

/*audit_sql*/ 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='erp1_items_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `erp1_items_before_update` BEFORE UPDATE ON `erp1_items`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='erp1_items_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `erp1_items_after_update` AFTER UPDATE ON `erp1_items`
BEGIN 

/*audit_sql*/ 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='erp1_items_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `erp1_items_before_delete` BEFORE DELETE ON `erp1_items`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='erp1_items_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `erp1_items_after_delete` AFTER DELETE ON `erp1_items`
BEGIN 

/*audit_sql*/ 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='erp1_items_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_labor_activity_before_insert` BEFORE INSERT ON `m_labor_activity`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;
IF NEW.audit_created_by NOT LIKE '%trigger' THEN
SET NEW.audit_created_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
SET NEW.audit_created_date=CURRENT_TIMESTAMP();

IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;
SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_labor_activity_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_labor_activity_after_insert` AFTER INSERT ON `m_labor_activity`
BEGIN 

/*audit_sql*/
IF (NEW.activity_name) THEN
INSERT INTO webcables20_log.log_sql SET table_name='m_labor_activity', field_name='activity_name',record_id=NEW.id, old_data='', new_data=NEW.activity_name,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.time_in_seconds) THEN
INSERT INTO webcables20_log.log_sql SET table_name='m_labor_activity', field_name='time_in_seconds',record_id=NEW.id, old_data='', new_data=NEW.time_in_seconds,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.active) THEN
INSERT INTO webcables20_log.log_sql SET table_name='m_labor_activity', field_name='active',record_id=NEW.id, old_data='', new_data=NEW.active,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_labor_activity_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_labor_activity_before_update` BEFORE UPDATE ON `m_labor_activity`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_labor_activity_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_labor_activity_after_update` AFTER UPDATE ON `m_labor_activity`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.activity_name,'')<>'' THEN
IF (OLD.activity_name <> NEW.activity_name) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='m_labor_activity', field_name='activity_name',record_id=NEW.id, old_data=OLD.activity_name, new_data=NEW.activity_name,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.time_in_seconds,'')<>'' THEN
IF (OLD.time_in_seconds <> NEW.time_in_seconds) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='m_labor_activity', field_name='time_in_seconds',record_id=NEW.id, old_data=OLD.time_in_seconds, new_data=NEW.time_in_seconds,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.active,'')<>'' THEN
IF (OLD.active <> NEW.active) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='m_labor_activity', field_name='active',record_id=NEW.id, old_data=OLD.active, new_data=NEW.active,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_labor_activity_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_labor_activity_before_delete` BEFORE DELETE ON `m_labor_activity`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_labor_activity_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_labor_activity_after_delete` AFTER DELETE ON `m_labor_activity`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='m_labor_activity', field_name='activity_name',record_id=OLD.id, old_data=OLD.activity_name, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='m_labor_activity', field_name='time_in_seconds',record_id=OLD.id, old_data=OLD.time_in_seconds, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='m_labor_activity', field_name='active',record_id=OLD.id, old_data=OLD.active, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_labor_activity_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_users_before_insert` BEFORE INSERT ON `m_users`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;
IF NEW.audit_created_by NOT LIKE '%trigger' THEN
SET NEW.audit_created_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
SET NEW.audit_created_date=CURRENT_TIMESTAMP();

IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;
SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_users_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_users_after_insert` AFTER INSERT ON `m_users`
BEGIN 

/*audit_sql*/
IF (NEW.username) THEN
INSERT INTO webcables20_log.log_sql SET table_name='m_users', field_name='username',record_id=NEW.id, old_data='', new_data=NEW.username,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.password) THEN
INSERT INTO webcables20_log.log_sql SET table_name='m_users', field_name='password',record_id=NEW.id, old_data='', new_data=NEW.password,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.user_type) THEN
INSERT INTO webcables20_log.log_sql SET table_name='m_users', field_name='user_type',record_id=NEW.id, old_data='', new_data=NEW.user_type,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.active) THEN
INSERT INTO webcables20_log.log_sql SET table_name='m_users', field_name='active',record_id=NEW.id, old_data='', new_data=NEW.active,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_users_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_users_before_update` BEFORE UPDATE ON `m_users`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_users_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_users_after_update` AFTER UPDATE ON `m_users`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.username,'')<>'' THEN
IF (OLD.username <> NEW.username) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='m_users', field_name='username',record_id=NEW.id, old_data=OLD.username, new_data=NEW.username,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.password,'')<>'' THEN
IF (OLD.password <> NEW.password) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='m_users', field_name='password',record_id=NEW.id, old_data=OLD.password, new_data=NEW.password,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.user_type,'')<>'' THEN
IF (OLD.user_type <> NEW.user_type) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='m_users', field_name='user_type',record_id=NEW.id, old_data=OLD.user_type, new_data=NEW.user_type,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.active,'')<>'' THEN
IF (OLD.active <> NEW.active) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='m_users', field_name='active',record_id=NEW.id, old_data=OLD.active, new_data=NEW.active,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_users_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_users_before_delete` BEFORE DELETE ON `m_users`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_users_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_users_after_delete` AFTER DELETE ON `m_users`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='m_users', field_name='username',record_id=OLD.id, old_data=OLD.username, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='m_users', field_name='password',record_id=OLD.id, old_data=OLD.password, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='m_users', field_name='user_type',record_id=OLD.id, old_data=OLD.user_type, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='m_users', field_name='active',record_id=OLD.id, old_data=OLD.active, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_users_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_vendors_before_insert` BEFORE INSERT ON `m_vendors`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;
IF NEW.audit_created_by NOT LIKE '%trigger' THEN
SET NEW.audit_created_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
SET NEW.audit_created_date=CURRENT_TIMESTAMP();

IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;
SET NEW.audit_created_by=@app_username;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_vendors_before_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_vendors_after_insert` AFTER INSERT ON `m_vendors`
BEGIN 

/*audit_sql*/
IF (NEW.vendor_name) THEN
INSERT INTO webcables20_log.log_sql SET table_name='m_vendors', field_name='vendor_name',record_id=NEW.id, old_data='', new_data=NEW.vendor_name,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;

IF (NEW.active) THEN
INSERT INTO webcables20_log.log_sql SET table_name='m_vendors', field_name='active',record_id=NEW.id, old_data='', new_data=NEW.active,operation='insert',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_vendors_after_insert',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_vendors_before_update` BEFORE UPDATE ON `m_vendors`
BEGIN 



IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF;

IF NEW.audit_updated_by NOT LIKE '%trigger' AND @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;
SET NEW.audit_ip=@app_user_ip;
IF NOT @dont_save_update_time THEN
SET NEW.audit_updated_date=CURRENT_TIMESTAMP();
END IF;

IF @dont_update_audit_username IS NULL THEN
SET NEW.audit_updated_by=@app_username;
END IF;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_vendors_before_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_vendors_after_update` AFTER UPDATE ON `m_vendors`
BEGIN 

/*audit_sql*/
IF IFNULL(NEW.vendor_name,'')<>'' THEN
IF (OLD.vendor_name <> NEW.vendor_name) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='m_vendors', field_name='vendor_name',record_id=NEW.id, old_data=OLD.vendor_name, new_data=NEW.vendor_name,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;

IF IFNULL(NEW.active,'')<>'' THEN
IF (OLD.active <> NEW.active) THEN 
INSERT INTO webcables20_log.log_sql SET table_name='m_vendors', field_name='active',record_id=NEW.id, old_data=OLD.active, new_data=NEW.active,operation='update',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;
END IF;
END IF;
 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_vendors_after_update',
token_id=@rand_token,audit=NEW.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_vendors_before_delete` BEFORE DELETE ON `m_vendors`
BEGIN 


IF (SELECT @app_username IS NULL) THEN
/*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete';*/
SET @app_username='PHPMyAdmin Test/Debug';
SET @app_user_ip='N';
END IF; 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_vendors_before_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/

/*
CREATE TRIGGER `m_vendors_after_delete` AFTER DELETE ON `m_vendors`
BEGIN 

/*audit_sql*/
INSERT INTO webcables20_log.log_sql SET table_name='m_vendors', field_name='vendor_name',record_id=OLD.id, old_data=OLD.vendor_name, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;


INSERT INTO webcables20_log.log_sql SET table_name='m_vendors', field_name='active',record_id=OLD.id, old_data=OLD.active, new_data='',operation='delete',audit_created_date=CURRENT_TIMESTAMP(),audit_created_by=@app_username;

 

IF @debug_triggers THEN
    INSERT INTO webcables20_log.log_triggers SET user=@app_username, datetime=CURRENT_TIMESTAMP(),trigger_name='m_vendors_after_delete',
token_id=@rand_token,audit=OLD.audit_updated_by;
END IF;

END
*/
