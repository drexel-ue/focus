import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_flutter/app/routing.dart';

/// App.
@immutable
class FocusApp extends ConsumerWidget {
  /// Constructs a const [FocusApp].
  const FocusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Focus',
      routerConfig: ref.read(goRouterProvider),
      builder: (BuildContext context, Widget? child) {
        return Material(
          color: Colors.black,
          child: child,
        );
      },
    );
  }
}
