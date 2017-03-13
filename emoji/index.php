<?php

$requestArray = explode("/", $_GET['request']);

echo "Welcome to my page about ";

if(urlencode($requestArray[0]) == '%F0%9F%90%A8') {
 echo 'koalas';
}

echo ' eating ';

if(urlencode($requestArray[1]) == '%F0%9F%8D%94') {
 echo "burgers!\n";
}

?>
