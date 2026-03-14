// lib/services/admin_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class AdminService {
  Future<bool> isAdmin(String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('admin')
        .where('Email', isEqualTo: email)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return false;
    return snapshot.docs.first.data()['role'] == 'admin';
  }
}
