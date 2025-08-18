package servlet;

import services.ItemService;
import model.Item;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/manageItems")
public class ItemServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        ItemService ser = new ItemService();

        try {
            if ("add".equals(action)) {
                String itemName = request.getParameter("itemName");
                double price = Double.parseDouble(request.getParameter("price"));
                String description = request.getParameter("description");
                Item item = new Item(0, itemName, price, description);
                boolean success = ser.addItem(item);
                if (success) {
                    request.setAttribute("message", "Item added successfully!");
                } else {
                    request.setAttribute("error", "Failed to add item.");
                }
            } else if ("update".equals(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                String itemName = request.getParameter("itemName");
                double price = Double.parseDouble(request.getParameter("price"));
                String description = request.getParameter("description");
                Item item = new Item(itemId, itemName, price, description);
                boolean success = ser.updateItem(item);
                if (success) {
                    request.setAttribute("message", "Item updated successfully!");
                } else {
                    request.setAttribute("error", "Failed to update item.");
                }
            } else if ("delete".equals(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                boolean success = ser.deleteItem(itemId);
                if (success) {
                    request.setAttribute("message", "Item deleted successfully!");
                } else {
                    request.setAttribute("error", "Failed to delete item.");
                }
            }
            List<Item> items = ser.getAllItems();
            request.setAttribute("items", items);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database driver not found.");
        }
        request.getRequestDispatcher("manageItem.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ItemService service = new ItemService();
        try {
            List<Item> items = service.getAllItems();
            request.setAttribute("items", items);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database driver not found.");
        }
        request.getRequestDispatcher("manageItem.jsp").forward(request, response);
    }
}

