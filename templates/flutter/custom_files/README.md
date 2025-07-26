# 📱 Aastera Flutter Template

This is Aastera's official Flutter template — a production-ready starter project for mobile and web applications, built with clean architecture and practical experience from years of real-world development.

It provides a ready-to-use structure with login flows, state management, API integrations, and common utilities — ideal for fast prototyping and scalable long-term projects.

---

## ✅ Key Features

### 1. ✅ App Initialization (Web & Mobile)

Seamless initialization for both **Flutter Web** and **Mobile** platforms, with environment-based configuration and entry-point flexibility.

---

### 2. 🔐 Ready-to-Use Auth Views

Out-of-the-box screens and forms for:

* Login
* Registration
* Forgot/reset password

Designed for easy integration with any RESTful backend.

---

### 3. 🔌 API Client, Services & Models Structure

Clean separation between:

* `api_clients/` → HTTP clients that interact with external/internal APIs
* `services/` → Business logic abstraction
* `models/` → Data parsing and transformation

All requests and models follow a reusable and maintainable pattern.

---

### 4. 🛠 Common Utilities

Useful helpers and extensions included, such as:

* String, Numbers and Date/time formatters and Utils
* Global toast/snackbar handling
* Simplification of Future Handling

---

### 5. 📦 Pre-installed Dependencies

Includes essential packages already set up and used across Aastera projects:

* `provider` for state management
* `dio` for HTTP requests
* `firebase_messaging` for push notifications
* `image_picker` for camera/gallery support
* `flutter_localizations` for i18n support
* `bugsnag_flutter` for crash reporting

---

### 6. 📷 Easy Media Picker Integration

Ready-to-use utility for selecting images from:

* Gallery
* Camera

With permissions already handled and easy-to-integrate callbacks.

---

### 7. 👤 User & Auth Structure

Built-in model and service layer to handle:

* Auth token storage
* User session persistence
* Authenticated API requests
* Global `UserProvider` provider

---

### 8. 🧠 State Management (Provider-Based)

Organized state management using `provider`, with support for:

* Nested change notifiers
* Scoped state access
* Easy injection of services and repositories

---

### 9. 🔔 Firebase Messaging Pre-Configured

Firebase is pre-wired for:

* Push notification handling
* Token refresh detection
* Background & foreground message handling

Just replace the configuration files and you're ready to go.

---

### 10. 🔗 Deep Linking Ready

Basic structure for deep link handling is already implemented — making it easy to define and navigate to routes via custom URLs or notification payloads.

---

### 11. 🐞 Bugsnag Integrated

Error monitoring with [Bugsnag](https://www.bugsnag.com/) is already included — just plug in your API key in the environment config.

---

## 🚀 Getting Started

To create a new Flutter project using this template:

```bash
dart run aastera_cli init -t flutter -n my-app-name
```

---

## ✅ Post-Install Checklist

After creating the project:

* Set up your `firebase_options.dart` using the [FlutterFire CLI](https://firebase.flutter.dev/docs/cli/)

* Add your `.env` variables for dev/prod

* Update app icons and names

* Connect your API endpoints and start building!

---

## 🧱 Built With

* [Flutter](https://flutter.dev/)
* [Dart](https://dart.dev/)
* Based on years of mobile/web development by the Aastera team

---

## 🏢 About Aastera

Aastera Tecnologia is a software company building scalable and efficient solutions for web, mobile, and cloud — specializing in Flutter, Laravel, and custom AI integrations.

---

## 📫 Contact

Have questions or suggestions? Reach out to us at [contact@aastera.com](mailto:contact@aastera.com) or [jm.borges7312@gmail.com](mailto:jm.borges7312@gmail.com)
