<?
class Core_WC_Datatable {
	private $fields=array();
	private $html;
	private $aoColumns=array();
	private $callbackFunctions=array('	$(".dropdown-menu").on("click", function(e){if($(this).hasClass("dropdown-menu-with-radios")){e.stopPropagation();}});$(".numeric").numeric();$("input:checkbox,input:radio").uniform();');
	private $arrSubQueries = array();
	private $rowCallbackFunctions=array();
	private $arrUnionQueries = array();
	private $table_id="";
	
	private $sql_query;
	private $pre_wh;
	private $pre_hv=array();
	private $orderBy = array();
	private $group_by;
	
	private $limit=100;
	private $_limit_set=false;
	private $no_limit=false;
	
	private $extraHTML;
	
	private $show_full_list_link=false;
	private $show_full_datatable=false;
	
	private $has_detail_row=false;
	private $url ="null";
	
	private $striked_rows=false;
	
	private $fields_titles=array();
	
	private $filter_else="";
	
	private $hidden_fields = array();
	
	private $countquery;

	private $return_results=false;
	
	private $db_adapter=false;
	
	function __construct($tableid="datatable",$sOptions=array()) {
		$show_query = Zend_Controller_Front::getInstance()->getRequest()->getParam('showquery');
		$fulldatatable = Zend_Controller_Front::getInstance()->getRequest()->getParam('fulldatatable');
		$this->url = $sOptions['url'];
		if($fulldatatable) {
			$tableid = "full_datatable_$tableid";
		}
		
		$this->show_full_datatable = $fulldatatable;
		
		if($fulldatatable) {
			unset($sOptions["sDom"]);
		}
		$params = 0;
		if(is_array($sOptions['params']) && count($sOptions['params'])>0){
			$params = http_build_query($sOptions['params']);
		}
		
		$this->html = "<script> _datatables.push('$tableid'); var datatable_{$tableid}_url = '".($this->url==""?"":$this->url)."';var datatable_{$tableid}_showquery='$show_query&fulldatatable=$fulldatatable&$params';  var datatable_{$tableid}_aoColumns = #aoColumns#; var datatable_{$tableid}_m_order = #m_order#; function datatable_{$tableid}_callback(){ $('#myoverlay').remove(); #callback#} function datatable_{$tableid}_row_callback(nRow, aData){ #row_callback# } var datatable_{$tableid}_sOptions = ".json_encode($sOptions)." </script><div style='margin-top:5px'><a href='#' class='right' style='margin-left:10px;float:right;' onclick='$(\"#$tableid\").DataTable().draw({sDom:\"".$sOptions["sDom"]."\"});return false;'><i class='fa fa-refresh'></i> Reload list </a><label class='right' style='float:right' id='total_time_info_$tableid'></label><table class='table table-striped table-bordered table-hover' id='$tableid'><thead><tr>#head#</tr><tr>#filters#</tr></thead><tbody></tbody></table>#full_list_link#</div>";
		$this->countquery = $countquery;
		$this->table_id = $tableid;
	}
	function setDbAdapter($db) {
		$this->db_adapter=$db;
		return $this;
	}
	function countquery($q){
		$this->countquery = $q;
		return $this;
	}

	function filterElse($f) {
		$this->filter_else=$f;
		return $this;
	}
	function addFunctionCallback($jScbFunction){
		$this->callbackFunctions[]=$jScbFunction;
	}	
	function addFunctionRowCallback($jScbFunction){
		$this->rowCallbackFunctions[]=$jScbFunction;
	}	
	function setPreHv($hv) {
		$this->pre_hv = $hv;
		return $this;
	}
	function setGroupBy($grp_by) {
		$this->group_by = $grp_by;
		return $this;
	}
	function setLimit($lmt) {
		$this->_limit_set=true;
		$this->limit = $lmt;
		return $this;
	}
	function addExtraHtmlToField($field,$html) {
		$this->extraHTML[$field]=$html;
		
		return $this;
	}
	function striked($s) {
		if(is_bool($s)) {
			$this->striked_rows=$s;
			return $this;
		} else {
			if($this->striked_rows) {
				return "<strike style='color:red'><span style='color:black'>$s</span></strike>";
			} else {
				return $s;
			}
		}
		
	}
	function showFullListLink($status=-1) {
		if($status!==-1) {
			$this->show_full_list_link=$status && !$this->show_full_datatable;
			return $this;
		} elseif(!$this->show_full_datatable && $this->show_full_list_link) {
			return "<a class='right' href='#' onclick='view_full_datatable(\"{$this->table_id}\")'>View full list</a>";
		}
	}
	
