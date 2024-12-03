import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'fooddetails.dart';
import 'profile.dart';
import 'setting.dart';
import 'cartpage.dart';

class Home extends StatefulWidget {
  final String profileImageUrl;
  final String displayName;
  final String email;

  const Home({
    super.key,
    required this.profileImageUrl,
    required this.displayName,
    required this.email,
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      const HomePageContent(),
      ProfilePage(
        profileImageUrl: widget.profileImageUrl,
        displayName: widget.displayName,
        email: widget.email,
      ),
      const AccountSettingsPage(),
      CartPage(cartItems: [], userId: ''),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color.fromARGB(255, 14, 15, 14),
        elevation: 0,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 5, 180, 40),
        unselectedItemColor: const Color.fromARGB(255, 15, 9, 5),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar and Icon Section
            Row(
              children: [
                const Icon(Icons.fastfood,
                    color: Color.fromARGB(255, 30, 207, 107), size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search food items',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Banners Section
            buildFoodBanners(),
            const SizedBox(height: 40),

            // Food Categories Section
            buildCategoryList(),
            const SizedBox(height: 20),

            // Popular Dishes Section
            buildSectionTitle('Popular Dishes'),
            buildFoodItemRow(context),
            const SizedBox(height: 20),

            // Recommended for You Section
            buildSectionTitle('Recommended for You'),
            buildFoodItemRow(context),
          ],
        ),
      ),
    );
  }

  /// Food Banners at the top
  Widget buildFoodBanners() {
    final List<String> bannerImages = [
      'lib/assests/banner1.jpg', 
      'lib/assests/banner5.jpg',
      'lib/assests/banner4.jpg',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
      ),
      items: bannerImages.map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            );
          },
        );
      }).toList(),
    );
  }

  /// Food Categories Section
  Widget buildCategoryList() {
    final List<Map<String, String>> categories = [
      {'title': 'Cake', 'image': 'lib/assests/menu4.jpeg'},
      {'title': 'Pizza', 'image': 'lib/assests/menu1.jpeg'},
      {'title': 'Burgers', 'image': 'lib/assests/menu3.jpeg'},
      {'title': 'Noodles', 'image': 'lib/assests/menu5.jpeg'},
      {'title': 'Coffee', 'image': 'lib/assests/menu6.jpg'},
      
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionTitle('Select by Category'),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final category = categories[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${category['title']} tapped')),
                      );
                    },
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(category['image']!),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    category['title']!,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildFoodItemRow(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FoodDetailsPage(
                    itemName: 'Spicy Ramen',
                    itemPrice: 1200.00,
                    itemDescription: 'Deliciously spicy noodle soup.',
                    itemImage: 'lib/assests/food1.jpg',
                  ),
                ),
              );
            },
            child: Container(
              width: 160,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'lib/assests/food1.jpg',
                      height: 90,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Spicy Ramen',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Rs. 1200.00',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
