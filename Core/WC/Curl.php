<?
class Core_WC_Curl {
	function get($url, $ptc="coo.txt",$follow=1, $maxredirs=0, $debug=0,$more_headers=array(),$otheragent=""){
		
			$ch=curl_init();
			$str  = array(
			"Accept-Language: en-us,en;q=0.5",
			"Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7",
			"Keep-Alive: 300",
			"Connection: keep-alive",
			"Expect: "
			
			);
			$str = array_merge($str,$more_headers);
			
			$mydebug = fopen(dirname(__FILE__).'/Curl/log_get.txt','a');
			curl_setopt($ch, CURLOPT_STDERR, $mydebug);
			curl_setopt($ch, CURLOPT_VERBOSE, 1);
			curl_setopt($ch, CURLOPT_HTTPHEADER, $str);
			curl_setopt($ch,CURLOPT_URL,$url);
			curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
			curl_setopt($ch,CURLOPT_SSL_VERIFYPEER,false);
			curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);              
			curl_setopt($ch,CURLOPT_COOKIEJAR,$ptc);
			curl_setopt($ch, CURLOPT_FREWC_CONNECT, 0);
			curl_setopt($ch, CURLOPT_FAILONERROR, 1);
			curl_setopt($ch, CURLOPT_HEADER, 0);
		//	curl_setopt($ch,CURLOPT_VERBOSE,0);
			curl_setopt($ch,CURLOPT_COOKIEFILE,$ptc);
			curl_setopt($ch, CURLOPT_AUTOREFERER, 1);
			if($maxredirs) {
				curl_setopt($ch, CURLOPT_MAXREDIRS, $maxredirs);
			}
			curl_setopt($ch,CURLOPT_FOLLOWLOCATION,$follow);
			curl_setopt($ch,CURLOPT_USERAGENT, $otheragent!=""?$otheragent:"Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.8.1.8) Gecko/20071008 Firefox/2.0.0.8");
			$result=curl_exec($ch);
			curl_close($ch);
		
