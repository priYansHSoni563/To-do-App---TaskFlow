# 📂 Project Structure & Screens

This application is a simple and clean To-Do app built with Flutter. It helps users organize their daily tasks by allowing them to create, update, complete, and delete tasks. All data is stored locally using Hive, so the app works completely offline.

## 📱 Screens

### 🏠 Home Screen
This is the main screen of the application where users can view all of their tasks.

**What you can do:**
- View all saved tasks
- Mark tasks as completed
- See completed and pending tasks
- Add a new task using the floating action button
- Open any task to edit it
- Smooth and responsive interface

---

### ➕ Add Task Screen
This screen is used to create a new task.

**Includes:**
- Task title
- Task description
- Date selection
- Time selection
- Add task button
- Input validation before saving

---

### ✏️ Edit Task Screen
After selecting a task, users can modify or remove it from this screen.

**Includes:**
- Update task title
- Update task description
- Change date and time
- Save changes
- Delete task

---

## ✨ Features

- Create new tasks
- Edit existing tasks
- Delete tasks
- Mark tasks as completed
- Store data locally
- Offline support
- Date & time picker
- Clean and simple user interface
- Responsive layout

---

## 🛠 Technologies Used

- Flutter
- Dart
- Provider (State Management)
- Hive Database
- Hive Flutter

---

## 📁 Folder Structure

```text
lib/
│
├── main.dart
├── models/
├── providers/
├── screens/
│   ├── home_screen.dart
│   ├── add_task_screen.dart
│   └── edit_task_screen.dart
├── services/
├── widgets/
├── utils/
└── assets/
```

---

## 💾 Storage

The app uses **Hive Database** to save all tasks locally on the device. Since everything is stored offline, users can access and manage their tasks without an internet connection.

---

## 🎯 Summary

This project was built to practice Flutter fundamentals, local storage with Hive, and state management using Provider. The main focus was to create a lightweight, user-friendly, and responsive To-Do application with a clean interface and smooth user experience.