	function addField($name,$attr) {
		if(is_string($attr)) { $attr = json_decode($attr,1); }
		
		if(array_key_exists($name,$this->arrSubQueries)){
			$attr["wwhere_str"]=$attr["where_str"];
			$attr["where_str"] = $this->arrSubQueries[$name];
		}
		$this->fields[$name] = $attr;
		
		return $this;
	}
	
	function parseFilter($fname,$fattr,$fidx){
		if(!$fattr["filter_type"]){
			return '<input type="text" style="padding:0px;height:100%" autocomplete=off class="form-control form-filter input-sm" placeholder="'.$fattr["title"].'" name="filter_'.$fname.'" id="filter_for_'.$fidx.'" onkeypress="if(event.keyCode==13) return false;">';
		}elseif($fattr["filter_type"]=="int_range"){
			return '<input type="text" style="padding:0px;height:100%" autocomplete=off class="form-control form-filter input-sm" placeholder="'.$fattr["title"].'" name="filter_'.$fname.'" id="filter_for_'.$fidx.'" onkeypress="if(event.keyCode==13) return false;">';
		}elseif($fattr["filter_type"]=="select"){
			
			// to simulate keyup enter key from onchange 
			
			return '<select style="padding:0px;height:100%" class="form-control form-filter input-sm" name="filter_'.$fname.'" id="filter_for_'.$fidx.'" onchange="var e = jQuery.Event(\'keyup\');e.which = 13;$(this).trigger(e);">'.$fattr["filter_options"].'</select>';
		}
	}
	
	function detailRowSql($sql,$field_name,$return_results=false){
		$showdetail = Zend_Controller_Front::getInstance()->getRequest()->getParam('showdetail');
		$show = Zend_Controller_Front::getInstance()->getRequest()->getParam('show');
		$showquery = Zend_Controller_Front::getInstance()->getRequest()->getParam('showquery');
		if($showdetail && $this->show($show)) {
			$column_widths = explode(",",Zend_Controller_Front::getInstance()->getRequest()->getParam('columnwidths'));
			
			if($this->db_adapter) {
				$db = $this->db_adapter;
			} else {
				$db = Zend_Db_Table::getDefaultAdapter();
			}
			
			ob_clean();
			$sql = str_replace("#detailrowid#", $showdetail, $sql);
			
			$sql = self::quickfixes($sql);
			if($showquery) {
				echo $sql;exit;
			}
			$ret="";
			$res = $db->query($sql);
			$row_class="odd";
			$_results=array();
			while($row=$res->fetch()) {
				$ret .= "<tr role='row' class='$row_class'>";
				$_row=array();
				$row_class = $row_class=="odd"?"even":"odd";
				
				foreach($this->fields as $fname => $fattr) {
					if(in_array($fname,$this->hidden_fields)) continue;
					$sClass = str_replace("details-control", "", $fattr["ao"]["sClass"]);
					$_field = $this->formatField($fname,$fattr, $row);
					$ret .= "<td width='".array_shift($column_widths)."' class='$sClass'>$_field</td>";
					if($return_results) {
						$_row[]=$_field;
					}
				}
				if($return_results) {
					$_results[]=$_row;
				}
				$ret .= "</tr>";
			}
			
			$ret = "<table class='table table-striped table-bordered table-hover dataTable no-footer' width=100%>$ret</table>";
			if($return_results) {
				return $_results;
			}
			echo $ret;
			exit;
		}
		$this->has_detail_row=$field_name;
	}
	
	function custom_detail($fied_name){
		$this->has_detail_row = $fied_name;
	}
	
