import 'package:flutter/material.dart';
import 'package:telemetria/pages/fullscreenmap.dart';

class PageMapa extends StatelessWidget {
  const PageMapa({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PageFullMap(),
    );
  }
}
