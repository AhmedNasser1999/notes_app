# Notes App

A modern, feature-rich note-taking application built with Flutter that allows users to create, edit, and manage notes with a clean and intuitive interface. The app supports both light and dark themes and uses local storage to ensure your notes are always available.

[![Flutter Version](https://img.shields.io/badge/Flutter-3.8.1-blue.svg)](https://flutter.dev/)
[![Dart Version](https://img.shields.io/badge/Dart-3.8.1-blue.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## Features

- ✏️ Create, read, update, and delete notes
- 🔍 Search and filter notes
- 🌓 Light and dark theme support
- 📱 Responsive design for various screen sizes
- 💾 Offline storage using Hive
- 🔒 Data persistence between app sessions
- 🧩 Clean architecture implementation

## Tech Stack & Dependencies

- **Flutter** - UI framework
- **Bloc Pattern** - State management via flutter_bloc
- **Hive** - Local NoSQL database
- **Get_it & Injectable** - Dependency injection
- **Dartz** - Functional programming
- **Equatable** - Value equality
- **UUID** - Unique identifiers
- **JSON Serialization** - Data serialization

## Project Structure

```
lib/
├── core/                  # Core functionality
│   ├── config/            # App configuration
│   ├── error/             # Error handling
│   ├── modules/           # Shared modules
│   ├── theme/             # App theming
│   └── widgets/           # Reusable widgets
├── data/                  # Data layer
│   ├── data_source/       # Data sources
│   ├── models/            # Data models
│   └── repository/        # Repository implementations
├── domain/                # Domain layer
│   ├── entities/          # Business entities
│   ├── repository/        # Repository interfaces
│   └── use_cases/         # Business logic use cases
├── hive/                  # Hive database configuration
│   └── data_source/       # Hive data sources
├── presentation/          # UI layer
│   ├── view/              # Screens and pages
│   └── view_model/        # View models (Cubits/Blocs)
└── main.dart              # App entry point
```

## Installation

### Prerequisites

- Flutter SDK (version ^3.8.1)
- Dart SDK (version ^3.8.1)
- Android Studio / VS Code with Flutter extensions

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/notes_app.git
   cd notes_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run code generation for annotations:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

## Running the App

### Development

```bash
flutter run
```

### Build Release APK

```bash
flutter build apk --release
```

### Build iOS App

```bash
flutter build ios --release
```

## Screenshots

*[Add screenshots here]*

Example screenshot placement:

- Home Screen
- Note Creation
- Note Details
- Settings/Theme Toggle

## How to Use

1. **Launch the app** - Open the app to view your notes list
2. **Create a note** - Tap the + button to create a new note
3. **Edit a note** - Tap on any note to view and edit its contents
4. **Delete a note** - Swipe left or right on a note to delete it
5. **Change theme** - Toggle between light and dark themes in settings

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

Built with ❤️ using Flutter
