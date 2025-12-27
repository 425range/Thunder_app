import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://qkijzqptexbbzpsjzmre.supabase.co';
const supabaseAnonKey = 'sb_publishable_wEh2RUmY4BiX8Ww1QyUVzg_1CgttVTN';

// 앱 딥링크 스킴(아래 Android/iOS 설정과 반드시 동일해야 함)
const oauthRedirectUrl = 'com.example.thunder://login-callback';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thunder',
      theme: ThemeData(useMaterial3: true),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = supabase.auth.currentSession;
        if (session != null) return const HomeScreen();
        return const LoginScreen();
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          TextButton(
            onPressed: () async => supabase.auth.signOut(),
            child: const Text('Logout'),
          ),
        ],
      ),
      body: const Center(child: Text('로그인 성공 ✅')),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 260,
          child: ElevatedButton.icon(
            onPressed: () async {
              await supabase.auth.signInWithOAuth(
                OAuthProvider.google,
                redirectTo: oauthRedirectUrl,
                queryParams: {'prompt': 'select_account'},
              );
            },
            icon: const Icon(Icons.login),
            label: const Text('Continue with Google'),
          ),
        ),
      ),
    );
  }
}
