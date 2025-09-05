# WDRepApp

This project contains:
- .NET 8 Web API backend (in /server)
- Angular frontend (in /client)
- PostgreSQL database (via Docker Compose)

## Getting Started

1. Build and start all services:
   ```sh
   docker-compose up --build
   ```
2. Access the Angular app at http://localhost:4200
3. The backend API will be available at http://localhost:5000
4. PostgreSQL will be available at localhost:5432 (user: wdrep, password: wdrep)

## Development
- To run backend locally: `cd server && dotnet run`
- To run frontend locally: `cd client && npm start`

## Notes
- Database schema will be provided in future steps.
- This is a clean, modular, and extensible scaffold.
