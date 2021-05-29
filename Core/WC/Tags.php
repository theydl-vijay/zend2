<?
class Core_WC_Tags {
	function parse($str, $tags, $fixed_field="", $fixed_val=null) {
		
		foreach($tags as $t => $r) {
			if($t==$fixed_field) {
				$str = str_replace("#$t#", $fixed_val, $str);
			} else {
				$str = str_replace("#$t#", $r, $str);
			}
		}
		
		return $str;
	}
}