	function draw() {
		$draw = Zend_Controller_Front::getInstance()->getRequest()->getParam('draw');
		
		$head = "";
		
		$m_order = "[]";
		$filters = "";
		$idx=-1;
		foreach($this->fields as $fname => $fattr) {
			if($fattr["permission_test_hide"]) {
				if(!Plugin_ACL::$fattr["permission_test_hide"](Core_WC_Session::getVal("user_id"))) {
					continue;
				}
			}
			if(in_array($fname, $this->hidden_fields)) {
				continue;
			}
			$idx++;
			$head .= "<th>$fattr[title]</th>";
			
			$this->fields_titles[]=$fattr["title"];
			
			$fattr["ao"]["sName"] = $fname;
			$this->aoColumns[]=$fattr["ao"];
			
			if($fattr["m_order"]) {
				$m_order = "[$idx,\"{$fattr[m_order]}\"]";
			}
			
			if(!$fattr["hide_filter"]) {
				if($fattr["custom_filter_area"]!=""){
					$filters .= "<td>".$fattr["custom_filter_area"]."</td>";	
				}else{
					$filters .= "<td>".$this->parseFilter($fname,$fattr,$idx)."</td>";	
				}
				
			} else {
				$filters .= "<td></td>";	
			}
			
		}
		
		if($m_order == "[]") {
			$m_order = "[0,\"ASC\"]";
		}
		
		$this->addFunctionCallback('fetchTotalQueryTime("'.$this->table_id.'")');
		$this->addFunctionCallback('__Datatable_loaded["'.$this->table_id.'"]=1;');
		
		$ret="";
		
		if($this->has_detail_row!==false) {
			
			$this->addFunctionCallback('initDetailRows_'.$this->table_id.'()');
			
			$detailid_idx=array_search($this->has_detail_row,array_keys($this->fields));
			
			$ret = <<<EOT
<script>
function initDetailRows_{$this->table_id}() {
	
	$('#{$this->table_id} tbody .details-control').unbind("click").bind('click', function (evt) {
		var tr = $(this).closest('tr');
		
		var row = $('#{$this->table_id}').DataTable().row( tr );

		if ( row.child.isShown() ) {
			// This row is already open - close it
			row.child.hide();
			tr.removeClass('shown');
			evt.stopPropagation();
			evt.preventDefault();
		} else {
			// Open this row
			var column_widths = Array();
			for(var j=0; j<tr.children().length; j++) {
				column_widths.push(tr.children()[j].offsetWidth);
			}
			
			tr.addClass('shown');
			$.get("?show={$this->table_id}&columnwidths="+column_widths.join(",")+"&showdetail="+row.data()[$detailid_idx].split("detailid ").pop().split("-->").shift(), function(r) {
				row.child( r ).show();
				datatable_{$this->table_id}_callback();
			});
		}
	} );
}
</script>
EOT;
		}
		
		$reps = array("#head#" => $head,
					"#filters#" => $filters,
					"#m_order#" => $m_order,
					"#aoColumns#" => json_encode($this->aoColumns),
					"#callback#" => implode(";\n",$this->callbackFunctions),
					"#row_callback#" => implode(";\n",$this->rowCallbackFunctions),
					"#full_list_link#" => $this->showFullListLink()
				);
		
		$ret .= str_replace(array_keys($reps), array_values($reps), $this->html);
		
		
		
		if("full_datatable_$draw"==$this->table_id) {
			ob_clean();
			echo $ret;
			exit;
		} else {
			return $ret;
		}
	}
	
	function addQuery($sql,$pre_wh=array(),$pre_hv=array(),$maintable="") {
		if($maintable) {
			$sql = str_replace("#mainalias#", $maintable, $sql);
		}
		foreach($pre_wh as $i => $w) {
			$pre_wh[$i] = str_replace("#mainalias#", $maintable, $w);
		}
		foreach($pre_hv as $i => $h) {
			$pre_hv[$i] = str_replace("#mainalias#", $maintable, $h);
		}
		
		$this->sql_query=$this->quickfixes($sql);
		$this->pre_wh=$pre_wh;
		$this->pre_hv = array_merge($this->pre_hv,$pre_hv);
		return $this;
	}
	
