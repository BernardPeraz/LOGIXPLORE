import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/profilesettings.dart';

class ProfileMenuBox extends StatelessWidget {
  const ProfileMenuBox({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Get current user
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Container(
        padding: const EdgeInsets.all(8),
        child: const Text('Guest'),
      );
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        String displayName = 'Loading...';
        String role = 'Visitor';
        String? imageUrl;

        if (snapshot.hasData && snapshot.data!.exists) {
          var data = snapshot.data!.data() as Map<String, dynamic>;
          displayName = '${data['First Name'] ?? ''} ${data['Last Name'] ?? ''}'
              .trim();
          imageUrl = data['profileImage'];
        }

        imageUrl ??= user.photoURL;

        if (displayName.isEmpty ||
            displayName == 'Loading...' ||
            displayName.trim().isEmpty) {
          displayName = user.displayName ?? user.email ?? 'No Email Found';
        }

        const String defaultAssetImage = 'assets/logo/avatar.png';
        if (screenWidth < 620) {
          return Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileSettings(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.transparent),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(1),
                  backgroundColor: const Color.fromARGB(0, 212, 7, 7),
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
              color: Colors.orange,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileSettings(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.transparent),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(1),
                    backgroundColor: Colors.orange,
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
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      role,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
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
