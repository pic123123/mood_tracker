import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/navigation/main_navigation.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  void _test(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainNavigationScreen(tab: 'home'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _test(context),
                child: const Text('Go to Home Screen'),
              ),
              const SizedBox(height: 20), // Add some space between the buttons
              ElevatedButton(
                onPressed: () => context.go('/post'),
                child: const Text('Go to Post Screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
