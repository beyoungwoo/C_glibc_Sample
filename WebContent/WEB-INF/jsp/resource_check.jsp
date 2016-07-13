<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset='utf-8'>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/menu_styles.css">
	<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

   <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawCpuChart);
      google.charts.setOnLoadCallback(drawMemoryChart);
      google.charts.setOnLoadCallback(drawDiskChart);

      function drawCpuChart() {

        var data = google.visualization.arrayToDataTable([
          ['CPU', 'Usage'],
          ['idle',     90],
          ['used',     10]
        ]);

        var options = {
          title: 'CPU USAGE'
        };

        var chart = new google.visualization.PieChart(document.getElementById('cpuchart'));

        chart.draw(data, options);
      }
      function drawMemoryChart() {

        var data = google.visualization.arrayToDataTable([
          ['MEMORY', 'Usage'],
          ['free',     70],
          ['used',     30]
        ]);

        var options = {
          title: 'Memory USAGE'
        };

        var chart = new google.visualization.PieChart(document.getElementById('memorychart'));

        chart.draw(data, options);
      }
      function drawDiskChart() {

        var data = google.visualization.arrayToDataTable([
          ['DISK', 'Usage'],
          ['free',     80],
          ['dev1',     20]
        ]);

        var options = {
          title: 'DISK USAGE'
        };

        var chart = new google.visualization.PieChart(document.getElementById('diskchart'));

        chart.draw(data, options);
      }
 
    </script>

</head>

<body>
<!--
	<jsp:include page="top_menu.jsp" flush="false" />
-->
    <table class="columns">
        <tr>
        <td><div id="cpuchart" style="width:250px; height: 250px; border : 1px solid #ccc"></div></td>
        <td><div id="memorychart" style="width:250px; height: 250px; border: 1px solid #ccc"></div></td>
        <td><div id="diskchart" style="width:250px; height: 250px; border : 1px solid #ccc"></div></td>
         </tr>
    </table>
 
</body>
</html>