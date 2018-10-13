package webwork.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import com.sun.deploy.nativesandbox.comm.Request;

/**
 * Servlet implementation class JSP2Servlet
 */
@WebServlet("/JSP2Servlet")
public class JSP2Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * Formluardaten werden verarbeitet. Anschließend werden sie angezeigt.
	 * Damit dies auch für mehrere Requests funktioniert: Nutzung der Session
	 * @param request
	 * @param response
	 * @throws IOException 
	 * @throws ServletException 
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Sessionobjekt besorgen; wird aus dem Request geholt
		//Damit schickt der Client seine ID mit 
		HttpSession session = request.getSession();
		
		List<String> nachrichten = (List<String>) session.getAttribute("nachrichten");
		
		//Prüfen ob eine Liste mit Nachrichten angelegt wurde
		if(nachrichten == null) {
			// wenn keine Liste exisiert --> neue Liste (ArrayList) wird erzeugt
			nachrichten = new ArrayList<String>();
			//an das Sessionobjekt anfügen
			session.setAttribute("nachrichten", nachrichten);
		}
		
		//Nachricht vom Client holen
		String nachricht = request.getParameter("nachricht");
		
		//Prüfen der Nachricht
		if(nachricht != null && !nachricht.trim().isEmpty()) {
			//Nachricht nicht null & nicht leer (nachdem alle Leerzeichen mit trim entfernt -->
			//Nachricht an die Liste anfügen
			nachrichten.add(nachricht);
			//nachrichten.add(nachricht);
		}
		
		//um die Zuständigkeit der Darstellung an das JSP File zu übergeben
		//holt man ein RequestDispatcher, der beide Request/Response-Objekte an JSP weiterleitet
		//gibt die Zuständigkeit an JSP ab 
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("kontakt.jsp");
		requestDispatcher.forward(request, response);
		
	}
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JSP2Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

}
