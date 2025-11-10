import 'dart:math';

class OtpUtils {
  static String generate6Digit() {
    final r = Random();
    return (100000 + r.nextInt(900000)).toString();
  }
}
