import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/Image.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/profileresponsive/updateprofile/usersprofile.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/signup_controller.dart';

class MobileProfile extends StatelessWidget {
  const MobileProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        String firstName = 'Logixplore';
        String username = 'Explorer';

        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data()!;
          firstName = data['First Name'] ?? 'Logixplore';
          username = data['Username'] ?? 'Explorer';
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A609C).withValues(alpha: 0.66),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // AVATAR ICON
                    Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(0, 212, 7, 7),
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: ClipOval(
                        child:
                            StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>
                            >(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  );
                                }

                                String? imageUrl;
                                if (snapshot.hasData && snapshot.data!.exists) {
                                  imageUrl = snapshot.data!
                                      .data()?['profileImage'];
                                }

                                if (imageUrl != null && imageUrl.isNotEmpty) {
                                  // Show the user's profile picture
                                  return Image.network(
                                    imageUrl,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                              'assets/logo/avatar.png',
                                              fit: BoxFit.cover,
                                            ),
                                  );
                                } else {
                                  // Default avatar if no image found
                                  return Image.asset(
                                    'assets/logo/avatar.png',
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  );
                                }
                              },
                            ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Dynamic First Name
                    Text(
                      firstName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    //  Dynamic Username
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    // TEXT FIELDS - CENTER
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        // FIRST NAME TEXT FIELD
                        TextField(
                          controller: firstNameeController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person_outline_outlined,
                            ),
                            labelText: 'First Name',
                            labelStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            enabledBorder: TInputBorders.enabled,
                            focusedBorder: TInputBorders.focused,
                            errorBorder: TInputBorders.error,
                            focusedErrorBorder: TInputBorders.focusedError,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // LAST NAME TEXT FIELD
                        TextField(
                          controller: lastNameeController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person_outline),
                            labelText: 'Last Name',
                            labelStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            enabledBorder: TInputBorders.enabled,
                            focusedBorder: TInputBorders.focused,
                            errorBorder: TInputBorders.error,
                            focusedErrorBorder: TInputBorders.focusedError,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // EMAIL TEXT FIELD
                        TextField(
                          controller: emaiilController,
                          readOnly: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_outlined),
                            labelText: 'Email Address',
                            labelStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            enabledBorder: TInputBorders.enabled,
                            focusedBorder: TInputBorders.focused,
                            errorBorder: TInputBorders.error,
                            focusedErrorBorder: TInputBorders.focusedError,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // USERNAME TEXT FIELD
                        TextFormField(
                          controller: usernameeController,
                          maxLength: 30,
                          decoration: InputDecoration(
                            label: const Text("Username"),
                            counterText: '',
                            border: InputBorder.none,
                            filled: true,
                            prefixIcon: const Icon(Icons.person),
                            enabledBorder: TInputBorders.enabled,
                            focusedBorder: TInputBorders.focused,
                            errorBorder: TInputBorders.error,
                            focusedErrorBorder: TInputBorders.focusedError,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // BUTTONS - BOTTOM
                    Column(
                      children: [
                        // FIRST BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              changeProfilePicture(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                            ),
                            child: const Text(
                              'Change Picture',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // SECOND BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              updateUserProfile(
                                context: context,
                                firstName: firstNameeController.text.trim(),
                                lastName: lastNameeController.text.trim(),
                                username: usernameeController.text.trim(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                255,
                                149,
                                0,
                              ),
                              foregroundColor: const Color.fromARGB(
                                255,
                                0,
                                0,
                                0,
                              ),
                              minimumSize: const Size(double.infinity, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                            ),
                            child: const Text(
                              'Save Changes',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
