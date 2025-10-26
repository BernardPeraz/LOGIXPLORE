import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Uint8List? _webImage;

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  String? _photoUrl;
  String? _firestoreImage;
  bool _isSaving = false;

  String _displayName = '';
  String _loginType = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    String? photoUrl = user.photoURL;
    String? firestoreImage;
    String displayName = '';
    String loginType = '';

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      firestoreImage = data['profileImage'];

      if (user.providerData.any((p) => p.providerId == 'password')) {
        displayName = '${data['First Name'] ?? ''} ${data['Last Name'] ?? ''}'
            .trim();
        // GUSTO KO: Kunin ang username na ininput sa account at i-assign sa loginType
        loginType = data['Username'] ?? 'User';
      }
    }

    if (user.providerData.any((p) => p.providerId == 'google.com')) {
      displayName = user.email ?? 'No Email Found';
      // GUSTO KO: Kunin ang username na ininput sa account at i-assign sa loginType
      loginType = doc.data()?['Username'] ?? user.displayName ?? 'Google User';
    }

    setState(() {
      _photoUrl = photoUrl;
      _firestoreImage = firestoreImage;
      _displayName = displayName;
      _loginType = loginType;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        _webImage = await pickedFile.readAsBytes();
      } else {
        _imageFile = File(pickedFile.path);
      }
      setState(() {});
    }
  }

  Future<void> _saveChanges() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || _imageFile == null) return;

    try {
      setState(() {
        _isSaving = true;
      });

      final storageRef = FirebaseStorage.instance.ref().child(
        'user_profile_images/${user.uid}.jpg',
      );
      await storageRef.putFile(_imageFile!);

      final downloadUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {'profileImage': downloadUrl},
      );

      setState(() {
        _firestoreImage = downloadUrl;
        _isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile image updated successfully!")),
      );
    } catch (e) {
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (_imageFile != null) {
      imageProvider = FileImage(_imageFile!);
    } else if (_firestoreImage != null && _firestoreImage!.isNotEmpty) {
      imageProvider = NetworkImage(_firestoreImage!);
    } else if (_photoUrl != null && _photoUrl!.isNotEmpty) {
      imageProvider = NetworkImage(_photoUrl!);
    } else {
      imageProvider = const AssetImage('assets/logo/avatar.png');
    }

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(20),
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 60, backgroundImage: imageProvider),
          const SizedBox(height: 20),

          Text(
            _displayName.isNotEmpty ? _displayName : 'Loading...',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          Text(
            _loginType,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 20),

          ElevatedButton(onPressed: () {}, child: const Text('Change Avatar')),
          const SizedBox(height: 15),

          ElevatedButton(onPressed: () {}, child: Text('Save Changes')),
        ],
      ),
    );
  }
}
