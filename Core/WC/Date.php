<?
class Core_WC_Date {
	function time_ago( $date ){
		if( empty( $date ) )
		{
			return "";
		}

		$periods = array("second", "minute", "hour", "day", "week", "month", "year", "decade");

		$lengths = array("60","60","24","7","4.35","12","10");

		$now = time();

		$unix_date = strtotime( $date );

		// check validity of date

		if( empty( $unix_date ) )
		{
			return "Bad date";
		}

		// is it future date or past date

		if( $now > $unix_date )
		{
			$difference = $now - $unix_date;
			//$tense = "ago";
		}
		else
		{
			$difference = $unix_date - $now;
			$tense = "from now";
		}

		for( $j = 0; $difference >= $lengths[$j] && $j < count($lengths)-1; $j++ )
		{
			$difference /= $lengths[$j];
		}

		$difference = round( $difference );

		if( $difference != 1 )
		{
			$periods[$j].= "s";
		}

		return "$difference $periods[$j] {$tense}";

	}
	function time_ago_with_tooltip($date,$alt_date="") {
		$i=strtotime($date);
		$i_alt=strtotime($alt_date);
		
		if($i>0) {
			return "<abbr class=timeago title='$date'>".date("m/d/Y H:i:s", $i)."</abbr>";
		} elseif($i_alt>0) {
			return "<abbr class=timeago title='$alt_date'>".date("m/d/Y H:i:s", $i_alt)."</abbr>";
		}
	}
	function month_name($month_number) {
		return date("M", strtotime(date("Y")."-$month_number-1"));
	}
	function productionadmin_date_to_str($date) {
		if($date>0) {
			list($year, $month) = explode("-",$date);
			return date("F", strtotime("$year-$month-1"))." $year";
		} else {
			return "";
		}
	}
	function productionadmin_week_to_str($week,$creation_date) {
		if(!$creation_date || (strtotime($creation_date)<100)) return "";
		
		list($year,$month) = explode("-",$creation_date);
		$date_from = strtotime("$year-$month-01 + ".($week)." weeks");
		$date_to = strtotime("$year-$month-01 + ".($week+1)." weeks");
		while(date("Y-m",$date_to)>date("Y-m",strtotime($creation_date))) {
			$date_to = strtotime(date("Y-m-d", $date_to)." - 1 day");
		}
		return date("jS", $date_from)." to ".date("jS", $date_to);
	}
}
