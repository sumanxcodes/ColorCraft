import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
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

  // Phase 2: Generate Image with Two-Tiered Logic
  Future<Uint8List> generateImage(String prompt) async {
    final apiKey = await _apiKeyService.getApiKey();
    if (apiKey == null) throw Exception('API Key not found');

    try {
      // 1. Try Primary Model (Pro - High Res)
      return await _callImageGenerationApi(
        apiKey: apiKey,
        modelName: 'gemini-3-pro-image-preview',
        prompt: prompt,
        aspectRatio: '3:4', // Portrait
        sampleCount: 1,
      );
    } catch (e) {
      if (e.toString().contains('403') ||
          e.toString().contains('PermissionDenied')) {
        // 2. Fallback to Flash (Low Res) on Permission Error
        return await _callImageGenerationApi(
          apiKey: apiKey,
          modelName: 'gemini-2.5-flash-image',
          prompt: prompt,
          aspectRatio:
              '1:1', // Flash might not support all aspect ratios, defaulting safe
          sampleCount: 1,
        );
      }
      rethrow;
    }
  }

  Future<Uint8List> _callImageGenerationApi({
    required String apiKey,
    required String modelName,
    required String prompt,
    required String aspectRatio,
    required int sampleCount,
  }) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/$modelName:predict',
    );

    final headers = {
      'Content-Type': 'application/json',
      'x-goog-api-key': apiKey,
    };

    final body = jsonEncode({
      'instances': [
        {
          'prompt':
              'High quality coloring page for kids. $prompt. Black and white line art, no shading, white background.',
        },
      ],
      'parameters': {
        'sampleCount': sampleCount,
        // Pro model specific config
        if (modelName.contains('pro')) 'aspectRatio': aspectRatio,
      },
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      // Parse response. Structure varies but typically:
      // { "predictions": [ { "bytesBase64Encoded": "..." } ] }
      final predictions = json['predictions'] as List;
      if (predictions.isNotEmpty) {
        final base64Image = predictions[0]['bytesBase64Encoded'] as String;
        return base64Decode(base64Image);
      }
      throw Exception('No image data in response');
    } else {
      throw Exception(
        'Image Gen Failed: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
