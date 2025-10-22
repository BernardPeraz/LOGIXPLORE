import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/splash_screen/splash_screens.dart';
import 'package:studydesign2zzdatabaseplaylist/firebase_options.dart';
import 'package:studydesign2zzdatabaseplaylist/src/utils/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _monitorUserStatus();
  }

  void _monitorUserStatus() {
    final auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((user) {
      if (user == null) {
        Get.offAll(() => SplashScreen());
      }
    });

    final currentUser = auth.currentUser;
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .snapshots()
          .listen((snapshot) async {
            if (!snapshot.exists) {
              await auth.signOut();
              Get.offAll(() => SplashScreen());
            }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LOGIXPLORE',
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      transitionDuration: const Duration(milliseconds: 500),
      home: FirebaseAuth.instance.currentUser != null
          ? const Dashboard()
          : SplashScreen(),
    );
  }
}
