📚 PAHANA EDU – Web-Based Billing & Customer Management System

⚡ A modern, secure, and scalable system to transform bookshop operations into a digital experience.










🚀 Project Overview

PAHANA EDU is a Java-based web application designed for Colombo’s leading bookshop, replacing manual billing and customer records with a digital platform.

The system provides:

🔐 Secure authentication (login/logout with sessions)

👥 Customer management (add, edit, view, delete)

📦 Item management (manage stock, add/update/remove items)

🧾 Automated billing system (calculate, print bills)

📊 Reports generation (customers, items, billing trends)

🆘 Help section (for new users)

🏗️ System Architecture
flowchart TB
    subgraph Client
        A[User Browser]
    end

    subgraph Presentation Layer
        B[JSP + CSS]
    end

    subgraph Business Logic Layer
        C[Java Servlets + Services]
    end

    subgraph Data Access Layer
        D[(MySQL Database)]
    end

    A --> B --> C --> D


✅ 3-tier architecture ensures scalability, maintainability, and clear separation of concerns.

🧩 Tech Stack

Frontend (Presentation Layer):

JSP (JavaServer Pages) → For dynamic web pages

CSS → For styling and layout

JSTL (JSP Standard Tag Library) → For UI logic simplification

Backend (Business Logic Layer):

Java Servlets → Handle requests and responses

Service Classes → Encapsulate business logic (e.g., BillService, CustomerService)

DAO Pattern (Data Access Object) → Database communication layer

Database (Data Access Layer):

MySQL → Relational database storing customers, items, users, and bills

JDBC (Java Database Connectivity) → Connect Java Servlets to MySQL

Server & Deployment:

Apache Tomcat → Web server to run Servlets & JSP

WAR Deployment → Packaged web archive for deployment

Version Control & Collaboration:

Git & GitHub → Version control and collaborative development

🧩 Design Patterns Used

DAO Pattern → Data access operations (CRUD for Customers, Items, Bills)

Singleton Pattern → DB connection pooling

MVC Pattern → Separation of UI, business logic, and data

Factory Pattern → Bill & Report generation

⚙️ Installation & Setup

1️⃣ Clone repository

git clone https://github.com/NavinduX/PAHANA-EDU-web-based-system.git
cd PAHANA-EDU-web-based-system


2️⃣ Configure database

Import pahanaedu.sql into MySQL

Update DBConnect.java with DB credentials

3️⃣ Deploy on Tomcat

Copy project into webapps/

Start Tomcat → Access: http://localhost:8080/pahana-edu

📖 Reports Generated

📝 Customer Reports → Active/Inactive accounts

📦 Item Reports → Stock levels, sales trends

💵 Billing Reports → Daily, monthly, revenue summaries

🧪 Testing

✅ Test Cases (JUnit + Manual validation)

Covers Login, Customer, Item, Billing, Reports, Help

All passed successfully ✔️

🔄 Git Workflow
gitGraph
   commit id: "Initial commit"
   branch feature/login
   commit id: "Login Module"
   branch feature/billing
   commit id: "Billing Service"
   checkout main
   merge feature/login
   merge feature/billing
   commit id: "Release v1.0"

   Directory structure:
└── navindux-pahana-edu-web-based-system-/
    ├── README.md
    └── src/
        └── main/
            ├── java/
            │   ├── controller/
            │   │   └── DBConnect.java
            │   ├── model/
            │   │   ├── Bill.java
            │   │   ├── BillItem.java
            │   │   ├── Customer.java
            │   │   ├── Item.java
            │   │   └── User.java
            │   ├── services/
            │   │   ├── BillItemService.java
            │   │   ├── BillService.java
            │   │   ├── CustomerService.java
            │   │   ├── ItemService.java
            │   │   └── UserService.java
            │   └── servlet/
            │       ├── BillServlet.java
            │       ├── CustomerServlet.java
            │       ├── EditCustomerServlet.java
            │       ├── ItemServlet.java
            │       ├── LoginServlet.java
            │       ├── LogoutServlet.java
            │       ├── ManageCustomerServlet.java
            │       └── ViewCustomerServlet.java
            └── webapp/
                ├── addCustomer.jsp
                ├── calculateBill.jsp
                ├── editCustomer.jsp
                ├── help.jsp
                ├── home.jsp
                ├── login.jsp
                ├── manageCustomer.jsp
                ├── manageItem.jsp
                ├── navbar.jsp
                ├── viewCustomer.jsp
                ├── CSS/
                │   ├── billPage.css
                │   ├── customerPage.css
                │   ├── helpPage.css
                │   ├── homePage.css
                │   ├── itemPage.css
                │   ├── loginPage.css
                │   └── navbar.css
                └── META-INF/
                    └── MANIFEST.MF


Main branch: Stable code

Feature branches: New functionality

Bugfix branches: Patches & hotfixes

🚀 Future Enhancements

📱 Mobile-first responsive UI

✉️ Email/SMS billing notifications

📊 Interactive dashboards & analytics

👨‍💻 Author
👤 NavinduX


✨ “Efficiency through simplicity – PAHANA EDU transforms bookshop operations into a digital era.”
