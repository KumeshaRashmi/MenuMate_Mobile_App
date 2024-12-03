import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with overlay
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('lib/assests/main3.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
              ),
            ),
          ),

          // Content in the center and bottom
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Expanded(
            child: Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Menu',
                  style: TextStyle(
                    fontSize: 60, 
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 246, 248, 249), 
                    letterSpacing: 2.0,
                    fontFamily: 'YourCustomFont', 
                  ),
                ),
                TextSpan(
                  text: 'Mate',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 82, 255, 97), 
                    letterSpacing: 2.0,
                    fontFamily: 'YourCustomFont',
                  ),
                ),
              ],
            ),
          ),
                  const SizedBox(height: 30),

                      const Text(
                        'Tasty meals delivered\n to your doorstep',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 30),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 82, 255, 97),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupPage()),
                          );
                        },
                        child: const Text(
                          'Get Started',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white70,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
