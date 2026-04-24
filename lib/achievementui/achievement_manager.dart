import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> markGateAsSolved(String gateId, bool isCorrect) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('simulator_progress')
      .doc(gateId)
      .set({
        'isCorrect': isCorrect,
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
}
