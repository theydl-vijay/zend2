DEF:3rfq
BEFORE INSERT{
	SET NEW.customer_name = (SELECT company_name FROM 1customers INNER JOIN 2rfq_request ON 2rfq_request.customer_id=1customers.id WHERE 2rfq_request.id=NEW.rfq_request_id);
}
BEFORE UPDATE{
	SET NEW.customer_name = (SELECT company_name FROM 1customers INNER JOIN 2rfq_request ON 2rfq_request.customer_id=1customers.id WHERE 2rfq_request.id=NEW.rfq_request_id);
}

DEF:3_1rfq_items
BEFORE INSERT{
	SET NEW.rfq_id = (SELECT id FROM 3rfq WHERE rfq_request_id=NEW.rfq_request_id);
}

DEF:3_2rfq_items__qty
BEFORE INSERT{
	SET NEW.rfq_id = (SELECT rfq_id FROM 3_1rfq_items WHERE id=NEW.rfq_items_id);
	SET NEW.extended_value_price_usa = NEW.release_qty*NEW.unit_price_sell_usa;
	SET NEW.extended_value_price_india = NEW.release_qty*NEW.extended_value_price_india;
}
BEFORE UPDATE{
	SET NEW.extended_value_price_usa = NEW.release_qty*NEW.unit_price_sell_usa;
	SET NEW.extended_value_price_india = NEW.release_qty*NEW.extended_value_price_india;	
}
AFTER INSERT{
	DECLARE rfq_items_release_qtys VARCHAR(255);
	SET rfq_items_release_qtys = (SELECT GROUP_CONCAT(release_qty) FROM 3_2rfq_items__qty WHERE rfq_items_id=NEW.rfq_items_id AND rfq_id=NEW.rfq_id);
	UPDATE 3_1rfq_items SET 3_1rfq_items.rfq_items_release_qtys=rfq_items_release_qtys;

	#clone_table_data#

	UPDATE 3_2rfq_items__qty_clone SET release_group = 0 WHERE rfq_id=NEW.rfq_id;
	SET @max_item_combination = (SELECT MAX(max_item_combination) FROM (SELECT COUNT(id) AS max_item_combination FROM 3_2rfq_items__qty_clone WHERE rfq_id=NEW.rfq_id GROUP BY rfq_items_id) AS a);
	SET @item_combination = 1;

	WHILE (@item_combination<=@max_item_combination) DO
		UPDATE 3_2rfq_items__qty_clone AS a SET a.release_group = @item_combination WHERE a.id IN (SELECT id FROM (SELECT substring_index(group_concat(b.id ORDER BY b.release_qty SEPARATOR ','), ',', 1) AS id FROM 3_2rfq_items__qty_clone AS b WHERE b.release_group=0 AND rfq_id=NEW.rfq_id GROUP BY b.rfq_items_id) AS c);
		SET @item_combination = @item_combination + 1;
	END WHILE;
}
AFTER UPDATE{
	DECLARE rfq_items_release_qtys VARCHAR(255);
	DECLARE row_count INT(11);
	SET rfq_items_release_qtys = (SELECT GROUP_CONCAT(release_qty) FROM 3_2rfq_items__qty WHERE rfq_items_id=NEW.rfq_items_id AND rfq_id=NEW.rfq_id);
	UPDATE 3_1rfq_items SET 3_1rfq_items.rfq_items_release_qtys=rfq_items_release_qtys;

	#clone_table_data#

	IF (NEW.release_qty<>OLD.release_qty) THEN
		UPDATE 3_2rfq_items__qty_clone SET release_group = 0 WHERE rfq_id=NEW.rfq_id;
		SET @max_item_combination = (SELECT MAX(max_item_combination) FROM (SELECT COUNT(id) AS max_item_combination FROM 3_2rfq_items__qty_clone WHERE rfq_id=NEW.rfq_id GROUP BY rfq_items_id) AS a);
		SET @item_combination = 1;

		WHILE (@item_combination<=@max_item_combination) DO
			UPDATE 3_2rfq_items__qty_clone AS a SET a.release_group = @item_combination WHERE a.id IN (SELECT id FROM (SELECT substring_index(group_concat(b.id ORDER BY b.release_qty SEPARATOR ','), ',', 1) AS id FROM 3_2rfq_items__qty_clone AS b WHERE b.release_group=0 AND rfq_id=NEW.rfq_id GROUP BY b.rfq_items_id) AS c);
			SET @item_combination = @item_combination + 1;
		END WHILE;
	END IF;
}
AFTER DELETE{
	UPDATE 3_2rfq_items__qty_clone SET release_group = 0 WHERE rfq_id=OLD.rfq_id;
	SET @max_item_combination = (SELECT MAX(max_item_combination) FROM (SELECT COUNT(id) AS max_item_combination FROM 3_2rfq_items__qty_clone WHERE rfq_id=OLD.rfq_id GROUP BY rfq_items_id) AS a);
	SET @item_combination = 1;

	#clone_table_data#

	WHILE (@item_combination<=@max_item_combination) DO
		UPDATE 3_2rfq_items__qty_clone AS a SET a.release_group = @item_combination WHERE a.id IN (SELECT id FROM (SELECT substring_index(group_concat(b.id ORDER BY b.release_qty SEPARATOR ','), ',', 1) AS id FROM 3_2rfq_items__qty_clone AS b WHERE b.release_group=0 AND rfq_id=OLD.rfq_id GROUP BY b.rfq_items_id) AS c);
		SET @item_combination = @item_combination + 1;
	END WHILE;
}

