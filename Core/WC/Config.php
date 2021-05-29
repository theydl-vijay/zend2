<?
class Core_WC_Config {
	function get($var) {
		$config = Zend_Controller_Front::getInstance()->getParam('bootstrap');
		return $config->getOption($var);
	}
}
