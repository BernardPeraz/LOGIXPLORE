import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/sizes.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/forget_password/forget_password_mail/forget_password_mail.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/forget_password/forget_password_options/forget_password_btn_widget.dart';

class ForgetPasswordScreen {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (context) => Container(
        padding: EdgeInsets.all(tDefaultSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Make Selection!",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              "Select one of the options given below to reset your password.",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 30),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.mail_outline_rounded,
              title: "E-Mail",
              subtitle: "Reset via Mail Verification.",
              onTap: () {
                Navigator.pop(context);
                Get.to(() => ForgetPasswordMailScreen());
              },
            ),
            SizedBox(height: 10.0),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.mobile_friendly_rounded,
              title: "Phone No",
              subtitle: "Reset via Phone Verification.",
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
