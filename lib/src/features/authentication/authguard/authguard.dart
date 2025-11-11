import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Not logged in → redirect to login
      return const RouteSettings(name: '/login');
    }

    // User logged in → allow access
    return null;
  }
}