	function rowcount($dont_wh=0,$maintablealias="") {
		if($this->countquery){
			return $this->countquery;
		}
		$extra_sql = Zend_Controller_Front::getInstance()->getRequest()->getParam('sql');
		$showquery = Zend_Controller_Front::getInstance()->getRequest()->getParam('showquery');
		
		$sql = $this->sql_query;
		$pre_wh = $this->pre_wh;
		
		
		$where = "";
		$wh=$pre_wh;
		
		$having="";
		$hv=$this->pre_hv;
		
		/*
		$_aux = explode(" ",$sql);
		$_aux[0] = "SELECT SQL_CALC_FOUND_ROWS";
		$sql = implode(" ",$_aux);
		*/
		
		if($maintablealias) {
			$sql = str_replace("#mainalias#", $maintablealias, $sql);
		}
		
		if(count($this->arrUnionQueries)>0) {
			if(!$dont_wh) {
				if(count($wh)) {
					$where = "WHERE ".implode(" AND ",$wh);
				}
				
				if($this->group_by) {
					$group_by = "GROUP BY {$this->group_by}";
				}
				
				$sql = "$sql $where $group_by $having";
			
			
				array_unshift($this->arrUnionQueries,$sql);
			}
			
			$sql = "(".implode(") UNION ALL (",$this->arrUnionQueries).")";
			
			$count_f = "*";
			
			/*if($extra_sql) {
				list($extra_sql_t,$extra_sql_f) = explode(".",$extra_sql);
				$count_f = strtoupper($extra_sql_t)."($extra_sql_f)";
			}*/
			
			$sql = "SELECT COUNT($count_f) FROM ($sql) AS tcount";
			
			if($maintablealias) {
				$sql = str_replace("#mainalias#", $maintablealias, $sql);
			}
			$sql = self::quickfixes($sql);
			
			if($this->db_adapter) {
				$db = $this->db_adapter;
			} else {
				$db = Zend_Db_Table::getDefaultAdapter();
			}
			
			try {
				if($showquery) {
					echo $sql;exit;
				}
				return $db->fetchOne($sql);
				
			} catch(Exception $e) {
				echo "sdg ".$sql."<br>".Core_WC_Exception::processException($e);
				exit;
			}
		} else {
			$_aux = explode(" ",$sql);
			$_aux[0] = "SELECT SQL_CALC_FOUND_ROWS";
			$sql = implode(" ",$_aux);
			
			if(!$dont_wh) {
				if(count($wh)) {
					$where = "WHERE ".implode(" AND ",$wh);
				}
			
				
				if($this->group_by) {
					$group_by = "GROUP BY {$this->group_by}";
				}
				
				$sql = "$sql $where $group_by $having $order_by LIMIT 0,1";
			} else {
				$sql = "$sql LIMIT 0,1";
			}
			
			
			
			$sql = self::quickfixes($sql);
			
			if($this->db_adapter) {
				$db = $this->db_adapter;
			} else {
				$db = Zend_Db_Table::getDefaultAdapter();
			}
			
			try {
				if($showquery) {
					echo $sql;exit;
				}
				$res = $db->query($sql);
				return array_shift($db->query("SELECT FOUND_ROWS()")->fetch());
			} catch(Exception $e) {
				echo $sql."<br>".Core_WC_Exception::processException($e);
				exit;
			}
		}
	}
	
