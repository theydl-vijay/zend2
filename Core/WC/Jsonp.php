<?
class Core_WC_Jsonp {
	function send($str,$morejs="") {
		$id = Zend_Controller_Front::getInstance()->getRequest()->getParam('jsonp_id');
		header("Content-type: application/javascript");
		echo "
		
if(_jsonp_callbacks[$id]) {
	var d=".json_encode(array("jsonp" => $str))."
	_jsonp_callbacks[$id](d.jsonp);
}
$('#__jsonp$id').remove();
if(_jsonp_timeout_callbacks[$id]) {
	setTimeout(_jsonp_timeout_callbacks[$id][0],_jsonp_timeout_callbacks[$id][1]);
}
$morejs
";
		exit;
	}
}
