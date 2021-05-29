<?php

class UserController extends Zend_Controller_Action
{
	public function loginAction() {
		$this->_helper->layout()->disableLayout();  
		
		$db = Zend_Db_Table::getDefaultAdapter();
		
		
		$username = $this->getRequest()->getParam('username');
		$this->view->username = $username;
		$_pass=$this->getRequest()->getParam('password');
		$password = md5($_pass);
		if($username!="" && $_pass!="") {
			$res = $db->query("SELECT id,username,initial FROM m_user WHERE username='$username' AND `password`='$password'");
			if($row=$res->fetch()) {
				$session = Core_WC_Session::get();
				
				$session->user_id = $row["id"];
				$session->user_name = $row["username"];

				$session->node_user_name = $row['initial'];								
				$_sets = array("user_id" => $row["id"],
							"datetime" => date('Y-m-j H:i:s'),
							"ip_address" => @$_SERVER["REMOTE_ADDR"],
							"referrer" => 2,
							"action" => 1);
				$this->db->insert("log_users", $_sets);
				
				$user_limitations = array();
				$q="SELECT * FROM m_user_stores WHERE user_id=$row[id]";
				$limits = $db->fetchAll($q);
				while($l = array_shift($limits)) {
					$user_limitations[] = $l["store_id"];
				}
				Core_WC_Session::setVal("user_limited_stores", $user_limitations);
				Core_WC_Session::setVal("node_user_name", $session->node_user_name);
				 
				$user_permissions = Core_WC_ACL::get_user_stores_p($row["id"]);
				Core_WC_Session::setVal("user_permissions", $user_permissions);
				 
				if($this->view->ref!="") {
					header("Location: ".base64_decode($this->view->ref));
				} else {
					header("Location: /index");
				}
				exit;
			} else {
			
				$this->view->invalid_login=1;
			}
			
		}
		
	}
	public function logoutAction() {
		$session = Core_WC_Session::get();
		$_sets = array("user_id" => $session->user_id,
					"datetime" => date('Y-m-j H:i:s'),
					"ip_address" => @$_SERVER["REMOTE_ADDR"],
					"referrer" => 2,
					"action" => 0);
		$this->db->insert("log_users", $_sets);
		$session->user_id = 0;
		$session->user_name = "";
		
		Core_WC_Session::setVal("user_id",0);
		Core_WC_Session::setVal("user_name","");
		
		
		
		$username = $this->getRequest()->getParam('username');
		$iframe = $this->getRequest()->getParam('iframe');
		header("Location: /user/login/iframe/$iframe/username/$username");
		exit;
	}


}
