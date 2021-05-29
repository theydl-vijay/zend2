<?php
class Plugin_Modal extends Zend_Controller_Plugin_Abstract {
	public function preDispatch(Zend_Controller_Request_Abstract $request) {
		if($this->getRequest()->getParam("modalframe")>0){
			$layout = Zend_Layout::getMvcInstance();
			$layout->setLayout('modal_iframe_layout');
		}
	}
}
?>
