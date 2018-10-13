package beans;
import java.sql.*;

public class TischBean {
	
	private int tischnr = 0;
	private String tischBestellungen ="<h3>Bestellungen für Tisch "+tischnr+" anzeigen</h3>"; 
	private String sSql="SELECT bestellung.tischid, bestellung.id, speisen.name, speisen.zubereitungszeit, speisen.preis FROM bestellung INNER JOIN speisen ON bestellung.speisenid=speisen.id WHERE bestellung.tischid = ";
	 
	  public int getTischnr() {
	    return tischnr;
	  }
	 
	  public void setTischnr(int tischnr) {
	    this.tischnr = tischnr;
	    sSql += tischnr;
	  }
	  
	  public String getTischBestellungen() throws ClassNotFoundException, SQLException {
		  
		  String[] ueberschriftArray = {"Tischnr.", "Bestellnr.", "Name der Bestellung", "Zubereitungszeit", "Preis"};
		  if( null != sSql   && 0 < sSql.length() )
		  {
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
			      tischBestellungen += "<table border=1 cellspacing=0><tr>" ;
			      
			      //Tabellen-Überschriften
			      for( int i=0; i<n; i++ ) { 
			    	  tischBestellungen += "<th>"+ueberschriftArray[i]+"</th>";
			      }
				  
			      //Alle Bestellungen
			      while( result.next() ) {
			    	  tischBestellungen +="</tr><tr>";
				        for( int i=1; i<=n; i++ ) { //  erste Spalte mit 1 statt 0 in SQL
				        	tischBestellungen += "<td>" + result.getString( i ) + "</td>" ;
				        }
			      }
			      
			      tischBestellungen += "</tr></table><br><input type='button' name='rechErst' value='Rechnung erstellen'>";
				      
		    } finally {
		      try { if( null != result ) result.close(); } catch( Exception ex ) {/*ok*/}
		      try { if( null != statem ) statem.close(); } catch( Exception ex ) {/*ok*/}
		      try { if( null != conn ) conn.close(); } catch( Exception ex ) {/*ok*/}
		    }
		  }
		  return tischBestellungen;
	  }
}
