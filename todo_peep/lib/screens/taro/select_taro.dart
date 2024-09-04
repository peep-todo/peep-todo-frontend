import 'package:flutter/material.dart';

class SelectTaro extends StatelessWidget {
  const SelectTaro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF3F5FF),
              Color.fromRGBO(255, 255, 255, 1),
            ],
          ),
        ),
      ),
    );
  }
}
