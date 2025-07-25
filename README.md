# Netflix Clone Backend API

This is a Spring Boot backend application for a Netflix-like streaming service, providing RESTful APIs for user authentication, movie management, and user profile handling.

## 🔧 Key Features

- **User  Authentication**: JWT-based authentication for secure access.
- **User  Registration**: New users can register and create accounts.
- **Movie Catalog Management**: CRUD operations for movies.
- **Role-Based Access Control**: Admin and user roles for different access levels.
- **Exception Handling**: Custom exception handling for better error management.
- **Pagination and Filtering**: Support for paginated movie listings and filtering by genre and content type.

## 🚀 Technologies Used

- **Java 17**
- **Spring Boot 3.5.3**
- **Spring Security**
- **JWT Authentication**
- **MySQL Database**
- **Spring Data JPA**
- **Hibernate**
- **Maven**
- **Lombok**

## ⚙️ Setup Instructions

### Prerequisites

- JDK 17
- MySQL 8.0+
- Maven
- Flutter
- Bloc

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/pavanpanche/netflix-clone-app.git
   cd netflix-clone-app

2. Configure the database:

- Create a MySQL database.
- Update src/main/resources/application.properties with your database credentials.

3.Run the application:

``bash

-   Run
mvn spring-boot:run

-- 

## API Documentation
#### Authentication
######Endpoint

- Login
  
  ```http
  
  POST /api/auth/login
Content-Type: application/json

 {
   "email": "user@example.com",
   "password": "password123"
 }


- Response
  {
   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
   "email": "user@example.com",
   "roles": ["USER"]
  }
---

```
src/
├── main/
│   ├── java/
│   │   └── com/example/netflix/backend/
│   │       ├── controller/     # API endpoints
│   │       ├── dto/            # Data Transfer Objects
│   │       ├── exception/      # Custom exceptions
│   │       ├── mapper/         # Mappers for DTOs
│   │       ├── models/         # Database entities
│   │       ├── repository/     # JPA repositories
│   │       ├── security/       # Security configuration
│   │       └── service/        # Business logic
│   └── resources/              # Configuration files
```

```
## Customization
- **Contact Information**: pavanpanche2@gmail.com.
- **License**: If you have a specific license file, ensure it is included in your repository.
- **Additional Features**: Feel free to add any additional features or sections that are relevant to your project.

This README provides a clear overview of your project, its features, and how to set it up, making it easier for others to understand and contribute to your work.
```
