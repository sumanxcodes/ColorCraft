# Product Requirements Document (PRD): ColorCraft Kids

## 1. Executive Summary

**Product Name:** ColorCraft Kids  
**Platform:** iPad (iOS 15.0+)  
**Target Audience:** Children ages 4-12 and their parents  
**Core Concept:** An iPad-native application that uses AI (Google Gemini + Image Generation) to create custom coloring book pages based on user themes. Features a "Magic Paint" interface for digital coloring and exports print-ready PDFs.

**Key Differentiators:**
- AI-powered custom coloring page generation
- Child-friendly interface with playful design
- Advanced flood-fill and painting tools
- Multi-page PDF export for printing
- Parental controls and authentication

---

## 2. Technical Stack

### Core Framework
- **Framework:** Flutter (Latest Stable - 3.27.1 or newer)
- **Dart Version:** 3.10.3 (stable)
- **Platform:** iPad only (initial release)
- **Minimum iOS Version:** 15.0

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.6.1
  
  # Navigation
  go_router: ^14.6.2
  
  # Authentication
  firebase_auth: ^5.3.3
  google_sign_in: ^6.2.2
  sign_in_with_apple: ^6.1.3
  
  # AI Integration
  google_generative_ai: ^0.4.6
  http: ^1.2.2
  
  # Storage
  firebase_storage: ^12.3.6
  firebase_firestore: ^5.5.0
  flutter_secure_storage: ^9.2.2
  shared_preferences: ^2.3.3
  
  # Image Processing
  image: ^4.3.0
  
  # PDF Generation
  pdf: ^3.11.1
  printing: ^5.13.4
  
  # Drawing & Canvas
  flutter_drawing_board: ^1.0.0 (or custom implementation)
  
  # UI Components
  flutter_colorpicker: ^1.1.0
  
  # Utilities
  path_provider: ^2.1.5
  permission_handler: ^11.3.1
  intl: ^0.20.1
  uuid: ^4.5.1
```

---

## 3. Information Architecture

### User Flow
```
App Launch
  ↓
First Time User?
  ├─ YES → Onboarding (3 screens) → Authentication
  └─ NO → Authentication Check
         ↓
    Authenticated?
      ├─ YES → Main Gallery
      └─ NO → Login/Sign Up
              ↓
         Main Gallery (Split View)
              ↓
         ┌────┴────┐
    Create New    Open Existing
         ↓              ↓
    Theme Input    Magic Paint Editor
         ↓              ↓
    AI Generation  Color/Export
         ↓
    Gallery Updated
```

---

## 4. Feature Specifications

### 4.1 Onboarding Experience

**Requirement:** First-time users see a 3-step onboarding flow.

**Screens:**
1. **Welcome Screen**
   - Hero illustration (animated emoji or Lottie)
   - Headline: "Welcome to ColorCraft!"
   - Description: "Create magical coloring pages with the power of AI"
   - Progress indicator (1/3)
   - Buttons: "Skip" (top-right), "Next" (bottom)

2. **Paint & Color**
   - Illustration of painting tools
   - Headline: "Paint & Color"
   - Description: "Use our magic paint tools to bring your pages to life"
   - Progress indicator (2/3)
   - Buttons: "Skip", "Next"

3. **Save & Share**
   - Illustration of book/PDF
   - Headline: "Save & Share"
   - Description: "Create your own coloring book collection and export to PDF"
   - Progress indicator (3/3)
   - Button: "Get Started! ✨"

**Implementation Notes:**
- Store onboarding completion in `shared_preferences`
- Smooth page transitions with `PageView`
- Skip button bypasses to authentication

---

### 4.2 Authentication System

**Requirement:** Secure user authentication with multiple providers.

#### Sign In Screen
**Layout:** Split-screen design
- **Left Panel (40%):** Brand showcase
  - Animated logo (🎨)
  - App name: "ColorCraft Kids"
  - Tagline: "Where Imagination Comes to Life!"
  - Gradient background (#ff6b6b → #ee5a6f)
  
- **Right Panel (60%):** Sign In Form
  - Title: "Welcome Back!"
  - Subtitle: "Sign in to continue creating"
  - Social authentication buttons:
    - **Google Sign In** (Primary)
    - **Apple Sign In** (Required for App Store)
  - Divider: "OR"
  - Email input field
  - Password input field
  - "Forgot Password?" link
  - "Sign In ✨" button
  - Footer: "Don't have an account? Sign Up"

#### Sign Up Screen
**Layout:** Same split-screen design

- **Right Panel Form:**
  - Title: "Create Account"
  - Subtitle: "Join the creative adventure!"
  - Social authentication buttons (same as sign in)
  - Divider: "OR"
  - Child's Name input
  - Parent's Email input
  - Password input (min 8 characters)
  - "Create Account ✨" button
  - Footer: "Already have an account? Sign In"

#### Technical Implementation
```dart
// Firebase Authentication
- Email/Password: firebase_auth
- Google Sign In: google_sign_in + firebase_auth
- Apple Sign In: sign_in_with_apple + firebase_auth

