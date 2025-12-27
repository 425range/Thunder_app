import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thunder'),
        actions: [
          TextButton(
            onPressed: () async => supabase.auth.signOut(),
            child: const Text('Logout'),
          ),
        ],
      ),
      body: const Center(child: Text('로그인 성공 ⚡')),
    );
  }
}
