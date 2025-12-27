import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const oauthRedirectUrl = 'com.example.thunder://login-callback';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 100,
              child: const Text('Login', overflow: TextOverflow.ellipsis),
            ),
            SizedBox(
              width: 260,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await supabase.auth.signInWithOAuth(
                    OAuthProvider.google,
                    redirectTo: oauthRedirectUrl,
                  );
                },
                icon: const Icon(Icons.login),
                label: const Text('Continue with Google'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