	function setOrderBy($arrOrderBy){
		if(count($arrOrderBy)>0){
			foreach ($arrOrderBy as $field => $type){
				$this->orderBy[]="$field $type";
			}
		}
	}	
	function showResults($sql="",$pre_wh=array(), $main_table_alias="", $initial_order_by="") {
		$session = Core_WC_Session::get();
		
		
		
		session_write_close();
		
		
		$_start_time = microtime(1);
		
		if(!$sql && $this->sql_query!="") $sql = $this->sql_query;
		if(count($pre_wh)==0 && count($this->pre_wh)>0) $pre_wh = $this->pre_wh;
		
		$iDisplayLength = Zend_Controller_Front::getInstance()->getRequest()->getParam('length');
		$iDisplayLength = !$iDisplayLength ? 50 : $iDisplayLength; 
		$iDisplayStart = Zend_Controller_Front::getInstance()->getRequest()->getParam('start');
		$iOrder = Zend_Controller_Front::getInstance()->getRequest()->getParam('order');
		$iColumns = Zend_Controller_Front::getInstance()->getRequest()->getParam('columns');
		$iDisplayStart = !$iDisplayStart?0:$iDisplayStart;
		$sEcho = Zend_Controller_Front::getInstance()->getRequest()->getParam('draw');
		
		//with this paging work fine
		//~ if(Zend_Controller_Front::getInstance()->getRequest()->getParam('length')>0){
			//~ $this->limit = $iDisplayLength;
		//~ }
		//~ 
		
		if($this->limit && !$this->show_full_datatable && $this->_limit_set) {
			$iDisplayLength=$this->limit;
		}
		
		$records = array();
		$records["data"] = array(); 
		$order_by="";
		
		$where = "";
		$wh=$pre_wh;
		
		$having="";
		$hv=$this->pre_hv;
		
		$end = $iDisplayLength;
		if($end<0){
				$this->no_limit=1;
		}
		$_aux = explode(" ",$sql);
		$_aux[0] = "SELECT ";
		$sql = implode(" ",$_aux);
		
		$_fs = array_keys($this->fields);
		
		$this->addWhereFromRequest($wh,$hv, $main_table_alias);
		
		
		
		if(count($wh)) {
			$where = "WHERE ".implode(" AND ",$wh);
		}
		if(count($hv)) {
			$having = "HAVING ".implode(" AND ",$hv);
		}
		
		if($this->group_by) {
			$group_by = "GROUP BY {$this->group_by}";
		}
		
		$order_by=array();
		if(count($this->orderBy)>0){
			$order_by = $this->orderBy;
		}
		if(isset($iOrder[0]["column"])) {
			$fn = $_fs[$iOrder[0]["column"]];
			$fn_original = $fn;
			$fn_base = array_pop(explode(".",$fn));
			if(is_array($this->arrSubQueries[$fn_base]) && $this->arrSubQueries[$fn_base][2]!="") {
				$fn = $this->arrSubQueries[$fn_base][2];
			} elseif($this->fields[$fn]["where_str"]!="" && !is_array($this->fields[$fn]["where_str"])) {
				$fn = $this->fields[$fn]["where_str"];
			}
			if($this->fields[$fn_original]["cast_order"]=="SIGNED"){
					$order_by[]= " CAST($fn AS SIGNED) ".strtoupper($iOrder[0]["dir"]);
			}else{
				$order_by[]= " $fn ".strtoupper($iOrder[0]["dir"]);
			}
		}

		if(count($this->orderBy)>0){
			$order_by = array_merge($order_by,$this->orderBy);
		}
		
		$sql = "$sql $where $group_by $having";
		
		$this->sql_query = $sql;
		$this->pre_wh = $pre_wh;
		
		if(count($this->arrUnionQueries)) {
			array_unshift($this->arrUnionQueries,$sql);
			$sql = "(".implode(") UNION ALL (",$this->arrUnionQueries).")";
		}
		if(count($order_by)>0){
			$sql = "$sql ".(count($order_by)>0?" ORDER BY ".implode(", ",$order_by):"")." ".(!$this->no_limit?"LIMIT $iDisplayStart, $end":"");
		}elseif($initial_order_by){
			$sql = "$sql ORDER BY ".$initial_order_by." ".(!$this->no_limit?"LIMIT $iDisplayStart, $end":"");
		}else{
			$sql = "$sql ".(!$this->no_limit?"LIMIT $iDisplayStart, $end":"");
		}
		
		
		if($main_table_alias) {
			$sql = str_replace("#mainalias#", $main_table_alias, $sql);
		}
		
		$sql = self::quickfixes($sql);
		
		
		$show_query = Zend_Controller_Front::getInstance()->getRequest()->getParam('showquery');
		if($show_query) { echo $sql;exit; }
		
		if($this->db_adapter) {
			$db = $this->db_adapter;
		} else {
			$db = Zend_Db_Table::getDefaultAdapter();
		}
		
		try {
			//if($_SERVER["REMOTE_ADDR"]=="122.170.115.187") { echo $sql;exit; }
			//echo $sql;exit; 
			$res = $db->query($sql);
		} catch(Exception $e) {
			echo $sql;
			//echo json_encode(array("error" => "Query: $sql\n\n".Core_WC_Exception::processException($e)));
			exit;
		}
		
		//$iTotalRecords = array_shift($db->query("SELECT FOUND_ROWS()")->fetch());
//		$iTotalRecords = self::rowcount(1, $main_table_alias);

		if($this->countquery <> ""){
			$iTotalRecords = array_shift($db->query($this->countquery)->fetch());
		}else{
			$iTotalRecords = self::rowcount(1, $main_table_alias);
		}

		
		while($row=$res->fetch()) {
			$_dont_add_row=0;
			$d=array();
			
			
			foreach($this->fields as $fname => $fattr) {
				
				if($fattr["permission_test_hide"]) {
					if(!Plugin_ACL::$fattr["permission_test_hide"](Core_WC_Session::getVal("user_id"))) {
						continue;
					}
				}
				if(in_array($fname, $this->hidden_fields)) continue;
				try {
					$_val = utf8_encode($this->formatField($fname,$fattr, $row));
				} catch(Exception $e) {
					$_dont_add_row=1;
					break;
				}
				
				$d[] = $_val;
			}
			if(!$_dont_add_row) $records["data"][]=$d;
			
			
		}
		
		$records["draw"] = $sEcho;
		$records["recordsTotal"] = $iTotalRecords;
		$records["recordsFiltered"] = $iTotalRecords;
		$session->table_total_time[$this->table_id] = microtime(1)-$_start_time;
		
		
		
		if($this->return_results) {
			return $records["data"];
		} else {
			echo json_encode($records);	
		}
	}
	function exportXLS($filename,$results) {
		$this->return_results=true;
		$this->no_limit = true;
		
		$f = "./tmp/xls_".uniqid().".xls";
		
		$this->draw();
		
		$_f = fopen($f,"w");
		fwrite($_f,'"'.implode('","', $this->fields_titles).'"'."\n");
		
		while($r=array_shift($results)) {
			fwrite($_f,'"'.implode('","',$r).'"'."\n");
		}
		
		fclose($_f);
		
		header("Content-type: application/xls");
		header("Content-disposition: attachment; filename=$filename");
		
		readfile($f);
		
		unlink($f);
	}
	function getFields() {
		$_fs = array_keys($this->fields);
		
		$_fs = array_values(array_diff($_fs,$this->hidden_fields));
		return $_fs;
	}
	function addWhereFromRequest(&$wh,&$hv,$maintablealias="",$alternate_wh=array()) {
		$iColumns = Zend_Controller_Front::getInstance()->getRequest()->getParam('columns');
		
		$_fs = array_keys($this->fields);
		
		$_fs = array_values(array_diff($_fs,$this->hidden_fields));
		
		
		$_condition_added=0;
		
		foreach($_fs as $fidx => $fname) {

			$fattr = $this->fields[$fname];
			
			if($iColumns[$fidx]["search"]["value"]!="") {

				$search_value =  str_replace("'","''",$iColumns[$fidx]["search"]["value"]);
				$this->countquery = "";
				
				if($fattr["wwhere_str"]) $fattr["where_str"]=$fattr["wwhere_str"];
				
				
				if(!$fattr["in_having"]) {
					if(in_array($fname, array_keys($alternate_wh))) {
						$wh[] = $alternate_wh[$fname];
					} else {
						if(is_array($fattr["where_str"])) {
							$fname=array_pop(explode(",",$fattr["where_str"][0]));
						} elseif($fattr["where_str"]!="") {
							$fname = $fattr["where_str"];
						}
						
						
						$_neg_complex_search=false;
						if(strpos($fname,"date")!==false) {
							preg_match('|\D(\d+) (d\w+)$|Us', $search_value, $days_search);
							
							if(is_numeric($days_search[1])) {
								$new_search_value = date("Y-m-d", strtotime(date("Y-m-d")." - $days_search[1] day"));
								
								$search_value = str_replace($days_search[1]." ".$days_search[2],"$new_search_value 00:00:00", $search_value);
								
								$_neg_complex_search=true;
							}
						}
						
						$_complex_search=false;
						$_complex_search_chars = array(">","<","=");
						foreach($_complex_search_chars as $csc) {
							if(strpos($search_value,$csc)!==false) {
								$_complex_search=true;
							}
						}
						if($_complex_search) {
							$_search_blocks = explode(",",$search_value);
							foreach($_search_blocks as $_s) {
								$_ss = str_replace($_complex_search_chars,"", $_s);
								$_op = str_replace($_ss,"", $_s);
								
								if($_neg_complex_search) {
									$_op = $_op==">"?"<":">";
								}
								
								if(is_numeric($_ss)) {
									$wh[] = "$fname $_op $_ss";
								} else {
									$wh[] = "$fname $_op '$_ss'";
								}
								$_condition_added=1;
							}
						} else {
							
							$fname = str_replace("#search_value#", $search_value, $fname);
							
							$wh[] = "($fname LIKE '".$fattr["filter_prefix"]."$search_value%')";
							$_condition_added=1;
						}
					}
				} else {
					//$hv[] = "$fname LIKE '".$fattr["filter_prefix"]."$search_value%'";
					//$_condition_added=1;
					$_complex_search=false;
					$_complex_search_chars = array(">","<","=");
					foreach($_complex_search_chars as $csc) {
						if(strpos($search_value,$csc)!==false) {
							$_complex_search=true;
						}
					}
					if($_complex_search) {
						$_search_blocks = explode(",",$search_value);
						foreach($_search_blocks as $_s) {
							$_ss = str_replace($_complex_search_chars,"", $_s);
							$_op = str_replace($_ss,"", $_s);
							
							if($_neg_complex_search) {
								$_op = $_op==">"?"<":">";
							}
							
							if(is_numeric($_ss)) {
								$hv[] = "$fname $_op $_ss";
							} else {
								$hv[] = "$fname $_op '$_ss'";
							}
							$_condition_added=1;
						}
					} else {

						$hv[] = "$fname LIKE '".$fattr["filter_prefix"]."$search_value%'";
						$_condition_added=1;
					}
				}
			}
		}
		
		if(!$_condition_added && $this->filter_else!="") {
			$felse = $this->filter_else;
			if($maintablealias) {
				$felse = str_replace("#mainalias#", $maintablealias, $felse);
			}
			array_unshift($wh,$felse);
		}
		
	}
	function formatField($fname, $fattr, $row) {
		if($fname===$this->has_detail_row) {
			$row[$fname] = $row[$fname]."<!--detailid ".$row[$this->has_detail_row]."-->";
		}
		
		$no_link=0;
		if($fattr["link_if"]) {
			//echo "return ".Core_WC_Tags::parse($fattr["link_if"],$row).";\n";
			$no_link = !eval("return (".Core_WC_Tags::parse($fattr["link_if"],$row).");");
		}
		if($fattr["link_permission"]) {
			$no_link = !call_user_method($fattr["link_permission"],new Plugin_ACL,Core_WC_Session::getVal("user_id"));
		}
		if($fattr["with_format"]) {
			$row[$fname] = number_format($row[$fname],2,".",",");
		}
		
		if($fattr["link"] && !$no_link && $row[$fname]) {
			$l = Core_WC_Tags::parse($fattr["link"],$row);
			$_ret = "<a href='#' onclick='$l; return false;'>".$this->striked($row[$fname])."</a>";
		} elseif($fattr["href"] && !$no_link && $row[$fname]) {
			if($fattr["link_split"]) {
				$vals = explode($fattr["link_split"], $row[$fname]);
			} else {
				$vals = array($row[$fname]);
			}
			
			$title="";
			if($fattr["href_title"]) {
				$_param = array_pop($fattr["href_title"]);
				$title = call_user_func($fattr["href_title"],$row[$_param]);
			}
			
			$ret=array();
			foreach($vals as $v) {
				$target="";
				$l = Core_WC_Tags::parse($fattr["href"],$row, $fname, $v);
				if($fattr["target"]) {
					$target = "target='$fattr[target]'";
				}
				
				$ret[] = "<a $target title='$title' href='$l'>".$this->striked($v)."</a>";
			}
			$_ret = implode($fattr["link_split"],$ret);
			
		} else {
			
			if(is_array($this->arrSubQueries[$fname])) { 
				$dstr=$this->arrSubQueries[$fname][1];
				$_fields = explode(",", $this->arrSubQueries[$fname][0]);
				foreach($_fields as $_f) {
					$dstr = str_replace("#$_f#", $row[array_pop(explode(".",$_f))], $dstr);
				}
				
				foreach($row as $_k => $_v) {
					$dstr = str_replace("#$_k#", $_v, $dstr);
				}
				
				if(is_array($this->arrSubQueries[$fname][1])) {
					$_params = array();
					foreach($_fields as $_fdef) {
						$ff = array_pop(explode(".",$_fdef));
						if(strpos($ff,"!")===false) {
							$_params[] = $row[$ff];
						} else {
							$_params[] = str_replace("!","",$ff);
						}
					}
					if($this->arrSubQueries[$fname][2]) {
						
						$_params[] = $row[$fname];
					}
					if(is_array($this->arrSubQueries[$fname][3])) {
						foreach($this->arrSubQueries[$fname][3] as $a) {
							$_params[] = $row[$a];
						}
					}
					
					if($fattr["permission_test_userparam"]) {
						$_params[] = Plugin_ACL::$fattr["permission_test_userparam"](Core_WC_Session::getVal("user_id"));
					}
					try {
						$dstr = call_user_func_array($this->arrSubQueries[$fname][1], $_params);
						
					} catch(Exception $e) {
						throw new Exception($e->getMessage());
					}
					
					
				}
				
				$_ret = $this->striked($dstr);
			} else {
				$_ret = $this->striked($row[$fname]);
			}
		}
		
		if(($exhtml=$this->extraHTML[$fname])!="") {
			$_ret .= $exhtml;
			foreach($row as $_k => $_v) {
				$_ret = str_replace("#$_k#", $_v, $_ret);
			}
		}
		
		return $_ret;
	}
	public function replaceFieldName($oldname,$newname) {
		$_newfields = array();
		foreach($this->fields as $f => $d) {
			if($f!=$oldname) {
				$_newfields[$f]=$d;
			} else {
				$_newfields[$newname]=$d;
			}
		}
		$this->fields = $_newfields;
		
		return $this;
	}
	public function newFieldAfter($prevfield,$f,$attr) {
		$_newfields = array();
		foreach($this->fields as $fx => $d) {
			if($prevfield!=$fx) {
				$_newfields[$fx]=$d;
			} else {
				$_newfields[$prevfield]=$d;
				$_newfields[$f]=$attr;
			}
		}
		$this->fields = $_newfields;
		
		return $this;
	}
	public function replaceFieldDef($f, $attr) {
		$this->fields[$f]=$attr;
		return $this;
	}
	function hideFields($fields) {
		$this->hidden_fields = array_merge($this->hidden_fields,$fields);
		return $this;
	}
	public function addSubsQueries($arrQueries=array()){
		if(count($this->arrSubQueries)>0) {
			$this->arrSubQueries = array_merge($this->arrSubQueries,$arrQueries);
		} else {
			$this->arrSubQueries = $arrQueries;
		}
	}
	function removeField($f) {
		unset($this->fields[$f]);
	}
	public function getSubQuery($ignore_fields=array(),$maintable=""){
		if(count($this->arrSubQueries)>0){
			foreach($this->arrSubQueries as $alias => $subquery){
				if(is_array($subquery)) {
					if(!$subquery[3]) { 
						$aux1_fields = explode(",",$subquery[0]);
						foreach($aux1_fields as $aux1_field){
							if(!array_key_exists($aux1_field,$this->arrSubQueries) && !in_array($aux1_field, $ignore_fields)){
								$sq[] = $aux1_field; 	
							}							
						}
						// $sq[] = $subquery[0]; now check if field already exist
					}
					
					if($subquery[2]) {
						$sq[] = $subquery[2]." AS ".$alias;
					}
				} else {
					if(!in_array($subquery, $ignore_fields)) {
						$sq[] = "$subquery AS $alias";
					}
				}
			}
			$this->sub_Q = $sq;
			
			$ret = implode(", ",$sq);
			
			$ret = str_replace("#mainalias#", $maintable, $ret);
			
			return $ret;
		}
		
	}
	function addUnionQuery($q, $wh=array(),$main_table_alias="",$alternate_wh=array(),$pre_hv=array()) {
		$this->addWhereFromRequest($wh,$hv,$main_table_alias,$alternate_wh);
		
		if(count($wh)) {
			$q .= "WHERE ".implode(" AND ",$wh);
		}
		if(count($hv)) {
			$q .= " HAVING ".implode(" AND ",$hv);
		}
		
		if($this->group_by) {
			$q .= " GROUP BY {$this->group_by}";
		}
		
		if($main_table_alias) {
			$q = str_replace("#mainalias#", $main_table_alias, $q);
		}
		
		
		foreach($pre_hv as $i => $h) {
			$pre_hv[$i] = str_replace("#mainalias#", $maintable, $h);
		}
		$this->pre_hv = array_merge($this->pre_hv,$pre_hv);
		
		$this->arrUnionQueries[]=$q;
	}
	function totaltime($table_id) {
		$session = Core_WC_Session::get();
		return $session->table_total_time[$table_id];
	}
	function show($tableid) {
		return ($tableid==$this->table_id) || ($tableid=="full_datatable_".$this->table_id);
	}
	function quickfixes($sql) {
		$sql = str_replace("od1.shipping_type", "od1.shiping_type", $sql);
		$sql = str_replace("od_detail_id=", "ord_det.id=", $sql);
		$sql = str_replace("od_detail_id LIKE", "ord_det.id LIKE", $sql);
		$sql = str_replace("create_checkbox ASC,", "", $sql);
		$sql = str_replace("rr.id ASC,", "", $sql);
		$sql = str_replace("rr.id DESC,", "", $sql);
		$sql = str_replace("ORDER BY  od.audit_created_date", "ORDER BY  audit_created_date", $sql);
		$sql = str_replace("ORDER BY  ord_det.audit_created_date", "ORDER BY  audit_created_date", $sql);
		
		return $sql;
	}
}
