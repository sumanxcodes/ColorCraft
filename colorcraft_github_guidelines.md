# ColorCraft Kids - AI Agent Development Guidelines

## 📋 Project Overview

**Repository:** `colorcraft-kids`  
**Platform:** iPad (iOS 15.0+)  
**Framework:** Flutter 3.38.4  
**Dart Version:** 3.10.3 (stable)  
**Target Audience:** Children ages 4-12

---

## 🎯 Core Mission

Build an AI-powered iPad app that generates custom coloring book pages using Google Gemini, with an intuitive painting interface and PDF export capabilities.

---

## 📁 Repository Structure

```
colorcraft-kids/
├── .github/
│   ├── workflows/
│   │   ├── ci.yml                    # Continuous Integration
│   │   ├── release.yml               # App Store release automation
│   │   └── pr-checks.yml             # PR validation
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md
│   │   ├── feature_request.md
│   │   └── enhancement.md
│   └── pull_request_template.md
├── lib/
│   ├── main.dart                     # App entry point
│   ├── app.dart                      # Root MaterialApp widget
│   ├── config/
│   │   ├── theme.dart                # App theme & design tokens
│   │   ├── routes.dart               # GoRouter configuration
│   │   └── firebase_options.dart    # Firebase config (generated)
│   ├── core/
│   │   ├── constants/
│   │   │   ├── colors.dart           # Color palette
│   │   │   ├── typography.dart       # Text styles
│   │   │   └── dimensions.dart       # Spacing, sizes
│   │   ├── utils/
│   │   │   ├── validators.dart       # Input validation
│   │   │   ├── formatters.dart       # Date/time formatting
│   │   │   └── extensions.dart       # Dart extensions
│   │   └── errors/
│   │       ├── exceptions.dart       # Custom exceptions
│   │       └── failures.dart         # Error handling
│   ├── features/
│   │   ├── onboarding/
│   │   │   ├── presentation/
│   │   │   │   ├── pages/
│   │   │   │   │   └── onboarding_page.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── onboarding_screen.dart
│   │   │   │       └── page_indicator.dart
│   │   │   └── providers/
│   │   │       └── onboarding_provider.dart
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   └── app_user.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── auth_repository.dart
│   │   │   │   └── services/
│   │   │   │       └── firebase_auth_service.dart
│   │   │   ├── presentation/
│   │   │   │   ├── pages/
│   │   │   │   │   ├── sign_in_page.dart
│   │   │   │   │   └── sign_up_page.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── auth_button.dart
│   │   │   │       └── auth_text_field.dart
│   │   │   └── providers/
│   │   │       └── auth_provider.dart
│   │   ├── api_key/
│   │   │   ├── data/
│   │   │   │   └── services/
│   │   │   │       └── api_key_service.dart
│   │   │   ├── presentation/
│   │   │   │   └── pages/
│   │   │   │       └── api_key_setup_page.dart
│   │   │   └── providers/
│   │   │       └── api_key_provider.dart
│   │   ├── gallery/
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   └── coloring_page.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── gallery_repository.dart
│   │   │   │   └── services/
│   │   │   │       └── firestore_service.dart
│   │   │   ├── presentation/
│   │   │   │   ├── pages/
│   │   │   │   │   └── gallery_page.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── theme_input_sidebar.dart
│   │   │   │       ├── quick_theme_chip.dart
│   │   │   │       ├── gallery_grid.dart
│   │   │   │       └── page_card.dart
│   │   │   └── providers/
│   │   │       └── gallery_provider.dart
│   │   ├── generation/
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   └── generation_state.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── generation_repository.dart
│   │   │   │   └── services/
│   │   │   │       ├── gemini_service.dart
│   │   │   │       ├── image_generation_service.dart  # Stability AI / DALL-E
│   │   │   │       └── firebase_storage_service.dart
│   │   │   ├── presentation/
│   │   │   │   └── widgets/
│   │   │   │       └── generation_progress_dialog.dart
│   │   │   └── providers/
│   │   │       └── generation_provider.dart
│   │   ├── editor/
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   ├── drawing_stroke.dart
│   │   │   │   │   └── stroke_tool.dart
│   │   │   │   └── services/
│   │   │   │       ├── canvas_service.dart
│   │   │   │       └── flood_fill_service.dart
│   │   │   ├── presentation/
│   │   │   │   ├── pages/
│   │   │   │   │   └── editor_page.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── coloring_canvas.dart
│   │   │   │       ├── color_picker_panel.dart
│   │   │   │       ├── tool_selector.dart
│   │   │   │       └── brush_size_slider.dart
│   │   │   └── providers/
│   │   │       └── editor_provider.dart
│   │   └── export/
│   │       ├── data/
│   │       │   └── services/
│   │       │       └── pdf_service.dart
│   │       ├── presentation/
│   │       │   └── widgets/
│   │       │       └── export_dialog.dart
│   │       └── providers/
│   │           └── export_provider.dart
│   └── shared/
│       └── widgets/
│           ├── loading_indicator.dart
│           ├── error_dialog.dart
│           ├── primary_button.dart
│           └── custom_text_field.dart
├── assets/
│   ├── images/
│   │   ├── logo.png
│   │   └── onboarding/
│   ├── fonts/
│   │   ├── Fredoka/
│   │   └── Quicksand/
│   └── animations/
│       └── lottie/
├── test/
│   ├── unit/
│   ├── widget/
│   └── integration/
├── .gitignore
├── pubspec.yaml
├── README.md
├── CONTRIBUTING.md
├── LICENSE
└── CHANGELOG.md
```

