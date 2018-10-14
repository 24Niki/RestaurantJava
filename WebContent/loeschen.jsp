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

<%@ page import = "java.sql.*"  %>
<!-- Referenz auf die Java-Bean -->
<%
  String sSql   = "";
  int tischid = 0;
  String id ="";
  if( request.getParameterNames().hasMoreElements() == true )
  {
	// Bekomme TischID aus Input-Feld
	id = request.getParameter( "prmID" );
	tischid = Integer.parseInt(id);
	
    sSql = "DELETE FROM bestellung WHERE bestellung.tischid = " + tischid;
  }
  
  
%>

<div class="container">
<h1>Pizzeria Toskana Küche</h1>
<br>
<br>

<!-- Navigation -->
<ul class="nav nav-tabs">
    <li ><a href="alleBestellungen.jsp">Alle Bestellungen</a></li>
    <li><a href="tischBestellungen.jsp">Bestellungen pro Tisch</a></li>
    <li><a href="rechnungen.jsp">Rechnungen</a></li>
    <li class="active"><a href="loeschen.jsp">Bestellungen löschen</a></li>
  </ul>

<h3>Bestellungen löschen</h3>

<p>Wählen Sie aus, für welchen Tisch Sie die Bestellungen löschen möchten.</p>
<form method="post"><pre>

	Tisch-Nummer <input type="number" name="prmID" size=60>
				 <br>
	             <input type="submit" name="submit" value="Bestellungen löschen">
</pre></form>



<%
  String[] ueberschriftArray = {"Tischnr.", "Bestellnr.", "Name der Bestellung", "Zubereitungszeit", "Preis"};

	Connection conn = null;
	Statement  statem = null;
	
  if( request.getParameterNames().hasMoreElements() == true
      && null != sSql   && 0 < sSql.length() )
  {
    try {
    	
    	// Verbindung aufbauen
	      Class.forName( "com.mysql.jdbc.Driver" );
	      conn = DriverManager.getConnection("jdbc:mysql://localhost/restaurantdb?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
	      
	      statem = conn.createStatement();
	      boolean y = statem.execute( sSql );
	    	 if(y == false){
	    	 out.println("Bestätigung: Bestellungen wurden gelöscht");
	    	
	    	 }
	      
	      
    } finally {
      try { if( null != statem ) statem.close(); } catch( Exception ex ) {/*ok*/}
      try { if( null != conn ) conn.close(); } catch( Exception ex ) {/*ok*/}
    }
  }
%>
</div>

</body>
</html>