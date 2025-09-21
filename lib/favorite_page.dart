import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteProducts;
  final Function(Map<String, dynamic>) onRemoveFavorite;

  const FavoritePage({
    required this.favoriteProducts,
    required this.onRemoveFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF0F5), // Lavender blush background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: favoriteProducts.isEmpty
            ? Center(
                child: Text(
                  'No favorite products yet!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFF69B4), // Hot pink text
                  ),
                ),
              )
            : GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: favoriteProducts.map((product) {
                  return GestureDetector(
                    onTap: () {}, // Optional: handle card tap if needed
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF0F5), // Lavender blush background
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color(
                              0xFFFFB6C1,
                            ).withOpacity(0.6), // Light pink shadow
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                        border: Border.all(
                          color: Color(0xFFFF69B4), // Hot pink border
                          width: 1.5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 26.0),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  product['imageUrl'],
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  product['title'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(
                                      0xFFC71585,
                                    ), // Medium violet red
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '\$${product['price']}',
                                  style: TextStyle(
                                    color: Color(0xFFFF69B4), // Hot pink
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            // Cancel icon
                            Positioned(
                              top: 145,
                              right: 8,
                              child: IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: Color(0xFFFF1493), // Deep pink
                                  size: 28,
                                ),
                                onPressed: () =>
                                    onRemoveFavorite(product), // Remove product
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
