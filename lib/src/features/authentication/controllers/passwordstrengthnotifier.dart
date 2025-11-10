import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/signup_controller.dart';
// adjust mo

class PasswordStrengthWidget extends StatelessWidget {
  final ValueNotifier<PasswordResult> notifier;

  const PasswordStrengthWidget({super.key, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PasswordResult>(
      valueListenable: notifier,
      builder: (context, result, _) {
        if (result.strength == PasswordStrength.empty) {
          return const SizedBox.shrink();
        }

        Color color;
        switch (result.strength) {
          case PasswordStrength.short:
            color = Colors.red;
            break;
          case PasswordStrength.veryWeak:
            color = const Color.fromARGB(255, 237, 77, 66);
            break;
          case PasswordStrength.medium:
            color = Colors.orange;
            break;
          case PasswordStrength.strong:
            color = const Color.fromARGB(255, 0, 183, 6);
            break;
          default:
            color = Colors.grey;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: result.score,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
            const SizedBox(height: 4),
            Text(
              result.label,
              style: TextStyle(fontWeight: FontWeight.w600, color: color),
            ),
          ],
        );
      },
    );
  }
}
