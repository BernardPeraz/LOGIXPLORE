import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/Image.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        changeProfilePicture(context);
      },
      child: Text('button'),
    );
  }
}
