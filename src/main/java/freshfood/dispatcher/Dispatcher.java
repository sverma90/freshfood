package freshfood.dispatcher;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import freshfood.utils.MailUtilGmail;
/**
 * Servlet implementation class Dispatcher
 */
/**
 * Servlet implementation class Dispatcher
 */
public class Dispatcher extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Dispatcher() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		ServletContext sc = getServletContext();
		
		String url = "/confirmation.jsp";
		
		// get current action
		String action = request.getParameter("action");
		System.out.println(action);
        if (action.equals("confirm")) {
        	System.out.println("confirming!");
        	//HttpSession session = request.getSession(false);
        	url = "/confirmation.jsp"; 
        	
        	String name = request.getParameter("name");
        	String email = request.getParameter("email");
        	
        	//session.setAttribute("dbUserr", dbUser);
        	//System.out.println("inserted user");
        	
        	// send email to user
            String to = email;
            String from = "cshih14@gmail.com";
            String subject = "Confirmation of Fresh Foods Purchase";
            String body = "Dear " + name + ",\n\n"
                    + "Thanks for your purchase. We'll make sure to send "
                    + "you announcements about new products and promotions.\n"
                    + "Have a great day and thanks again!";
            boolean isBodyHTML = false;
            
            System.out.println(from);

            try {
            	System.out.println("trying send email");
                MailUtilGmail.sendMail(to, from, subject, body, isBodyHTML);
            } catch (MessagingException e) {
                String errorMessage
                        = "ERROR: Unable to send email... "
                        + "Check Tomcat logs for details.<br>"
                        + "NOTE: You may need to configure your system "
                        + "as described in chapter 14.<br>"
                        + "ERROR MESSAGE: " + e.getMessage();
                request.setAttribute("errorMessage", errorMessage);
                this.log(
                        "Unable to send email. \n"
                        + "Here is the email you tried to send: \n"
                        + "=====================================\n"
                        + "TO: " + email + "\n"
                        + "FROM: " + from + "\n"
                        + "SUBJECT: " + subject + "\n"
                        + "\n"
                        + body + "\n\n");
            }
        	
        }
		
        System.out.println(url);
        sc.getRequestDispatcher(url)
        .forward(request, response);
		
	}

}

