import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(Map<String, dynamic>) onAddToCart;
  final Function(int) onRemoveItem; // Add this callback
  final Function(int) onIncreaseQuantity; // Add this callback
  final Function(int) onDecreaseQuantity; // Add this callback
  final Function() onClearCart; // Add this callback

  CartPage({
    required this.cartItems,
    required this.onAddToCart,
    required this.onRemoveItem,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
    required this.onClearCart,
  });

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  double getTotalPrice() {
    return widget.cartItems.fold(0, (total, item) {
      return total + (item['price'] * item['selectedCount']);
    });
  }

  void removeItem(int index) {
    final removedItem = widget.cartItems[index];
    widget.onRemoveItem(index); // Use callback instead of direct modification

    // Show notification when item is removed
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed ${removedItem['title']} from cart!'),
        backgroundColor: Color(0xFFFF69B4), // Hot pink
        duration: Duration(seconds: 2),
      ),
    );
  }

  void increaseQuantity(int index) {
    widget.onIncreaseQuantity(
      index,
    ); // Use callback instead of direct modification

    // Show notification when quantity is increased
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Increased quantity of ${widget.cartItems[index]['title']}',
        ),
        backgroundColor: Color(0xFFFF69B4), // Hot pink
        duration: Duration(seconds: 1),
      ),
    );
  }

  void decreaseQuantity(int index) {
    if (widget.cartItems[index]['selectedCount'] > 1) {
      widget.onDecreaseQuantity(
        index,
      ); // Use callback instead of direct modification

      // Show notification when quantity is decreased
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Decreased quantity of ${widget.cartItems[index]['title']}',
          ),
          backgroundColor: Color(0xFFFF69B4), // Hot pink
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      removeItem(index);
    }
  }

  void clearCart() {
    widget.onClearCart(); // Use callback instead of direct modification

    // Show notification when cart is cleared
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cart cleared successfully!'),
        backgroundColor: Color(0xFFFF69B4), // Hot pink
        duration: Duration(seconds: 2),
      ),
    );
  }

  // ... rest of your validation methods remain the same

  String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter card number';
    }
    if (value.length < 16) {
      return 'Card number must be 16 digits';
    }
    return null;
  }

  String? validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter expiry date';
    }
    if (!RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$').hasMatch(value)) {
      return 'Please enter valid expiry date (MM/YY)';
    }
    return null;
  }

  String? validateCVC(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter CVC';
    }
    if (value.length < 3) {
      return 'CVC must be 3 digits';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter name on card';
    }
    return null;
  }

  void _showCardDetailsForm() {
    // Store the context before showing the dialog
    final scaffoldContext = context;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFFFF0F5), // Lavender blush background
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Card Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF69B4), // Hot pink
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Card Number',
                        labelStyle: TextStyle(
                          color: Color(0xFFDA70D6),
                        ), // Orchid
                        hintText: '1234 5678 9012 3456',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF69B4),
                          ), // Hot pink border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFDA70D6),
                          ), // Orchid focused border
                        ),
                      ),
                      validator: validateCardNumber,
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: expiryDateController,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              labelText: 'Expiry Date',
                              labelStyle: TextStyle(
                                color: Color(0xFFDA70D6),
                              ), // Orchid
                              hintText: 'MM/YY',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFFF69B4),
                                ), // Hot pink border
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFDA70D6),
                                ), // Orchid focused border
                              ),
                            ),
                            validator: validateExpiryDate,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: cvcController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'CVC/CVV',
                              labelStyle: TextStyle(
                                color: Color(0xFFDA70D6),
                              ), // Orchid
                              hintText: '123',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFFF69B4),
                                ), // Hot pink border
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFDA70D6),
                                ), // Orchid focused border
                              ),
                            ),
                            validator: validateCVC,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name on Card',
                        labelStyle: TextStyle(
                          color: Color(0xFFDA70D6),
                        ), // Orchid
                        hintText: 'John Doe',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF69B4),
                          ), // Hot pink border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFDA70D6),
                          ), // Orchid focused border
                        ),
                      ),
                      validator: validateName,
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Color(0xFFFF69B4)),
                          ), // Hot pink
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Simulate successful payment processing
                              Navigator.of(context).pop();
                              // Use the stored context for the snackbar
                              ScaffoldMessenger.of(
                                scaffoldContext,
                              ).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Payment successful using card!',
                                  ),
                                  backgroundColor: Color(
                                    0xFFFF69B4,
                                  ), // Hot pink
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              clearCart(); // Clear the cart after payment
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFF69B4), // Hot pink
                          ),
                          child: Text('Submit'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF0F5), // Lavender blush background
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: TextStyle(
            color: Color(0xFFC71585), // Medium violet red
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFFB6C1), // Light pink
        iconTheme: IconThemeData(color: Color(0xFFC71585)), // Medium violet red
      ),
      body: widget.cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 64,
                    color: Color(0xFFFF69B4), // Hot pink
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your cart is empty!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFFF69B4),
                    ), // Hot pink
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add some items to get started',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFDA70D6), // Orchid
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Color(0xFFFFF0F5), // Lavender blush
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Color(0xFFFFB6C1),
                      width: 1,
                    ), // Light pink border
                  ),
                  child: ListTile(
                    leading: Image.network(
                      item['imageUrl'],
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      item['title'],
                      style: TextStyle(
                        color: Color(0xFFC71585), // Medium violet red
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price: \$${item['price']}',
                          style: TextStyle(color: Color(0xFFDA70D6)),
                        ), // Orchid
                        Row(
                          children: [
                            Text(
                              'Quantity: ',
                              style: TextStyle(color: Color(0xFFDA70D6)),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.remove,
                                size: 16,
                                color: Color(0xFFFF69B4),
                              ),
                              onPressed: () => decreaseQuantity(index),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                            Text(
                              '${item['selectedCount']}',
                              style: TextStyle(
                                color: Color(0xFFC71585),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                size: 16,
                                color: Color(0xFFFF69B4),
                              ),
                              onPressed: () => increaseQuantity(index),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Color(0xFFFF1493),
                      ), // Deep pink
                      onPressed: () => removeItem(index),
                      tooltip: 'Remove Item',
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: widget.cartItems.isEmpty
          ? null
          : Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFFFF0F5), // Lavender blush
                border: Border(
                  top: BorderSide(color: Color(0xFFFFB6C1), width: 1),
                ), // Light pink border
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFC71585), // Medium violet red
                        ),
                      ),
                      Text(
                        '\$${getTotalPrice().toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC71585), // Medium violet red
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _showCardDetailsForm,
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF69B4), // Hot pink
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
