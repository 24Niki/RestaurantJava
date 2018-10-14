<html>
<head>
  <title>Küche</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<%@ page import ="java.sql.*" %>

<!-- Referenz auf die Java-Bean -->
<jsp:useBean id="myBean" class="beans.Bean"/>

	<div class="container">
		<h1>Pizzeria Toskana Küche</h1>
		<br>
		<br>
		
		<!-- Navigation -->
		<ul class="nav nav-tabs">
		    <li class="active"><a href="alleBestellungen.jsp">Alle Bestellungen</a></li>
		    <li><a href="tischBestellungen.jsp">Bestellungen pro Tisch</a></li>
		    <li><a href="rechnungen.jsp">Rechnungen</a></li>
		    <li><a href="loeschen.jsp">Bestellungen löschen</a></li>
		 </ul>
		
		<!-- Lade die Tabelle mit allen Bestellungen aus der Java-Bean -->
		<jsp:getProperty name="myBean" property="alleBestellungen" />
		
	</div> <!-- End Container -->
	
</body>
</html>