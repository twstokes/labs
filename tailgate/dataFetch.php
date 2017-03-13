<?php

$link = mysql_connect('localhost', 'xxx', 'xxx') or die ("Couldn't connect: " . mysql_error());

mysql_select_db('labs_tailgate') or die ('Could not select database');

// get latest time
$sql = "SELECT date FROM data ORDER BY date desc LIMIT 1";
$result = mysql_query($sql) or die ('Query failed: ' . mysql_error());

$latestTimeArray = mysql_fetch_row($result);
$latestTime = $latestTimeArray[0];

$zoom = 10;

if(!empty($_GET['zoom'])) {
  if(is_numeric($_GET['zoom'])) {
    $zoom = $_GET['zoom'];  
  }
}

if($zoom < 3) {
  $zoom = 3;
}

if($zoom > 7200) {
//  $zoom = 7200;
}

// generate array with data for each school
// **WARNING - THIS COULD GET LARGE ***
//  $sql = "SELECT name, perc, date FROM data WHERE date > NOW() - INTERVAL ".$zoom." MINUTE AND (name LIKE 'Clemson University' OR name LIKE 'University of Mississippi') ORDER BY date DESC";
//$sql = "SELECT name, perc, date FROM data WHERE date > NOW() - INTERVAL ".$zoom." MINUTE ORDER BY date DESC";
  $sql = "SELECT name, perc, date FROM data WHERE date < '2012-10-01' - INTERVAL ".$zoom." MINUTE AND (name LIKE 'Clemson University' OR name LIKE 'University of Mississippi') ORDER BY date DESC";
  $result = mysql_query($sql) or die ('Query failed: ' . mysql_error());

  while($row = mysql_fetch_assoc($result)) {

    unset($schoolColor);

    $perc = substr($row['perc'], 0, -1);
    $perc = number_format($perc, 3);
    $time = (strtotime($row['date'])-14400) * 1000;

    $schoolName = $row['name'];

    if($schoolName == 'Clemson University') {
      $schoolColor = "#F66733";
    } elseif ($schoolName == 'University of Mississippi') {
      $schoolColor = "#30368B";
    }


    $schoolData[$row['name']]['label'] = $row['name'];
    $schoolData[$row['name']]['data'][] = array($time, $perc);
    if(!empty($schoolColor)) {
      $schoolData[$row['name']]['color'] = $schoolColor;
    }

  }

// now that we have all school data clustered, strip down the array one level
// so we don't have to do anything on the javascript side

$x = 0;

foreach($schoolData as $school) {
//  if($x > 1) break;
  $returnArray[] = $school;
  $x++;
}



echo json_encode($returnArray);

mysql_close($link);

?>
