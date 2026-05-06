<div align="center">

# CoreLab App Challenge

**Flutter marketplace UI built for the CoreLab technical recruitment challenge.**

A responsive product browsing app with search, categories, and favorites — fetching listings from Firebase Realtime Database and rendering them with a clean, tablet-aware layout.

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-RTDB-FFCA28?logo=firebase)](https://firebase.google.com)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20Web-lightgrey)]()
[![Status](https://img.shields.io/badge/Status-Challenge%20Submission-blue)]()

</div>

---

## Overview

This repository contains my submission for the **CoreLab Flutter technical challenge**, part of the company's recruitment process. The app reproduces a marketplace-style mobile experience — five-tab navigation, real-time product search, category browsing, and a responsive layout that adapts to phones and tablets in both orientations.

The codebase prioritizes a clean separation between presentation, controllers, and data, and uses `Provider` to keep the UI in sync with state changes. Data is fetched from a hosted Firebase Realtime Database via a thin HTTP client wrapper.

### Key Features

- **Bottom Navigation** — Five tabs (Home, Categories, Announce, Favorites, Account) wired through an `IndexedStack` to preserve tab state
- **Live Search** — Filters products as the user types, with explicit empty / no-result states
- **Search History** — Persists previous queries via `shared_preferences` and lets the user re-run them from a suggestions panel
- **Categorized Home** — Latest listings grouped by recency (Today, Yesterday, All)
- **Categories Grid** — Dynamic AppBar that swaps title and styling when the categories tab is selected
- **Responsive Layout** — Uses `MediaQuery` and `responsive_builder` to adjust paddings, AppBar height, and grid widths for phones, tablets, portrait, and landscape
- **Firebase-Backed Catalog** — Products loaded from Firebase Realtime Database through a swappable repository interface

## Tech Stack

- **Framework**: Flutter (Dart SDK >= 3.0.5)
- **State Management**: [`provider`](https://pub.dev/packages/provider) ^6.1.2
- **HTTP**: [`http`](https://pub.dev/packages/http) ^1.2.2
- **Local Storage**: [`shared_preferences`](https://pub.dev/packages/shared_preferences) ^2.0.13 (search history)
- **Responsive UI**: [`responsive_builder`](https://pub.dev/packages/responsive_builder) ^0.7.1
- **Logging**: [`logger`](https://pub.dev/packages/logger) ^2.4.0
- **Backend**: Firebase Realtime Database (REST endpoint)

## Getting Started

### Prerequisites

- Flutter SDK 3.x ([install](https://docs.flutter.dev/get-started/install))
- Dart SDK 3.0.5 or newer
- An iOS Simulator, Android Emulator, or connected device

### Installation

```bash
# Clone the repository
git clone https://gitlab.com/mikaeldavidlopes/corelab_app_challenge.git
cd corelab_app_challenge

# Install dependencies
flutter pub get
```

### Running

```bash
# Run on the default connected device
flutter run

# Or pick a target
flutter run -d chrome
flutter run -d ios
flutter run -d android
```

### Testing

```bash
flutter test
```

## Architecture

The project follows a lightweight layered structure: views render UI, controllers hold state and business logic, and the data layer talks to Firebase through a repository abstraction.

```
UI (views)  →  Controller (Provider)  →  Repository  →  HttpClient  →  Firebase RTDB
```

Controllers extend `ChangeNotifier`; views read them via `Provider.of` / `Consumer`. The `iProducts` interface lets the data source be swapped (e.g., for a mock in tests) without touching the UI.

## Project Structure

```
lib/
├── main.dart                         # App entrypoint, MultiProvider setup
└── app/
    ├── modules/
    │   ├── controllers/              # HomeController, SearchLogicController
    │   └── views/                    # Navigation, Home, Categories, Search, Favorites, Profile, Announce
    ├── widgets/                      # Reusable widgets (product cards, lists, suggestions, loaders)
    └── data/
        ├── models/                   # Product model
        ├── stores/                   # Local product store
        ├── utilities/                # App colors / shared utils
        └── firebase/
            ├── http/                 # IHttpClient + custom exceptions
            └── repositories/         # ProductsRepository (iProducts impl)
assets/
└── images/                           # Empty-state and UI assets
test/                                 # Widget and unit tests
```

## Notes on the Challenge

- Implemented from the design and feature spec provided by CoreLab during the recruitment process.
- The Firebase endpoint is a public test database created specifically for this challenge.
- Focus areas: UI fidelity, responsive behavior across form factors, search UX (live filtering + history), and clean separation between layers.

## License

Personal challenge submission — no license. All rights reserved.

---

<div align="center">
Built by <a href="https://github.com/MikaelDDavidd">Mikael David</a>
</div>
