import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  // SMTP Server configuration for Gmail
  static final smtpServer = gmail('your.email@gmail.com', 'your_app_password');

  // Function to send verification code to email
  static Future<void> sendVerificationCode(
    String recipientEmail,
    String verificationCode,
  ) async {
    try {
      // Create the email message
      final message = Message()
        ..from = Address('your.email@gmail.com', 'Your App Name')
        ..recipients.add(recipientEmail)
        ..subject = 'Verification Code - Your App Name'
        ..html =
            """
        <html>
          <body>
            <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
              <h2 style="color: #333;">Email Verification</h2>
              <p>Hello,</p>
              <p>Thank you for using our app. Here is your verification code:</p>
              
              <div style="background-color: #f8f9fa; padding: 15px; border-radius: 5px; text-align: center; margin: 20px 0;">
                <h1 style="color: #007bff; font-size: 32px; margin: 0; letter-spacing: 5px;">
                  $verificationCode
                </h1>
              </div>
              
              <p>This code will expire in 15 minutes.</p>
              <p>If you didn't request this code, please ignore this email.</p>
              
              <hr style="border: none; border-top: 1px solid #eee; margin: 20px 0;">
              <p style="color: #666; font-size: 12px;">
                This is an automated message. Please do not reply to this email.
              </p>
            </div>
          </body>
        </html>
        """;

      // Send the email
      final sendReport = await send(message, smtpServer);
      print(
        'Verification code sent to $recipientEmail: ${sendReport.toString()}',
      );
    } catch (e) {
      print('Error sending email: $e');
      throw Exception('Failed to send verification code: $e');
    }
  }

  // Function to send password reset code
  static Future<void> sendPasswordResetCode(
    String recipientEmail,
    String resetCode,
  ) async {
    try {
      final message = Message()
        ..from = Address('your.email@gmail.com', 'Your App Name')
        ..recipients.add(recipientEmail)
        ..subject = 'Password Reset Code - Your App Name'
        ..html =
            """
        <html>
          <body>
            <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
              <h2 style="color: #333;">Password Reset Request</h2>
              <p>Hello,</p>
              <p>We received a request to reset your password. Here is your reset code:</p>
              
              <div style="background-color: #fff3cd; padding: 15px; border-radius: 5px; text-align: center; margin: 20px 0;">
                <h1 style="color: #856404; font-size: 32px; margin: 0; letter-spacing: 5px;">
                  $resetCode
                </h1>
              </div>
              
              <p>This code will expire in 15 minutes.</p>
              <p>If you didn't request a password reset, please ignore this email.</p>
              
              <hr style="border: none; border-top: 1px solid #eee; margin: 20px 0;">
              <p style="color: #666; font-size: 12px;">
                This is an automated message. Please do not reply to this email.
              </p>
            </div>
          </body>
        </html>
        """;

      final sendReport = await send(message, smtpServer);
      print(
        'Password reset code sent to $recipientEmail: ${sendReport.toString()}',
      );
    } catch (e) {
      print('Error sending password reset email: $e');
      throw Exception('Failed to send password reset code: $e');
    }
  }
}