DEF:4rfq_items_drawing
BEFORE INSERT{
	SET NEW.rfq_id = (SELECT rfq_id FROM 3_1rfq_items WHERE id=NEW.rfq_items_id);
	SET NEW.version_number = (SELECT IFNULL(MAX(version_number),0)+1 FROM 4rfq_items_drawing WHERE rfq_items_id=NEW.rfq_items_id);
}

DEF:5rfq_items_bom
BEFORE INSERT{
	SET NEW.rfq_id = (SELECT rfq_id FROM 3_1rfq_items WHERE id=NEW.rfq_items_id);
	SET NEW.version_number = (SELECT IFNULL(MAX(version_number),0)+1 FROM 5rfq_items_bom WHERE rfq_items_id=NEW.rfq_items_id);
}
AFTER INSERT{
	#clone_table_data#
	IF(NEW.default_rev=1) THEN
		UPDATE 5rfq_items_bom_clone SET default_rev=0 WHERE rfq_items_id=NEW.rfq_items_id;
		UPDATE 5rfq_items_bom_clone SET default_rev=1 WHERE id=NEW.id;
	END IF;
}
AFTER UPDATE{
	#clone_table_data#
	IF(NEW.default_rev=1) THEN
		UPDATE 5rfq_items_bom_clone SET default_rev=0 WHERE rfq_items_id=NEW.rfq_items_id;
		UPDATE 5rfq_items_bom_clone SET default_rev=1 WHERE id=NEW.id;
	END IF;
}
AFTER DELETE{
	DECLARE default_rev_var INT(1);
	SET default_rev_var = (SELECT default_rev FROM 5rfq_items_bom_clone WHERE id=OLD.id);
	IF(default_rev_var=1) THEN
		UPDATE 5rfq_items_bom_clone SET default_rev=1 WHERE rfq_items_id=OLD.rfq_items_id LIMIT 1;
	END IF;
	#clone_table_data#
}

