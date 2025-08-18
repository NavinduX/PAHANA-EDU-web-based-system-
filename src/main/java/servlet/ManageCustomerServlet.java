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

@WebServlet("/manageCustomers")
public class ManageCustomerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CustomerService ser = new CustomerService();

        try {
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                String address = request.getParameter("address");
                String telephone = request.getParameter("telephone");
                Customer customer = new Customer(0, name, address, telephone);
                boolean success = ser.addCustomer(customer);
                if (success) {
                    request.setAttribute("message", "Customer added successfully!");
                } else {
                    request.setAttribute("error", "Failed to add customer.");
                }
            } else if ("update".equals(action)) {
                int accountNumber = Integer.parseInt(request.getParameter("accountNumber"));
                String name = request.getParameter("name");
                String address = request.getParameter("address");
                String telephone = request.getParameter("telephone");
                Customer customer = new Customer(accountNumber, name, address, telephone);
                boolean success = ser.updateCustomer(customer);
                if (success) {
                    request.setAttribute("message", "Customer updated successfully!");
                } else {
                    request.setAttribute("error", "Failed to update customer.");
                }
            } else if ("delete".equals(action)) {
                int accountNo = Integer.parseInt(request.getParameter("accountNo"));
                boolean success = ser.deleteCustomer(accountNo);
                if (success) {
                    request.setAttribute("message", "Customer deleted successfully!");
                } else {
                    request.setAttribute("error", "Failed to delete customer.");
                }
            }
            List<Customer> customers = ser.getAllCustomers();
            request.setAttribute("customers", customers);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database driver not found.");
        }
        request.getRequestDispatcher("manageCustomer.jsp").forward(request, response);
    }

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
        request.getRequestDispatcher("manageCustomer.jsp").forward(request, response);
    }
}