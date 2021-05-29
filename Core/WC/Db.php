<?
class Core_WC_Db {
	function clean(&$arr,$table) {
		$db = Zend_Db_Table::getDefaultAdapter();
		
		$valid = array();
		$res = $db->query("DESCRIBE $table");
		while($row=$res->fetch()) {
			if(substr($row["Field"],0,6)==="audit_") continue;
			$valid[]=$row["Field"];
		}
		
		$ret = array();
		if(count($arr)>0){
			foreach($arr as $i => $v) {
				if(in_array($i,$valid)) {
					$ret[$i]=$v;
				}
			}
		}
		
		$arr = $ret;
	}
	
	public static function get($table,$id,$field="*",$id_field="id") {
		$db = Zend_Db_Table::getDefaultAdapter();
		try {
			$res = $db->query("SELECT *".($field!="*"?", $field AS f":"")." FROM $table WHERE $id_field='$id'");
			$row = $res->fetch();
			
			if($field=="*") {
				return $row;
			} else {
				$ff=explode(",",$field);
				if(count($ff)==1) {
					return $row["f"];
				} else {
					$ret = array();
					foreach($ff as $f) {
						$ret[]=$row[$f];
					}
					return implode(", ",$ret);
				}
			}
		} catch(Exception $e) {
			echo $e->getMessage();
			exit;
		}
	}
}
