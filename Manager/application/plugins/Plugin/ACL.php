<?php

class Plugin_ACL extends Core_WC_ACL {
	public function preDispatch(Zend_Controller_Request_Abstract $request) {
		Core_WC_Maintenance::check();
		
		$current_controller = Zend_Controller_Front::getInstance()->getRequest()->getControllerName();
		$current_action = Zend_Controller_Front::getInstance()->getRequest()->getActionName();
				
		$jsonp=$this->getRequest()->getParam('jsonp');
		
		$public_urls = array(
			"user"=>array("login","autologoutusers"),
			"error"=>"*",
		);
		
		if($jsonp) {
			$check_session_is_over=true;
			$session = Core_WC_Session::get($check_session_is_over);
			
			if($current_action=="checksessionalive") {
				session_write_close();
				
				$config = Zend_Controller_Front::getInstance()->getParam('bootstrap');
				$session_timeout = $config->getOption("session_timeout");
				
				if($check_session_is_over) {
					$session->user_id=0;
					echo "checkSession_over()";
					exit;
				}
				$ttl=30;
				while((time()-($session->last_session_time))<$session_timeout) {
					if($ttl-- == 0) {
						break;
					}
					sleep(1);
				}
				if($ttl>0) {
					$session->user_id=0;
					echo "checkSession_over()";
					exit;
				}
				
				Core_WC_Jsonp::send("");
				
				exit;
			}
			$_authorized=0;
			$searchk=$this->getRequest()->getParam('k');
			if($searchk==$session->searchk) {
				$_authorized=1;
			}
			if(!$_authorized && $public_urls[$current_controller]!="*" && !@in_array($current_action, $public_urls[$current_controller])) {
				if(!$session->user_id) {
					header("Location: /user/login/?ref=".base64_encode($_SERVER["REQUEST_URI"]));
					exit;
					
				}
			}
			
		} elseif(!$jsonp) {
			$check_session_is_over=false;
			$session = Core_WC_Session::get($check_session_is_over);
			
			
			
			
			if($current_action!="fromcore" && $public_urls[$current_controller]!="*" && !@in_array($current_action, $public_urls[$current_controller])) {
				if(!$session->user_id) {
					header("Location: /user/login/?ref=".base64_encode($_SERVER["REQUEST_URI"]));
					exit;
					
				}
			} else {
				
			}
			
			if($jsonp) {
				echo "";
				exit;
			}
			
			$db = Zend_Db_Table::getDefaultAdapter();
			
			if($session->user_id) {
				try {
					
					$db->query("SET @app_username='".$session->user_name."';");
					$db->query("SET @app_user_ip='".$_SERVER["REMOTE_ADDR"]."';");
					$db->query("SET @debug_triggers=0;");
					$db->query("SET @rand_token='".uniqid()."';");
					$db->query("SET @dont_save_update_time=0;");
					
					$config = Zend_Controller_Front::getInstance()->getParam('bootstrap');
					if(is_array($config->getOption("wall_messages_order_qty_max_than")) && count($config->getOption("wall_messages_order_qty_max_than"))>0){
						$db->query("SET @min_qty_per_trigger_post=".min($config->getOption("wall_messages_order_qty_max_than")).";");
					}
					
				} catch(Exception $e) {
					echo json_encode(array("error" => $e->getMessage()));
					exit;
				}
				
			}
			
			$db = Zend_Db_Table::getDefaultAdapter();
			$methods = get_class_methods(Core_WC_ACL);
			$_permissions = array();
			foreach($methods as $m) {
				if(substr($m,0,8)=="user_can") {
					$_permissions[]=$m;
				}
			}
			$all=$db->fetchAll("SELECT name FROM m_user_rules");
			$_all = array();
			while($a=array_shift($all)) $_all[]=$a["name"];
			$_missing = array_diff($_permissions,$_all);
			
			foreach($_missing as $m) {
				$db->insert("m_user_rules", array("name" => $m));
			}
		}
	}
	
}
