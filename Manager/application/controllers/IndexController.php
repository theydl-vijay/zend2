<?php

class IndexController extends Zend_Controller_Action
{
	public function indexAction() {		
		$db = Zend_Db_Table::getDefaultAdapter();
		// $this->view->id = $id;
		if ($this->getRequest()->isPost()) {
			$data = $this->_request->getPost();

			// require_once('shippo-lib/lib/Shippo.php');
			// Shippo::setApiKey("<API_TOKEN>");

			$_sets = array();
			$_sets['from_name'] =  $data['from_name'];
			$_sets['from_street'] = $data['from_street'];
			$_sets['from_city'] = $data['from_city'];
			$_sets['from_state'] = $data['from_state'];
			$_sets['from_zip'] = $data['from_zip'];
			$_sets['from_country'] = $data['from_country'];

			$_sets['name'] =  $data['name'];
			$_sets['street'] = $data['street'];
			$_sets['city'] = $data['city'];
			$_sets['state'] = $data['state'];
			$_sets['zip'] = $data['zip'];
			$_sets['country'] = $data['country'];
			$_sets['length'] =  $data['length'];
			$_sets['width'] = $data['width'];
			$_sets['height'] = $data['height'];
			$_sets['distance_unit'] = $data['distance_unit'];
			$_sets['weight'] = $data['weight'];
			$_sets['mass_unit'] = $data['mass_unit'];

			echo json_encode($_sets); die();
			// print_r($_sets); 

		}
	}

}
