# Flutter User List

A Flutter mobile app for viewing a list of users with offline caching support.

## Features

- **User list** — displays name, birth date, age, email, and phone
- **Offline mode** — data is cached in a local database (SQLite via Drift); when offline, cached data is shown
- **Pull-to-refresh** — refresh the list by pulling down
- **Cache-first strategy** — on launch, cached data is shown first (if available), then fresh data is loaded from the API in the background

## Tech Stack

| Layer | Technology |
|-------|------------|
| UI / State | Flutter, BLoC (Cubit), Material |
| Network | Dio, Retrofit |
| Local DB | Drift (SQLite) |
| DI | Get It |
| Code generation | json_serializable, retrofit_generator, drift_dev |

## Requirements

- Flutter SDK ^3.9.2
- Dart ^3.9.2

## Installation and run

```bash
# Clone the repository (if not already)
git clone <repo-url>
cd flutter_user_list

# Install dependencies
flutter pub get

# Generate code (Retrofit, JSON, Drift)
dart run build_runner build --delete-conflicting-outputs

# Run
flutter run
```

Supported platforms: Android, iOS, Web, macOS, Windows, Linux.

## API

Uses the public [DummyJSON](https://dummyjson.com/) API:

- **Base URL:** `https://dummyjson.com/`
- **Users list endpoint:** `GET /users`

## Project structure

The app follows **Clean Architecture** with clear layer separation:

```
lib/
├── core/                    # Shared constants and utilities
│   └── constants.dart
├── di/                      # Dependency Injection (GetIt)
│   └── injection_container.dart
├── main.dart
└── features/
    └── users/
        ├── data/            # Data: API, DB, mapping
        │   ├── database/    # Drift (SQLite)
        │   ├── datasource/  # Remote (API) and Local (DB)
        │   ├── mapper/      # DTO ↔ Domain, Entity ↔ Domain
        │   ├── models/      # DTOs (RemoteUser, UsersResponse)
        │   ├── repository/  # UserRepositoryImpl
        │   └── users_api.dart
        ├── domain/          # Business logic
        │   ├── model/       # User (domain model)
        │   ├── repository/  # UserRepository (interface)
        │   └── usecase/     # GetUserListUseCase
        └── presentation/    # UI
            ├── app/         # MyApp, routing
            ├── cubit/       # UsersCubit
            ├── pages/       # UsersPage
            ├── state/       # UsersUiState
            └── widgets/     # UsersList, UserRow, UserAvatar, ContactField
```

### Data flow

1. **UsersPage** subscribes to **UsersCubit** and displays **UsersUiState** (user list, loading, error).
2. **UsersCubit** calls **GetUserListUseCase** with the `forceRefresh` flag (on startup: cache first, then refresh; on manual refresh: refresh only).
3. **UserRepositoryImpl** in `getUsers()`:
   - if cache exists and `forceRefresh` is false — returns data from **LocalUserDataSource** (Drift);
   - otherwise fetches from **RemoteUserDataSource** (Retrofit → DummyJSON), maps to domain model, saves to DB, and returns the list.

## Code generation

After changing the API, DTOs, or DB schema, run code generation again:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Generated files:

- `users_api.g.dart` — Retrofit client implementation
- `remote_user.g.dart`, `users_response.g.dart` — JSON serialization
- `users_local_db.g.dart` — Drift tables and queries

## Testing

```bash
flutter test
```

> **Note:** `test/widget_test.dart` still contains the default counter test; it should be replaced with tests for the user list screen and Cubit.

## License

This project is for educational purposes. User data is provided by [DummyJSON](https://dummyjson.com/).
