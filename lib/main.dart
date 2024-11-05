import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/firebase_options.dart';
import 'package:tech_gate/widgets/auth_wrapper.dart'; // Import the AuthWrapper
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print("Before loading .env file");
  await dotenv.load(fileName: ".env");
  print("After loading .env file");

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(ProviderScope(child: MyApp()));
  } catch (e) {
    print("Firebase initialization failed: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Gate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFEC1D3B), // Red from the logo
        scaffoldBackgroundColor:
            const Color(0xFF03222C), // Dark teal background
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFFEC1D3B), // AppBar in red
          foregroundColor: Colors.white, // White text in the AppBar
        ),
        colorScheme: ColorScheme(
          primary: const Color(0xFFEC1D3B), // Red as the primary color
          secondary:
              const Color(0xFF03222C), // Dark teal as the secondary color
          surface: Colors.white, // White surface color for contrast
          background: const Color(0xFF03222C), // Dark teal background
          error: Colors.red, // Standard error color
          onPrimary: Colors.white, // Text on red should be white
          onSecondary: Colors.white, // Text on dark teal should also be white
          onSurface: Colors.black, // Text on white surfaces should be black
          onBackground: Colors.white, // Text on dark teal should be white
          onError: Colors.white, // Text on error (red) should be white
          brightness: Brightness.dark, // Dark theme overall
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.white), // Large text in white
          titleMedium: TextStyle(color: Colors.white), // Medium text in white
          titleSmall: TextStyle(color: Colors.white), // Small text in white
          bodyLarge: TextStyle(color: Colors.white), // Body text in white
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFFEC1D3B), // Red button color
          textTheme: ButtonTextTheme.primary, // Button text in white
        ),
        useMaterial3: true,
      ),
      home: AuthWrapper(), // Use AuthWrapper as the home screen
    );
  }
}
