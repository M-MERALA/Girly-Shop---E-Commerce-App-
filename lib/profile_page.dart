import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF0F5), // Lavender blush background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar with a shadow effect
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(
                      0xFFFF69B4,
                    ).withOpacity(0.4), // Hot pink shadow
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 65,
                backgroundImage: AssetImage(
                  'images/WhatsApp Image 2024-12-26 at 14.53.18_c4e4e0f5.png',
                ), // Replace with actual image URL
                backgroundColor: Color(0xFFFFF0F5), // Lavender blush
              ),
            ),
            const SizedBox(height: 20),
            // Welcome back message
            Text(
              'Welcome back, Meral Mohammed!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC71585), // Medium violet red
              ),
            ),
            const SizedBox(height: 20),
            // Email Text with styling
            Text(
              'Email: Meralmohammed770@gmail.com',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFFF69B4), // Hot pink
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            // Phone number with styling
            Text(
              'Phone: +201000000000',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFFF69B4), // Hot pink
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            // Additional information section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFFFF0F5), // Lavender blush
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(
                      0xFFFFB6C1,
                    ).withOpacity(0.4), // Light pink shadow
                    blurRadius: 8,
                    spreadRadius: 4,
                  ),
                ],
                border: Border.all(
                  color: Color(0xFFFF69B4), // Hot pink border
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  // User's address (example)
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Color(0xFFFF1493),
                      ), // Deep pink
                      SizedBox(width: 10),
                      Text(
                        'Address: Eleman street, Egypt',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFC71585), // Medium violet red
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // User's date of birth (example)
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Color(0xFFFF1493),
                      ), // Deep pink
                      SizedBox(width: 10),
                      Text(
                        'Date of Birth: 00/00/0000',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFC71585), // Medium violet red
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Additional decorative elements
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFFFB6C1).withOpacity(0.3), // Light pink
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Premium Member',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFFF1493), // Deep pink
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