// User Data Model
class AppUser {
  final String uid;
  final String email;
  final String? childName;
  final String? photoUrl;
  final AuthProvider provider; // email, google, apple
  final DateTime createdAt;
  final String? geminiApiKey; // Stored securely
}

// Firestore Structure
users/{uid}/
  - email
  - childName
  - createdAt
  - apiKey (encrypted)
  
  /pages/{pageId}/
    - prompt
    - imageUrl
    - createdAt
    - isColored
```

#### Security Requirements
- API keys stored in `flutter_secure_storage`
- User data in Firestore with security rules
- Email verification optional (parent decision)
- Password reset via Firebase Auth
- OAuth tokens managed by Firebase

---

### 4.3 API Key Management

**Requirement:** Users must provide their own Google Gemini API key.

**Flow:**
1. After authentication, check if user has API key in Firestore
2. If NO key:
   - Show modal overlay (cannot be dismissed)
   - Title: "🔑 API Key Required"
   - Description: "To generate coloring pages, you need a Google Gemini API key (free!)"
   - Link button: "Get Your Free API Key" → Opens browser to `ai.google.dev`
   - Text input for API key
   - "Validate & Save" button
3. Validation:
   - Test key with simple Gemini API call (`gemini-1.5-flash`)
   - If valid: Save to `flutter_secure_storage` + Firestore (encrypted)
   - If invalid: Show error message

**Implementation:**
```dart
class ApiKeyService {
  Future<bool> validateApiKey(String key) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: key,
      );
      await model.generateContent([Content.text('Hello')]);
      return true;
    } catch (e) {
      return false;
    }
  }
}
```

---

### 4.4 Main Gallery (Split View Layout)

**Platform:** iPad Optimized

#### Left Sidebar (380px width)
**Background:** Gradient (#fef6e4 → #f8e5c1)

**Components:**
1. **App Logo Section**
   - Animated emoji (🎨) with floating animation
   - App title: "ColorCraft Kids"
   - Tagline: "Create Your Magic!"

2. **Theme Input**
   - Label: "🎭 What do you want to draw?"
   - Text input with placeholder
   - Border: 3px solid #e8d4a8
   - Border radius: 18px

3. **Child Name Input (Optional)**
   - Label: "👤 Your Name (Optional)"
   - Text input
   - Used in prompts (e.g., "Emma's Dragon Castle")

4. **Quick Theme Chips**
   - Label: "⚡ Quick Ideas"
   - Grid: 2 columns
   - Themes:
     - 🦄 Unicorns
     - 🐉 Dragons
     - 🚀 Space
     - 🧚 Fairies
     - 🦖 Dinosaurs
     - 🌊 Ocean
     - 🏰 Castles
     - 🌈 Rainbows
   - On tap: Populate theme input

5. **Generate Button (Bottom)**
   - Text: "✨ Create Magic Pages!"
   - Full width
   - Gradient background (#ff6b6b → #ee5a6f)
   - On tap: Trigger AI generation flow

#### Right Content Area (Flex: 1)
**Background:** Gradient (#fff5f5 → #ffe8e8)

**Header Bar:**
- Title: "🌟 My Coloring Pages"
- Export button: "📄 Export to PDF"

**Gallery Grid:**
- 3 columns on iPad
- Gap: 25px
- Card components:
  - Aspect ratio: 3:4 (portrait)
  - Border: 3px solid #ffc0cb
  - Border radius: 20px
  - Shadow on hover
  - Badge: "New!" for pages < 24 hours old
  - Image preview (emoji placeholder initially)
  - Title text
  - Timestamp

**Empty State:**
- Large illustration
- Text: "No coloring pages yet!"
- Subtitle: "Create your first magical page"

---

### 4.5 AI Generation Pipeline

**Models Used:**
- **Text Generation:** `gemini-1.5-pro` or `gemini-1.5-flash` (Dart SDK 3.10.3 compatible)
- **Image Generation:** Stable Diffusion / DALL-E / Imagen (see note below)

**⚠️ IMPORTANT NOTE:**
Google Gemini does NOT generate images directly. You must use one of:
1. **Google Vertex AI + Imagen** (Requires Google Cloud setup)
2. **Stability AI** (StabilityAI API)
3. **OpenAI DALL-E** (OpenAI API)
4. **Replicate.com** (Multiple models available)

#### Phase 1: Prompt Generation (Ideation)

**Goal:** Generate 5 diverse scene descriptions for coloring pages.

**API Call:**
```dart
Model: gemini-1.5-pro
Temperature: 0.9 (high creativity)
Response Format: JSON

