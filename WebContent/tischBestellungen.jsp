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
	int index = 0;
  String sSql   = "";
  int tischid = 0;
  String id ="";
  if( request.getParameterNames().hasMoreElements() == true )
  {
	// Bekomme TischID aus Input-Feld
	id = request.getParameter( "prmID" );
	tischid = Integer.parseInt(id);
	
    sSql = "SELECT bestellung.tischid, bestellung.id, speisen.name, speisen.zubereitungszeit, speisen.preis FROM bestellung INNER JOIN speisen ON bestellung.speisenid=speisen.id WHERE bestellung.tischid = " + tischid;
  }
  
  
%>
<div class="container">
<h1>Pizzeria Toskana Küche</h1>
<br>

<!-- Navigation -->
<ul class="nav nav-tabs">
    <li ><a href="alleBestellungen.jsp">Alle Bestellungen</a></li>
    <li class="active"><a href="tischBestellungen.jsp">Bestellungen pro Tisch</a></li>
    <li><a href="rechnungen.jsp">Rechnungen</a></li>
  </ul>

<h3>Bestellungen für Tisch anzeigen</h3>


<form method="post"><pre>

	Tisch-Nummer <input type="number" name="prmID" size=60>
				 <br>
	             <input type="submit" name="submit" value="Bestellungen anzeigen">
</pre></form>



<%
  String[] ueberschriftArray = {"Tischnr.", "Bestellnr.", "Name der Bestellung", "Zubereitungszeit", "Preis"};

	Connection conn = null;
	Statement  statem = null;
	ResultSet  result= null;
  if( request.getParameterNames().hasMoreElements() == true
      && null != sSql   && 0 < sSql.length() )
  {
    try {
    	
    	// Verbindung aufbauen
	      Class.forName( "com.mysql.jdbc.Driver" );
	      conn = DriverManager.getConnection("jdbc:mysql://localhost/restaurantdb?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
	      
	      statem = conn.createStatement();
	      result = statem.executeQuery( sSql );
	      
	      ResultSetMetaData rsmd = result.getMetaData();
	      int n = rsmd.getColumnCount(); // Länge der Spalte
	      
	      out.println( "<table border=1 cellspacing=0><tr>" );
	      for( int i=0; i<n; i++ )   
	        out.println( "<th>"+ueberschriftArray[i]+"</th>" );
		    while( result.next() ) {
		        out.println( "</tr><tr>" );
		        for( int i=1; i<=n; i++ )  // Achtung: erste Spalte mit 1 statt 0
		          out.println( "<td>" + result.getString( i ) + "</td>" );
		      }
		      out.println( "</tr></table>" );
    } finally {
      try { if( null != result ) result.close(); } catch( Exception ex ) {/*ok*/}
      try { if( null != statem ) statem.close(); } catch( Exception ex ) {/*ok*/}
      try { if( null != conn ) conn.close(); } catch( Exception ex ) {/*ok*/}
    }
  }
%>
</div>

</body>
</html>