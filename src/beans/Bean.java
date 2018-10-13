package beans;

import java.sql.*;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

public class Bean {
	
	 private String alleBestellungen = "<h3>Alle Bestellungen</h3><br>";
	 
	 // Gibt in der Tabelle alle Bestellungen für alle Tische aus
	 String sSql = "SELECT bestellung.id, bestellung.tischid, speisen.name, speisen.zubereitungszeit, speisen.preis FROM bestellung INNER JOIN speisen ON bestellung.speisenid=speisen.id ";
	 
	 // GET alle Bestellungen
	 public String getAlleBestellungen() throws ClassNotFoundException, SQLException {
		  String[] ueberschriftArray = {"Bestellnr.", "Tischnr.", "Name der Bestellung", "Zubereitungszeit", "Preis"};
		  
		    Connection conn = null;
		    Statement  statem = null;
		    ResultSet  result= null;
		    try {
		    	
		    	  // Verbindung aufbauen zum JDBC
			      Class.forName( "com.mysql.jdbc.Driver" );
			      
			      // Verbindung aufbauen zur Datenbank
			      conn = DriverManager.getConnection("jdbc:mysql://localhost/restaurantdb?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
			      
			      statem = conn.createStatement();
			      
			      // Ausführung der SQL-Datenbankabfrage
			      result = statem.executeQuery( sSql );
			      
			      ResultSetMetaData rsmd = result.getMetaData();
			      int n = rsmd.getColumnCount(); // Anzahl der Spalten
			      
			      
			      // Ausgabe erstellen: Tabelle mit allen Bestellungen
			      alleBestellungen += "<table border=1 cellspacing=0><tr>" ;
			      
			      //Tabellen-Überschriften
			      for( int i=0; i<n; i++ ) { 
			    	  alleBestellungen += "<th>"+ueberschriftArray[i]+"</th>";
			      }
				  
			      //Alle Bestellungen
			      while( result.next() ) {
			    	  alleBestellungen +="</tr><tr>";
				        for( int i=1; i<=n; i++ ) { //  erste Spalte mit 1 statt 0 in SQL
				        	alleBestellungen += "<td>" + result.getString( i ) + "</td>" ;
				        }
			      }
			      alleBestellungen += "</tr></table>";
			      
		    } finally {
		      try { if( null != result ) result.close(); } catch( Exception ex ) {/*ok*/}
		      try { if( null != statem ) statem.close(); } catch( Exception ex ) {/*ok*/}
		      try { if( null != conn ) conn.close(); } catch( Exception ex ) {/*ok*/}
		    }
		    
	    return alleBestellungen;
	  }
	 
}