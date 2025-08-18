<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Help & Support</title>
    <link rel="stylesheet" href="CSS/helpPage.css">
</head>
<body>
<div class="main-layout">
    <jsp:include page="navbar.jsp" />
    <div class="content-area">
        <h2>Help & Support Center</h2>
        
        <div class="help-container">
            <!-- Getting Started Section -->
            <div class="help-section">
                <h3>🚀 Getting Started</h3>
                <div class="help-content">
                    <div class="help-item">
                        <h4>Login to System</h4>
                        <p>Enter your username and password to access the Pahana Edu Online Billing System. Ensure your credentials are correct and contact the administrator if you encounter any issues.</p>
                    </div>
                    
                    <div class="help-item">
                        <h4>Dashboard Overview</h4>
                        <p>View key performance indicators on the home page including total customers, items, bills, and revenue. This gives you a quick overview of your business metrics.</p>
                    </div>
                </div>
            </div>

            <!-- Customer Management Section -->
            <div class="help-section">
                <h3>👥 Customer Management</h3>
                <div class="help-content">
                    <div class="help-item">
                        <h4>Adding New Customers</h4>
                        <ul>
                            <li>Navigate to Customer Management from the main menu</li>
                            <li>Fill in the customer details: Name, Address, and Telephone</li>
                            <li>Click "Add Customer" to save the information</li>
                            <li>Account numbers are automatically generated</li>
                        </ul>
                    </div>
                    
                    <div class="help-item">
                        <h4>Managing Existing Customers</h4>
                        <ul>
                            <li>View all customers in the Customer Details table</li>
                            <li>Click the Edit button to modify customer information</li>
                            <li>Click the Delete button to remove customers</li>
                            <li>All changes are saved immediately</li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Item Management Section -->
            <div class="help-section">
                <h3>📦 Item Management</h3>
                <div class="help-content">
                    <div class="help-item">
                        <h4>Adding New Items</h4>
                        <ul>
                            <li>Go to Manage Item Information from the main menu</li>
                            <li>Enter Item Name, Price, and Description</li>
                            <li>Click "Add Item" to save</li>
                            <li>Item IDs are automatically assigned</li>
                        </ul>
                    </div>
                    
                    <div class="help-item">
                        <h4>Updating Items</h4>
                        <ul>
                            <li>Click the Edit button next to any item</li>
                            <li>Modify the details in the popup modal</li>
                            <li>Click "Update Item" to save changes</li>
                            <li>Prices can be updated with decimal values</li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Billing Section -->
            <div class="help-section">
                <h3>💰 Billing & Invoicing</h3>
                <div class="help-content">
                    <div class="help-item">
                        <h4>Creating a New Bill</h4>
                        <ol>
                            <li>Select "Calculate and Print Bill" from the main menu</li>
                            <li>Choose a customer from the dropdown list</li>
                            <li>Enter quantities for each item (0 for items not purchased)</li>
                            <li>Click "Calculate Bill" to generate the invoice</li>
                            <li>Review the bill preview before printing</li>
                        </ol>
                    </div>
                    
                    <div class="help-item">
                        <h4>Printing Bills</h4>
                        <ul>
                            <li>After calculating a bill, click the "Print Bill" button</li>
                            <li>A new window will open with the printable version</li>
                            <li>Use your browser's print function (Ctrl+P)</li>
                            <li>Bills are automatically saved to the system</li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- System Features Section -->
            <div class="help-section">
                <h3>⚙️ System Features</h3>
                <div class="help-content">
                    <div class="help-item">
                        <h4>Navigation</h4>
                        <ul>
                            <li>Use the top navigation bar to move between sections</li>
                            <li>All pages are accessible from the main menu</li>
                            <li>The system remembers your current session</li>
                        </ul>
                    </div>
                    
                    <div class="help-item">
                        <h4>Data Management</h4>
                        <ul>
                            <li>All data is automatically saved</li>
                            <li>Use the search and filter options where available</li>
                            <li>Export functionality for reports (if enabled)</li>
                            <li>Regular backups are performed automatically</li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Troubleshooting Section -->
            <div class="help-section">
                <h3>🔧 Troubleshooting</h3>
                <div class="help-content">
                    <div class="help-item">
                        <h4>Common Issues</h4>
                        <ul>
                            <li><strong>Login Failed:</strong> Check username/password and ensure caps lock is off</li>
                            <li><strong>Page Not Loading:</strong> Refresh the page or check your internet connection</li>
                            <li><strong>Data Not Saving:</strong> Ensure all required fields are filled</li>
                            <li><strong>Print Issues:</strong> Check printer settings and browser print options</li>
                        </ul>
                    </div>
                    
                    <div class="help-item">
                        <h4>Getting Support</h4>
                        <p>If you need further assistance or encounter technical issues, please contact your system administrator. Include specific error messages and steps to reproduce the problem for faster resolution.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>