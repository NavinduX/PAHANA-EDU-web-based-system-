<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Item" %>
<html>
<head>
    <title>Item Management</title>
    <link rel="stylesheet" href="CSS/itemPage.css">
</head>
<body>
<div class="main-layout">
    <jsp:include page="navbar.jsp" />
    <div class="content-area">
        <h2>Item Management</h2>
        <% if (request.getAttribute("message") != null) { %>
            <div class="message"><%= request.getAttribute("message") %></div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <div class="item-container">
            <!-- Left Panel: Item Register -->
            <div class="register-panel">
                <h3>Item Register</h3>
                <form method="post" action="manageItems" class="register-form">
                    <input type="hidden" name="action" value="add">
                    <div class="form-group">
                        <label for="itemName">Item Name:</label>
                        <input type="text" id="itemName" name="itemName" required>
                    </div>
                    <div class="form-group">
                        <label for="price">Price:</label>
                        <input type="number" id="price" name="price" step="0.01" min="0" required>
                    </div>
                    <div class="form-group">
                        <label for="description">Description:</label>
                        <input type="text" id="description" name="description">
                    </div>
                    <button type="submit" class="add-btn">Add Item</button>
                </form>
            </div>

            <!-- Right Panel: Item Details -->
            <div class="details-panel">
                <h3>Item Details</h3>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Description</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% List<Item> items = (List<Item>) request.getAttribute("items");
                               if (items != null) {
                                   for (Item item : items) { %>
                            <tr>
                                <td><%= item.getItemId() %></td>
                                <td><%= item.getName() %></td>
                                <td>Rs. <%= String.format("%.2f", item.getPrice()) %></td>
                                <td><%= item.getDescription() != null ? item.getDescription() : "" %></td>
                                <td class="actions">
                                    <button class="edit-btn" 
                                            data-id="<%= item.getItemId() %>"
                                            data-name="<%= item.getName() %>"
                                            data-price="<%= item.getPrice() %>"
                                            data-description="<%= item.getDescription() != null ? item.getDescription() : "" %>"
                                            onclick="editItemFromData(this)">
                                        Edit
                                    </button>
                                    <button class="delete-btn" 
                                            onclick="deleteItem('<%= item.getItemId() %>')">
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
                <h3>Edit Item</h3>
                <form method="post" action="manageItems" class="edit-form">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="itemId" id="editItemId">
                    <div class="form-group">
                        <label for="editName">Item Name:</label>
                        <input type="text" id="editName" name="itemName" required>
                    </div>
                    <div class="form-group">
                        <label for="editPrice">Price:</label>
                        <input type="number" id="editPrice" name="price" step="0.01" min="0" required>
                    </div>
                    <div class="form-group">
                        <label for="editDescription">Description:</label>
                        <input type="text" id="editDescription" name="description">
                    </div>
                    <button type="submit" class="update-btn">Update Item</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
function editItemFromData(button) {
    const id = button.getAttribute('data-id');
    const name = button.getAttribute('data-name');
    const price = button.getAttribute('data-price');
    const description = button.getAttribute('data-description');
    
    document.getElementById('editItemId').value = id;
    document.getElementById('editName').value = name;
    document.getElementById('editPrice').value = price;
    document.getElementById('editDescription').value = description;
    
    document.getElementById('editModal').style.display = 'block';
}

function deleteItem(itemId) {
    if (confirm('Are you sure you want to delete this item?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = 'manageItems';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'delete';
        
        const itemInput = document.createElement('input');
        itemInput.type = 'hidden';
        itemInput.name = 'itemId';
        itemInput.value = itemId;
        
        form.appendChild(actionInput);
        form.appendChild(itemInput);
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