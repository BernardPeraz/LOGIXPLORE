import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/profileresponsive/desktopprofile.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/profileresponsive/mobileprofile.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 10 : 20),
            child: isMobile ? const MobileProfile() : const DesktopProfile(),
          ),
        );
      },
    );
  }
}