DEF:5_1rfq_items_bom_items
BEFORE INSERT{
	SET NEW.rfq_id = (SELECT rfq_id FROM 5rfq_items_bom WHERE id=NEW.rfq_items_bom_id);
}
AFTER INSERT{
	DECLARE avail_row INT(1);
	DECLARE rfq_items_bom_items_ids_var VARCHAR(100);
	DECLARE item_no_var VARCHAR(100);
	DECLARE master_item_count INT(1);
	DECLARE master_item_no_var VARCHAR(100);
	DECLARE consolidated_count INT(10);

	DECLARE rfq_id_tmp INT(11);
	DECLARE item_no_tmp VARCHAR(255);
	DECLARE item_desc_tmp VARCHAR(255);
	DECLARE mfg_partnumber_tmp VARCHAR(255);
	DECLARE rev_tmp VARCHAR(5);
	DECLARE equivalent_tmp TINYINT(1);
	DECLARE uom_tmp VARCHAR(255);
	DECLARE note_tmp VARCHAR(255);
	DECLARE qty_tmp INT(1);

	IF(NEW.rfq_items_bom_items_id<>'') THEN

		SET rfq_id_tmp = (SELECT rfq_id FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
		SET item_no_tmp = (SELECT item_no FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
		SET item_desc_tmp = (SELECT item_desc FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
		SET mfg_partnumber_tmp = (SELECT mfg_part_number FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
		SET rev_tmp = (SELECT rev FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
		SET equivalent_tmp = (SELECT equivalent FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
		SET uom_tmp = (SELECT uom FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
		SET note_tmp = (SELECT note FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
		SET qty_tmp = (SELECT qty FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);

		SET item_no_var = (SELECT item_no FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
		SET master_item_count = (SELECT COUNT(id) FROM 5_1rfq_items_bom_items WHERE item_no=item_no_var);
		IF(master_item_count=1) THEN
			DELETE FROM 5_1_1rfq_consolidated_bom WHERE item_no=item_no_var;
		ELSE
			SET master_item_no_var = (SELECT item_no FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
			SET consolidated_count = (SELECT SUM(qty) FROM 5_1rfq_items_bom_items WHERE item_no=master_item_no_var AND id NOT IN (SELECT rfq_items_bom_items_id FROM 5_1rfq_items_bom_items WHERE rfq_id=NEW.rfq_id AND rfq_items_bom_items_id<>''));
			SET rfq_items_bom_items_ids_var = (SELECT group_concat(id) FROM 5_1rfq_items_bom_items WHERE item_no=master_item_no_var AND id NOT IN (SELECT rfq_items_bom_items_id FROM 5_1rfq_items_bom_items WHERE rfq_id=NEW.rfq_id AND rfq_items_bom_items_id<>''));
			UPDATE 5_1_1rfq_consolidated_bom SET rfq_items_bom_items_ids=rfq_items_bom_items_ids_var, quantity_for_one_piece=consolidated_count, rfq_id=rfq_id_tmp, item_desc=item_desc_tmp, mfg_partnumber=mfg_partnumber_tmp, rev=rev_tmp, equivalent=equivalent_tmp, uom=uom_tmp, note=note_tmp WHERE item_no=item_no_tmp AND rfq_id=NEW.rfq_id;
		END IF;
	END IF;

	SET avail_row = (SELECT COUNT(id) AS avail_row FROM 5_1_1rfq_consolidated_bom WHERE item_no=NEW.item_no AND rfq_id=NEW.rfq_id);
	IF(avail_row>0) THEN
		SET consolidated_count = (SELECT SUM(qty) FROM 5_1rfq_items_bom_items WHERE item_no=NEW.item_no AND id NOT IN (SELECT rfq_items_bom_items_id FROM 5_1rfq_items_bom_items WHERE rfq_id=NEW.rfq_id AND rfq_items_bom_items_id<>''));
		SET rfq_items_bom_items_ids_var = (SELECT group_concat(id) FROM 5_1rfq_items_bom_items WHERE item_no=NEW.item_no AND id NOT IN (SELECT rfq_items_bom_items_id FROM 5_1rfq_items_bom_items WHERE rfq_id=NEW.rfq_id AND rfq_items_bom_items_id<>''));
		UPDATE 5_1_1rfq_consolidated_bom SET rfq_items_bom_items_ids=rfq_items_bom_items_ids_var, quantity_for_one_piece=consolidated_count, rfq_id=NEW.rfq_id, item_no=NEW.item_no, item_desc=NEW.item_desc, mfg_partnumber=NEW.mfg_part_number, rev=NEW.rev, equivalent=NEW.equivalent, uom=NEW.uom, note=NEW.note WHERE item_no=NEW.item_no AND rfq_id=NEW.rfq_id;
	ELSE
		INSERT INTO 5_1_1rfq_consolidated_bom SET rfq_items_bom_items_ids=NEW.id, quantity_for_one_piece=NEW.qty, rfq_id=NEW.rfq_id, item_no=NEW.item_no, item_desc=NEW.item_desc, mfg_partnumber=NEW.mfg_part_number, rev=NEW.rev, equivalent=NEW.equivalent, uom=NEW.uom, note=NEW.note;
	END IF;
}
AFTER UPDATE{
	DECLARE avail_row INT(1);
	DECLARE rfq_items_bom_items_ids_var VARCHAR(100);
	DECLARE item_count INT(1);
	DECLARE item_no_var VARCHAR(100);
	DECLARE master_item_count INT(1);
	DECLARE master_item_no_var VARCHAR(100);
	DECLARE consolidated_count INT(10);

	DECLARE rfq_id_tmp INT(11);
	DECLARE item_no_tmp VARCHAR(255);
	DECLARE item_desc_tmp VARCHAR(255);
	DECLARE mfg_partnumber_tmp VARCHAR(255);
	DECLARE rev_tmp VARCHAR(5);
	DECLARE equivalent_tmp TINYINT(1);
	DECLARE uom_tmp VARCHAR(255);
	DECLARE note_tmp VARCHAR(255);
	DECLARE qty_tmp INT(1);

	DECLARE m_rfq_id_tmp INT(11);
	DECLARE m_item_no_tmp VARCHAR(255);
	DECLARE m_item_desc_tmp VARCHAR(255);
	DECLARE m_mfg_partnumber_tmp VARCHAR(255);
	DECLARE m_rev_tmp VARCHAR(5);
	DECLARE m_equivalent_tmp TINYINT(1);
	DECLARE m_uom_tmp VARCHAR(255);
	DECLARE m_note_tmp VARCHAR(255);
	DECLARE m_qty_tmp INT(1);

	DECLARE new_master_item_no VARCHAR(100);
	DECLARE old_master_item_no VARCHAR(100);

	IF(NEW.rfq_items_bom_items_id<>OLD.rfq_items_bom_items_id) THEN

		SET rfq_id_tmp = (SELECT rfq_id FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
		SET item_no_tmp = (SELECT item_no FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
		SET item_desc_tmp = (SELECT item_desc FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
		SET mfg_partnumber_tmp = (SELECT mfg_part_number FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
		SET rev_tmp = (SELECT rev FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
		SET equivalent_tmp = (SELECT equivalent FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
		SET uom_tmp = (SELECT uom FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
		SET note_tmp = (SELECT note FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
		SET qty_tmp = (SELECT qty FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);

		IF(OLD.rfq_items_bom_items_id<>'') THEN

			SET old_master_item_no = (SELECT item_no FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
			SET new_master_item_no = (SELECT item_no FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);

			IF(old_master_item_no<>new_master_item_no) THEN
				SET master_item_no_var = old_master_item_no;
				SET master_item_count = (SELECT COUNT(id) FROM 5_1rfq_items_bom_items WHERE item_no=master_item_no_var);

				IF(master_item_count=1) THEN

					SET m_rfq_id_tmp = (SELECT rfq_id FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
					SET m_item_no_tmp = (SELECT item_no FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
					SET m_item_desc_tmp = (SELECT item_desc FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
					SET m_mfg_partnumber_tmp = (SELECT mfg_part_number FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
					SET m_rev_tmp = (SELECT rev FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
					SET m_equivalent_tmp = (SELECT equivalent FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
					SET m_uom_tmp = (SELECT uom FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
					SET m_note_tmp = (SELECT note FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
					SET m_qty_tmp = (SELECT qty FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);

					INSERT INTO 5_1_1rfq_consolidated_bom SET rfq_items_bom_items_ids=OLD.rfq_items_bom_items_id, quantity_for_one_piece=m_qty_tmp, rfq_id=m_rfq_id_tmp, item_no=m_item_no_tmp, item_desc=m_item_desc_tmp, mfg_partnumber=m_mfg_partnumber_tmp, rev=m_rev_tmp, equivalent=m_equivalent_tmp, uom=m_uom_tmp, note=m_note_tmp;

				ELSE
					SET consolidated_count = (SELECT SUM(qty) FROM 5_1rfq_items_bom_items WHERE item_no=master_item_no_var AND id NOT IN (SELECT rfq_items_bom_items_id FROM 5_1rfq_items_bom_items WHERE rfq_id=NEW.rfq_id AND rfq_items_bom_items_id<>''));
					SET rfq_items_bom_items_ids_var = (SELECT group_concat(id) FROM 5_1rfq_items_bom_items WHERE item_no=master_item_no_var AND id NOT IN (SELECT rfq_items_bom_items_id FROM 5_1rfq_items_bom_items WHERE rfq_id=NEW.rfq_id AND rfq_items_bom_items_id<>''));
					UPDATE 5_1_1rfq_consolidated_bom SET rfq_items_bom_items_ids=rfq_items_bom_items_ids_var, quantity_for_one_piece=consolidated_count, rfq_id=rfq_id_tmp, item_desc=item_desc_tmp, mfg_partnumber=mfg_partnumber_tmp, rev=rev_tmp, equivalent=equivalent_tmp, uom=uom_tmp, note=note_tmp WHERE item_no=master_item_no_var AND rfq_id=NEW.rfq_id;				
				END IF;
			END IF;

		END IF;

		IF(NEW.rfq_items_bom_items_id<>'') THEN
			SET master_item_no_var = (SELECT item_no FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
			SET master_item_count = (SELECT COUNT(id) FROM 5_1rfq_items_bom_items WHERE item_no=master_item_no_var);

			IF(master_item_count=1) THEN
				DELETE FROM 5_1_1rfq_consolidated_bom WHERE item_no=master_item_no_var;
			ELSE
				SET consolidated_count = (SELECT SUM(qty) FROM 5_1rfq_items_bom_items WHERE item_no=master_item_no_var AND id NOT IN (SELECT rfq_items_bom_items_id FROM 5_1rfq_items_bom_items WHERE rfq_id=NEW.rfq_id AND rfq_items_bom_items_id<>''));
				SET rfq_items_bom_items_ids_var = (SELECT group_concat(id) FROM 5_1rfq_items_bom_items WHERE item_no=master_item_no_var AND id NOT IN (SELECT rfq_items_bom_items_id FROM 5_1rfq_items_bom_items WHERE rfq_id=NEW.rfq_id AND rfq_items_bom_items_id<>''));
				UPDATE 5_1_1rfq_consolidated_bom SET rfq_items_bom_items_ids=rfq_items_bom_items_ids_var, quantity_for_one_piece=consolidated_count, rfq_id=rfq_id_tmp, item_desc=item_desc_tmp, mfg_partnumber=mfg_partnumber_tmp, rev=rev_tmp, equivalent=equivalent_tmp, uom=uom_tmp, note=note_tmp WHERE item_no=item_no_tmp AND rfq_id=NEW.rfq_id;				
			END IF;
		ELSE
			SET item_no_var = (SELECT item_no FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
			SET item_count = (SELECT COUNT(id) FROM 5_1_1rfq_consolidated_bom WHERE item_no=item_no_var);
			IF(item_count=0) THEN
				INSERT INTO 5_1_1rfq_consolidated_bom SET rfq_items_bom_items_ids=NEW.rfq_items_bom_items_id, quantity_for_one_piece=qty_tmp, rfq_id=rfq_id_tmp, item_no=item_no_tmp, item_desc=item_desc_tmp, mfg_partnumber=mfg_partnumber_tmp, rev=rev_tmp, equivalent=equivalent_tmp, uom=uom_tmp, note=note_tmp;
			ELSE
				SET master_item_no_var = (SELECT item_no FROM 5_1rfq_items_bom_items WHERE id=NEW.rfq_items_bom_items_id);
				SET consolidated_count = (SELECT SUM(qty) FROM 5_1rfq_items_bom_items WHERE item_no=master_item_no_var AND id NOT IN (SELECT rfq_items_bom_items_id FROM 5_1rfq_items_bom_items WHERE rfq_id=NEW.rfq_id AND rfq_items_bom_items_id<>''));
				SET rfq_items_bom_items_ids_var = (SELECT group_concat(id) FROM 5_1rfq_items_bom_items WHERE item_no=master_item_no_var AND id NOT IN (SELECT rfq_items_bom_items_id FROM 5_1rfq_items_bom_items WHERE rfq_id=NEW.rfq_id AND rfq_items_bom_items_id<>''));
				UPDATE 5_1_1rfq_consolidated_bom SET rfq_items_bom_items_ids=rfq_items_bom_items_ids_var, quantity_for_one_piece=consolidated_count, rfq_id=rfq_id_tmp, item_desc=item_desc_tmp, mfg_partnumber=mfg_partnumber_tmp, rev=rev_tmp, equivalent=equivalent_tmp, uom=uom_tmp, note=note_tmp WHERE item_no=item_no_tmp AND rfq_id=NEW.rfq_id;
			END IF;
		END IF;
		
	END IF;

	SET avail_row = (SELECT COUNT(id) AS avail_row FROM 5_1_1rfq_consolidated_bom WHERE item_no=NEW.item_no AND rfq_id=NEW.rfq_id);
	IF(avail_row>0) THEN
		SET consolidated_count = (SELECT SUM(qty) FROM 5_1rfq_items_bom_items WHERE item_no=NEW.item_no AND id NOT IN (SELECT rfq_items_bom_items_id FROM 5_1rfq_items_bom_items WHERE rfq_id=NEW.rfq_id AND rfq_items_bom_items_id<>''));
		SET rfq_items_bom_items_ids_var = (SELECT group_concat(id) FROM 5_1rfq_items_bom_items WHERE item_no=NEW.item_no AND id NOT IN (SELECT rfq_items_bom_items_id FROM 5_1rfq_items_bom_items WHERE rfq_id=NEW.rfq_id AND rfq_items_bom_items_id<>''));
		UPDATE 5_1_1rfq_consolidated_bom SET rfq_items_bom_items_ids=rfq_items_bom_items_ids_var, quantity_for_one_piece=consolidated_count, rfq_id=NEW.rfq_id, item_no=NEW.item_no, item_desc=NEW.item_desc, mfg_partnumber=NEW.mfg_part_number, rev=NEW.rev, equivalent=NEW.equivalent, uom=NEW.uom, note=NEW.note WHERE item_no=NEW.item_no AND rfq_id=NEW.rfq_id;
	ELSE
		INSERT INTO 5_1_1rfq_consolidated_bom SET rfq_items_bom_items_ids=NEW.id, quantity_for_one_piece=NEW.qty, rfq_id=NEW.rfq_id, item_no=NEW.item_no, item_desc=NEW.item_desc, mfg_partnumber=NEW.mfg_part_number, rev=NEW.rev, equivalent=NEW.equivalent, uom=NEW.uom, note=NEW.note;
	END IF;
}
AFTER DELETE{
	DECLARE avail_row INT(1);
	DECLARE rfq_items_bom_items_ids_var VARCHAR(100);
	DECLARE item_no_var VARCHAR(100);
	DECLARE item_count INT(1);
	DECLARE master_item_count INT(1);
	DECLARE master_item_no_var VARCHAR(100);
	DECLARE consolidated_count INT(10);

	DECLARE rfq_id_tmp INT(11);
	DECLARE item_no_tmp VARCHAR(255);
	DECLARE item_desc_tmp VARCHAR(255);
	DECLARE mfg_partnumber_tmp VARCHAR(255);
	DECLARE rev_tmp VARCHAR(5);
	DECLARE equivalent_tmp TINYINT(1);
	DECLARE uom_tmp VARCHAR(255);
	DECLARE note_tmp VARCHAR(255);
	DECLARE qty_tmp INT(1);

	IF(OLD.rfq_items_bom_items_id<>'') THEN
		SET item_no_var = (SELECT item_no FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
		SET item_count = (SELECT COUNT(id) FROM 5_1_1rfq_consolidated_bom WHERE item_no=item_no_var);

		SET rfq_id_tmp = (SELECT rfq_id FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
		SET item_no_tmp = (SELECT item_no FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
		SET item_desc_tmp = (SELECT item_desc FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
		SET mfg_partnumber_tmp = (SELECT mfg_part_number FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
		SET rev_tmp = (SELECT rev FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
		SET equivalent_tmp = (SELECT equivalent FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
		SET uom_tmp = (SELECT uom FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
		SET note_tmp = (SELECT note FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
		SET qty_tmp = (SELECT qty FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);

		IF(item_count=0) THEN
			INSERT INTO 5_1_1rfq_consolidated_bom SET rfq_items_bom_items_ids=OLD.rfq_items_bom_items_id, quantity_for_one_piece=qty_tmp, rfq_id=rfq_id_tmp, item_no=item_no_tmp, item_desc=item_desc_tmp, mfg_partnumber=mfg_partnumber_tmp, rev=rev_tmp, equivalent=equivalent_tmp, uom=uom_tmp, note=note_tmp;
		ELSE
			SET master_item_no_var = (SELECT item_no FROM 5_1rfq_items_bom_items WHERE id=OLD.rfq_items_bom_items_id);
			SET consolidated_count = (SELECT SUM(qty) FROM 5_1rfq_items_bom_items WHERE item_no=master_item_no_var AND id NOT IN (SELECT rfq_items_bom_items_id FROM 5_1rfq_items_bom_items WHERE rfq_id=OLD.rfq_id AND rfq_items_bom_items_id<>''));
			SET rfq_items_bom_items_ids_var = (SELECT group_concat(id) FROM 5_1rfq_items_bom_items WHERE item_no=master_item_no_var AND id NOT IN (SELECT rfq_items_bom_items_id FROM 5_1rfq_items_bom_items WHERE rfq_id=OLD.rfq_id AND rfq_items_bom_items_id<>''));
			UPDATE 5_1_1rfq_consolidated_bom SET rfq_items_bom_items_ids=rfq_items_bom_items_ids_var, quantity_for_one_piece=consolidated_count, rfq_id=rfq_id_tmp, item_desc=item_desc_tmp, mfg_partnumber=mfg_partnumber_tmp, rev=rev_tmp, equivalent=equivalent_tmp, uom=uom_tmp, note=note_tmp WHERE item_no=item_no_tmp AND rfq_id=OLD.rfq_id;
		END IF;
	END IF;

	SET avail_row = (SELECT COUNT(id) AS avail_row FROM 5_1_1rfq_consolidated_bom WHERE item_no=OLD.item_no AND rfq_id=OLD.rfq_id);
	IF(avail_row>0) THEN
		SET consolidated_count = (SELECT IFNULL(SUM(qty),0) FROM 5_1rfq_items_bom_items WHERE item_no=OLD.item_no AND id NOT IN (SELECT rfq_items_bom_items_id FROM 5_1rfq_items_bom_items WHERE rfq_id=OLD.rfq_id AND rfq_items_bom_items_id<>''));
		IF(consolidated_count=0) THEN
			DELETE FROM 5_1_1rfq_consolidated_bom WHERE item_no=OLD.item_no AND rfq_id=OLD.rfq_id;
		ELSE
			SET rfq_items_bom_items_ids_var = (SELECT group_concat(id) FROM 5_1rfq_items_bom_items WHERE item_no=OLD.item_no AND id NOT IN (SELECT rfq_items_bom_items_id FROM 5_1rfq_items_bom_items WHERE rfq_id=OLD.rfq_id AND rfq_items_bom_items_id<>''));
			UPDATE 5_1_1rfq_consolidated_bom SET rfq_items_bom_items_ids=rfq_items_bom_items_ids_var, quantity_for_one_piece=consolidated_count, rfq_id=OLD.rfq_id, item_no=OLD.item_no, item_desc=OLD.item_desc, mfg_partnumber=OLD.mfg_part_number, rev=OLD.rev, equivalent=OLD.equivalent, uom=OLD.uom, note=OLD.note WHERE item_no=OLD.item_no AND rfq_id=OLD.rfq_id;
		END IF;
	END IF;
}

DEF:5_1_1rfq_consolidated_bom
AFTER INSERT{
	DECLARE release_group_count INT(11);
	DECLARE max_release_group INT(11);
	DECLARE release_qtys_var VARCHAR(50);
	DECLARE rfq_items_ids_var VARCHAR(50);
	DECLARE check_item_avail VARCHAR(255);

	SET release_group_count = 1;
	SET max_release_group = (SELECT MAX(release_group) FROM 3_2rfq_items__qty_clone WHERE rfq_id = NEW.rfq_id);
	SET check_item_avail = (SELECT id FROM erp1_items WHERE ItemID=NEW.item_no);

	IF check_item_avail IS NULL THEN
		SET @source_type_auto_var = 2;
	ELSE
		SET @source_type_auto_var = 1;
	END IF;

	WHILE (release_group_count<=max_release_group) DO

		SET release_qtys_var = (SELECT group_concat(release_qty ORDER BY rfq_items_id) AS release_qtys FROM 3_2rfq_items__qty_clone WHERE rfq_id = NEW.rfq_id AND release_group=release_group_count GROUP BY release_group);
		SET rfq_items_ids_var = (SELECT group_concat(rfq_items_id ORDER BY rfq_items_id) AS rfq_items_ids FROM 3_2rfq_items__qty_clone WHERE rfq_id = NEW.rfq_id AND release_group=release_group_count GROUP BY release_group);

		INSERT INTO 5_1_1_1rfq_consolidated_bom_costing SET rfq_id=NEW.rfq_id, rfq_consolidated_bom_id=NEW.id, release_group=release_group_count, release_qtys=release_qtys_var, rfq_items_ids=rfq_items_ids_var, source_type_auto=@source_type_auto_var;
		SET release_group_count = release_group_count + 1;
	END WHILE;
}
AFTER DELETE{
	DELETE FROM 5_1_1_1rfq_consolidated_bom_costing WHERE rfq_consolidated_bom_id=OLD.id;
}

DEF:5_1_1_1rfq_consolidated_bom_costing
BEFORE INSERT{
	
}

DEF:5_1_1_2rfq_consolidated_bom_required_vendor
BEFORE INSERT{
	DECLARE item_no VARCHAR(255);
	SET NEW.vendor_name = (SELECT vendor_name FROM m_vendors WHERE id=NEW.vendor_id);
	SET NEW.vendor_email = (SELECT vendor_email FROM m_vendors WHERE id=NEW.vendor_id);
	SET NEW.vendor_visit_read_stats = (SELECT COUNT(id) FROM 5_1_1_2rfq_consolidated_bom_required_vendor_stats WHERE rfq_consolidated_bom_required_vendor_id=NEW.id);

}

BEFORE UPDATE{
	IF(OLD.vendor_id<>NEW.vendor_id) THEN
		SET NEW.vendor_name = (SELECT vendor_name FROM m_vendors WHERE id=NEW.vendor_id);
		SET NEW.vendor_email = (SELECT vendor_email FROM m_vendors WHERE id=NEW.vendor_id);
	END IF;
}

DEF:5_1_1_2rfq_consolidated_bom_required_vendor_stats
AFTER INSERT{
	DECLARE visit_count INT(11);
	SET visit_count = (SELECT COUNT(id) FROM 5_1_1_2rfq_consolidated_bom_required_vendor_stats WHERE rfq_consolidated_bom_required_vendor_id=NEW.rfq_consolidated_bom_required_vendor_id);
	UPDATE 5_1_1_2rfq_consolidated_bom_required_vendor SET vendor_visit_read_stats=visit_count;
}

DEF:6rfq_items_labor
BEFORE INSERT{
	SET NEW.rfq_id = (SELECT rfq_id FROM 3_1rfq_items WHERE id=NEW.rfq_items_id);
	SET NEW.hour = NEW.time_in_seconds/3600;
	SET NEW.total_per_piece_in_hours = NEW.activity_per_part*NEW.time_in_seconds/3600;
}

BEFORE UPDATE{
	SET NEW.hour = NEW.time_in_seconds/3600;
	SET NEW.total_per_piece_in_hours = NEW.activity_per_part*NEW.time_in_seconds/3600;
}

AFTER UPDATE{
	DECLARE labour_hrs DECIMAL(9,4);
	SET labour_hrs = (SELECT SUM(hour) FROM 6rfq_items_labor WHERE rfq_items_id=NEW.rfq_items_id);
	UPDATE 6_1rfq_items_labor_summary SET total_labor_hours=labour_hrs;
}

DEF:6_1rfq_items_labor_summary
BEFORE INSERT{
	SET NEW.rfq_items_id = (SELECT rfq_items_id FROM 6rfq_items_labor WHERE id=NEW.rfq_items_labor_id);
	SET NEW.rfq_id = (SELECT rfq_id FROM 6rfq_items_labor WHERE id=NEW.rfq_items_labor_id);
	SET NEW.total_labor_hours = (SELECT SUM(hour) FROM 6rfq_items_labor WHERE rfq_items_id=NEW.rfq_items_id);
}

DEF:8rfq_items_assumptions
BEFORE INSERT{
	SET NEW.rfq_id = (SELECT rfq_id FROM 3_1rfq_items WHERE id=NEW.rfq_items_id);
}

DEF:9rfq_outboundfreight
BEFORE INSERT{
	SET NEW.rfq_id = (SELECT rfq_id FROM 3_1rfq_items WHERE id=NEW.rfq_items_id);
}