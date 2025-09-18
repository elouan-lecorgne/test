# DoD Manager - Definition of Done Management System

![DoD Manager](https://img.shields.io/badge/DoD-Manager-blue.svg)
![Go](https://img.shields.io/badge/Go-1.19+-00ADD8.svg)
![React](https://img.shields.io/badge/React-18+-61DAFB.svg)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-13+-336791.svg)

A comprehensive web application for managing Definition of Done (DoD) in software development projects, enabling teams to create, share, and track completion criteria across multiple projects.

## 👥 Team Members

- **Elouan Lecorgne** 

## 🚀 Features

### MVP (Minimum Viable Product)
- ✅ **User Authentication** - Secure registration and login system
- ✅ **Project Management** - Create, update, and delete projects
- ✅ **Multiple DoDs per Project** - Support for various completion criteria
- ✅ **Collaborative Projects** - Multi-user project participation
- ✅ **Participant Management** - Add/remove project participants with roles
- ✅ **DoD Item Management** - Detailed completion criteria with requirements
- ✅ **Responsive UI** - Modern Material-UI interface

### Additional Features
- 🔐 **Role-based Access Control** - Owner, Editor, Viewer permissions
- 📊 **Project Dashboard** - Overview of user's projects and statistics
- 🔍 **Search & Filter** - Find projects and DoDs quickly

## 🛠️ Tech Stack

### Backend
- **Go 1.19+** - Main backend language
- **Gin Framework** - HTTP web framework
- **GORM** - ORM for database operations
- **PostgreSQL** - Primary database
- **JWT** - Authentication tokens
- **bcrypt** - Password hashing

### Frontend
- **React 18+** - Frontend framework
- **Material-UI (MUI)** - Component library
- **React Router** - Client-side routing
- **Axios** - HTTP client
- **React Hook Form** - Form management

### DevOps & Infrastructure
- **Docker** - Containerization
- **Docker Compose** - Multi-container orchestration
- **GitHub Actions** - CI/CD pipeline
- **AppVeyor** - Continuous Integration

## 📋 Prerequisites

Before running this application, make sure you have the following installed:

- **Go 1.19 or higher** ([Download Go](https://golang.org/dl/))
- **Node.js 16+ and npm** ([Download Node.js](https://nodejs.org/))
- **Docker and Docker Compose** ([Download Docker](https://www.docker.com/get-started))
- **Git** ([Download Git](https://git-scm.com/downloads))

## 🔧 Development Setup

### 1. Clone the Repository

```bash
git clone <your-repository-url>
cd dod-project
```

### 2. Environment Configuration

#### Backend Environment
```bash
cd backend
cp .env.example .env
```

Edit `backend/.env`:
```env
DB_HOST=localhost
DB_PORT=5432
DB_USER=dod_user
DB_PASSWORD=dod_password
DB_NAME=dod_database
JWT_SECRET=your-super-secret-jwt-key-here
PORT=8080
GIN_MODE=debug
```

#### Frontend Environment
```bash
cd frontend
cp .env.example .env
```

Edit `frontend/.env`:
```env
REACT_APP_API_URL=http://localhost:8080/api/v1
REACT_APP_NAME=DoD Manager
```

### 3. Database Setup

Start PostgreSQL using Docker:
```bash
docker-compose up -d
```

Wait for PostgreSQL to be ready (about 15 seconds), then seed the database:
```bash
cd backend
go mod tidy
go run main.go seed
```

### 4. Backend Setup

```bash
cd backend
go mod download
go run main.go
```

The backend will be available at `http://localhost:8080`

### 5. Frontend Setup

```bash
cd frontend
npm install
npm start
```

The frontend will be available at `http://localhost:3000`

## 🧪 Running Tests

### Backend Tests
```bash
cd backend
go test ./... -v
```

### Frontend Tests
```bash
cd frontend
npm test
```

### Integration Tests
```bash
# Run all tests
npm run test:all
```

## 🌐 API Documentation

### Authentication Endpoints
- `POST /api/v1/auth/register` - User registration
- `POST /api/v1/auth/login` - User login

### Project Endpoints
- `GET /api/v1/projects/` - Get user's projects
- `POST /api/v1/projects/` - Create new project
- `POST /api/v1/projects/:id/participants` - Add project participant
- `GET /api/v1/projects/:id/dods` - Get project DoDs

### DoD Endpoints
- `POST /api/v1/dods/` - Create new DoD
- `POST /api/v1/dods/:id/items` - Add DoD item

### Health Check
- `GET /health` - Service health status

## 🏗️ Project Structure

```
dod-project/
├── backend/
│   ├── main.go              # Entry point
│   ├── config/              # Configuration
│   ├── controllers/         # Request handlers
│   ├── database/            # DB connection & migrations
│   ├── middleware/          # Authentication & CORS
│   ├── models/              # Data models
│   ├── routes/              # Route definitions
│   └── tests/               # Backend tests
├── frontend/
│   ├── public/              # Static assets
│   ├── src/
│   │   ├── components/      # Reusable components
│   │   ├── contexts/        # React contexts
│   │   ├── pages/           # Page components
│   │   ├── services/        # API services
│   │   └── __tests__/       # Frontend tests
├── docker-compose.yml       # Development environment
├── .github/                 # CI/CD workflows
└── README.md               # This file
```

## 🚀 Deployment

### Production Environment Variables

#### Backend (.env.production)
```env
DB_HOST=your-production-db-host
DB_PORT=5432
DB_USER=your-production-db-user
DB_PASSWORD=your-production-db-password
DB_NAME=your-production-db-name
JWT_SECRET=your-super-secure-production-jwt-secret
PORT=8080
GIN_MODE=release
```

#### Frontend (.env.production)
```env
REACT_APP_API_URL=https://your-api-domain.com/api/v1
REACT_APP_NAME=DoD Manager
```

### Docker Production Build

```bash
# Build backend
docker build -t dod-backend ./backend

# Build frontend
docker build -t dod-frontend ./frontend

# Run with docker-compose
docker-compose -f docker-compose.prod.yml up -d
```

### Manual Deployment

#### Backend
```bash
cd backend
go build -o main .
./main
```

#### Frontend
```bash
cd frontend
npm run build
# Serve the build/ directory with your web server
```

## 🔄 CI/CD Pipeline

This project uses GitHub Actions for continuous integration and deployment:

- **On Push to `develop`**: Run tests and build
- **On Push to `main`**: Run tests, build, and deploy to production
- **On Pull Request**: Run tests and security checks

## 🧪 Test Accounts

After running the seed command, you can use these test accounts:

| Email | Password | Role |
|-------|----------|------|
| alice@example.com | password123 | Owner |
| bob@example.com | password123 | Member |
| charlie@example.com | password123 | Member |

## 🐛 Troubleshooting

### Common Issues

**Database Connection Failed**
```bash
# Check if PostgreSQL is running
docker-compose ps

# Restart database
docker-compose restart postgres
```

**Frontend Can't Connect to Backend**
- Verify backend is running on port 8080
- Check CORS configuration
- Verify API URL in frontend .env

**Build Failures**
```bash
# Clean Go modules
cd backend && go mod tidy

# Clean npm cache
cd frontend && npm ci
```

## 📝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Material-UI for the excellent React components
- Gin framework for the lightweight Go web framework
- GORM for the powerful ORM capabilities
- The open-source community for the amazing tools and libraries