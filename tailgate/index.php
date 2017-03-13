<!DOCTYPE html>
<head>
<title>South's Best Tailgate</title>
<link rel="stylesheet" type="text/css" href="main.css" />
<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="js/flot/excanvas.min.js"></script><![endif]-->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script type="text/javascript" src="js/flot/jquery.flot.js"></script>
<script type="text/javascript">
    // needed for IE
    $.ajaxSetup({ cache: false });
</script>
<script type="text/javascript" src="js/include.js"></script>
</head>
<body>
  <h5>Note: This project is no longer active and is only available for historical purposes. It probably won't function as designed.</h5>
  <div id="container">
    <div id="graph"><h2 style="padding-right: 300px;">Please wait. Loading...</h2></div>
    <div id="viewOptions">
      <ul>
        <li><a class="interval" intvl="10" href="#">ten minutes</a></li>
        <li><a class="interval" intvl="30" href="#">thirty minutes</a></li>
        <li><a class="interval" intvl="60" href="#">one hour</a></li>
        <li><a class="interval" intvl="300" href="#">five hours</a></li>
        <li><a class="interval" intvl="1440" href="#">one day</a></li>
	<li><a class="interval" intvl="7200" href="#">five days</a></li>
        <li><a id="zoomOut" href="#">out</a> | <a id="zoomIn" href="#">in</a></li>
      </ul>
      <span id="info">auto updates every minute</span><br />
      <span id="timeText">last updated: </span><span id="timeStamp"></span>
    </div>
  </div>
</body>
</html>