Prompt Template:
"""
Generate 5 distinct, creative, and fun scene descriptions for a children's coloring book.

Theme: "${theme}"
Child's Name (optional, use contextually if provided): "${childName}"

Requirements:
- Each description should be visual and suitable for black and white line art
- Ensure variety between all 5 scenes
- Keep descriptions simple and child-friendly
- If child's name provided, include it naturally (e.g., "A castle with ${childName}'s name on a banner")

Return ONLY a JSON array of 5 strings with no additional text.

Example format:
["Scene 1 description", "Scene 2 description", ...]
"""

Response Handling:
1. Parse JSON response
2. Clean any markdown artifacts (```json ... ```)
3. Validate array length = 5
4. Store prompts for next phase
```

#### Phase 2: Image Generation

**Goal:** Convert text descriptions to coloring page images.

**Option A: Using Stability AI (Recommended)**
```dart
API: https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image

Prompt Template per scene:
"""
A high-quality black and white coloring book page for children.
Subject: ${sceneDescription}
Style: Thick clean black outlines, simple shapes, pure white background, 
no shading, no grayscale, high contrast, vector-style line art, 
suitable for children ages 4-10.
"""

Configuration:
- Size: 1024x1024 (or 768x1024 for portrait)
- Steps: 30
- CFG Scale: 7
- Sampler: K_EULER
- Style Preset: line-art (if available)
```

**Option B: Using DALL-E 3**
```dart
API: OpenAI Image Generation

Prompt Template:
"""
Simple black and white coloring book page for children. ${sceneDescription}. 
Thick black outlines, no shading, no grayscale, pure white background, 
clean line art suitable for coloring.
"""

Configuration:
- Model: dall-e-3
- Size: 1024x1024
- Quality: standard
- Style: natural
```

**Post-Processing:**
1. Download image bytes
2. Convert to grayscale if needed using `image` package
3. Apply threshold to ensure pure black/white
4. Store in Firebase Storage
5. Save URL to Firestore

**Loading States:**
```
State 1: "✨ Thinking of ideas..." (0-5 seconds)
State 2: "🎨 Drawing page 1 of 5..." (5-30 seconds)
State 3: "🖌️ Almost done..." (Final touches)
State 4: "🌟 Pages ready!" (Complete)
```

**Error Handling:**
- API timeout: Retry with exponential backoff
- Invalid API key: Show error + link to settings
- Quota exceeded: Show upgrade message
- Network error: Offer retry

---

### 4.6 Magic Paint Editor (Canvas)

**Layout:** Full-screen with header and right sidebar toolbar

#### Editor Header
- Back button (←)
- Page title (e.g., "🦄 Unicorn Garden")
- Action buttons:
  - 💾 Save
  - 📤 Share
  - 🗑️ Delete

#### Canvas Area (Center, Flex: 1)
- White background with coloring page image
- Multi-touch gesture support
- Layers:
  1. **Background Layer:** The AI-generated line art (locked)
  2. **Drawing Layer:** User's paint strokes (editable)

#### Right Toolbar Panel (280px width)

**Section 1: Colors 🎨**
- Grid: 4 columns
- 12 preset colors:
  - Red (#ef4444)
  - Orange (#f97316)
  - Yellow (#facc15)
  - Light Green (#84cc16)
  - Green (#22c55e)
  - Cyan (#06b6d4)
  - Blue (#3b82f6)
  - Indigo (#6366f1)
  - Purple (#8b5cf6)
  - Violet (#a855f7)
  - Pink (#ec4899)
  - Rose (#f43f5e)
- Active state: Border highlight
- Tap to select color

**Section 2: Tools 🛠️**
- Grid: 2 columns
- 4 tools:
  1. **🖌️ Brush:** Free-form drawing
  2. **🪣 Fill Bucket:** Flood fill (see algorithm below)
  3. **🧹 Eraser:** Remove paint
  4. **↩️ Undo:** Undo last action (up to 50 steps)
- Active state: Gradient background

**Section 3: Brush Size 📏**
- Slider: 1-50
- Visual preview circle
- Default: 10

#### Drawing Implementation

**Technology Choice:**
- Use `CustomPainter` for drawing layer
- Use `GestureDetector` for touch input
- Store strokes in memory as `List<DrawingStroke>`

```dart
class DrawingStroke {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;
  final StrokeTool tool; // brush, eraser, fill
}

