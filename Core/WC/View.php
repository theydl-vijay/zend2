<?
class Core_WC_View {
	public static function renderForm($templateFile = "form.phtml", $scriptPath = "",$use_method_2=0,$environment=array()){

		if($scriptPath == ""){
			$currentControllerName = Zend_Controller_Front::getInstance()->getRequest()->getControllerName();
			$script_path = APPLICATION_PATH. '/views/scripts/'. $currentControllerName ."/";
		}
		else{
			$script_path =$scriptPath;
		}

		if(!$use_method_2) {
			Zend_Controller_Action_HelperBroker::getExistingHelper('ViewRenderer')->view->addScriptPath($script_path );
			Zend_Controller_Action_HelperBroker::getExistingHelper('ViewRenderer')->renderScript($templateFile);
		} else {
			$view= new Core_WC_OntheflyView();
			$view->innerextract($environment);
			$view->addScriptPath($script_path);
			if($use_method_2==2) {
				return $view->render($templateFile);
			} else {
				echo $view->render($templateFile);
			}
		}



	}
}
