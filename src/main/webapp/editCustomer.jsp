<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Management</title>
    <link rel="stylesheet" href="CSS/customerPage.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="customer-management">
        <header class="page-header">
            <h1><i class="fas fa-users"></i> Customer Management</h1>
            <p>Manage customer information, add new customers, and update existing records</p>
            <div class="header-actions">
                <button class="btn btn-primary" onclick="showAddCustomerForm()">
                    <i class="fas fa-plus"></i> Add New Customer
                </button>
                <button class="btn btn-secondary" onclick="goBackToMenu()">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </button>
            </div>
        </header>
        
        <!-- Add Customer Form -->
        <div id="add-customer-form" class="form-container" style="display: none;">
            <div class="form-header">
                <h3><i class="fas fa-user-plus"></i> Add New Customer</h3>
                <button class="btn btn-close" onclick="hideAddCustomerForm()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <form action="addCustomer" method="post">
                <label>Name:</label>
                <input type="text" name="name" required>
                <label>Address:</label>
                <input type="text" name="address" required>
                <label>Telephone:</label>
                <input type="text" name="telephone" required>
                <label>Units Consumed:</label>
                <input type="number" name="units" value="0" required>
                <button type="submit">Add Customer</button>
            </form>
        </div>

        <!-- Edit Customer Form -->
        <div id="edit-customer-form" class="form-container" style="display: none;">
            <div class="form-header">
                <h3><i class="fas fa-user-edit"></i> Edit Customer</h3>
                <button class="btn btn-close" onclick="hideEditCustomerForm()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <form id="editCustomerForm" onsubmit="return submitEditCustomerForm()">
                <input type="hidden" id="editAccountNumber" name="accountNumber">
                <div class="form-row">
                    <div class="form-group">
                        <label for="editCustomerName">Customer Name *</label>
                        <input type="text" id="editCustomerName" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="editCustomerTelephone">Telephone *</label>
                        <input type="tel" id="editCustomerTelephone" name="telephone" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="editCustomerAddress">Address</label>
                        <input type="text" id="editCustomerAddress" name="address">
                    </div>
                    <div class="form-group">
                        <label for="editCustomerUnits">Units Consumed</label>
                        <input type="number" id="editCustomerUnits" name="units" min="0" required>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save"></i> Update Customer
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="hideEditCustomerForm()">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                </div>
            </form>
        </div>

        <!-- Search and Filter Section -->
        <div class="search-section">
            <div class="search-box">
                <input type="text" id="searchCustomer" placeholder="Search customers by name, telephone, or address..." onkeyup="filterCustomers()">
                <i class="fas fa-search search-icon"></i>
            </div>
        </div>

        <!-- Customer Table -->
        <div class="table-container">
            <div class="table-header">
                <h3>Customer List</h3>
                <div class="table-actions">
                    <button class="btn btn-sm btn-outline" onclick="exportCustomers()">
                        <i class="fas fa-download"></i> Export
                    </button>
                    <button class="btn btn-sm btn-outline" onclick="refreshCustomerData()">
                        <i class="fas fa-sync-alt"></i> Refresh
                    </button>
                </div>
            </div>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Account No</th>
                        <th>Name</th>
                        <th>Telephone</th>
                        <th>Address</th>
                        <th>Units Consumed</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="customerTableBody">
                    <!-- Customer data will be loaded here -->
                </tbody>
            </table>
            <div class="table-footer">
                <div class="pagination-info">
                    <span id="paginationInfo">Showing 1-10 of 0 customers</span>
                </div>
                <div class="pagination-controls">
                    <button class="btn btn-sm btn-outline" onclick="previousPage()" id="prevBtn" disabled>
                        <i class="fas fa-chevron-left"></i> Previous
                    </button>
                    <span id="pageNumbers"></span>
                    <button class="btn btn-sm btn-outline" onclick="nextPage()" id="nextBtn" disabled>
                        Next <i class="fas fa-chevron-right"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        const ctx = '<%= request.getContextPath() %>';
        let currentCustomers = [];
        let filteredCustomers = [];
        let currentPage = 1;
        const customersPerPage = 10;

        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            loadCustomerData();
        });

        function goBackToMenu() {
            window.location.href = ctx + '/menu.jsp';
        }

        function showAddCustomerForm() {
            window.location.href = ctx + '/addCustomer.jsp';
        }

        function hideAddCustomerForm() {
            document.getElementById('add-customer-form').style.display = 'none';
            document.getElementById('customerForm').reset();
        }

        function showEditCustomerForm(customer) {
            document.getElementById('edit-customer-form').style.display = 'block';
            document.getElementById('add-customer-form').style.display = 'none';
            
            // Populate form fields
            document.getElementById('editAccountNumber').value = customer.accountNumber;
            document.getElementById('editCustomerName').value = customer.name;
            document.getElementById('editCustomerTelephone').value = customer.telephone;
            document.getElementById('editCustomerAddress').value = customer.address || '';
            document.getElementById('editCustomerUnits').value = customer.unitsConsumed || 0;
        }

        function hideEditCustomerForm() {
            document.getElementById('edit-customer-form').style.display = 'none';
            document.getElementById('editCustomerForm').reset();
        }

        function submitCustomerForm() {
            const form = document.getElementById('customerForm');
            const data = new URLSearchParams(new FormData(form));
            data.append('action', 'create');
            fetch(ctx + '/customers', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
                body: data
            }).then(r => r.json())
            .then(res => {
                if (res.success) {
                    alert('Customer added successfully!');
                    hideAddCustomerForm();
                    loadCustomerData();
                } else {
                    // Try fallback JSP endpoint when servlet path is missing
                    fetch(ctx + '/customers.jsp', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
                        body: data
                    }).then(r => r.json())
                    .then(fb => {
                        if (fb.success) {
                            alert('Customer added successfully!');
                            hideAddCustomerForm();
                            loadCustomerData();
                        } else {
                            alert('Failed to add customer: ' + (fb.message || ''));
                        }
                    })
                    .catch(() => alert('Failed to add customer: ' + (res.message || '')));
                }
            }).catch(() => alert('Failed to add customer'));
            return false;
        }

        function submitEditCustomerForm() {
            const form = document.getElementById('editCustomerForm');
            const data = new URLSearchParams(new FormData(form));
            data.append('action', 'update');
            fetch(ctx + '/customers', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
                body: data
            }).then(r => r.json())
            .then(res => {
                if (res.success) {
                    alert('Customer updated successfully!');
                    hideEditCustomerForm();
                    loadCustomerData();
                } else {
                    // Try fallback JSP endpoint when servlet path is missing
                    fetch(ctx + '/customers.jsp', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
                        body: data
                    }).then(r => r.json())
                    .then(fb => {
                        if (fb.success) {
                            alert('Customer updated successfully!');
                            hideEditCustomerForm();
                            loadCustomerData();
                        } else {
                            alert('Failed to update customer: ' + (fb.message || ''));
                        }
                    })
                    .catch(() => alert('Failed to update customer: ' + (res.message || '')));
                }
            }).catch(() => alert('Failed to update customer'));
            return false;
        }

        function loadCustomerData() {
            fetch(ctx + '/customers')
                .then(async r => {
                    if (!r.ok) {
                        const text = await r.text();
                        throw new Error('GET /customers failed: ' + text);
                    }
                    return r.json();
                })
                .then(list => {
                    if (!Array.isArray(list)) {
                        console.error('Unexpected customers payload:', list);
                        alert('Failed to load customers (invalid response).');
                        list = [];
                    }
                    currentCustomers = list;
                    filteredCustomers = [...currentCustomers];
                    currentPage = 1;
                    displayCustomers();
                })
                .catch(err => {
                    console.error(err);
                    // Fallback to JSP data endpoint if servlet is unavailable
                    fetch(ctx + '/customers.jsp')
                        .then(r => r.json())
                        .then(list => {
                            currentCustomers = Array.isArray(list) ? list : [];
                            filteredCustomers = [...currentCustomers];
                            currentPage = 1;
                            displayCustomers();
                        })
                        .catch(() => {
                            alert('Failed to load customers. Please check server logs.');
                            currentCustomers = [];
                            filteredCustomers = [];
                            displayCustomers();
                        });
                });
        }

        function displayCustomers() {
            const tbody = document.getElementById('customerTableBody');
            tbody.innerHTML = '';
            
            const startIndex = (currentPage - 1) * customersPerPage;
            const endIndex = startIndex + customersPerPage;
            const pageCustomers = filteredCustomers.slice(startIndex, endIndex);
            
            if (pageCustomers.length === 0) {
                const row = document.createElement('tr');
                row.innerHTML = `<td colspan="6" style="text-align:center;">No customers found</td>`;
                tbody.appendChild(row);
            } else {
                pageCustomers.forEach(customer => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td>${customer.accountNumber}</td>
                        <td>${customer.name}</td>
                        <td>${customer.telephone}</td>
                        <td>${customer.address || '-'}</td>
                        <td>${customer.unitsConsumed ?? '-'}</td>
                        <td>
                            <button class="btn btn-sm btn-warning" onclick="editCustomer(${customer.accountNumber})">
                                <i class="fas fa-edit"></i> Edit
                            </button>
                            <button class="btn btn-sm btn-danger" onclick="deleteCustomer(${customer.accountNumber})">
                                <i class="fas fa-trash"></i> Delete
                            </button>
                        </td>
                    `;
                    tbody.appendChild(row);
                });
            }
            
            updatePagination();
        }

        function editCustomer(accountNumber) {
            const customer = currentCustomers.find(c => c.accountNumber === accountNumber);
            if (customer) {
                showEditCustomerForm(customer);
            }
        }

        function deleteCustomer(accountNumber) {
            if (confirm('Are you sure you want to delete this customer? This action cannot be undone.')) {
                const data = new URLSearchParams();
                data.append('action', 'delete');
                data.append('accountNumber', accountNumber);
                fetch(ctx + '/customers', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
                    body: data
                }).then(r => r.json())
                .then(res => {
                    if (res.success) {
                        alert('Customer deleted successfully!');
                        loadCustomerData();
                    } else {
                        // Try fallback JSP endpoint when servlet path is missing
                        fetch(ctx + '/customers.jsp', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
                            body: data
                        }).then(r => r.json())
                        .then(fb => {
                            if (fb.success) {
                                alert('Customer deleted successfully!');
                                loadCustomerData();
                            } else {
                                alert('Failed to delete customer: ' + (fb.message || ''));
                            }
                        })
                        .catch(() => alert('Failed to delete customer: ' + (res.message || '')));
                    }
                }).catch(() => alert('Failed to delete customer'));
            }
        }

        function filterCustomers() {
            const searchTerm = document.getElementById('searchCustomer').value.toLowerCase();
            const categoryFilter = document.getElementById('categoryFilter').value;
            
            filteredCustomers = currentCustomers.filter(customer => {
                const matchesSearch = customer.name.toLowerCase().includes(searchTerm) ||
                                      (customer.telephone || '').toLowerCase().includes(searchTerm) ||
                                      (customer.address || '').toLowerCase().includes(searchTerm);
                return matchesSearch;
            });
            
            currentPage = 1;
            displayCustomers();
        }

        function updatePagination() {
            const totalPages = Math.ceil(filteredCustomers.length / customersPerPage);
            const startItem = (currentPage - 1) * customersPerPage + 1;
            const endItem = Math.min(currentPage * customersPerPage, filteredCustomers.length);
            
            document.getElementById('paginationInfo').textContent = 
                `Showing ${startItem}-${endItem} of ${filteredCustomers.length} customers`;
            
            document.getElementById('prevBtn').disabled = currentPage === 1;
            document.getElementById('nextBtn').disabled = currentPage === totalPages;
            
            // Update page numbers
            const pageNumbers = document.getElementById('pageNumbers');
            pageNumbers.innerHTML = '';
            
            for (let i = 1; i <= totalPages; i++) {
                const pageBtn = document.createElement('button');
                pageBtn.className = `btn btn-sm ${i === currentPage ? 'btn-primary' : 'btn-outline'}`;
                pageBtn.textContent = i;
                pageBtn.onclick = () => goToPage(i);
                pageNumbers.appendChild(pageBtn);
            }
        }

        function goToPage(page) {
            currentPage = page;
            displayCustomers();
        }

        function previousPage() {
            if (currentPage > 1) {
                currentPage--;
                displayCustomers();
            }
        }

        function nextPage() {
            const totalPages = Math.ceil(filteredCustomers.length / customersPerPage);
            if (currentPage < totalPages) {
                currentPage++;
                displayCustomers();
            }
        }

        function refreshCustomerData() {
            loadCustomerData();
        }

        function exportCustomers() {
            // TODO: Implement export functionality
            alert('Export functionality will be implemented soon!');
        }
    </script>
</body>
</html>
