<%@page import="java.util.ArrayList"%>
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

<%@ page import = "java.sql.*" import = "java.util.*" isThreadSafe="false" %>

<%
 
  String sTable = "bestellung";
  String sSql = "SELECT id FROM bestellung WHERE tischid=1";
  
%>
<div class="container">
<h1>Pizzeria Toskana	Küche</h1>
<br>

<!-- Navigation -->
<ul class="nav nav-tabs">
    <li><a href="alleBestellungen.jsp">Alle Bestellungen</a></li>
    <li><a href="tischBestellungen.jsp">Bestellungen pro Tisch</a></li>
    <li class="active"><a href="rechnungen.jsp">Rechnungen</a></li>
</ul>

<h3>Alle Rechnungen</h3>


<%
  String[] ueberschriftArray = {"Rechnungsnr.", "Tischnr.", "Name der Bestellung", "Preis"};
  
    Connection conn = null;
    Statement  statem = null;
    Statement  statem1 = null;
    Statement  statem2 = null;
    ResultSet  result= null;
    ResultSet  result1= null;
    String bestellung = "";
    List<Integer> bestellungen = new ArrayList<>();
    try {
    	
    	// Verbindung aufbauen
	      Class.forName( "com.mysql.jdbc.Driver" );
	      conn = DriverManager.getConnection("jdbc:mysql://localhost/restaurantdb?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
	      
	      statem = conn.createStatement();
	      // AUFRUF DER SQL ABFRAGE
	      result = statem.executeQuery( sSql );
	      
	      ResultSetMetaData rsmd = result.getMetaData();
	      int n = rsmd.getColumnCount(); // Länge der Spalte
	      
	      out.println( "Das Sind alle Bestellungen die in die Rechnung sollen" );
	     
		    while( result.next() ) {
		        for( int i=1; i<=n; i++ ){  // Achtung: erste Spalte mit 1 statt 0
			    	bestellungen.add(result.getInt(i));
		        }
		        
		      }
		    out.println(bestellungen);
		    
		    
		 int rnr = 1;
		 int tischnr = 1;
		 String speise = "tomate";
		 double preis = 0.5;
		 
		    out.println( "<table border=1 cellspacing=0><tr>" );
	        out.println( "<th>hi</th>" );
	        out.println( "<th>hi</th>" );
		 for(int i=0; i< bestellungen.size(); i++){
			 int bestellid = bestellungen.get(i);
			 String sSql1 = "SELECT speisen.name, speisen.preis FROM bestellung INNER JOIN speisen ON bestellung.id = speisen.id WHERE bestellung.id=";
			 
			 sSql1 += bestellid;
			
			 statem1 = conn.createStatement();
		      // AUFRUF DER SQL ABFRAGE
		      result1 = statem1.executeQuery( sSql1 );
		      
		      ResultSetMetaData rsmd1 = result.getMetaData();
		      int n1 = rsmd1.getColumnCount(); // Länge der Spalte

		       
			    while( result1.next() ) {
			        out.println( "</tr><tr>" );
			        for( int k=1; k<=n1+1; k++ ){  // Achtung: erste Spalte mit 1 statt 0
			          out.println( "<td>" + result1.getString( k ) + "</td>" );
			          
			        }
			        
			       /* String statement = "INSERT INTO rechnungen (rechnungsnr, tischid, speisenname, speisenpreis) VALUES (";
			        statement += rnr;
			        statement += ",";
			        statement += tischnr;
			        statement += ",";
			        statement += speise;
			        statement += ",";
			        statement += preis;
			        statement += ")";
			        statem2 = conn.createStatement();
				    statem2.executeUpdate(statement);*/
			      }
			      out.println( "</tr>" );
			      
		 }
		 out.println("</table>");
    } finally {
      try { if( null != result ) result.close(); } catch( Exception ex ) {/*ok*/}
      try { if( null != statem ) statem.close(); } catch( Exception ex ) {/*ok*/}
      try { if( null != conn ) conn.close(); } catch( Exception ex ) {/*ok*/}
    }

%>
</div>
</body>
</html>