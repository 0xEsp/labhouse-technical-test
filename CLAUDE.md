# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Labhouse is a Flutter mobile application (iOS/Android) that lets users consult AI-generated rankings. The user enters a ranking question (e.g. "Top 10 entrepreneurship books") and the app displays a rich ranking with images, star ratings, locations, and other visual information powered by the ChatGPT API. The app uses BLoC pattern for state management, get_it for dependency injection, and go_router for navigation. It integrates with native platform features through Flutter method channels.

## Development Setup

### Prerequisites

1. Install Ruby as specified in `.ruby-version` (recommended: use rbenv)
2. Run `bundle install` to install bundle dependencies
3. Obtain secret variables from a team member and place in `.env/secrets.json`

### Flutter Version Management

This project uses **FVM (Flutter Version Manager)** to manage the Flutter version (3.41.1).

- Run Flutter commands with: `fvm flutter <command>`
- If FVM is not available, the project will fallback to global `flutter` command
- Fastlane scripts automatically handle both scenarios

## Essential Commands

### Development

```bash
# Generate localization files
flutter gen-l10n

# Generate .g files for JsonSerializable models
dart run build_runner build

# Run the app
fvm flutter run --dart-define-from-file=.env/secrets.json -t lib/main.dart

# Run tests
fvm flutter test

# Run specific test file
fvm flutter test test/path/to/test_file.dart

# Clean and get dependencies
fvm flutter clean && fvm flutter pub get
```

### Build & Deploy

**Android:**

```bash
cd android
bundle exec fastlane build_sign                    # Build signed Android app
bundle exec fastlane upload_google_play_store      # Upload to Google Play (internal track)
bundle exec fastlane pipeline_build_upload_dev     # Full pipeline: build + upload + notify
```

**iOS:**

```bash
cd ios
bundle exec fastlane build_sign development_mode:true   # Build signed iOS app
bundle exec fastlane upload_testflight                  # Upload to TestFlight
bundle exec fastlane pipeline_build_upload_dev          # Full pipeline: build + upload + notify
bundle exec fastlane fetch_certificates_development     # Fetch development certificates
bundle exec fastlane fetch_certificates_appstore        # Fetch distribution certificates
```

### Version Management

Build numbers are auto-incremented by Fastlane during the build process via scripts in `scripts/`:

- `scripts/bump_build_version.sh` - Increment build number
- `scripts/get_build_version.sh` - Get current build number
- `scripts/get_marketing_version.sh` - Get current marketing version

## Architecture

### Directory Structure

