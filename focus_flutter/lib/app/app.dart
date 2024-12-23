import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_flutter/app/routing.dart';
import 'package:google_fonts/google_fonts.dart';

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
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          surface: Colors.black,
        ),
      ),
      builder: (BuildContext context, Widget? child) {
        return Material(child: child);
      },
    );
  }
}
