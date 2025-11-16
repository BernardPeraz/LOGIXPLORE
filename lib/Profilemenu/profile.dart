import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/profileresponsive/updateprofile/profilecontroller.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/profilesettings.dart';

class ProfileMenuBox extends StatelessWidget {
  const ProfileMenuBox({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    double screenWidth = MediaQuery.of(context).size.width;

    // Get current user
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Container(
        padding: const EdgeInsets.all(8),
        child: const Text('Guest'),
      );
    }

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: UserProfileController.userProfileStream(),
      builder: (context, snapshot) {
        String displayName = 'Loading...';
        String role = 'Student';
        String? imageUrl;

        if (snapshot.hasData && snapshot.data!.exists) {
          var data = snapshot.data!.data() as Map<String, dynamic>;
          displayName = '${data['First Name'] ?? ''} ${data['Last Name'] ?? ''}'
              .trim();
          imageUrl = data['profileImage'];
        }

        //  fixed misplaced code here
        imageUrl ??= user.photoURL;
        const String defaultAssetImage = 'assets/logo/avatar.png';

        if (displayName.isEmpty ||
            displayName == 'Loading...' ||
            displayName.trim().isEmpty) {
          displayName = user.displayName ?? user.email ?? 'No Email Found';
        }

        if (screenWidth < 620) {
          return Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Get.to(() => const ProfileSettings());
                  });
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.transparent),
                  shape: const CircleBorder(
                    side: BorderSide(style: BorderStyle.solid),
                  ),
                  padding: const EdgeInsets.all(1),
                  backgroundColor: const Color.fromARGB(0, 158, 158, 158),
                  fixedSize: const Size(40, 40),
                ),
                child: ClipOval(
                  child: imageUrl != null && imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                                defaultAssetImage,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                        )
                      : Image.asset(
                          defaultAssetImage,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ],
          );
        } else {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: isDark ? Colors.black : Colors.orange,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      Get.to(() => const ProfileSettings());
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.transparent),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(1),
                    backgroundColor: const Color.fromARGB(0, 255, 153, 0),
                    fixedSize: const Size(50, 50),
                  ),
                  child: ClipOval(
                    child: imageUrl != null && imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            width: 45,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                                  defaultAssetImage,
                                  width: 45,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                          )
                        : Image.asset(
                            defaultAssetImage,
                            width: 45,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      role,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 5),
              ],
            ),
          );
        }
      },
    );
  }
}
