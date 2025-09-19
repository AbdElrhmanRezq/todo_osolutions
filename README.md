# 📝 Todo Osolutions  

A **task management app** built with **Flutter** that allows users to manage tasks, filter them by different attributes (category, completion, priority, etc.), and view details. The app is structured with **Riverpod** for state management and clean integration with a custom **API service**.  

---

## 🚀 Tech Stack  

- **Flutter** – Cross-platform framework for building mobile apps.  
- **Dart** – The programming language powering Flutter.  
- **Riverpod** – Used for state management. It is type-safe, testable, and integrates well with async APIs.  
- **REST API** – Data comes from an external backend via `ApiService`.  
- **Models** –  
  - `TaskModel` → Represents individual tasks.  
  - `CategoryModel` → Represents task categories.  

---

## 🧩 Key Features  

- **Task Management** – Fetch tasks from the API and display them in the home screen.  
- **Filtering** – Limit, offset, category, completion state, priority, and order can all be applied when fetching tasks.  
- **Categories** – Fetch and display task categories.  
- **Details View** – Open a bottom sheet to see detailed information about a single task.  
- **Reactive UI** – Thanks to Riverpod, the UI updates automatically when filters or data change.  

---

## 📂 Project Structure  

```
lib/
│── core/
│   └── services/
│       └── api_service.dart        # Handles REST API requests
│
│── models/
│   ├── task_model.dart             # Task entity
│   └── category_model.dart         # Category entity
│
│── providers/
│   └── api_provider.dart           # Riverpod providers & filters
│
│── screens/
│   ├── home_screen.dart            # Task listing + categories
│   └── details_screen.dart         # Task details bottom sheet
│
└── main.dart                       # App entry point
```

---

## 🔧 Providers  

Defined in **`api_provider.dart`**:  

- `apiServiceProvider` → Provides a single `ApiService` instance.  
- **Filters**  
  - `limitFilterProvider`  
  - `offsetFilterProvider`  
  - `categoryFilterProvider`  
  - `completedFilterProvider`  
  - `priorityFilterProvider`  
  - `orderFilterProvider`  
- **Async Providers**  
  - `tasksProvider` → Fetches a filtered list of tasks.  
  - `categoriesProvider` → Fetches categories.  
  - `singleTaskProvider` → Fetches a single task by ID.  

---

## 📱 Screens  

### 1. **HomeScreen**  
- Displays the list of tasks.  
- Uses `tasksProvider` to fetch data with applied filters.  
- Shows categories fetched from `categoriesProvider`.  
- Tapping a task opens the **DetailsScreen**.  

### 2. **DetailsScreen**  
- Triggered via a **bottom sheet**.  
- Fetches a single task using `singleTaskProvider`.  
- Displays title, description, and metadata.  

---

## ✅ Why Riverpod?  

- **Scoped Providers** → Each screen can watch exactly the data it needs.  
- **Async Handling** → `FutureProvider` simplifies loading/error states.  
- **Testability** → Providers can be easily mocked in unit tests.  
- **Reactivity** → Changing filters instantly updates the task list.  

---

## ▶️ Getting Started  

1. **Clone the repo**  
   ```bash
   git clone https://github.com/your-username/todo-osolutions.git
   cd todo-osolutions
   ```

2. **Install dependencies**  
   ```bash
   flutter pub get
   ```

3. **Run the app**  
   ```bash
   flutter run
   ```

---

## 📌 Example Flow  

1. Open the app → **HomeScreen** shows tasks & categories.  
2. Apply filters (limit, offset, category, etc.) → Task list updates.  
3. Tap on a task → Opens **DetailsScreen** in a bottom sheet with detailed info.  

---

## 🏗️ Future Improvements  

- Add authentication for user-specific tasks.  
- Offline caching with `hive` or `sqflite`.  
- Push notifications for task reminders.  
- UI enhancements with animations.  
