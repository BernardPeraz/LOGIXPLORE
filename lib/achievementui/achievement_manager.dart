import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> markGateAsSolved(String gateId) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('simulator_progress')
      .doc(gateId)
      .set({'timestamp': FieldValue.serverTimestamp()});
}
