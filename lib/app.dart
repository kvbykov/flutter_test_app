import 'package:flutter/material.dart';
import 'package:test_case/screens/main_page.dart';

class TestAppDependenciesProvider extends StatefulWidget {
  const TestAppDependenciesProvider({super.key});

  @override
  State<TestAppDependenciesProvider> createState() =>
      _TestAppDependenciesProviderState();
}

class _TestAppDependenciesProviderState
    extends State<TestAppDependenciesProvider> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class TestAppView extends StatefulWidget {
  const TestAppView({super.key});

  @override
  State<TestAppView> createState() => _TestAppViewState();
}

class _TestAppViewState extends State<TestAppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: const MainPage(),
    );
  }
}
