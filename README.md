# 🛠️ Aastera CLI

**Aastera CLI** is a simple command-line tool designed to accelerate the creation of boilerplate projects for **Flutter** and **Laravel** using custom templates.  
It helps standardize and simplify project setup at **Aastera Tecnologia**, but it can be adapted for other workflows.

---

## 🚀 Features

- Quickly scaffold **Flutter** or **Laravel** projects with pre-configured templates.
- Automatically installs dependencies.
- Custom template file structure.
- Environment setup script execution (if available).

---

## 📦 Installation

Clone this repository:

```bash
git clone https://github.com/AN-Tecnologia/aastera-cli.git
cd aastera-cli
````

Run directly using Dart:

```bash
dart run bin/aastera.dart init -t flutter -n my_project
```

### 🔄 Optional: Activate Globally

To use `aastera` as a global command in your terminal:

```bash
dart pub global activate --source path .
```

Now you can run:

```bash
aastera init -t flutter -n my_project
```

---

## ⚠️ Firebase Reminder (for Flutter Projects)

After generating a Flutter project, don’t forget to link it to a Firebase project for full functionality.

We recommend using the **FlutterFire CLI**:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

---

## 🧩 Usage

```bash
aastera init -t flutter -n my_flutter_app
aastera init -t laravel -n my_laravel_app
```

**Options:**

* `-t`, `--type` → Project type (`flutter` or `laravel`)
* `-n`, `--name` → Name of the project


This will:

* Run `flutter create`
* Replace files with a custom Aastera template
* Clear and recreate the `test/` folder
* Run `flutter pub get`
* Execute `update_env.sh` or `update_env.bat` if present
* Show instructions to link with Firebase

### Create a Laravel project:

- SOON

---

## 🔗 Firebase Setup (Flutter only)

For full functionality, you must connect your Flutter app to a Firebase project.

We recommend using the [FlutterFire CLI](https://firebase.flutter.dev/docs/cli/):

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

---

## 📁 Project Structure

```
aastera_cli/
│
├── bin/
│   └── aastera.dart         # Entry point
│
├── lib/
│   ├── cli.dart             # Main runner logic
│   ├── commands/            # Command handlers (init, etc.)
│   ├── flutter.dart         # Flutter init logic
│   ├── laravel.dart         # Laravel init logic
│   └── utils/               # Helper functions (file, exec, etc.)
│
├── templates/
│   └── flutter/
│       └── custom_files/    # Your custom Flutter template files
│
└── README.md
```

---

## 🧰 Dependencies

* Dart SDK
* Flutter SDK (for Flutter projects)
* Laravel Installer (for Laravel projects)
* Bash (on Linux/macOS) or PowerShell/.bat support (on Windows)

---

## 👨‍💻 Maintained by

**Aastera Tecnologia**
Custom software development, tools & automation
[https://aastera.com](https://aastera.com)


