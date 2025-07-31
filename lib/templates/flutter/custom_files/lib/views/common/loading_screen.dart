import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  final Future<Widget> Function(BuildContext context) futureBuilder;

  const LoadingScreen({super.key, required this.futureBuilder});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _loadAndNavigate();
  }

  Future<void> _loadAndNavigate() async {
    final targetScreen = await widget.futureBuilder(context);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => targetScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
