$(document).ready(function() {

    function getTimeStamp() {
      var d = new Date();

      var hour = d.getHours();
      if(hour < 10) {
        hour = '0' + hour;
      }

      var minute = d.getMinutes();
      if(minute < 10) {
        minute = '0' + minute;
      }

      var second = d.getSeconds();
      if(second < 10) {
        second = '0' + second;
      }

      var timeStamp = hour + ":" + minute + ":" + second;
      return timeStamp;
    }

    $(".interval").click(function() {
      getHash['zoom'] = $(this).attr('intvl');
      updateGraph();
    });

    $("#zoomIn").click(function() {
      if(getHash['zoom'] > 3) {
        getHash['zoom'] /= 1.25;
        updateGraph();
      }
    });

    $("#zoomOut").click(function() {
     // if(getHash['zoom'] < 7200) {
        getHash['zoom'] *= 1.25;
        updateGraph();
    //  }
    });

    function graphAjax() {

      return $.ajax({
        url: 'dataFetch.php',
        dataType: 'json',
        data: getHash,
      });
    }

    function updateGraph() {
      graphPromise = graphAjax();
      graphPromise.success(function(data) {
      plot.setData(data);
      plot.setupGrid();
      plot.draw();
      $("#timeStamp").html(getTimeStamp());
    });

    }

    var getHash = {};
    getHash['zoom'] = 2880;


    var graphOptions = {
      xaxis: {
      mode: "time",
      timeformat: "%m/%d %h:%M",
      },
      yaxis: {
        max: 100
      },
      legend: {
        position: "nw"
      },
      series: {
        lines: {show: true},
      },
    }

    var graphPromise = graphAjax();
    var plot;

    $("#timeStamp").html(getTimeStamp());

    graphPromise.success(function(data) {
      plot = $.plot($("#graph"), data, graphOptions);
    });

    setInterval(updateGraph, 60000);

});
