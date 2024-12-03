import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cartpage.dart';

class FoodDetailsPage extends StatelessWidget {
  final String itemName;
  final double itemPrice;
  final String itemDescription;
  final String itemImage;

  const FoodDetailsPage({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.itemDescription,
    required this.itemImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemName),
        backgroundColor: const Color.fromARGB(255, 117, 255, 82),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full-width image
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(itemImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Item name
                      Text(
                        itemName,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Item price
                      Text(
                        'Price: Rs. ${itemPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // "Most Popular" Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            label: Row(
                              children: const [
                                Icon(Icons.star, color: Colors.yellow),
                                SizedBox(width: 5),
                                Text("#1 most liked"),
                              ],
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(Icons.thumb_up, color: Colors.green),
                              SizedBox(width: 5),
                              Text("88% (90)"),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Ingredients section
                      const Text(
                        'Ingredients:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '- Noodles\n- Spices\n- Vegetables\n- Broth\n- Garnish',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      const SizedBox(height: 20),

                      // Item description
                      const Text(
                        'Description:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        itemDescription,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 30),

                      // Serving Size Options
                      const Text(
                        'Choice of Serving:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text("1 Person"),
                            trailing: Radio(
                              value: 1,
                              groupValue: 1,
                              onChanged: (value) {},
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.group),
                            title: const Text("2 Persons (+Rs. 1,040.00)"),
                            trailing: Radio(
                              value: 2,
                              groupValue: 1,
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Fixed Add to Basket Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ElevatedButton(
                onPressed: () async {
                  final userCollection =
                      FirebaseFirestore.instance.collection('users');

                  String userId = 'user123';

                  var userData = {
                    'userId': userId,
                    'cart': [
                      {
                        'name': itemName,
                        'price': itemPrice,
                        'imageUrl': itemImage,
                        'quantity': 1,
                      },
                    ],
                    'name': 'John Doe',
                    'email': 'johndoe@example.com',
                  };

                  await userCollection
                      .doc(userId)
                      .set(userData, SetOptions(merge: true));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(
                        cartItems: [
                          {
                            'name': itemName,
                            'price': itemPrice,
                            'imageUrl': itemImage,
                            'quantity': 1,
                          },
                        ],
                        userId: '',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 105, 255, 82),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  'Add 1 to basket • Rs. ${itemPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
