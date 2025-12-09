import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/generation_repository.dart';
import '../../data/services/api_key_service.dart';

// Service Provider
final apiKeyServiceProvider = Provider((ref) => ApiKeyService());

// Repository Provider
final generationRepositoryProvider = Provider((ref) {
  final apiKeyService = ref.watch(apiKeyServiceProvider);
  return GenerationRepository(apiKeyService);
});

// AsyncNotifier: Manages the state of generated images
class GenerationController extends AsyncNotifier<List<Uint8List>> {
  @override
  FutureOr<List<Uint8List>> build() {
    return [];
  }

  Future<void> createMagicPages(String theme, String? childName) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(generationRepositoryProvider);

      // 1. Generate Prompts (Phase 1)
      final prompts = await repository.generatePrompts(
        theme: theme,
        childName: childName,
      );

      if (prompts.isEmpty) return [];

      // 2. Generate Image (Phase 2 - Real API call)
      // Taking the first prompt to generate one image for now.
      final imageBytes = await repository.generateImage(prompts.first);

      return [imageBytes];
    });
  }
}

final generationProvider =
    AsyncNotifierProvider<GenerationController, List<Uint8List>>(() {
      return GenerationController();
    });
