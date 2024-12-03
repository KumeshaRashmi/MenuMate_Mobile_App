import 'package:flutter/material.dart';
import 'setting.dart';

class ProfilePage extends StatelessWidget {
  final String profileImageUrl;
  final String displayName;
  final String email;

  const ProfilePage({
    super.key,
    required this.profileImageUrl,
    required this.displayName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0, // Hide default AppBar
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Profile Avatar and Notification Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40), 
                CircleAvatar(
                  radius: 40,
                  backgroundImage: profileImageUrl.isNotEmpty
                      ? NetworkImage(profileImageUrl)
                      : const AssetImage('lib/assests/profile.png')
                          as ImageProvider,
                ),
                IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.redAccent),
                  onPressed: () {
                    // Handle notification tap (e.g., open notifications page)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Notifications tapped')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Display Name and Email
            Text(
              displayName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              email,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Menu Options List
            Expanded(
              child: ListView(
                children: [
                  buildMenuItem(context, 'Orders'),
                  buildMenuItem(context, 'Payment Methods'),
                  buildMenuItem(context, 'Change Location'),
                  buildMenuItem(context, 'Help'),
                  buildMenuItem(context, 'Privacy'),
                  buildMenuItem(context, 'Invite Friends'),
                  buildMenuItem(context, 'Promotions'),
                  buildMenuItem(context, 'Account Settings'),
                  buildMenuItem(context, 'Map'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a menu item with navigation handling
  Widget buildMenuItem(BuildContext context, String title) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            if (title == 'Account Settings') {
              // Navigate to Account Settings page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountSettingsPage(),
                ),
              );
            } else if (title == 'Map') {
              // Navigate to Map page
            } else if (title == 'Change Location') {
              // Navigate to Change Location page
            } else {
              // Handle other menu items (e.g., Orders, Help, Privacy)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$title tapped')),
              );
            }
          },
        ),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }
}