---

## 🔧 Development Standards

### Code Style & Formatting

1. **Dart Formatting:**
   - Always run `dart format .` before committing
   - Line length: 80 characters
   - Use trailing commas for better diffs

2. **Linting:**
   - Follow `flutter_lints` package rules
   - Enable additional rules in `analysis_options.yaml`:
     ```yaml
     linter:
       rules:
         - prefer_const_constructors
         - prefer_const_literals_to_create_immutables
         - avoid_print
         - avoid_unnecessary_containers
         - sized_box_for_whitespace
     ```

3. **Naming Conventions:**
   - Classes: `PascalCase` (e.g., `ColoringCanvas`)
   - Files: `snake_case` (e.g., `coloring_canvas.dart`)
   - Variables: `camelCase` (e.g., `selectedColor`)
   - Constants: `lowerCamelCase` (e.g., `kPrimaryColor`)
   - Private members: Prefix with `_` (e.g., `_drawStroke`)

### Architecture Pattern

**Feature-First Clean Architecture:**

```
feature/
├── data/
│   ├── models/           # Data models (fromJson, toJson)
│   ├── repositories/     # Abstract data access layer
│   └── services/         # External API/SDK interactions
├── presentation/
│   ├── pages/            # Full-screen pages
│   └── widgets/          # Reusable UI components
└── providers/            # Riverpod state management
```

**Key Principles:**
- **Separation of Concerns:** UI, business logic, and data layers are independent
- **Dependency Injection:** Use Riverpod providers
- **Testability:** All services should be mockable
- **Single Responsibility:** Each class has one job

### State Management (Riverpod)

```dart
// Provider example
@riverpod
class GalleryNotifier extends _$GalleryNotifier {
  @override
  Future<List<ColoringPage>> build() async {
    return await ref.read(galleryRepositoryProvider).getPages();
  }

  Future<void> addPage(ColoringPage page) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(galleryRepositoryProvider).savePage(page);
      return [...state.value ?? [], page];
    });
  }
}

// Usage in widgets
class GalleryGrid extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagesAsync = ref.watch(galleryNotifierProvider);
    
    return pagesAsync.when(
      data: (pages) => GridView.builder(...),
      loading: () => LoadingIndicator(),
      error: (err, stack) => ErrorDialog(error: err),
    );
  }
}
```

---

## 🚀 Git Workflow

### Branch Naming

```
feature/auth-google-signin
feature/editor-flood-fill
bugfix/canvas-memory-leak
hotfix/api-key-validation
chore/update-dependencies
docs/update-readme
refactor/simplify-generation-flow
```

### Commit Message Format

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code formatting (no logic change)
- `refactor`: Code restructuring (no feature/fix)
- `perf`: Performance improvements
- `test`: Adding/updating tests
- `chore`: Build/tooling changes

**Examples:**
```
feat(editor): implement flood fill algorithm

Add queue-based flood fill with tolerance control.
Runs in isolate to prevent UI blocking.

Closes #45

---

fix(auth): handle apple sign-in cancellation

Previously crashed when user cancelled Apple Sign In flow.
Now returns gracefully to login screen.

Fixes #78

---

docs(readme): add installation instructions

Added step-by-step guide for setting up development environment
and Firebase configuration.
```

### Pull Request Process

1. **Create Feature Branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Develop & Test:**
   - Write unit tests for business logic
   - Write widget tests for UI components
   - Test on physical iPad device

