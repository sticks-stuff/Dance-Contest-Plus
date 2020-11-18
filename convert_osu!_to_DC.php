<?php
	include("getid3/getid3.php");
	// $fileName = '1196084 Usada Pekora - Discommunication Alien.osz';
	$fileName = $_GET["fileName"];
	// $chart = 'Usada Pekora - Discommunication Alien (LLENN-) [Easy]';
	$chart = $_GET["chart"];
	echo $fileName;
	echo $chart;
	$file = "./tmp/" . $fileName;
	$zip = new ZipArchive;
	$res = $zip->open($file);
	$AudioLeadIn = 0;
	if ($res === TRUE) {
		$result = file('zip://' . realpath($file) . '#' . $chart . '.osu'); 
		$result_GC = file_get_contents('zip://' . realpath($file) . '#' . $chart . '.osu'); 
		$search  = array('AudioFilename', 'AudioLeadIn', 'Title', 'Artist', 'Creator', 'Mode');
		foreach($result as $line)
		{
			if(strposa($line, $search) !== false){
				$tempExplodeVar = explode(':', $line);
				echo '&' . trim($tempExplodeVar[0]) . '=' . trim(end($tempExplodeVar));
				if(trim($tempExplodeVar[0]) == 'AudioFilename')
				{
					if (!file_exists('./tmp/' . substr($fileName, 0, -4))) 
					{
						mkdir('./tmp/' . substr($fileName, 0, -4));
					}
					$zip->extractTo('./tmp/' . substr($fileName, 0, -4), trim(end($tempExplodeVar)));
					   $getID3 = new getID3;
					   $fileAnalyze = $getID3->analyze('./tmp/' . substr($fileName, 0, -4) . '/' . trim(end($tempExplodeVar)));
					   $playtime_seconds = $fileAnalyze['playtime_seconds'];
					   echo '&' . "playtime_seconds=" .$playtime_seconds;
					   
				}
				if(trim($tempExplodeVar[0]) == 'AudioLeadIn')
				{
					$AudioLeadIn = trim(end($tempExplodeVar));
				}
			}
		}
		
		$tempArray = explode('[HitObjects]', $result_GC);
		//print_r($tempArray);		
		//$str = explode('_', $tempArray[1]);
		$finalArray = explode('\n', $tempArray[1]);
		$noteData = trim($finalArray[0]);
		$separator = "\r\n";

		$numLists = interpret_numbers_list($noteData);
		// print_r($numLists[0][0]);
		handle_number_lists($numLists);
		// print_r($GLOBALS[0]);
		$outputdata = format_output_lines();
		// file_put_contents('output.txt', print_r($outputdata, true));
		echo '&notes=' . implode(',', $GLOBALS[0]);
		echo '&noteTimes=' . implode(',', $GLOBALS[1]);
		echo '&noteLengths=' . implode(',', $GLOBALS[2]);
		$zip->close($file);
	}
		
	function strposa($haystack, $needle, $offset=0) {
		if(!is_array($needle)) $needle = array($needle);
		foreach($needle as $query) {
			if(strpos($haystack, $query, $offset) !== false) return true; // stop on first true result
		}
		return false;
	}
	$GLOBALS = array(array(),array(),array());

	function write_to_line($line,$s) {
		$GLOBALS[$line][] = $s;
	}
	function format_output_lines() {
		global $GLOBALS;
		return implode(PHP_EOL, (array(implode(',', $GLOBALS[0]), implode(',', $GLOBALS[1]), implode(',', $GLOBALS[2]))));
	}

	function handle_first_number($num) {
		$result = floor(intval($num) / 128);
		switch ($result) {
			case 0:
				write_to_line(0, '0');
				break;
			case 1:
				write_to_line(0, '2');
				break;
			case 2:
				write_to_line(0, '3');
				break;
			case 3:
				write_to_line(0, '1');
				break;
		}
	}
	function handle_third_number($num) {
		write_to_line(1, strval($num + $AudioLeadIn));
	}
	function handle_fourth_and_fifth_number($third_num,$fourth_num,$sixth_num) {
		if (($fourth_num == 128)) {
			write_to_line(2, strval(($sixth_num - $third_num)));
		}
		else {
			write_to_line(2, '0');
		}
	}

	function handle_number_lists($numLists) {
		foreach($numLists as $numList) {
			handle_first_number($numList[0]);
			handle_third_number($numList[2]);
			handle_fourth_and_fifth_number($numList[2], $numList[3], $numList[5]);
		}
	}
		
	function interpret_numbers_list($nLists) {
		$returnInterp = array();
		foreach(preg_split("/((\r?\n)|(\r\n?))/", $nLists) as $line){
			array_push($returnInterp, explode(',', explode(':', $line)[0]));
		}
		return $returnInterp;
	}
?>