import 'package:flutter/material.dart';
import 'favorite_page.dart';
import 'cart_page.dart';
import 'products.dart';
import 'category_button.dart';
import 'product_card.dart';
import 'profile_page.dart';
import 'product_detail_page.dart'; // Import the ProductDetailPage

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<String> categories = ['Sneakers', 'Jacket', 'Watch'];
  String selectedCategory = 'Sneakers';
  String searchQuery = '';

  List<Map<String, dynamic>> favoriteProducts = [];
  List<Map<String, dynamic>> cartItems = [];
  int currentIndex = 0;
  bool isDarkMode = false; // State variable for dark mode

  void toggleFavorite(Map<String, dynamic> product) {
    setState(() {
      if (favoriteProducts.contains(product)) {
        favoriteProducts.remove(product);
      } else {
        favoriteProducts.add(product);
      }
    });
  }

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      final existingItem = cartItems.firstWhere(
        (item) =>
            item['title'] == product['title'], // Using title for simplicity
        orElse: () => {},
      );

      if (existingItem.isNotEmpty) {
        existingItem['selectedCount'] += product['selectedCount'];
      } else {
        cartItems.add(product);
      }
    });

    // Show notification when item is added to cart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added ${product['title']} to cart!'),
        backgroundColor: Color(0xFFFF69B4), // Hot pink
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Add these new methods for cart operations
  void removeItemFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void increaseItemQuantity(int index) {
    setState(() {
      cartItems[index]['selectedCount'] += 1;
    });
  }

  void decreaseItemQuantity(int index) {
    setState(() {
      if (cartItems[index]['selectedCount'] > 1) {
        cartItems[index]['selectedCount'] -= 1;
      } else {
        cartItems.removeAt(index);
      }
    });
  }

  void clearAllCart() {
    setState(() {
      cartItems.clear();
    });
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      final matchesCategory = product['category'] == selectedCategory;
      final matchesSearch = product['title'].toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();

    final pages = [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFFFF69B4),
                ), // Hot pink
                hintText: 'Search Products',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Color(0xFFFF69B4),
                  ), // Hot pink border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Color(0xFFFF1493),
                  ), // Deep pink focused border
                ),
                fillColor: Color(0xFFFFF0F5), // Lavender blush background
                filled: true,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: categories.map((category) {
                return CategoryButton(
                  title: category,
                  isSelected: selectedCategory == category,
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: filteredProducts.map((product) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to ProductDetailPage when a product card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: product,
                            onAddToCart: addToCart,
                          ),
                        ),
                      );
                    },
                    child: ProductCard(
                      imageUrl: product['imageUrl'],
                      title: product['title'],
                      price: product['price'],
                      product: product,
                      isFavorite: favoriteProducts.contains(product),
                      onFavoriteToggle: toggleFavorite,
                      onAddToCart: addToCart,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      ProfilePage(),
      // FIX: Pass all required callback functions to CartPage
      CartPage(
        cartItems: cartItems,
        onAddToCart: addToCart,
        onRemoveItem: removeItemFromCart,
        onIncreaseQuantity: increaseItemQuantity,
        onDecreaseQuantity: decreaseItemQuantity,
        onClearCart: clearAllCart,
      ),
      FavoritePage(
        favoriteProducts: favoriteProducts,
        onRemoveFavorite: (product) {
          setState(() {
            favoriteProducts.remove(product);
          });

          // Show notification when item is removed from favorites
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Removed ${product['title']} from favorites!'),
              backgroundColor: Color(0xFFFF69B4), // Hot pink
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    ];

    return Scaffold(
      backgroundColor: Color(0xFFFFF0F5), // Lavender blush background
      appBar: AppBar(
        backgroundColor: Color(0xFFFFB6C1), // Light pink
        elevation: 0,
        title: Text(
          'Our Products',
          style: TextStyle(
            color: Color(0xFFC71585), // Medium violet red
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Color(0xFFC71585), // Medium violet red
            ),
            onPressed: toggleTheme,
          ),
          // Shopping cart icon with badge
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Color(0xFFC71585)),
                onPressed: () {
                  setState(() {
                    currentIndex = 2; // Navigate to cart page
                  });
                },
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF1493), // Deep pink
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(minWidth: 14, minHeight: 14),
                    child: Text(
                      cartItems.length.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Color(0xFFFF69B4), // Hot pink background
              backgroundImage: AssetImage(
                'images/WhatsApp Image 2024-12-26 at 14.53.18_c4e4e0f5.jpg',
              ),
            ),
          ),
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: Color(0xFFFFB6C1), // Light pink background
        selectedItemColor: Color(0xFFFF1493), // Deep pink selected
        unselectedItemColor: Color(0xFFDA70D6), // Orchid unselected
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                if (cartItems.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Color(0xFFFF1493), // Deep pink
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(minWidth: 12, minHeight: 12),
                      child: Text(
                        cartItems.length.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 8),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