			if($debug==1){
			echo "<textarea rows=30 cols=120>".$result."</textarea>";       
			}
			if($debug==2){
			echo "<textarea rows=30 cols=120>".$result."</textarea>";       
			echo $result;
			}
			return $result;
		}

		function get2($url, $ptc="coo.txt",$follow=0, $debug=0){

			$ch=curl_init();
			$str  = array(
			"Accept-Language: en-us,en;q=0.5",
			"Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7",
			"Keep-Alive: 300",
			"Connection: keep-alive",
			"Expect: "
			
			);
			curl_setopt($ch, CURLOPT_HTTPHEADER, $str);
			curl_setopt($ch,CURLOPT_URL,$url);
			curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
			curl_setopt($ch,CURLOPT_SSL_VERIFYPEER,false);
			curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);              
			curl_setopt($ch,CURLOPT_COOKIEJAR,$ptc);
			curl_setopt($ch, CURLOPT_FREWC_CONNECT, 1);
			curl_setopt($ch, CURLOPT_FAILONERROR, 1);
			curl_setopt($ch,CURLOPT_COOKIEFILE,$ptc);
			curl_setopt($ch, CURLOPT_AUTOREFERER, 1);
			//curl_setopt($ch,CURLOPT_FOLLOWLOCATION,$follow);
			curl_setopt($ch,CURLOPT_USERAGENT, "Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.8.1.8) Gecko/20071008 Firefox/2.0.0.8");
			$result=curl_redir_exec($ch);
			curl_close($ch);
		
			if($debug==1){
			echo "<textarea rows=30 cols=120>".$result."</textarea>";       
			}
			if($debug==2){
			echo "<textarea rows=30 cols=120>".$result."</textarea>";       
			echo $result;
			}
			return $result;
		}
		function get_web_page( $url )
		{
			$options = array( 'http' => array(
			'user_agent'    => 'Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.8.1.8) Gecko/20071008 Firefox/2.0.0.8',    // who am i
			'max_redirects' => 10,          // stop after 10 redirects
			'timeout'       => 120,         // timeout on response
			) );
			$context = stream_context_create( $options );
			$page    = file_get_contents( $url, false, $context );
		 
			$result  = array( );
			if ( $page != false )
			$result['content'] = $page;
			else if ( !isset( $http_response_header ) )
			return null;    // Bad url, timeout

			// Save the header
			$result['header'] = $http_response_header;

			// Get the *last* HTTP status code
			$nLines = count( $http_response_header );
			for ( $i = $nLines-1; $i >= 0; $i-- )
			{
			$line = $http_response_header[$i];
			if ( strncasecmp( "HTTP", $line, 4 ) == 0 )
			{
				$response = explode( ' ', $line );
				$result['http_code'] = $response[1];
				break;
			}
			}
		 
			return $result;
		}
		function post($url,$postal_data, $ptc="tmp/coo.txt",$referer="",$verbose=1,$more_headers=array(),$otheragent=""){

			$ch=curl_init();
			$app_type="application/x-www-form-urlencoded";
			$str  = array(
			
			
			);
			$str = array_merge($str,$more_headers);
			
			/*if($_SERVER["REMOTE_ADDR"]=="186.22.4.95") { 
				$mydebug = fopen(dirname(__FILE__).'/Curl/log_get.txt','a');
				curl_setopt($ch, CURLOPT_STDERR, $mydebug);
				curl_setopt($ch, CURLOPT_VERBOSE, $verbose);
				//curl_setopt($ch, CURLOPT_HTTPHEADER, $str);
			}*/
			
			curl_setopt($ch, CURLOPT_HTTPHEADER, $str);
			
			curl_setopt($ch,CURLOPT_URL,$url);
			curl_setopt($ch, CURLOPT_POST, 1); 
			curl_setopt($ch,CURLOPT_USERAGENT, $otheragent!=""?$otheragent:"Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.8.1.8) Gecko/20071008 Firefox/2.0.0.8"); //"Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)");
			curl_setopt($ch, CURLOPT_POSTFIELDS,($postal_data));
			curl_setopt($ch, CURLOPT_FAILONERROR, 0);
			curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
			curl_setopt($ch,CURLOPT_SSL_VERIFYPEER,false);
			curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);             
			curl_setopt($ch, CURLOPT_FREWC_CONNECT, 1);
			if($referer!="") {
				curl_setopt($ch, CURLOPT_REFERER, $referer);
			} else {
				curl_setopt($ch, CURLOPT_AUTOREFERER, 1);
			}
			curl_setopt($ch,CURLOPT_COOKIEJAR,$ptc);
			curl_setopt($ch,CURLOPT_COOKIEFILE,$ptc);
			curl_setopt($ch,CURLOPT_FOLLOWLOCATION,1);
			$result=curl_exec($ch);
			curl_close($ch);
		
			if($debug==1){
			echo "<textarea rows=30 cols=120>".$result."</textarea>";       
			}
			if($debug==2){
			echo "<textarea rows=30 cols=120>".$result."</textarea>";       
			echo $result;
			}
			return $result;
		}

	function redir_exec($ch,$ptc="coo.txt",$debug="")
	{
		static $curl_loops = 0;
		static $curl_max_loops = 20;
		
		global $aux_host;
		
		if ($curl_loops++ >= $curl_max_loops)
		{
			$curl_loops = 0;
			return FALSE;
		}
		curl_setopt($ch, CURLOPT_HEADER, true);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

		$data = curl_exec($ch);
		$debbbb = $data;
		list($header, $data) = explode("\n\n", $data, 2);
		$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);

		if ($http_code == 301 || $http_code == 302) {
			$matches = array();
			preg_match('/Location:(.*?)\n/', $header, $matches);
			$url = parse_url(trim(array_pop($matches)));
			//print_r($url);
			if (!$url)
			{
				//couldn't process the url to redirect to
				$curl_loops = 0;
				return $data;
			}
			$last_url = parse_url(curl_getinfo($ch, CURLINFO_EFFECTIVE_URL));
		/*	if (!$url['scheme'])
				$url['scheme'] = $last_url['scheme'];
			if (!$url['host'])
				$url['host'] = $last_url['host'];
			if (!$url['path'])
				$url['path'] = $last_url['path'];*/
			$new_url = $url['scheme'] . '://' . $url['host'] . $url['path'] . ($url['query']?'?'.$url['query']:'');
			$new_url = str_replace(":///","/",$new_url);
			
			if(substr($new_url,0,6)=="/aviso") {
				$new_url = "http://www.masoportunidades.com.ar$new_url";
			}
			
			curl_setopt($ch, CURLOPT_URL, $new_url);
		//	debug('Redirecting to', $new_url);

			return curl_redir_exec($ch);
		} else {
			$curl_loops=0;
			return $debbbb;
		}
	}

}
