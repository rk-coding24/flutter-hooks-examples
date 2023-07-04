import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:developer' as devtools show log;

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    ),
  );
}

const url =
    'https://images.unsplash.com/photo-1485529910432-783b455774fa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = useAppLifecycleState();
    devtools.log(state.toString());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Opacity(
            opacity: state == AppLifecycleState.resumed ? 1.0 : 0.0,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withAlpha(100),
                    spreadRadius: 10,
                  )
                ],
              ),
              child: Image.asset('assets/card.png'),
            ),
          ),
        ));
  }
}
