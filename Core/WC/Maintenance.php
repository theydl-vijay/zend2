<?
class Core_WC_Maintenance {
	function check() {
		$maintenance = 0;
		
		if(file_exists(realpath(CORE_PATH."/../../trigger/triggerin.running"))) {
			$maintenance = file_get_contents(realpath(CORE_PATH."/../../trigger/triggerin.running"));
		}
		
		
		if($maintenance===1) {
			echo "<center><img src='/images/maintenance.gif'></center>";
			exit;
		}
	}
}
