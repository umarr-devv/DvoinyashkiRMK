# GEMINI.md - Project Guidelines for Antygravity

## 📁 Project Structure

### 🚫 Read-Only Directories (Do Not Modify)

* **`/assets`** — Static assets. **Strictly hands-off.**

* **`/android`, `/ios`, `/windows`, `/linux`, `/macos`, `/web`** — Platform-specific manifests and configurations. View for context only; do not modify.

### 🏗️ Core Application (`/lib`)

This is the primary workspace for logic and UI changes.

* **`/blocs`** — Global State Management (App-wide Blocs).
* **`/core`** — Fundamental application components.
* **`/router`** — Navigation and routing configurations.
* **`/data`** — Data layer.
* **`/repositories`** — Data abstraction and API interactions.
* **`/features`** — Feature-based modules.
* **`/[feature_name]`** — Isolated logic for a specific screen.
* **`view.dart`** — Main UI entry point for the feature.
* **`/blocs`** — Local state management for this feature.
* **`/widgets`** — Feature-specific reusable UI components.
* **`/service`** — Internal and external service integrations.
* **`/shared`** — UI components and logic shared across multiple features.
* **`/utils`** — Helper functions and utility classes.
* **`app.dart`** — The root widget of the application.
* **`main.dart`** — The execution entry point.

### ⚙️ Configuration Files (Read-Only)

* **`pubspec.yaml` / `pubspec.lock`** — Dependency management. **Do not modify.**
* **`.env`** — Environment variables.
* **`.gitignore`** — Git exclusion rules.
* **`build.yaml`** — Code generation settings.
* **`analysis_options.yaml`** — Linter and static analysis rules.
* **`README.md`** — Project overview.

---

## 📜 Development Rules & Guidelines

1. **Prefer Existing Solutions:** Always check for existing third-party libraries or internal widgets before writing custom code. Reuse is a priority.
2. **Strict Theming:** Use colors and text styles **exclusively** from the global theme or the `theme.dart` file. Hardcoded values are prohibited.
3. **Dependency Awareness:** Check `pubspec.yaml` to ensure compatibility and avoid using deprecated versions of packages.
4. **Language Standard:** Use **English only** for all code, comments, file naming, directory naming, and variables.
5. **State Management:** Follow the BLoC pattern consistently as structured in the directories.

---

## 🛠️ Coding Style & Standards

* **Naming:** Use `PascalCase` for classes, `camelCase` for variables/methods, and `snake_case` for file names.
* **Architecture:** Strictly separate UI (View) from Business Logic (BLoC).
* **Clean Code:** Keep widgets small and modular. If a widget exceeds 100 lines, consider breaking it down into smaller components in the `/widgets` folder of the feature.
* **Async Operations:** Always handle loading and error states within the BLoC and reflect them in the UI.
