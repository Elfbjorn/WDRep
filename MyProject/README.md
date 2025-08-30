# WDRep: Full Stack .NET 8 + Angular + PostgreSQL Codespace

## Quick Start

1. **Start all services:**

   ```bash
   docker compose up --build
   ```

2. **Access the site:**
   - Frontend: [http://localhost:4200](http://localhost:4200)
   - Backend: [http://localhost:5000/swagger](http://localhost:5000/swagger)
   - Database: localhost:5432 (user: wdrep, pass: wdrep_pass, db: wdrep_db)

3. **Test the stack:**
   - Open the site and click "Check Database Connection". You should see "Database is reachable" if all services are running.

## Codespaces Extensions
- .NET Dev Kit (`ms-dotnettools.csdevkit`)
- Angular Language Service (`angular.ng-template`)

## Data Persistence
- PostgreSQL data is persisted in the `pgdata` Docker volume.

## Self-Healing & Validation
- The stack auto-validates DB connectivity on launch.
- If you see errors, restart with `docker compose down -v && docker compose up --build`.

---

**Status:** SUCCESSFUL

This Codespace is ready for scalable, modular development. All services are orchestrated and persist across restarts. For further schema or feature changes, simply update the stack and re-run the above command.
