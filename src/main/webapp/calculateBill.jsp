<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Customer" %>
<%@ page import="model.Bill" %>
<%@ page import="model.Item" %>
<%@ page import="services.ItemService" %>
<html>
<head>
    <title>Bill Management</title>
    <link rel="stylesheet" href="CSS/billPage.css">
    <script>
        function printBill() {
            var billContent = document.querySelector('.bill-details').innerHTML;
            var printWindow = window.open('', '', 'height=600,width=800');
            printWindow.document.write('<html><head><title>Print Bill</title>');
            printWindow.document.write('<style>body{font-family:Arial,sans-serif;} table{width:100%;border-collapse:collapse;} th,td{border:1px solid #ccc;padding:8px;text-align:left;} th{background:#f2f2f2;} .bill-details{background:#f9f9f9;padding:15px;border-radius:6px;}</style>');
            printWindow.document.write('</head><body>');
            printWindow.document.write('<div class="bill-details">' + billContent + '</div>');
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.focus();
            printWindow.print();
            printWindow.close();
        }
    </script>
</head>
<body>
<div class="main-layout">
    <jsp:include page="navbar.jsp" />
    <div class="content-area">
        <h2>Bill Management</h2>
        <% if (request.getAttribute("message") != null) { %>
            <div class="message"><%= request.getAttribute("message") %></div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <div class="bill-container">
            <!-- Left Panel: Bill Calculation -->
            <div class="calculation-panel">
                <h3>Calculate Bill</h3>
                <form method="post" action="calculateBill" class="calculation-form">
                    <div class="form-group">
                        <label for="accountNumber">Select Customer:</label>
                        <select id="accountNumber" name="accountNumber" required>
                            <option value="">-- Select Customer --</option>
                            <% List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                               if (customers != null) {
                                   for (Customer customer : customers) { %>
                            <option value="<%= customer.getAccountNumber() %>"><%= customer.getAccountNumber() %> - <%= customer.getName() %></option>
                            <%     }
                               } %>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>Select Items & Quantities:</label>
                        <div class="items-table-container">
                            <table class="items-table">
                                <thead>
                                    <tr>
                                        <th>Item Name</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        ItemService itemService = new ItemService();
                                        List<Item> items = itemService.getAllItems();
                                        for (Item item : items) { %>
                                    <tr>
                                        <td><%= item.getName() %></td>
                                        <td>Rs. <%= String.format("%.2f", item.getPrice()) %></td>
                                        <td>
                                            <input type="number" name="quantity_<%= item.getItemId() %>" min="0" value="0" class="quantity-input" />
                                            <input type="hidden" name="itemId" value="<%= item.getItemId() %>" />
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <button type="submit" class="calculate-btn">Calculate Bill</button>
                </form>
                
                <!-- Bill Preview -->
                <% if (request.getAttribute("bill") != null && request.getAttribute("customer") != null) {
                    Bill bill = (Bill) request.getAttribute("bill");
                    Customer customer = (Customer) request.getAttribute("customer");
                %>
                    <div class="bill-details">
                        <h4>Bill Preview</h4>
                        <div class="customer-info">
                            <p><strong>Account No:</strong> <%= customer.getAccountNumber() %></p>
                            <p><strong>Name:</strong> <%= customer.getName() %></p>
                            <p><strong>Date:</strong> <%= bill.getBillDate() %></p>
                        </div>
                        
                        <div class="bill-items">
                            <table class="bill-table">
                                <thead>
                                    <tr>
                                        <th>Item Name</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (bill.getBillItems() != null) {
                                        for (model.BillItem billItem : bill.getBillItems()) {
                                            model.Item item = billItem.getItem();
                                    %>
                                    <tr>
                                        <td><%= item.getName() %></td>
                                        <td>Rs. <%= String.format("%.2f", item.getPrice()) %></td>
                                        <td><%= billItem.getQuantity() %></td>
                                        <td>Rs. <%= String.format("%.2f", billItem.getQuantity() * item.getPrice()) %></td>
                                    </tr>
                                    <%     }
                                       } %>
                                </tbody>
                            </table>
                        </div>
                        
                        <div class="bill-total">
                            <p><strong>Total Amount:</strong> Rs. <%= String.format("%.2f", bill.getAmount()) %></p>
                        </div>
                        
                        <button class="print-btn" onclick="printBill()">Print Bill</button>
                    </div>
                <% } %>
            </div>

            <!-- Right Panel: Bill History -->
            <div class="history-panel">
                <h3>Bill History</h3>
                <div class="table-container">
                    <table class="history-table">
                        <thead>
                            <tr>
                                <th>Bill ID</th>
                                <th>Account No</th>
                                <th>Date</th>
                                <th>Total Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                List<Bill> billList = (List<Bill>) request.getAttribute("billList");
                                if (billList != null) {
                                    for (Bill billItem : billList) { %>
                            <tr>
                                <td><%= billItem.getBillId() %></td>
                                <td><%= billItem.getAccountNumber() %></td>
                                <td><%= billItem.getBillDate() %></td>
                                <td>Rs. <%= String.format("%.2f", billItem.getAmount()) %></td>
                            </tr>
                            <%     }
                                } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>