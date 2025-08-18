<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Customer" %>
<html>
<head>
    <title>Customer Management</title>
    <link rel="stylesheet" href="CSS/customerPage.css">
</head>
<body>
<div class="main-layout">
    <jsp:include page="navbar.jsp" />
    <div class="content-area">
        <h2>Customer Management</h2>
        <% if (request.getAttribute("message") != null) { %>
            <div class="message"><%= request.getAttribute("message") %></div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <div class="customer-container">
            <!-- Left Panel: Customer Register -->
            <div class="register-panel">
                <h3>Customer Register</h3>
                <form method="post" action="manageCustomers" class="register-form">
                    <input type="hidden" name="action" value="add">

                    <div class="form-group">
                        <label for="name">Customer Name:</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="address">Address:</label>
                        <input type="text" id="address" name="address" required>
                    </div>
                    <div class="form-group">
                        <label for="telephone">Telephone:</label>
                        <input type="text" id="telephone" name="telephone" required>
                    </div>

                    <button type="submit" class="add-btn">Add Customer</button>
                </form>
            </div>

            <!-- Right Panel: Customer Details -->
            <div class="details-panel">
                <h3>Customer Details</h3>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Account No</th>
                                <th>Name</th>
                                <th>Address</th>
                                <th>Telephone</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                               if (customers != null) {
                                   for (Customer customer : customers) { %>
                            <tr>
                                <td><%= customer.getAccountNumber() %></td>
                                <td><%= customer.getName() %></td>
                                <td><%= customer.getAddress() %></td>
                                <td><%= customer.getTelephone() %></td>
                                <td class="actions">
                                    <button class="edit-btn" 
                                            data-account="<%= customer.getAccountNumber() %>"
                                            data-name="<%= customer.getName() %>"
                                            data-address="<%= customer.getAddress() %>"
                                            data-telephone="<%= customer.getTelephone() %>"
                                            onclick="editCustomerFromData(this)">
                                        Edit
                                    </button>
                                    <button class="delete-btn" 
                                            onclick="deleteCustomer('<%= customer.getAccountNumber() %>')">
                                        Delete
                                    </button>
                                </td>
                            </tr>
                            <%     }
                               } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Edit Modal -->
        <div id="editModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <h3>Edit Customer</h3>
                <form method="post" action="manageCustomers" class="edit-form">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="accountNumber" id="editAccountNumber">
                    <div class="form-group">
                        <label for="editName">Customer Name:</label>
                        <input type="text" id="editName" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="editAddress">Address:</label>
                        <input type="text" id="editAddress" name="address" required>
                    </div>
                    <div class="form-group">
                        <label for="editTelephone">Telephone:</label>
                        <input type="text" id="editTelephone" name="telephone" required>
                    </div>

                    <button type="submit" class="update-btn">Update Customer</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
function editCustomerFromData(button) {
    const accountNumber = button.getAttribute('data-account');
    const name = button.getAttribute('data-name');
    const address = button.getAttribute('data-address');
    const telephone = button.getAttribute('data-telephone');
    
    document.getElementById('editAccountNumber').value = accountNumber;
    document.getElementById('editName').value = name;
    document.getElementById('editAddress').value = address;
    document.getElementById('editTelephone').value = telephone;
    
    document.getElementById('editModal').style.display = 'block';
}

function deleteCustomer(accountNumber) {
    if (confirm('Are you sure you want to delete this customer?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = 'manageCustomers';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'delete';
        
        const accountInput = document.createElement('input');
        accountInput.type = 'hidden';
        accountInput.name = 'accountNo';
        accountInput.value = accountNumber;
        
        form.appendChild(actionInput);
        form.appendChild(accountInput);
        document.body.appendChild(form);
        form.submit();
    }
}

// Close modal when clicking on X
document.querySelector('.close').onclick = function() {
    document.getElementById('editModal').style.display = 'none';
}

// Close modal when clicking outside
window.onclick = function(event) {
    if (event.target == document.getElementById('editModal')) {
        document.getElementById('editModal').style.display = 'none';
    }
}
</script>
</body>
</html>