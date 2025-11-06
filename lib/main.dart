import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart'; // IDINAGDAG
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/splash_screen/splash_screens.dart';
import 'package:studydesign2zzdatabaseplaylist/firebase_options.dart';
import 'package:studydesign2zzdatabaseplaylist/src/utils/theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Global loading controller - Dinagdagan lang dito
class AppLoadingController extends GetxController {
  final isLoading = false.obs;

  void startLoading() => isLoading.value = true;
  void stopLoading() => isLoading.value = false;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // IDINAGDAG: Cloud Functions initialization with error handling
  try {
    FirebaseFunctions functions = FirebaseFunctions.instance;
    // Optional: Set region if needed
    // functions = FirebaseFunctions.instanceFor(region: 'asia-southeast1');

    // Optional: For local emulator testing
    // functions.useFunctionsEmulator('localhost', 5001);

    print('Cloud Functions initialized successfully');
  } catch (e) {
    print('Error initializing Cloud Functions: $e');
  }

  await Supabase.initialize(
    url: 'https://yumufbsbqiwnjnzkacnn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl1bXVmYnNicWl3bmpuemthY25uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjEzOTg0MDYsImV4cCI6MjA3Njk3NDQwNn0.nDq_gUdJBbsdzdHNLZap1B6QWxP4Nna92gRwHG_Gbp0',
  );

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
        Future.delayed(Duration(milliseconds: 100), () {
          if (FirebaseAuth.instance.currentUser == null && mounted) {
            Get.offAll(() => SplashScreen());
          }
        });
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
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            Obx(() {
              final loadingController = Get.put(AppLoadingController());
              return loadingController.isLoading.value
                  ? Container(
                      color: Colors.black54,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Loading...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox.shrink();
            }),
          ],
        );
      },
    );
  }
}
