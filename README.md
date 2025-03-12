# NextElect Frontend

## Overview
NextElect is a blockchain-based voting system that ensures secure and transparent elections. The **Flutter** frontend communicates with the **NextElect backend API** to facilitate user authentication, election participation, and voting functionalities.

## Features
- **User Authentication**
  - Login with Aadhaar ID, Birth Date, and Gender.
  - PIN-based authentication for added security.

- **Election Management**
  - View available elections.
  - Vote for a candidate.
  - View election results.

- **Admin Features**
  - Create new elections.
  - End elections and view results.

## Tech Stack
- **Frontend:** Flutter (Dart)
- **State Management:** Provider (or Riverpod, if preferred)
- **API Communication:** HTTP requests to Node.js backend
- **Storage:** SharedPreferences (for session management)

## Installation & Setup
### Prerequisites
Ensure you have the following installed:
- **Flutter** (latest stable version)
- **Dart**
- **Android Studio** or **VS Code** (with Flutter plugin)
- **NextElect Backend API** (running on `http://localhost:5000`)

### Clone the Repository
```sh
git clone https://github.com/yourusername/NextElect-Frontend.git
cd NextElect-Frontend
```

### Install Dependencies
```sh
flutter pub get
```

### Configure API Endpoint
Update the `api_base_url` in the configuration file (e.g., `lib/constants.dart`):
```dart
const String apiBaseUrl = "http://localhost:5000/api";
```

### Run the Application
```sh
flutter run
```

## Folder Structure
```
lib/
│── main.dart             # Entry point of the app
│── api/                  # API service handlers
│── models/               # Data models
│── providers/            # State management
│── screens/              # UI screens
│── widgets/              # Reusable components
│── utils/                # Utility functions
```

## API Endpoints Used
| Method | Endpoint | Description |
|--------|----------|--------------|
| `POST` | `/api/auth/login` | Authenticate user & issue JWT token |
| `POST` | `/api/auth/set-pin` | Set user PIN after first login |
| `GET` | `/api/elections` | Fetch available elections |
| `POST` | `/api/elections/vote` | Cast a vote for a candidate |
| `GET` | `/api/admin/results` | View election results (Admin) |

## Contributing
1. Fork the repository.
2. Create a new branch: `git checkout -b feature-branch`
3. Commit changes: `git commit -m 'Add new feature'`
4. Push to the branch: `git push origin feature-branch`
5. Open a Pull Request.

## License
This project is licensed under the MIT License.

## Contact
For any queries, contact kshitijdesai179@gmail.com.