class ColoringCanvas extends StatefulWidget {
  final Uint8List backgroundImage;
  // ...
}
```

**Gesture Handling:**
```dart
GestureDetector(
  onPanStart: (details) {
    // Start new stroke
    currentStroke = DrawingStroke(
      points: [details.localPosition],
      color: selectedColor,
      strokeWidth: brushSize,
      tool: selectedTool,
    );
  },
  onPanUpdate: (details) {
    // Add points to current stroke
    currentStroke.points.add(details.localPosition);
    setState(() {}); // Redraw
  },
  onPanEnd: (details) {
    // Finalize stroke
    strokes.add(currentStroke);
    undoHistory.add(currentStroke);
  },
)
```

#### Flood Fill Algorithm

**Challenge:** Flutter's `CustomPainter` is vector-based, but flood fill is raster-based.

**Solution:** Use the `image` package for pixel manipulation.

**Implementation:**
```dart
import 'package:image/image.dart' as img;
import 'dart:collection'; // For Queue

Future<img.Image> floodFill({
  required img.Image sourceImage,
  required Offset tapPosition,
  required Color fillColor,
  required int tolerance,
}) async {
  // Convert to pixel buffer
  final image = img.copyResize(sourceImage, 
    width: sourceImage.width, 
    height: sourceImage.height
  );
  
  final x = tapPosition.dx.toInt();
  final y = tapPosition.dy.toInt();
  
  // Get target color at tap position
  final targetPixel = image.getPixel(x, y);
  final targetColor = img.ColorInt32.rgb(
    targetPixel.r.toInt(),
    targetPixel.g.toInt(),
    targetPixel.b.toInt(),
  );
  
  // If already same color, return
  if (_colorsMatch(targetColor, fillColor, 0)) {
    return image;
  }
  
  // Queue-based flood fill (non-recursive to avoid stack overflow)
  final queue = Queue<Point>();
  queue.add(Point(x, y));
  
  final visited = <Point>{};
  
  while (queue.isNotEmpty) {
    final point = queue.removeFirst();
    
    if (visited.contains(point)) continue;
    if (point.x < 0 || point.x >= image.width) continue;
    if (point.y < 0 || point.y >= image.height) continue;
    
    final currentPixel = image.getPixel(point.x, point.y);
    final currentColor = img.ColorInt32.rgb(
      currentPixel.r.toInt(),
      currentPixel.g.toInt(),
      currentPixel.b.toInt(),
    );
    
    // Check if color matches within tolerance
    if (!_colorsMatch(currentColor, targetColor, tolerance)) {
      continue;
    }
    
    // Fill pixel
    image.setPixel(point.x, point.y, img.ColorInt32.rgb(
      fillColor.red,
      fillColor.green,
      fillColor.blue,
    ));
    
    visited.add(point);
    
    // Add neighbors to queue
    queue.add(Point(point.x + 1, point.y));
    queue.add(Point(point.x - 1, point.y));
    queue.add(Point(point.x, point.y + 1));
    queue.add(Point(point.x, point.y - 1));
  }
  
  return image;
}

