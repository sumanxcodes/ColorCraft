import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ApiKeyService {
  final _storage = const FlutterSecureStorage();
  static const _keyParams = 'gemini_api_key';

  // Check if key exists
  Future<bool> hasKey() async {
    final key = await _storage.read(key: _keyParams);
    if (key != null && key.isNotEmpty) return true;

    // Check environment variable as fallback (for dev)
    const envKey = String.fromEnvironment('GEMINI_API_KEY');
    return envKey.isNotEmpty;
  }

  // Get the key
  Future<String?> getApiKey() async {
    // 1. Check Secure Storage
    final storedKey = await _storage.read(key: _keyParams);
    if (storedKey != null && storedKey.isNotEmpty) return storedKey;

    // 2. Check Environment (compile-time)
    const envKey = String.fromEnvironment('GEMINI_API_KEY');
    if (envKey.isNotEmpty) return envKey;

    return null;
  }

  // Save key
  Future<void> saveApiKey(String key) async {
    await _storage.write(key: _keyParams, value: key);
  }

  // Validate key
  Future<bool> validateApiKey(String key) async {
    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: key);
      await model.generateContent([Content.text('Hello')]);
      return true;
    } catch (e) {
      return false;
    }
  }
}
