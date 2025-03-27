import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: theme.textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Center(child: Text('Home')),
    );
  }
}
