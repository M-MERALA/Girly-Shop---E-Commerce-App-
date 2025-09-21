import 'package:flutter/material.dart';
import 'product_page.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Set the initial route to splash screen
      initialRoute: '/splash',
      // Define the routes
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => ProductPage(),
      },
      // Optional: Customize the theme to match your girly color scheme
      theme: ThemeData(
        primaryColor: Color(0xFFFF69B4), // Hot pink
        colorScheme: ColorScheme.light(
          primary: Color(0xFFFF69B4), // Hot pink
          secondary: Color(0xFFFF1493), // Deep pink
          background: Color(0xFFFFF0F5), // Lavender blush
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFFB6C1), // Light pink
          titleTextStyle: TextStyle(
            color: Color(0xFFC71585), // Medium violet red
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Color(0xFFC71585), // Medium violet red
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFFF69B4)), // Hot pink
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFFF1493)), // Deep pink
          ),
          labelStyle: TextStyle(color: Color(0xFFDA70D6)), // Orchid
          filled: true,
          fillColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFF69B4), // Hot pink
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFFFF1493), // Deep pink
          ),
        ),
      ),
    );
  }
}
