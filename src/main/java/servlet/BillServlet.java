package servlet;

import services.BillService;
import services.CustomerService;
import services.ItemService;
import model.Bill;
import model.BillItem;
import model.Customer;
import model.Item;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/calculateBill")
public class BillServlet extends HttpServlet {
    private static final double RATE_PER_UNIT = 10.0;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int accountNumber = Integer.parseInt(request.getParameter("accountNumber"));
        CustomerService customerService = new CustomerService();
        Customer customer = null;
        ItemService itemService = new ItemService();
        List<Item> items = null;
        try {
            customer = customerService.getCustomerByAccountNo(accountNumber);
            items = itemService.getAllItems();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database driver not found.");
        }
        List<BillItem> billItems = new ArrayList<>();
        double totalAmount = 0.0;
        for (Item item : items) {
            String quantityParam = request.getParameter("quantity_" + item.getItemId());
            int quantity = 0;
            if (quantityParam != null && !quantityParam.isEmpty()) {
                try {
                    quantity = Integer.parseInt(quantityParam);
                } catch (NumberFormatException e) {
                    quantity = 0;
                }
            }
            if (quantity > 0) {
                double itemTotal = quantity * item.getPrice();
                totalAmount += itemTotal;
                BillItem billItem = new BillItem(0, 0, item.getItemId(), quantity, item);
                billItems.add(billItem);
            }
        }
        if (customer != null && !billItems.isEmpty()) {
            Bill bill = new Bill(0, accountNumber, totalAmount, new Date(), billItems);
            BillService billService = new BillService();
            boolean success = false;
            try {
                success = billService.addBill(bill);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                request.setAttribute("error", "Database driver not found.");
            }
            if (success) {
                request.setAttribute("message", "Bill calculated and saved successfully!");
                request.setAttribute("bill", bill);
                request.setAttribute("customer", customer);
                // Always show all bills in the bill list
                List<Bill> billList = null;
                try {
                    billList = billService.getAllBills();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                request.setAttribute("billList", billList);
            } else {
                request.setAttribute("error", "Failed to save bill.");
            }
        } else if (customer == null) {
            request.setAttribute("error", "Customer not found.");
        } else {
            request.setAttribute("error", "Please select at least one item with quantity greater than zero.");
        }
        CustomerService customerService2 = new CustomerService();
        List<Customer> customers = null;
        try {
            customers = customerService2.getAllCustomers();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("calculateBill.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CustomerService customerService = new CustomerService();
        List<Customer> customers = null;
        try {
            customers = customerService.getAllCustomers();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        request.setAttribute("customers", customers);
        // Always show all bills in the bill list
        BillService billService = new BillService();
        List<Bill> billList = null;
        try {
            billList = billService.getAllBills();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        request.setAttribute("billList", billList);
        request.getRequestDispatcher("calculateBill.jsp").forward(request, response);
    }
}