<?
// All functions have to start with "user_can" so we know wich are real permissions

// after adding a permission, refresh a page in SH6 BackOffice app so the code in
// Plugin_ACL updates the rules in DB, then you can configure the rule in the role


class Core_WC_ACL extends Zend_Controller_Plugin_Abstract {
	function test($rule,$user) {
		if(strpos(__FILE__,"home/webs")!==false) return true;
//error_reporting(E_ALL); ini_set("display_errors","on");
		if($user==Core_WC_Session::getVal("user_id")) {
			$permissions = Core_WC_Session::getVal("user_permissions");
		} else {
			$permissions = self::get_user_stores_p($user);
		}
//print_r($permissions);exit;
		return @in_array($rule,$permissions);
	}
	function user_can_copy_paste($userid) {
                return self::test("user_can_copy_paste", $userid);
        }
	function user_can_edit_order_qty($userid) {
		return self::test("user_can_edit_order_qty", $userid);
	}
	function user_can_edit_order_notes($userid) {
		return self::test("user_can_edit_order_notes", $userid);
	}
	function user_can_edit_order_wear_date($userid) {
		return self::test("user_can_edit_order_wear_date", $userid);
	}
	function user_can_adj_style_stock($userid) {
		return self::test("user_can_adj_style_stock", $userid);
	}
	function user_can_edit_order_discount($userid) {
		return self::test("user_can_edit_order_discount", $userid);
	}
	function user_can_edit_invoice_discount($userid) {
		return self::test("user_can_edit_invoice_discount", $userid);
	}
	function user_can_return_invoice_qty($userid) {
		return self::test("user_can_return_invoice_qty", $userid);
	} 
	function user_can_delete_factory_payment($userid) {
		return self::test("user_can_delete_factory_payment", $userid);
	}
	function user_can_advance_payment_for_store($userid) {
		return self::test("user_can_advance_payment_for_store", $userid);
	}
	function user_can_approve_new_sites_requests($userid) {
		return self::test("user_can_approve_new_sites_requests", $userid);
	}
	function user_can_approve_artwork_request_download($userid) {
		return self::test("user_can_approve_artwork_request_download", $userid);
	}
	function user_can_approve_images_download_request($userid) {
		return self::test("user_can_approve_images_download_request", $userid);
	}
	function user_can_edit_order_customer_po($userid) {
		return self::test("user_can_edit_order_customer_po", $userid);
	}
	function user_can_edit_request_customer_po($userid) {
		return self::test("user_can_edit_request_customer_po", $userid);
	}
	function user_can_delete_order_line($userid) {
		return self::test("user_can_delete_order_line", $userid);
	}
	function user_can_edit_bridal($userid) {
		//return Core_WC_Db::get("m_user", $userid, "can_order_bridal");
		return self::test("user_can_edit_bridal", $userid);
	}
	function user_can_delete_request_line($userid) {
		return self::test("user_can_delete_request_line", $userid);
	}
	function user_can_see_other_calendar($userid) {
		return self::test("user_can_see_other_calendar", $userid);
	}
	function user_can_see_calendar($userid) {
		return self::test("user_can_see_calendar", $userid);
	}
	function user_can_approve_free_days($userid) {
		return self::test("user_can_approve_free_days", $userid);
	}
	function user_can_edit_orders($userid) {
		return self::test("user_can_edit_orders", $userid);
	}
	function user_can_set_store_categories($userid) {
		return self::test("user_can_set_store_categories", $userid);
	}
	function user_can_set_order_qualifying_category($userid) {
		return self::test("user_can_set_order_qualifying_category", $userid);
	}
	function user_can_edit_store_address($userid) {
		return self::test("user_can_edit_store_address", $userid);
	}
	function user_can_delete_invoice_lines($userid) {
		return self::test("user_can_delete_invoice_lines", $userid);
	}
	function user_can_edit_invoice($userid) {
		return self::test("user_can_edit_invoice", $userid);
	}
	function user_can_edit_invoice_customer_po($userid) {
		return self::test("user_can_edit_invoice_customer_po", $userid);
	}
	function user_can_edit_po($userid) {
		return self::test("user_can_edit_po", $userid);
	}
	function user_can_view_invoices($userid) {
		return self::test("user_can_view_invoices", $userid);
	}
	function user_can_view_orders($userid) {		
		return self::test("user_can_view_orders", $userid);
	}
	function user_can_view_bridalorders($userid) {		
		return self::test("user_can_view_bridalorders", $userid);
	}
	function user_can_view_payments($userid) {
		return self::test("user_can_view_payments", $userid);
	}
	function user_can_receive_packings($userid) {
		return self::test("user_can_receive_packings", $userid);
	}
	function user_can_view_po($userid) {
		return self::test("user_can_view_po", $userid);
	}
	function user_can_manage_style_images($userid) {
		return self::test("user_can_manage_style_images", $userid);
	}
	function user_can_create_po($userid) {
		return self::test("user_can_create_po", $userid);
	}
	function user_can_view_production_manager($userid) {
		return self::test("user_can_view_production_manager", $userid);
	}
	function user_can_create_packinglist($userid) {
		return self::test("user_can_create_packinglist", $userid);
	}
	function user_can_edit_packinglist($userid) {
		return self::test("user_can_edit_packinglist", $userid);
	}
	function user_can_see_packing_tracking_number($userid) {
		return self::test("user_can_see_packing_tracking_number", $userid);
	}
	function user_can_manage_ruWC_list($userid) {
		return self::test("user_can_manage_ruWC_list", $userid);
	}
	function user_can_view_rush($userid) {
		return true;
		return self::test("user_can_view_rush", $userid);
	}
	function user_can_view_storeapplicants($userid) {
		return self::test("user_can_view_storeapplicants", $userid);
	}
	function user_can_view_requests($userid) {
		return self::test("user_can_view_requests", $userid);
	}
	function user_can_view_returns($userid) {
		return self::test("user_can_view_returns", $userid);
	}
	function user_can_view_dashboard($userid) {
		return self::test("user_can_view_dashboard", $userid);
	}
	function user_can_view_factory($userid) {
		return self::test("user_can_view_factory", $userid);
	}
	function user_can_search($userid) {
		return self::test("user_can_search", $userid);
	}
	function user_can_view_packing_itemproduction($userid) {
		return self::test("user_can_view_packing_itemproduction", $userid);
	}
	function user_can_view_po_orderrequest($userid) {
		return self::test("user_can_view_po_orderrequest", $userid);
	}
	function user_can_create_invoice($userid) {
		return self::test("user_can_create_invoice", $userid);
	}
	function user_can_view_market_admin($userid) {
		return self::test("user_can_view_market_admin", $userid);
	}
	function user_can_set_market_show_runway_link($userid) {
		return self::test("user_can_set_market_show_runway_link", $userid);
	}
	function user_can_edit_market_runway_style($userid) {
		return self::test("user_can_edit_market_runway_style", $userid);
	}
	function user_can_delete_market($userid) {
		return self::test("user_can_delete_market", $userid);
	}
	function user_can_edit_market($userid) {
		return self::test("user_can_edit_market", $userid);
	}
	function user_can_configure_market_runway($userid) {
		return self::test("user_can_configure_market_runway", $userid);
	}
	function user_can_manage_style_bodytypes($userid) {
		return self::test("user_can_manage_style_bodytypes", $userid);
	}
	function user_can_delete_any_user_notes($userid) {
		return self::test("user_can_delete_any_user_notes", $userid);
	}
	function user_can_set_store_account_status($userid) {
		return self::test("user_can_set_store_account_status", $userid);
	}
	function user_can_set_order_line_urgent_ship($userid) {
		return self::test("user_can_set_order_line_urgent_ship", $userid);
	}
	function user_can_lock_shipments($userid) {
		return self::test("user_can_lock_shipments", $userid);
	}
	function user_can_set_store_payment_methods($userid) {
		return self::test("user_can_set_store_payment_methods", $userid);
	}
	function user_can_edit_store_ups_number($userid) {
		return self::test("user_can_edit_store_ups_number", $userid);
	}
	function user_can_set_store_default_payment_method($userid) {
		return self::test("user_can_set_store_default_payment_method", $userid);
	}
	function user_can_edit_coop_orders($userid) {
		return self::test("user_can_edit_coop_orders", $userid);
	}
	function user_can_set_store_payment_terms($userid) {
		return self::test("user_can_set_store_payment_terms", $userid);
	}
	
