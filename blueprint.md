
# Project Blueprint

## Overview

This document outlines the structure and implementation plan for a Flutter application featuring a login screen and a dashboard. The application will follow the Model-View-ViewModel (MVVM) architectural pattern.

## Features

*   **Login Screen:** A screen for users to enter their credentials (User ID and Password).
*   **Dashboard Screen:** A screen displaying various options and information after a successful login.
*   **Authentication:** A simple, hardcoded authentication mechanism.
*   **Navigation:** Routing between the login and dashboard screens.

## Architecture & Design

*   **Pattern:** MVVM (Model-View-ViewModel)
*   **State Management:** `provider` package for managing the application state.
*   **Navigation:** `go_router` package for declarative routing.
*   **Styling:** A consistent theme will be applied using Material Design principles, with colors and fonts inspired by the provided screenshots.

## Project Structure

```
lib/
├── main.dart             # App entry point
├── router.dart             # GoRouter configuration
├── models/               # Data models (if any)
├── views/                # UI widgets (Screens)
│   ├── login_view.dart
│   └── dashboard_view.dart
├── viewmodels/           # ViewModels for business logic
│   └── auth_viewmodel.dart
└── utils/                # Utility classes
    └── app_colors.dart
```

## Implementation Plan

1.  **Dependencies:** Add `provider`, `go_router`, and `google_fonts` to `pubspec.yaml`.
2.  **Project Structure:** Create the directories as outlined above.
3.  **`AuthViewModel`:** Implement a `ChangeNotifier` to manage the authentication state.
4.  **`router.dart`:** Configure `GoRouter` with routes for `/login` and `/dashboard` and set up a redirect based on authentication state.
5.  **`LoginView`:** Create the UI for the login screen, with text fields and a login button that interacts with the `AuthViewModel`.
6.  **`DashboardView`:** Create the UI for the dashboard, including the grid layout and bottom navigation bar.
7.  **`main.dart`:** Set up `ChangeNotifierProvider` and `MaterialApp.router` to tie everything together.
8.  **Theming:** Define a color scheme and text styles in `utils/app_colors.dart` and the main theme.
