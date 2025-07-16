# 📝 Simple ToDo List App (Flutter + Firebase)

This is a simple and elegant ToDo List mobile application built with **Flutter** and integrated with **Firebase**. It allows users to:

- ✅ Create tasks  
- 🗑️ Delete tasks  
- 🔄 View tasks in **List Mode** or **Card Mode**  
- ☁️ Data is saved and persisted using **Firebase Firestore**

---

## 🚀 Features

- Add new tasks with ease
- Delete tasks with a single tap
- Two display modes:
  - 📄 List View
  - 🃏 Card View
- Data synchronization with Firebase Firestore
- Clean and responsive UI

---

## 🛠️ Tech Stack

- **Flutter** – Cross-platform mobile framework
- **Dart** – Programming language
- **Firebase Firestore** – Cloud NoSQL database for storing tasks
- **Provider / Riverpod / setState** – (depending on what you used) for state management

---

## 📸 Video

[![Watch the video](https://img.youtube.com/vi/bxaKU_Q8TsU/0.jpg)](https://youtu.be/bxaKU_Q8TsU)

---

## 📦 Getting Started

### Prerequisites

- Flutter SDK installed
- Firebase project set up
- A device or emulator

### Installation

1. Clone the repository:

```bash
git clone https://github.com/your-username/flutter-todo-firebase.git
cd flutter-todo-firebase
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

### 🧠 Project Structure

```bash
lib/
├── models/        # Task model
├── provider/       # Google provider
├── screens/       # Reusable widgets (card_screen, list_screen)
├── services/      # Firebase interaction logic
├── widgets/      # Widgets components
└── main.dart      # App entry point
```
