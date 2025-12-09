import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../services/api_key_service.dart';

class GenerationRepository {
  final ApiKeyService _apiKeyService;

  GenerationRepository(this._apiKeyService);

  // Phase 1: Generate Prompts with Gemini
  Future<List<String>> generatePrompts({
    required String theme,
    String? childName,
  }) async {
    final apiKey = await _apiKeyService.getApiKey();
    if (apiKey == null) {
      throw Exception('API Key not found');
    }

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.9,
        responseMimeType: 'application/json',
      ),
    );

    final nameContext = childName != null && childName.isNotEmpty
        ? 'Child\'s Name: "$childName"'
        : '';

    final prompt =
        '''
Generate 5 distinct, creative, and fun scene descriptions for a children's coloring book.

Theme: "$theme"
$nameContext

Requirements:
- Each description should be visual and suitable for black and white line art
- Ensure variety between all 5 scenes
- Keep descriptions simple and child-friendly
- If child's name provided, include it naturally (e.g., "A castle with $childName's name on a banner")

Return ONLY a JSON array of 5 strings with no additional text.

Example format:
["Scene 1 description", "Scene 2 description", ...]
''';

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      final text = response.text;

      if (text == null) throw Exception('Empty response from AI');

      // Clean markdown if present
      final cleanText = text
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      final List<dynamic> jsonList = jsonDecode(cleanText);
      return jsonList.cast<String>();
    } catch (e) {
      throw Exception('Failed to generate prompts: $e');
    }
  }

  // Phase 2: Generate Image (Stub/Placeholder for now)
  // In a real app, this would call Stability AI or DALL-E
  Future<String> generateImage(String prompt) async {
    // Simulating API latency
    await Future.delayed(const Duration(seconds: 3));

    // Return a placeholder URL or a mock asset path
    // For now, let's return a specific Unsplash URL that looks like a coloring page
    // or just a placeholder to prove the flow.
    return 'https://images.unsplash.com/photo-1544376798-89aa6b82c6cd?q=80&w=1000&auto=format&fit=crop';
  }
}
