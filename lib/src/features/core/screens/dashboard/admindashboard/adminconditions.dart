import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminConditions {
  static Future<bool> isAdmin() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return false;

    final snapshot = await FirebaseFirestore.instance
        .collection('admin1')
        .where('Email', isEqualTo: user.email)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      return data['role'] == 'Admin';
    }

    return false;
  }
}
