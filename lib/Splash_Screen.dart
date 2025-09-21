import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();

    // Simulate loading process
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF0F5), // Lavender blush background
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo/icon with girly colors
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Color(0xFFFFB6C1), // Light pink
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(
                        0xFFFF69B4,
                      ).withOpacity(0.4), // Hot pink shadow
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.shopping_bag,
                  size: 60,
                  color: Color(0xFFFF1493), // Deep pink
                ),
              ),
              SizedBox(height: 30),
              // App name with girly styling
              Text(
                'Girly Shop',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC71585), // Medium violet red
                  fontFamily: 'Pacifico', // Use a cute font if available
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Fashion & Accessories',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFFF69B4), // Hot pink
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 40),
              // Loading indicator
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFFFF1493),
                ), // Deep pink
              ),
            ],
          ),
        ),
      ),
    );
  }
}