- **lib/core/** - Core infrastructure
  - `api/` - API client, interceptors, response models
  - `analytics/` - Amplitude tracker integration
  - `cache/` - Cache storage (SharedPreferences)
  - `secure/` - Secure storage (Keychain/AES)
  - `managers/` - Session, connection, locale, navigation, channel managers
  - `config/` - Configuration (Sentry, Google Sign In)
  - `base_bloc/` - Base BLoC with global error handling
  - `usecases/` - Core use cases

- **lib/common/** - Shared/reusable code
  - `model/` - Common data models
  - `router/` - Router configuration and routes
  - `presentation/` - Reusable UI components (buttons, loading, toasts, etc.)

- **lib/modules/** - Feature modules
  - `home/` - Home screen
  - `environment/` - Environment switching

- **lib/assembly/** - Dependency injection assembly
  - `assembly.dart` - Main DI container
  - `persistance_assembly.dart` - Storage registrations
  - `data_assembly.dart` - Data layer registrations
  - `manager_assembly.dart` - Manager registrations
  - `usecase_assembly.dart` - Use case registrations
  - `common_assembly.dart` - Common registrations

- **lib/extensions/** - Extension methods organized by type (error, iterable, numeric, string, theme, router)

### Dependency Injection

The app uses **get_it** for dependency injection with a singleton `Assembly` class. Dependencies are registered at app startup in `main.dart`:

```dart
container.setup();           // Register all dependencies
await container.setupCompleted();  // Wait for async dependencies
```

Access dependencies using: `container.get<Type>()`

### State Management

The app uses **BLoC pattern** with `flutter_bloc`:

- Base BLoC (`core/base_bloc/base_bloc.dart`) handles global concerns:
  - API error handling via stream
  - Network connectivity status
  - App version updates
  - Session management
  - Push token handling
  - Force logout on authentication errors

- Feature-specific BLoCs in `lib/modules/*/bloc/`
- Use `bloc_concurrency` transformers (e.g., `droppable()`) for event handling

### Navigation

Uses **go_router** for declarative routing:

- Routes defined in `common/router/routes.m.dart` (enum)
- Route builders implement `RouterBuilder` abstract class
- Global router key in `common/router/router_key.dart`

### API & Networking

- **Dio** client for HTTP requests
- Interceptors:
  - `interceptor_error.dart` - Global error handling and error stream
  - `interceptor_log.dart` - Request/response logging
- Response wrapper: `ApiResponse<T>` model
- Sentry integration via `sentry_dio` for API error tracking

### Native Platform Communication

**Android (Kotlin):**

- `android/app/src/main/kotlin/com/labhouse/app/modules/channel/ChannelManager.kt`
- `ShakeDetector.kt` - Detects device shake for environment switching

**iOS (Swift):**

- `ios/Runner/` - Contains AppDelegate and native modules
- Channel communication managed by ChannelManager

**Flutter side:**

- `core/managers/channel_manager.dart` - Handles method channel calls
- Example usage: Device decimal separator retrieval

### Error Handling

- Global error handling in `BaseBloc` via `InterceptorError` stream
- Custom error types: `ARPError`, `ARPErrorCode`, `ARPErrorType`
- Error extensions for UI widgets and metrics
- Sentry integration for crash reporting and logging

### Analytics

- **Amplitude** for event tracking via `core/analytics/tracker_amplitude.dart`
- Tracker interface pattern for flexibility
- Event models in `core/analytics/model/`

### Storage

- **SecureStorage** - Encrypted storage (iOS Keychain, Android AES) for sensitive data
- **CacheStorage** - SharedPreferences for non-sensitive cached data
- Both use option enums for type-safe keys

## File Naming Conventions

- `.m.dart` - Model files (data classes)
- `.dto.m.dart` - Data Transfer Objects
- `.g.dart` - Generated files (json_serializable, build_runner)
- `*_bloc.dart` - BLoC files
- `*_state.dart` - BLoC state files
- `*_event.dart` - BLoC event files
- `*_usecase.dart` - Use case files
- `*_assembly.dart` - DI assembly files

## Code Generation

When modifying models with `@JsonSerializable` annotation:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Testing

- Tests mirror `lib/` structure in `test/` directory
- Mock assemblies in `test/assembly/` for dependency injection in tests
- Mock implementations use `.m.dart` suffix (e.g., `cache_storage_mock.m.dart`)

## Environment Configuration

- Secrets stored in `.env/secrets.json` (not committed to git)
- Secrets accessed via `SecretsManager` at runtime
- Pass to build with: `--dart-define-from-file=.env/secrets.json`
- Environment can be switched at runtime via shake gesture (debug builds)

## Important Notes

- Always use `container.get<Type>()` for dependency access, never instantiate services directly
- BLoC events should extend `Equatable` for proper comparison
- API errors are automatically handled by `BaseBloc` - only handle specific cases in feature BLoCs
- When adding new routes, update both `Routes` enum and router configuration
- Localization files are auto-generated from `.arb` files via `flutter gen-l10n`

## Agentic Architecture

This project uses specialized skills and agents. When a request matches the triggers below, invoke the corresponding tool without waiting to be asked.

### Skills — inline consultation via Skill tool

Skills load reference documentation directly into the conversation. Use them for questions, pattern lookups, and "how to" guidance — not for autonomous implementation.

| Skill                | Invoke when the user asks about...                                                                                                                  |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| `flutter-animations` | Adding animations or transitions: `AnimatedContainer`, `Hero`, fade/slide effects, `AnimationController`, staggered sequences, physics-based motion |

### Agents — autonomous implementation via Task tool

Agents run as subprocesses and handle complete implementation tasks. Delegate to them when the work requires reading multiple files, making decisions, and writing code.

| Agent              | Invoke when...                                                                                                                                                                                                               |
| ------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `flutter-expert`   | Implementing or refactoring Flutter screens, Bloc modules, widgets, or use cases in this project                                                                                                                             |
| `mobile-developer` | Native iOS/Android code (method channels, `ChannelManager`), Fastlane pipelines, code signing, TestFlight/Play Store uploads, push notifications, deep linking                                                               |
| `qa-expert`        | Writing or improving test suites, `blocTest` coverage, widget tests, integration tests, test strategy for a module                                                                                                           |
| `ui-designer`      | Reviewing or improving the visual design of an already-functional screen: colors, typography, spacing, layout composition, navigation patterns, accessibility. Also when the design system needs to be consulted or extended |
| `error-detective`  | Complex bugs that span multiple layers (BLoC → repository → API → native) and are hard to reproduce or don't appear in Sentry                                                                                                |

### Routing rules

1. **Flutter is the default.** All Flutter widget/Bloc/navigation work uses `flutter-expert` agent. Only escalate to `mobile-developer` when native platform code or the CI/CD pipeline is involved.
2. **Animations get a skill, not an agent.** Unless the animation is part of a larger screen implementation — then the `flutter-expert` agent handles it.
3. **Agents can chain.** A design task may use one agent first for specs, then other to implement. A QA pass may follow any implementation task.
4. **Design always follows implementation.** `ui-designer` acts on functional screens, not wireframes or ideas.