3. **Pre-PR Checklist:**
   - [ ] Code formatted (`dart format .`)
   - [ ] No linting errors (`flutter analyze`)
   - [ ] All tests passing (`flutter test`)
   - [ ] Updated `CHANGELOG.md`
   - [ ] Added/updated documentation
   - [ ] Tested on iPad (multiple sizes if possible)

4. **Create Pull Request:**
   - Use PR template (auto-populated)
   - Link related issues
   - Add screenshots/videos for UI changes
   - Request review from 1+ team members

5. **PR Review Criteria:**
   - Code follows architecture patterns
   - Adequate test coverage (>70%)
   - No breaking changes without migration plan
   - Performance considerations addressed
   - Accessibility standards met

6. **Merge Strategy:**
   - Squash and merge for feature branches
   - Fast-forward merge for hotfixes
   - Delete branch after merge

---

## 🧪 Testing Standards

### Test Coverage Requirements

- **Unit Tests:** >80% coverage for services/repositories
- **Widget Tests:** All custom widgets
- **Integration Tests:** Critical user flows

### Test Structure

```dart
// Unit Test Example
void main() {
  group('FloodFillService', () {
    late FloodFillService service;
    
    setUp(() {
      service = FloodFillService();
    });
    
    test('should fill connected pixels with same color', () async {
      // Arrange
      final image = createTestImage();
      final tapPosition = Offset(50, 50);
      
      // Act
      final result = await service.floodFill(
        sourceImage: image,
        tapPosition: tapPosition,
        fillColor: Colors.red,
        tolerance: 10,
      );
      
      // Assert
      expect(result.getPixel(50, 50).red, equals(255));
    });
  });
}

// Widget Test Example
void main() {
  testWidgets('PrimaryButton shows loading indicator when loading',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            text: 'Submit',
            isLoading: true,
            onPressed: () {},
          ),
        ),
      ),
    );
    
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Submit'), findsNothing);
  });
}
```

### Mock Data

Create test fixtures in `test/fixtures/`:
```dart
// test/fixtures/coloring_page_fixtures.dart
class ColoringPageFixtures {
  static ColoringPage unicornPage() {
    return ColoringPage(
      id: 'test-1',
      userId: 'user-123',
      prompt: 'Unicorns',
      sceneDescription: 'A magical unicorn in a rainbow garden',
      originalImageUrl: 'https://example.com/image.png',
      createdAt: DateTime(2024, 1, 1),
      isColored: false,
      strokeCount: 0,
    );
  }
}
```

---

## 📦 Dependency Management

### Adding Dependencies

1. **Check compatibility:**
   - Dart SDK: 3.10.3+
   - Flutter: 3.27.1+
   - iOS: 15.0+

2. **Add to `pubspec.yaml`:**
   ```yaml
   dependencies:
     package_name: ^x.y.z
   ```

3. **Update lockfile:**
   ```bash
   flutter pub get
   ```

4. **Document in PR:**
   - Why is this dependency needed?
   - What alternatives were considered?
   - What's the bundle size impact?

### Version Constraints

- Use `^` for semantic versioning (e.g., `^2.0.0`)
- Lock critical dependencies with exact versions
- Avoid mixing major versions

### Dependency Audit

Run quarterly security audits:
```bash
flutter pub outdated
dart pub audit
```

---

## 🔐 Security Guidelines

### API Key Management

**❌ NEVER commit:**
- API keys
- Firebase config files (use `.gitignore`)
- User credentials
- Private certificates

**✅ DO:**
- Use `flutter_secure_storage` for runtime secrets
- Store encrypted hashes in Firestore
- Use environment variables for CI/CD
- Include `google-services.json` / `GoogleService-Info.plist` in `.gitignore`

### Firebase Security Rules

```javascript
// Firestore rules example
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      
      match /pages/{pageId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }
}
```

### Data Privacy

- No PII (Personally Identifiable Information) in logs
- Encrypt sensitive data at rest
- GDPR/COPPA compliance for children's data
- Implement data deletion on user request

---

## 🎨 Design Implementation

### Accessing Design Tokens

```dart
// Use constants from core/constants/
import 'package:colorcraft_kids/core/constants/colors.dart';
import 'package:colorcraft_kids/core/constants/typography.dart';
import 'package:colorcraft_kids/core/constants/dimensions.dart';

// Usage
Container(
  decoration: BoxDecoration(
    gradient: AppColors.primaryGradient,
    borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
  ),
  child: Text(
    'Hello',
    style: AppTypography.h2,
  ),
)
```

