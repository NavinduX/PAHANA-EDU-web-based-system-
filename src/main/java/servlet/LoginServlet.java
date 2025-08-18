package servlet;

import services.UserService;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserService userService = new UserService();
        boolean isAuthenticated = false;
        try {
            isAuthenticated = userService.authenticateUser(username, password);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        if (isAuthenticated) {
            HttpSession session = request.getSession();
            String role = null;
            try {
                role = userService.getUserRole(username);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            if (role == null) {
                role = "USER";
            }
            User user = new User(0, username, null, role);
            session.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/home.jsp");
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}