import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:colorcraft_kids/features/auth/presentation/providers/auth_provider.dart';
import 'package:colorcraft_kids/features/auth/presentation/pages/sign_in_page.dart';

import 'package:colorcraft_kids/features/gallery/presentation/pages/gallery_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isLoading = authState.isLoading;
      final hasError = authState.hasError;
      final isAuthenticated = authState.asData?.value.isNotEmpty ?? false;

      final isSignInRoute = state.matchedLocation == '/sign-in';

      if (isLoading || hasError) return null;

      if (!isAuthenticated && !isSignInRoute) {
        return '/sign-in';
      }

      if (isAuthenticated && isSignInRoute) {
        return '/'; // Redirect to home if already signed in
      }

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const GalleryPage()),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInPage(),
      ),
    ],
  );
});
