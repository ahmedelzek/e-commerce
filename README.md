#  E-commerce flutter application

##  Overview

This project is a Flutter application built with a strong focus on **Clean Architecture**, scalability, and maintainability. The goal is to create a well-structured and production-ready app that is easy to extend and maintain over time.

---

##  Architecture

The application follows a **3-layer architecture**:

### 1. Data Layer

* Responsible for handling data sources (APIs, Local Storage)
* Contains repository implementations and data sources

### 2. Domain Layer

* Contains the core **business logic**
* Includes entities and use cases
* Completely independent from external frameworks

### 3. Features Layer

* Each feature is modular and self-contained
* Includes UI and state management

---

##  Tech Stack & Tools

* **Dio** → Handling REST API requests and error management
* **Flutter Secure Storage** → Securely storing sensitive data
* **Go Router** → Managing navigation in a scalable way
* **Localization (l10n)** → Supporting multiple languages
* **Get It** → Dependency Injection for better code organization

---

##  Features

* Clean and scalable architecture
* Secure data handling
* Multi-language support
* Modular feature-based structure
* Maintainable and testable codebase

---

##  Getting Started

### Prerequisites

* Flutter SDK
* Dart SDK

##  Project Structure

```
lib/
 ├── core/
 ├── data/
 ├── domain/
 ├── features/
 └── main.dart
```

##  Author

Developed by [Ahmed Adel]

---

##  Feedback

Feel free to open issues or submit pull requests to improve the project!
