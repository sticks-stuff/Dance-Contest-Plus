<?php
	
	//$download_url = "https://bloodcat.com/osu/s/244796"; 
	$download_url = $_GET["download_url"];
	if(substr($download_url,0,25) != "https://beatconnect.io/b/")
	{
		echo "Not an osu! url!";
	} else {
		$headers = get_headers($download_url,true);
		$headers = array_combine(array_map("strtolower",array_keys($headers)),$headers);
		$fileName = isset($headers['content-disposition']) ? strstr($headers['content-disposition'], "=") : null ;
		$fileName = trim($fileName,"=\"'");
		$fileName = (explode('";', $fileName)[0]);
		$file = "./tmp/" . urldecode($fileName);
		$script = basename($_SERVER['PHP_SELF']);

	// download the file 
		file_put_contents($file, fopen($download_url, 'r'));
		echo '&fileName=' . urldecode($fileName);
		$zip = new ZipArchive;
		$res = $zip->open($file);
		if ($res === TRUE) {
			$charts = array();
			echo '&charts=';
			for( $i = 0; $i < $zip->numFiles; $i++ ){ 
				$stat = $zip->statIndex( $i ); 
				if (substr($stat['name'], -4) == '.osu'){
						echo ( basename( $stat['name'] )); 
						array_push($charts, basename( $stat['name'] ));
					}
				}
		}
	}
?>