	function user_can_delete_stores_cc($userid) {
		return self::test("user_can_delete_stores_cc", $userid);
	}
	function user_can_view_db_log($userid) {
		return self::test("user_can_view_db_log", $userid);
	}
	function user_can_edit_cc_label($userid) {
		return self::test("user_can_edit_cc_label", $userid);
	}
	function user_can_edit_invoice_qty($userid) {
		return self::test("user_can_edit_invoice_qty", $userid);
	}
	function user_can_set_invoice_as_old_return($userid) {
		return self::test("user_can_set_invoice_as_old_return", $userid);
	}
	function user_can_edit_invoice_sell_price($userid) {
		return self::test("user_can_edit_invoice_sell_price", $userid);
	}
	function user_can_view_eod_report($userid) {
		return self::test("user_can_view_eod_report", $userid);
	}
	function user_can_view_cod_report($userid) {
		return self::test("user_can_view_cod_report", $userid);
	}
	
	function user_can_send_post_to_top($userid) {
		return self::test("user_can_send_post_to_top", $userid);
	}
	function user_can_add_eod_transactions($userid) {
		return self::test("user_can_add_eod_transactions", $userid);
	}
	function user_can_link_sample_to_style($userid) {
		return self::test("user_can_link_sample_to_style", $userid);
	}
	function user_can_see_style_factory_cost($userid) {
		return self::test("user_can_see_style_factory_cost", $userid);
	}

