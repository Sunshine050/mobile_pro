import 'package:flutter/material.dart';
import 'package:project/Login.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2A776F),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                "Let's\nCreate\nYour\nAccount",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              // Full Name TextField
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person, color: Colors.white70),
                  hintText: "Full Name",
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

              // Username TextField
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_outline, color: Colors.white70),
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
              const SizedBox(height: 20),

              // Retype Password TextField
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
                  hintText: "Retype Password",
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

              // Terms and Privacy Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        _agreeToTerms = value ?? false;
                      });
                    },
                    activeColor: Colors.teal,
                  ),
                  const Text(
                    "I agree to the ",
                    style: TextStyle(color: Colors.white70),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle terms and privacy link tap
                    },
                    child: Text(
                      "Terms & Privacy",
                      style: TextStyle(
                        color: Colors.teal.shade300,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Sign Up Button
              Center(
                child: ElevatedButton(
  onPressed: _agreeToTerms
      ? () {
          // Show alert dialog when the button is pressed
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Sign Up"),
                content: const Text("Are you sure you want to sign up?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Handle confirmation of sign-up action
                      Navigator.of(context).pop(); // Close the dialog
                      
                      // Navigate to the LoginPage
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text("Yes"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      ); // Close the dialog
                    },
                    child: const Text("No"),
                  ),
                ],
              );
            },
          );
        }
      : null,
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.teal.shade800,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
  ),
  child: const Text(
    "Sign Up",
    style: TextStyle(fontSize: 18),
  ),
),

              ),
              const SizedBox(height: 20),

              // Sign In Link
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to Register page
                  );
                  },
                  child: const Text(
                    "Have an account? Sign In",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
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