bool _colorsMatch(Color a, Color b, int tolerance) {
  final rDiff = (a.red - b.red).abs();
  final gDiff = (a.green - b.green).abs();
  final bDiff = (a.blue - b.blue).abs();
  
  return (rDiff + gDiff + bDiff) <= tolerance * 3;
}
```

**Tolerance Strategy:**
- **High-brightness pixels (white/near-white):** Tolerance = 120
  - Prevents bleeding into line art
- **Dark pixels (black lines):** Tolerance = 30
  - Crisp boundaries
- User-adjustable slider (future feature): 5-50 range

**Performance Optimization:**
- Run flood fill in `compute()` (isolate) to prevent UI freeze
- Show loading indicator during processing
- Limit canvas size to 2048x2048 max

```dart
// Run in background isolate
final filledImage = await compute(floodFill, FloodFillParams(
  sourceImage: canvasImage,
  tapPosition: tapPos,
  fillColor: selectedColor,
  tolerance: 120,
));
```

---

### 4.7 PDF Export

**Requirement:** Export coloring pages (colored or uncolored) to PDF for printing.

#### PDF Library
```dart
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
```

#### PDF Structure

**Page 1: Title Page**
```dart
pw.Page(
  build: (context) => pw.Center(
    child: pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Text(
          "${childName}'s",
          style: pw.TextStyle(fontSize: 48, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 20),
        pw.Text(
          "${theme}",
          style: pw.TextStyle(fontSize: 64, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          "A Coloring Adventure",
          style: pw.TextStyle(fontSize: 32),
        ),
      ],
    ),
  ),
)
```

**Pages 2-N: Coloring Pages**
```dart
for (var page in selectedPages) {
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(20),
      build: (context) => pw.Center(
        child: pw.Image(
          pw.MemoryImage(page.imageBytes),
          fit: pw.BoxFit.contain,
        ),
      ),
    ),
  );
}
```

#### Export Options
- **Export Single Page:** Current page only
- **Export Selected:** Multi-select from gallery
- **Export All:** Entire collection
- **Include Colored:** Toggle to include user's colored versions

#### Share Dialog
```dart
await Printing.sharePdf(
  bytes: await pdf.save(),
  filename: '${childName}_${theme}_${DateTime.now().millisecondsSinceEpoch}.pdf',
);
```

This opens iOS native share sheet:
- AirDrop
- Save to Files
- Print
- Share via apps

---

## 5. UI/UX Design System

### Typography
**Fonts:**
- **Fredoka** (Headers, Titles, Buttons)
  - Weights: 400, 600, 700
  - Characteristics: Rounded, playful, child-friendly
  - Usage: App title, screen titles, button labels
  
- **Quicksand** (Body, Inputs)
  - Weights: 400, 600, 700
  - Characteristics: Soft, readable, modern
  - Usage: Descriptions, input fields, helper text

**Font Sizes:**
```dart
// Headlines
h1: 3.5rem (56px) - Onboarding titles
h2: 2.5rem (40px) - Screen titles
h3: 2rem (32px) - Section headers
h4: 1.6rem (25.6px) - Card titles

// Body
body1: 1.2rem (19.2px) - Primary text
body2: 1rem (16px) - Secondary text
caption: 0.9rem (14.4px) - Timestamps, hints

// Buttons
button: 1.3rem (20.8px) - Primary actions
chip: 1.1rem (17.6px) - Theme chips
```

### Color Palette

**Brand Colors:**
```dart
// Primary Gradient
primaryStart: #ff6b6b (Coral Red)
primaryEnd: #ee5a6f (Deep Coral)
primaryDark: #c44569 (Burgundy)

// Accent
accentPink: #ffc0cb (Light Pink)
accentYellow: #fef6e4 (Cream)

// Backgrounds
bgLight: #fff5f5 (Pale Pink)
bgLightGradient: #fff5f5 → #ffe8e8
sidebarGradient: #fef6e4 → #f8e5c1

// Neutrals
textDark: #c44569
textMedium: #8b6914 (Brown)
borderLight: #e8d4a8 (Tan)
borderMedium: #ffc0cb (Pink)

// Semantic
success: #22c55e
error: #ef4444
warning: #f59e0b
info: #3b82f6
```

**Paint Palette (Editor):**
12 vibrant colors optimized for children:
```dart
colors: [
  #ef4444, //