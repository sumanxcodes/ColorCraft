import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:colorcraft_kids/features/auth/presentation/providers/auth_provider.dart';
import 'package:colorcraft_kids/features/auth/presentation/widgets/sign_in_button.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF9A9E), Color(0xFFFECFEF)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // TODO: Add Logo here
                const Icon(Icons.palette, size: 100, color: Colors.white),
                const SizedBox(height: 16),
                const Text(
                  'ColorCraft Kids',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Create, Color, & Share!',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
                const Spacer(),
                SignInButton(
                  text: 'Sign in with Google',
                  icon: FontAwesomeIcons.google,
                  onPressed: () {
                    ref.read(authRepositoryProvider).signInWithGoogle();
                  },
                ),
                SignInButton(
                  text: 'Sign in with Apple',
                  icon: FontAwesomeIcons.apple,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  onPressed: () {
                    ref.read(authRepositoryProvider).signInWithApple();
                  },
                ),
                SignInButton(
                  text: 'Continue as Guest',
                  icon: FontAwesomeIcons.user,
                  backgroundColor: Colors.grey[200]!,
                  textColor: Colors.black87,
                  onPressed: () {
                    ref.read(authRepositoryProvider).signInAnonymously();
                  },
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
