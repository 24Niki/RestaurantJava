<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- um Java-List verwenden zu können, Import! -->
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Formularverarbeitung</title>
</head>
<body>
	<h2>Kontaktformular!</h2>

	<!-- Formular zusammenstellen -->
	<form method="POST" action="JSP2Servlet">

		<!-- Formular soll Daten mit POST abschicken -->
		<!-- action: Ziel hier: Servlet -->
		<strong>Ihre Nachricht an uns:</strong><br />
		<textarea name="nachricht"></textarea>
		<input type="submit" value="Absenden" />
	</form>

	<!-- Nachricht von Client anzeigen -->


	<!--Liste mit aktueller Nachricht holen  -->
	<%
		List<String> nachrichten = (List<String>) session.getAttribute("nachrichten");

		//prüfen ob Liste befüllt ist
		if (nachrichten == null) {
	%>
	<br />
	<strong> aktuell wurde keine Nachricht gesendet </strong>
	<br />
	<%
		} else {
	%>
	<table>
		<%
			for (String nachricht : nachrichten) {
		%>
		<tr>
			<td><%=nachricht%></td>
		</tr>
		<%
			}
		%>
	</table>
	<%
		}
	%>

</body>
</html>