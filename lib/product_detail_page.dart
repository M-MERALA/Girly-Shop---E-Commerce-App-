import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;
  final Function(Map<String, dynamic>) onAddToCart;

  ProductDetailPage({required this.product, required this.onAddToCart});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  double selectedCount = 1;
  late double maxCount;

  @override
  void initState() {
    super.initState();
    maxCount = widget.product['count_of_product'].toDouble();
  }

  void addToCart() {
    if (selectedCount <= maxCount) {
      Map<String, dynamic> cartItem = {
        'title': widget.product['title'],
        'imageUrl': widget.product['imageUrl'],
        'price': widget.product['price'],
        'description': widget.product['description'],
        'rating': widget.product['rating'],
        'selectedCount': selectedCount.toInt(),
      };

      widget.onAddToCart(cartItem);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color(0xFFFFF0F5), // Lavender blush background
          title: Text(
            'Success',
            style: TextStyle(color: Color(0xFFFF69B4)),
          ), // Hot pink
          content: Text(
            'You have successfully added ${selectedCount.toInt()} of ${widget.product['title']} to the cart.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Color(0xFFFF69B4)), // Hot pink
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color(0xFFFFF0F5), // Lavender blush background
          title: Text(
            'Sorry',
            style: TextStyle(color: Color(0xFFFF69B4)),
          ), // Hot pink
          content: Text('The quantity selected exceeds available stock.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Color(0xFFFF69B4)), // Hot pink
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF0F5), // Lavender blush background
      appBar: AppBar(
        title: Text(
          widget.product['title'],
          style: TextStyle(color: Color(0xFFC71585)), // Medium violet red
        ),
        backgroundColor: Color(0xFFFFB6C1), // Light pink
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFC71585)), // Medium violet red
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xFFFF69B4), // Hot pink border
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.product['imageUrl'],
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                widget.product['description'],
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFFC71585), // Medium violet red
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 13),
              Text(
                'Price: \$${widget.product['price']}',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFFFF69B4), // Hot pink
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 13),
              Text(
                'Available: ${widget.product['count_of_product']}',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFDA70D6), // Orchid
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 13),
              Text(
                ' ⭐ ${widget.product['rating']}',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFFFF69B4), // Hot pink
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Select Quantity: ${selectedCount.toInt()}',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFC71585), // Medium violet red
                  fontWeight: FontWeight.bold,
                ),
              ),
              Slider(
                activeColor: Color(0xFFFF69B4), // Hot pink
                inactiveColor: Color(0xFFFFB6C1), // Light pink
                thumbColor: Color(0xFFFF1493), // Deep pink
                value: selectedCount,
                min: 1,
                max: maxCount,
                divisions: maxCount.toInt(),
                label: selectedCount.toInt().toString(),
                onChanged: (value) {
                  setState(() {
                    selectedCount = value;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: addToCart,
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Color(0xFFFF69B4), // Hot pink
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
