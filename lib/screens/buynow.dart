import 'package:flutter/material.dart';

class BuyNowPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const BuyNowPage({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartItems.fold(0, (sum, item) => sum + item['price']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Now'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.network(
                    item['imageUrl'],
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item['name']),
                  subtitle: Text('\$${item['price']}'),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Total Price: \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle purchase logic
                // For example, navigate to a confirmation page or show a success message
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Purchase Confirmed'),
                    content: Text('Thank you for your purchase!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context); // Go back to cart or home page
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Confirm Purchase'),
            ),
          ],
        ),
      ),
    );
  }
}
