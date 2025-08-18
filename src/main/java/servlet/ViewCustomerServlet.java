package servlet;

import services.CustomerService;
import model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/viewCustomer")
public class ViewCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CustomerService ser = new CustomerService();
        try {
            List<Customer> customers = ser.getAllCustomers();
            request.setAttribute("customers", customers);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database driver not found.");
        }
        request.getRequestDispatcher("viewCustomer.jsp").forward(request, response);
    }
}