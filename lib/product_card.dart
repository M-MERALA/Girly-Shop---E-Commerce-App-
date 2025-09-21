import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final Map<String, dynamic> product;
  final bool isFavorite;
  final Function(Map<String, dynamic>) onFavoriteToggle;
  final Function(Map<String, dynamic>) onAddToCart;

  const ProductCard({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.product,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFF0F5), // Lavender blush background
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFFB6C1).withOpacity(0.6), // Light pink shadow
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
        border: Border.all(
          color: Color(0xFFFF69B4), // Hot pink border
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(imageUrl, height: 230, fit: BoxFit.cover),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFC71585), // Medium violet red
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis, // Handle overflow
              maxLines: 2,
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '\$$price',
                  style: TextStyle(
                    color: Color(0xFFFF69B4), // Hot pink
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite
                      ? Color(0xFFFF1493)
                      : Color(
                          0xFFDA70D6,
                        ), // Deep pink when favorite, orchid when not
                  size: 28,
                ),
                onPressed: () => onFavoriteToggle(product),
              ),
            ],
          ),
          // Add to cart button
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: ElevatedButton(
              onPressed: () => onAddToCart(product),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF69B4), // Hot pink background
                foregroundColor: Colors.white, // White text
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 40),
              ),
              child: Text(
                'Add to Cart',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
