<?php

// script was put into cron tab for updates
// */1 * * * * /usr/bin/php -f /var/www/labs.tannr.com/html/tailgate/pushDB.php


$dateTime = date("Y-m-d H:i:s");

$link = mysql_connect('localhost', 'xxx', 'xxx') or die ("Couldn't connect: " . mysql_error());

mysql_select_db('labs_tailgate') or die ('Could not select database');

$url = 'https://usscpromotions.com/southernliving/tailgate_party/widget';
//$url = 'http://labs.tannr.com/tailgate/output.html';

$curl = curl_init($url);
curl_setopt($curl, CURLOPT_AUTOREFERER, true);
curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1 );
curl_setopt($curl, CURLOPT_TIMEOUT, 2 );                

$html = curl_exec( $curl );

$html = @mb_convert_encoding($html, 'HTML-ENTITIES', 'utf-8');   

curl_close( $curl );

$doc = new DOMDocument();
//echo $doc->saveHTML();
$doc->loadHTML($html);

$schoolNodes = $doc->getElementsByTagName('span');
// put school names into an array
$schoolNameArray[] = "";

foreach($schoolNodes as $node) {
  $schoolNameArray[] = $node->nodeValue;
}

$finder = new DomXPath($doc);
$classname="fill";
$nodes = $finder->query("//*[contains(@class, '$classname')]");

array_shift($schoolNameArray);

foreach($nodes as $node) {
  $styleText = $node->getAttribute("style");
  $voteNumberPerc = substr($styleText, 7, -1);
  $currentSchoolName = array_shift($schoolNameArray);

  $sql = "INSERT INTO data (name, perc, date) VALUES ('".$currentSchoolName."', '".$voteNumberPerc."', '".$dateTime."')";
  $result = mysql_query($sql) or die ('Query failed: ' . mysql_error());
}

mysql_close($link);

?>
