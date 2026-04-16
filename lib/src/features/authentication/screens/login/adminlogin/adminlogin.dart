import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/login_screen.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/admindashboard/admindashboard.dart';

class Adminlogin extends StatefulWidget {
  const Adminlogin({super.key});

  @override
  State<Adminlogin> createState() => _AdminloginState();
}

class _AdminloginState extends State<Adminlogin> {
  bool isAdminLoggedIn = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  // FIXED ADMIN LOGIN FUNCTION — NO DELETIONS, ONLY FIXES
  Future<void> _adminLogin() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError("Please fill in all fields.");
      return;
    }

    if (!mounted) return;
    setState(() => _isLoading = true);

    try {
      // FIXED: Correct comparison — MUST use .text, not controller object
      final adminSnapshot = await FirebaseFirestore.instance
          .collection('admin1')
          .where('Email', isEqualTo: email) // ← FIXED HERE
          .limit(1)
          .get();

      if (adminSnapshot.docs.isEmpty) {
        _showError("Admin not found.");
        setState(() => _isLoading = false);
        return;
      }

      final adminData = adminSnapshot.docs.first.data();

      // Check password
      if (adminData['Password'] != password) {
        _showError("Incorrect password.");
        setState(() => _isLoading = false);
        return;
      }

      // ADD THIS: FirebaseAuth sign-in
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!mounted) return;
      setState(() => _isLoading = false);

      Get.off(() => const Admindashboard());
    } catch (e) {
      if (!mounted) return;
      _showError("Something went wrong: $e");
      setState(() => _isLoading = false);
    }
  }

  // ERROR SNACKBAR
  void _showError(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating, //  IMPORTANT
        margin: const EdgeInsets.all(20), //  para makita
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.blueGrey,
          child: Center(
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Admin Login",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Admin",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      fillColor: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: _isLoading ? null : _adminLogin,

                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 45),

                      backgroundColor: const Color.fromARGB(255, 255, 149, 0),
                      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Login"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          onPressed: () => Get.off(LoginScreen()),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
    );
  }
}
