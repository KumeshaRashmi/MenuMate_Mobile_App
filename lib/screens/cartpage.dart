import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({super.key, required this.cartItems, required String userId});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0;

    for (var item in widget.cartItems) {
      totalPrice += item['price'] * item['quantity'];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: const Color.fromARGB(255, 117, 255, 82),
      ),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                var item = widget.cartItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    leading: Image.asset(item['imageUrl'], width: 50, height: 50),
                    title: Text(item['name']),
                    subtitle: Text('Rs. ${item['price']} x ${item['quantity']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (item['quantity'] > 1) {
                                item['quantity']--;
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              item['quantity']++;
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              widget.cartItems.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Price: ", style: TextStyle(fontSize: 18)),
                Text('Rs. ${totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, color: Colors.green)),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Show purchase confirmation message
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Purchase Successful"),
                    content: const Text("Your items have been successfully purchased."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 105, 255, 82),
              ),
              child: const Text('Buy Now'),
            ),
          ],
        ),
      ),
    );
  }
}