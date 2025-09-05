# SSN Duplicate Check and Upsert Implementation

## Overview
This implementation adds SSN duplicate check and upsert logic for core identity management as requested in the proposal.

## Components Added

### 1. Services/IdentityService.cs
- **IIdentityService interface**: Defines the contract for identity operations
- **IdentityService class**: Implements SSN duplicate check and upsert logic
- **Key Methods**:
  - `FindIdentityBySsnAsync()`: Finds existing identity by encrypted SSN
  - `CreateOrUpdateIdentityAsync()`: Creates new identity or updates existing one
  - `ValidateTokenAndGetSsnAsync()`: Validates SSN token and decrypts SSN

### 2. Models/CreateIdentityRequest.cs
- Business model for identity creation/update requests
- Separate from DTOs to provide clean model representation
- Includes all identity fields plus SSN token

### 3. Controllers/IdentityController.cs (Updated)
- Added dependency injection for `IIdentityService`
- New endpoint: `POST /api/identity/create-or-update`
- Uses the service for business logic instead of direct database operations

### 4. DTOs/CreateIdentityRequest.cs (Updated)
- Added `SsnToken` property to support token-based operations
- Maintains compatibility with existing DTO structure

### 5. Program.cs (Updated)
- Registered `IIdentityService` in dependency injection container
- Added proper service lifetime management (Scoped)

## API Endpoints

### Check SSN (Existing)
```
POST /api/identity/check-ssn
Content-Type: application/json
Body: "123456789"
```
Returns: `{"found": true/false, "token": "guid"}`

### Create or Update Identity (New)
```
POST /api/identity/create-or-update
Content-Type: application/json
Body: {
  "SsnToken": "guid-from-check-ssn",
  "FirstName": "John",
  "LastName": "Doe",
  "Dob": "1990-01-01",
  "SexId": 1,
  // ... other fields
}
```
Returns: `{"Success": true, "CoreIdentityId": 123}` or error response

## Workflow

1. **Client checks SSN**: Calls `check-ssn` endpoint with SSN
2. **Server responds**: Returns token and whether SSN exists
3. **Client creates/updates**: Calls `create-or-update` with token and identity data
4. **Server processes**: 
   - Validates token and gets decrypted SSN
   - Checks for existing identity with that SSN
   - Either creates new or updates existing identity
   - Returns success/failure response

## Security Features

- **Token-based SSN handling**: SSN is never sent in plaintext after initial check
- **One-time tokens**: Tokens expire and are deleted after use
- **Encryption**: All SSN data is encrypted using PostgreSQL's pgp_sym_encrypt
- **Key management**: Uses EAGLE_SEK environment variable for encryption key

## Database Operations

- Uses raw SQL for encryption/decryption operations (PostgreSQL pgp_sym_encrypt/decrypt)
- Handles potential encryption errors gracefully
- Maintains existing database schema and constraints
- Supports both create and update operations seamlessly

## Error Handling

- Validates SSN tokens before processing
- Handles database connection errors
- Provides meaningful error messages
- Logs errors for debugging while protecting sensitive data

## Testing

The implementation can be tested using:
1. Swagger UI at `http://localhost:5173/swagger` when server is running
2. Direct API calls using curl or HTTP clients
3. The provided test script at `/tmp/test_api.sh`

## Configuration

Required environment variables:
- `EAGLE_SEK`: Encryption key for SSN data (must be set)

Database connection string should be configured in `appsettings.json` or `appsettings.Development.json`.