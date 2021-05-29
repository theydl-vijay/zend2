<?
class Core_WC_Exception {
	public static function processException($e) {
		$db = Zend_Db_Table::getDefaultAdapter();
		
		if(!$db) {
			echo $e->getMessage();
			exit;
		}
		
		$conf = $db->getConfig();

		$dblog = new Zend_Db_Adapter_Pdo_Mysql(array(
			'host'     => $conf['host'], 
			'username' => $conf['username'],
			'password' => $conf['password'],  
			'dbname'   => $conf['dbname']."_log"
		));		
		
		$session = Core_WC_Session::get();		
		try {
			if($session->user_name) {
				$u = $session->user_name;
			} elseif($session->userId) {
				$u = $session->userId;
			} elseif($session->storeId) {
				$u = Core_WC_Db::get("m_store", $session->storeId, "store_name");
			} else {
				$u="(other)";
			}
			
			$trace = debug_backtrace(); //$e->getTrace();
			
			$ct = count($trace);
			
			
			$arrLog = array(
				"application"=> $session->getNamespace(),
				"controller"=>  Zend_Controller_Front::getInstance()->getRequest()->getControllerName(),
				"action"=>		Zend_Controller_Front::getInstance()->getRequest()->getActionName(),
				"user"=>	 	$u,
				"error"=> 	 	$e->getMessage(),
				"logtrace"=> 	json_encode($trace)
			);
			
			$dblog->insert("log_errors",$arrLog);
			
			return $e->getMessage();
			
		} catch(Exception $e) {
			echo $e->getMessage();
			exit;
		}
		
	}
}