### Custom Fonts

Add to `pubspec.yaml`:
```yaml
flutter:
  fonts:
    - family: Fredoka
      fonts:
        - asset: assets/fonts/Fredoka/Fredoka-Regular.ttf
        - asset: assets/fonts/Fredoka/Fredoka-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Fredoka/Fredoka-Bold.ttf
          weight: 700
    - family: Quicksand
      fonts:
        - asset: assets/fonts/Quicksand/Quicksand-Regular.ttf
        - asset: assets/fonts/Quicksand/Quicksand-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Quicksand/Quicksand-Bold.ttf
          weight: 700
```

### Responsive Layout

```dart
class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width >= 1024) {
      // iPad Pro 12.9"
      return _buildLargeLayout();
    } else if (width >= 834) {
      // iPad Pro 11"
      return _buildMediumLayout();
    } else {
      // iPad Mini
      return _buildSmallLayout();
    }
  }
}
```

---

## 🐛 Debugging & Logging

### Logging Levels

```dart
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
  ),
);

// Usage
logger.d('Debug message'); // Development only
logger.i('Info message');  // General information
logger.w('Warning');       // Potential issues
logger.e('Error occurred', error, stackTrace); // Errors
```

### Error Handling

```dart
try {
  await service.generateImages();
} on FirebaseException catch (e) {
  logger.e('Firebase error', e, e.stackTrace);
  _showErrorDialog('Failed to save image. Please try again.');
} on ApiException catch (e) {
  logger.e('API error', e, e.stackTrace);
  _showErrorDialog('Generation failed: ${e.message}');
} catch (e, stackTrace) {
  logger.e('Unexpected error', e, stackTrace);
  _showErrorDialog('Something went wrong. Please try again.');
}
```

---

## 📊 Performance Optimization

### Best Practices

1. **Image Optimization:**
   - Compress images before upload
   - Use `CachedNetworkImage` for remote images
   - Limit canvas size to 2048x2048

2. **Isolate Usage:**
   - Run flood fill in `compute()`
   - Process large images in background

3. **Memory Management:**
   - Dispose controllers in `dispose()`
   - Clear image caches periodically
   - Use `AutomaticKeepAliveClientMixin` sparingly

4. **Build Optimization:**
   - Use `const` constructors
   - Split large widgets
   - Avoid rebuilding entire trees

### Performance Monitoring

```dart
// Measure operation time
final stopwatch = Stopwatch()..start();
await service.generateImage();
stopwatch.stop();
logger.i('Image generation took: ${stopwatch.elapsedMilliseconds}ms');
```

---

## 🚢 Release Process

### Version Numbering

Follow semantic versioning: `MAJOR.MINOR.PATCH`

```yaml
# pubspec.yaml
version: 1.2.3+10
#         │ │ │  └─ Build number (increments with each build)
#         │ │ └──── Patch (bug fixes)
#         │ └────── Minor (new features, backwards compatible)
#         └──────── Major (breaking changes)
```

### Pre-Release Checklist

- [ ] All tests passing
- [ ] No `TODO` or `FIXME` in production code
- [ ] Updated `CHANGELOG.md`
- [ ] Version number bumped in `pubspec.yaml`
- [ ] App Store screenshots updated
- [ ] Privacy policy reviewed
- [ ] TestFlight beta tested
- [ ] App Store metadata updated

### Release Notes Template

```markdown
## Version 1.2.0 (Build 10)

### ✨ New Features
- Added flood fill tool for easier coloring
- Export multiple pages to single PDF

### 🐛 Bug Fixes
- Fixed canvas freezing on large images
- Resolved Apple Sign-In crash on iOS 17

### 🎨 Improvements
- Faster AI generation (20% speed increase)
- Better color picker UI

### 📱 Compatibility
- iOS 15.0+
- iPad Mini (6th gen) and later recommended
```

---

## 🆘 Common Issues & Solutions

### Issue: Build fails with "Pod install failed"

**Solution:**
```bash
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
cd ..
flutter clean
flutter pub get
flutter run
```

### Issue: Firebase not initialized

**Solution:**
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

### Issue: Image package version conflicts

**Solution:**
```bash
flutter pub upgrade
flutter pub get
# Check analysis_options.yaml for specific version constraints
```

---

## 📚 Documentation Standards

### Code Comments

