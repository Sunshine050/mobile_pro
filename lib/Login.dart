import 'package:flutter/material.dart';
import 'package:project/Admin/Home_Admin.dart';
import 'package:project/Approver/Home_Approver.dart';
import 'package:project/User/Home_User.dart';
import 'package:project/register.dart'; // Import the Register page

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2A776F),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with App Title
              const CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.book,
                        size: 60, color: Colors.orange), // Placeholder icon
                    Text(
                      "นาย มาร์ช",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "BORROW APP",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              // Username TextField
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person, color: Colors.white70),
                  hintText: "Username",
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  hintStyle: const TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),

              // Password TextField
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                  hintText: "Password",
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  hintStyle: const TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 30),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  _handleLogin(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),

              // "or" Text
              const Text(
                "or",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),

              // Create Account Button
              OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Register()), // Navigate to Register page
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                ),
                child: const Text(
                  "Create an account",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin(BuildContext context) {
    String username = usernameController.text;
    String password = passwordController.text;

    // Here, you can replace this logic with your actual authentication logic
    // For demonstration, I'll use hardcoded values.
    if (username == 'admin' && password == '222') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeAdmin()),
      );
    } else if (username == 'approver' && password == '333') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeApprover()),
      );
    } else if (username == 'user' && password == '111') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeUser()),
      );
    } else {
      // Show an error message if the credentials are invalid
      _showErrorDialog(context);
    }
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Failed'),
        content: const Text('Invalid username or password.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
