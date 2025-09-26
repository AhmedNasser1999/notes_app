# Notes App



A simple, offline-first notes application built with Flutter. It allows users to create, manage, and store notes locally on their device.

## Features

- **Create, Read, Update, and Delete (CRUD) Notes**: Full functionality to manage your notes.
- **Offline Storage**: Notes are saved locally using **Hive**, ensuring your data is always accessible, even without an internet connection.
- **Theme Switching**: Seamlessly switch between a light and dark theme. Your preference is saved for future sessions.
- **Clean Architecture**: Built following Clean Architecture principles for a scalable, maintainable, and testable codebase.
- **Responsive UI**: A clean and intuitive user interface that works well on different screen sizes.

## Architecture

This project is structured using the principles of **Clean Architecture**, separating the code into three main layers:

- **Presentation**: Manages the UI and state. Uses **flutter_bloc (Cubit)** for state management.
- **Domain**: Contains the core business logic, including entities, use cases, and repository contracts. This layer is independent of any framework.
- **Data**: Implements the repository contracts from the domain layer. It is responsible for fetching data from local sources (Hive).

Dependency injection is managed using **`get_it`** and **`injectable`** to decouple the layers and manage dependencies efficiently.

## Project Structure

The `lib` directory is organized as follows:

```
lib/
├── core/         # Shared utilities, widgets, DI, and theme configuration
├── data/         # Data sources, models, and repository implementations
├── domain/       # Entities, use cases, and abstract repository definitions
├── presentation/ # UI screens and Blocs/Cubits for state management
└── main.dart     # Application entry point
```

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed on your machine.

### Installation & Run

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/AhmedNasser1999/notes_app.git
    cd notes_app
    ```
2.  **Install dependencies:**
    ```sh
    flutter pub get
    ```
3.  **Run the code generator:**
    This project uses code generation for dependency injection and data models. Run the following command to generate the necessary files:
    ```sh
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
4.  **Run the application:**
    ```sh
    flutter run