```dart
/// Generates coloring book pages using AI.
///
/// Takes a [theme] and optional [childName] and returns a list of
/// [ColoringPage] objects. This is a two-phase process:
/// 1. Generate scene descriptions using Gemini
/// 2. Convert descriptions to images using Stability AI
///
/// Throws [ApiException] if API calls fail.
/// Throws [StorageException] if Firebase upload fails.
///
/// Example:
/// ```dart
/// final pages = await service.generatePages(
///   theme: 'Unicorns',
///   childName: 'Emma',
/// );
/// ```
class GenerationService {
  // Implementation...
}
```

### README Requirements

Every feature directory should have a `README.md`:

```markdown
# Gallery Feature

## Overview
Displays user's coloring page collection in a responsive grid layout.

## Components
- `GalleryPage`: Main page with split-view layout
- `ThemeInputSidebar`: Left sidebar for creating new pages
- `GalleryGrid`: Grid display of existing pages
- `PageCard`: Individual page preview card

## State Management
Uses `GalleryNotifier` (Riverpod) to manage page list.

## Dependencies
- firebase_firestore: Fetching pages
- cached_network_image: Image loading
- intl: Date formatting

## Testing
- Unit tests: `test/unit/gallery/gallery_repository_test.dart`
- Widget tests: `test/widget/gallery/gallery_grid_test.dart`
```

---

## 🤝 Code Review Checklist

### For Authors

- [ ] Self-reviewed code before requesting review
- [ ] Added tests for new functionality
- [ ] Updated documentation
- [ ] Checked for console warnings
- [ ] Tested on physical iPad device
- [ ] Ensured accessibility compliance
- [ ] Verified no performance regressions

### For Reviewers

- [ ] Code follows architecture patterns
- [ ] Business logic is testable
- [ ] UI matches design specifications
- [ ] Error handling is comprehensive
- [ ] No hardcoded values (use constants)
- [ ] Naming is clear and consistent
- [ ] Comments explain "why" not "what"
- [ ] No unnecessary complexity

---

## 🎓 Learning Resources

### Flutter/Dart
- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

### Riverpod
- [Riverpod Documentation](https://riverpod.dev/)
- [Riverpod Architecture](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)

### Firebase
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Security Rules](https://firebase.google.com/docs/rules)

### AI Integration
- [Google Gemini API](https://ai.google.dev/docs)
- [Stability AI Documentation](https://platform.stability.ai/docs/api-reference)

---

## 📞 Support & Communication

### Getting Help

1. **Check Documentation:** Review this guide and feature READMEs
2. **Search Issues:** Someone may have encountered the same problem
3. **Ask in Discussions:** Use GitHub Discussions for questions
4. **Create Issue:** For bugs or feature requests

### Issue Reporting

Use the appropriate template:
- Bug Report: For reproducible errors
- Feature Request: For new functionality
- Enhancement: For improvements to existing features

**Required Information:**
- Flutter/Dart version (`flutter --version`)
- Device model (e.g., "iPad Pro 11" 2021")
- iOS version
- Steps to reproduce
- Expected vs actual behavior
- Screenshots/videos if applicable

---

## ✅ Quick Reference

### Daily Development Workflow

```bash
# Start work
git checkout develop
git pull origin develop
git checkout -b feature/my-feature

# During development
flutter pub get                    # After changing dependencies
dart format .                      # Format code
flutter analyze                    # Check for issues
flutter test                       # Run tests

# Before committing
git add .
git commit -m "feat(scope): description"
git push origin feature/my-feature

# Create PR on GitHub
```

### Common Commands

```bash
# Clean build
flutter clean && flutter pub get

# Run on device
flutter run -d <device-id>

# Build release
flutter build ipa --release

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Update dependencies
flutter pub upgrade --major-versions
```

---

## 🏆 Best Practices Summary

1. **Code Quality:** Format, lint, and test before every commit
2. **Architecture:** Follow feature-first clean architecture
3. **State Management:** Use Riverpod for all state
4. **Testing:** Write tests as you develop, not after
5. **Documentation:** Comment complex logic, document public APIs
6. **Security:** Never commit secrets, encrypt sensitive data
7. **Performance:** Profile before optimizing, use isolates for heavy work
8. **Accessibility:** Test with VoiceOver, ensure sufficient contrast
9. **Git:** Small, focused commits with clear messages
10. **Communication:** Over-communicate in PRs, be respectful in reviews

---

**Last Updated:** December 2024  
**Document Version:** 1.0.0  
**Maintainers:** ColorCraft Kids Development Team

---
## 📦 Github Repository
GitHub Repository: git@github.com:sumanxcodes/ColorCraft.git

**Use this key**
ssh-add ~/.ssh/id_ed25519_lora
