package servlet;

import services.CustomerService;
import model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/editCustomer")
public class EditCustomerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CustomerService service = new CustomerService();

        if ("search".equals(action)) {
            try {
                int accountNumber = Integer.parseInt(request.getParameter("accountNumber"));
                Customer customer = service.getCustomerByAccountNo(accountNumber);
                if (customer != null) {
                    request.setAttribute("customer", customer);
                } else {
                    request.setAttribute("error", "Customer not found.");
                }
                request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                request.setAttribute("error", "Database driver not found.");
                request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
            }
        } else if ("update".equals(action)) {
            try {
                int accountNumber = Integer.parseInt(request.getParameter("accountNumber"));
                String name = request.getParameter("name");
                String address = request.getParameter("address");
                String telephone = request.getParameter("telephone");
                Customer customer = new Customer(accountNumber, name, address, telephone);
                boolean success = service.updateCustomer(customer);
                if (success) {
                    request.setAttribute("message", "Customer updated successfully!");
                    request.setAttribute("customer", customer);
                } else {
                    request.setAttribute("error", "Failed to update customer.");
                    request.setAttribute("customer", customer);
                }
                request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                request.setAttribute("error", "Database driver not found.");
                request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
    }
}