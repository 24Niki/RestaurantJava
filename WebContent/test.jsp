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
	
	<%@page contentType="text/html" pageEncoding="UTF-8"%>
	<jsp:useBean id="tischBean" class="beans.TischBean"/>
	
	<% 
	int tischid = 0;
	if( request.getParameterNames().hasMoreElements() == true )
	  {
		// Bekomme TischID aus Input-Feld
		String id = request.getParameter( "prmID" );
		 tischid = Integer.parseInt(id);
		 tischBean.getTischBestellungen();
		 
	  } 
	%>
	
	<jsp:setProperty name="tischBean" property="tischnr" value="${tischid}"/>
	<div class="container">
		<h1>Pizzeria Toskana Küche</h1>
		<br>
		
		<!-- Navigation -->
		<ul class="nav nav-tabs">
		    <li ><a href="alleBestellungen.jsp">Alle Bestellungen</a></li>
		    <li class="active"><a href="tischBestellungen.jsp">Bestellungen pro Tisch</a></li>
		    <li><a href="rechnungen.jsp">Rechnungen</a></li>
		 </ul>
		
		<form method="post"><pre>
			Tisch-Nummer <input type="number" name="prmID" size=60>
						 <br>
			             <input type="submit" name="submit" value="Bestellungen anzeigen">
		</pre></form>
	    
    <jsp:getProperty name="tischBean" property="tischnr" />
    <jsp:getProperty name="tischBean" property="tischBestellungen" />
    </div>
  </body>
</html>