	function can_store_place_order($userid) {
		return self::test("can_store_place_order", $userid);
	}
	function user_can_see_order_total($userid) {
		return self::test("user_can_see_order_total", $userid);
	}
	function user_can_edit_style_ship_from_date($userid) {
		return self::test("user_can_edit_style_ship_from_date", $userid);
	}
	function user_can_view_images($userid) {
                return self::test("user_can_view_images", $userid);
        }


	// checks if user has stores assigned
	
	function get_user_stores_limitation($table_alias, $user_id) {
		$limitations = self::get_user_stores_l($user_id);
		
		if(count($limitations)>0) {
			return "$table_alias.store_id IN (".implode(",",$limitations).")";
		}
		return false;
	}
	function get_user_store_available($storeid, $user_id) {
		$limitations = self::get_user_stores_l($user_id);
		if(count($limitations)>0) {
			return in_array($storeid,$limitations);
		}
		return true;
	}
	function get_user_stores_l($user_id) {
		if($user_id==Core_WC_Session::getVal("user_id")) {
			$limitations = Core_WC_Session::getVal("user_limited_stores");
		} else {
			$limitations = array();
			
			$db = Zend_Db_Table::getDefaultAdapter();
			
			$lims = $db->fetchAll("SELECT store_id FROM m_user_stores WHERE user_id=$user_id");
			while($l=array_shift($lims)) {
				$limitations[] = $l["store_id"];
			}
		}
		
		return $limitations;
	}
	function get_user_stores_p($user_id) {
		$db = Zend_Db_Table::getDefaultAdapter();
		$users_permissions = array();
		$q="SELECT rule FROM m_user mu 
				RIGHT JOIN m_user_roles_assigned mura ON mura.user_id=mu.id
				RIGHT JOIN m_user_roles_permissions murp ON  mura.role_id=murp.role_id 
				WHERE mu.id=$user_id";
		$res = $db->fetchAll($q);
		while($perm = array_shift($res)) {
			$users_permissions[] = $perm["rule"];
		}
		return $users_permissions;
	}
	function user_can_view_po_total($userid) {
         return self::test("user_can_view_po_total", $userid);
    }	
}
