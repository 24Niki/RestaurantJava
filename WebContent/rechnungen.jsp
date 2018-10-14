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
String sSql   = "";
int tischid = 0;
String id ="";
if( request.getParameterNames().hasMoreElements() == true ){
	// Bekomme TischID aus Input-Feld
	id = request.getParameter( "prmID" );
	tischid = Integer.parseInt(id);
 
    sSql = "SELECT id FROM bestellung WHERE tischid= " + tischid;
}
%>

<div class="container">
<h1>Pizzeria Toskana Küche</h1>
<br>
<br>

<!-- Navigation -->
<ul class="nav nav-tabs">
    <li><a href="alleBestellungen.jsp">Alle Bestellungen</a></li>
    <li><a href="tischBestellungen.jsp">Bestellungen pro Tisch</a></li>
    <li class="active"><a href="rechnungen.jsp">Rechnungen</a></li>
    <li><a href="loeschen.jsp">Bestellungen löschen</a></li>
</ul>

<h3>Rechnung</h3>
<br>
Neue Rechnung anlegen für:
<br>

<form method="post"><pre>
	Tisch-Nummer <input type="number" name="prmID" size=60>
				 <br>
	             <input type="submit" name="submit" value="Rechnunge erstellen">
</pre></form>
<br>

<%
    String[] ueberschriftArray = {"Name der Speise", "Preis"};
  
    Connection conn = null;
    
    Statement  statem = null;
    Statement  statem1 = null;
    Statement  statem2 = null;
    
    ResultSet  result= null;
    ResultSet  result1= null;
    ResultSet  result2= null;
    
    String bestellung = "";
    
    List<Integer> bestellungen = new ArrayList<>();
    List<Double> preise = new ArrayList<>();
    
    // Falls etwas im Input-Feld eingegeben wurde...
    if( request.getParameterNames().hasMoreElements() == true
    	      && null != sSql   && 0 < sSql.length() )
    	  {
	    try {
	    	
	    	// Verbindung aufbauen
		      Class.forName( "com.mysql.jdbc.Driver" );
		      conn = DriverManager.getConnection("jdbc:mysql://localhost/restaurantdb?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
		      
		      // Statement 0 --> Alle Bestellids herausfinden
		      statem = conn.createStatement();
		      // AUFRUF DER SQL ABFRAGE
		      result = statem.executeQuery( sSql );
		      
		      ResultSetMetaData rsmd = result.getMetaData();
		      int n = rsmd.getColumnCount(); // Länge der Spalte
		     
			  while( result.next() ) {
			        for( int i=1; i<=n; i++ ){  // Achtung: erste Spalte mit 1 statt 0
				    	bestellungen.add(result.getInt(i));
			        }
			  }
			  
			  out.println("<h4>Neue Rechnung für Tisch " + tischid + "</h4>");
			    
			  out.println( "<table border=1 cellspacing=0><tr>" );
			  
			  // Überschriften der Tabelle
			  for(int j=0; j< ueberschriftArray.length; j++){
		     	 out.println( "<th>"+ueberschriftArray[j]+"</th>" );
			  }
		        
		      
		     //Für Jede Bestellid -> gib mir Name und Preis der Speise 
			 for(int i=0; i< bestellungen.size(); i++){
				 int bestellid = bestellungen.get(i);
				 
				 String sSql1 = "SELECT speisen.name, speisen.preis FROM bestellung INNER JOIN speisen ON bestellung.id = speisen.id WHERE bestellung.id=";
				 sSql1 += bestellid;
				
				 statem1 = conn.createStatement();
			      // AUFRUF DER SQL ABFRAGE
			     result1 = statem1.executeQuery( sSql1 );
			      
			     ResultSetMetaData rsmd1 = result1.getMetaData();
			     int n1 = rsmd1.getColumnCount(); // Länge der Spalte
	
			     while( result1.next() ) {
				    out.println( "</tr><tr>" );
				    for( int k=1; k<=n1; k++ ){  // Achtung: erste Spalte mit 1 statt 0
				          out.println( "<td>" + result1.getString( k ) + "</td>" );
				    } // end for
				 }// end while
				 out.println( "</tr>" );      
			 }// end for
			 out.println("</table>");
					 
			 
			//Für jede Bestellung -> Gibt mir den Preis um den Rechnungsbetrag zu berechnen.	 
			 double preis= 0;
			 for(int i=0; i< bestellungen.size(); i++){
				 int bestellid = bestellungen.get(i);
				 
				 String sSql2 = "SELECT speisen.preis FROM bestellung INNER JOIN speisen ON bestellung.id = speisen.id WHERE bestellung.id=";
				 sSql2 += bestellid;
				
				 statem2 = conn.createStatement();
			      // AUFRUF DER SQL ABFRAGE
			     result2 = statem2.executeQuery( sSql2 );
			      
			     ResultSetMetaData rsmd2 = result2.getMetaData();
			     int n2 = rsmd2.getColumnCount(); // Länge der Spalte
	
			     while( result2.next() ) {
				        for( int l=1; l<=n2; l++ ){  // Achtung: erste Spalte mit 1 statt 0
					    	preise.add(result2.getDouble(l));
				        }//end for
				 }// end while
			 }// end for
			 
			 // Addiere bitte alle Preise zusammen
			 for( int l=0; l<preise.size(); l++ ){
		    	 preis += preise.get(l);
		      }  
			 out.println("<br>");
			 out.println("Gesamt:             ");
		     out.println(preis);
		     out.println(" Euro");
			 
	    } finally {
	      try { if( null != result ) result.close(); } catch( Exception ex ) {/*ok*/}
	      try { if( null != statem ) statem.close(); } catch( Exception ex ) {/*ok*/}
	      
	      try { if( null != result1 ) result1.close(); } catch( Exception ex ) {/*ok*/}
	      try { if( null != statem1 ) statem1.close(); } catch( Exception ex ) {/*ok*/}
	      
	      try { if( null != result2 ) result2.close(); } catch( Exception ex ) {/*ok*/}
	      try { if( null != statem2 ) statem2.close(); } catch( Exception ex ) {/*ok*/}
	      
	      try { if( null != conn ) conn.close(); } catch( Exception ex ) {/*ok*/}
	    }
   } // End if
 %>    
 	  
   

</div>
</body>
</html>