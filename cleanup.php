<?php
$fileName = $_GET["file"];
array_map('unlink', glob('./tmp/' . substr($fileName, 0, -4) . "/*.*"));
rmdir('./tmp/' . substr($fileName, 0, -4));
unlink('./tmp/' . $fileName);
?> 