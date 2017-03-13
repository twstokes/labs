<?php

//$url = 'http://labs.tannr.com/tailgate/output.html';
//$url = 'https://usscpromotions.com/southernliving/tailgate_party/widget';

$path = "/var/www/labs.tannr.com/html/tailgate/log";

$latest_ctime = 0;
$latest_filename = '';

$d = dir($path);
while (false !== ($entry = $d->read())) {
  $filepath = "{$path}/{$entry}";
  // could do also other checks than just checking whether the entry is a file
  if (is_file($filepath) && filectime($filepath) > $latest_ctime) {
      $latest_ctime = filectime($filepath);
      $latest_filename = $entry;
    }
  }

//echo $latest_filename;
//echo '<br />';

$doc = new DOMDocument();
$doc->loadHTMLFile('/var/www/labs.tannr.com/html/tailgate/log/'.$latest_filename);
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

echo '<!DOCTYPE html>';
echo '<head><title>Data</title></head>';
echo '<body>';
echo '<table>';
foreach($nodes as $node) {
  $styleText = $node->getAttribute("style");
  $voteNumber = substr($styleText, 7, -1);

  echo '<tr>';
  echo '<td>';
  echo array_shift($schoolNameArray);
  echo '</td>';
  echo '<td>';  
  echo $voteNumber;
  echo '<td />';
  echo '</tr>';
}

echo '</table>';
echo '</body>';
echo '</html>';
?>
