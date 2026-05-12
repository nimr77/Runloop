# 🔁 Runloop

> **Background command collections with auto-restart — macOS utility.**

🇵🇸 *Built with love. Free Palestine.*

Runloop is a native **macOS menu-bar app** built with Flutter that lets you group shell commands into named **collections**, run them all at once, and automatically restart any command that exits — keeping your background processes alive without any babysitting.

---

## 📸 Screenshots

![How to add a collection](public/how%20to%20add.png)

---

## ✨ Features

- 📦 **Command Collections** — Group multiple shell commands under a single named collection
- 🔄 **Auto-Restart** — Each command is automatically respawned 1 second after it exits
- 🚀 **Auto-Run on App Start** — Mark collections to start automatically when the app launches
- 🖥️ **macOS Menu-Bar Integration** — Lives in the system tray; always accessible, never in the way
- 🔐 **Launch at Login** — Optionally start Runloop automatically when you log in to macOS
- 💾 **SQLite Persistence** — All collections are saved locally using Drift (SQLite)
- 🛑 **Stop All** — One-click stop for every running collection
- ⚙️ **Settings Screen** — Manage launch-at-login and view collection status at a glance
- 🎨 **Clean macOS-native UI** — Built with Flutter, smooth animations via `flutter_animate`

---

## 🗂️ Project Structure

```
lib/
├── main.dart                      # App entry point, window & tray setup
├── application/
│   ├── dto/                       # Data transfer objects (RunSnapshot, SlotSnapshot)
│   ├── ports/                     # Abstract interfaces (CommandExecutor)
│   └── supervisor/                # CollectionSupervisor — auto-restart logic
├── core/
│   ├── di/                        # Dependency injection (get_it)
│   ├── router/                    # App routing (go_router)
│   └── theme/                     # AppTheme constants & Material theme
├── domain/
│   ├── entities/                  # CommandCollection aggregate root
│   └── repositories/              # Abstract repository interfaces
├── infrastructure/
│   ├── database/                  # Drift database definition & DAOs
│   ├── persistence/               # Repository implementations
│   ├── process/                   # Shell process execution
│   └── startup/                   # Launch-at-login sync helpers
└── presentation/
    ├── notifiers/                 # CollectionsNotifier (ValueNotifier)
    ├── screens/                   # HomeScreen, EditCollectionScreen, SettingsScreen
    ├── services/                  # TrayController
    └── widgets/                   # Reusable widgets (ShadowCard, HoverScale)
```

---

## 🚀 How to Run

### Prerequisites

| Requirement | Version |
|---|---|
| Flutter | `^3.x` (SDK `^3.11.3`) |
| Dart | `^3.11.3` |
| macOS | 12+ recommended |
| Xcode | Latest stable |

### Steps

```bash
# 1. Clone the repository
git clone git@github.com:nimr77/Runloop.git
cd Runloop

# 2. Install Flutter dependencies
flutter pub get

# 3. Run on macOS
flutter run -d macos
```

To build a release `.app`:

```bash
flutter build macos --release
```

The built app will be in `build/macos/Build/Products/Release/runloop.app`.

---

## 🧑‍💻 How to Use

### ➕ Creating a Collection

1. Launch Runloop — it appears in your **menu bar** (tray icon).
2. Click the tray icon and open the main window.
3. Press **New** (top-right `+` button).
4. Give the collection a **name**.
5. Add one or more **shell commands** (one per line / entry).
6. Optionally toggle **Auto-run on app start**.
7. Save — the collection is persisted to the local SQLite database.

### ▶️ Running a Collection

- On the **Home** screen, tap the **play** button on any collection card to start it.
- All commands in the collection run concurrently as separate processes.
- If a command exits for any reason, Runloop waits **1 second** and automatically **restarts** it.

### ⏹️ Stopping

- Tap the **stop** button on a collection card to stop all its processes.
- Use the **Stop All** button in the app bar to stop everything at once.

### ⚙️ Settings

- Navigate to **Settings** (tune icon in the app bar).
- Toggle **Launch at Login** to have Runloop start automatically on macOS login.
  - This is locked to `on` if any collection has *Auto-run on app start* enabled.

---

## 🧱 Architecture

Runloop follows a **clean / layered architecture**:

| Layer | Responsibility |
|---|---|
| `domain` | Pure entities & repository contracts — zero Flutter dependencies |
| `application` | Use-case logic: `CollectionSupervisor` orchestrates process lifecycle |
| `infrastructure` | Drift/SQLite repositories, shell process execution, OS integrations |
| `presentation` | Flutter widgets, screens, `ValueNotifier`-based state, tray controller |

Dependency injection is handled by **get_it** (`service_locator.dart`), and navigation by **go_router**.

---

## 📦 Key Dependencies

| Package | Purpose |
|---|---|
| `drift` + `sqlite3_flutter_libs` | Local SQLite database |
| `tray_manager` | macOS system tray icon & menu |
| `window_manager` | macOS window control |
| `launch_at_startup` | Launch at login integration |
| `go_router` | Declarative navigation |
| `get_it` | Service locator / DI |
| `flutter_animate` | Smooth UI animations |
| `package_info_plus` | App metadata |

---

## 📄 License

MIT © 2026

---

🇵🇸 *Free Palestine. From the river to the sea.*
