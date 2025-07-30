import 'package:emailjs/emailjs.dart' as emailjs;

class EmailService {
  static const String serviceId = 'service_kpp9efr';
  static const String templateId = 'template_j460yxo';
  static const String publicKey = 'N3Qh-Rnday_LBqJyB';

  static Future<void> sendSignInvitationEmail({
    required String recipientEmail,
    required String senderName,
    required String documentName,
    required String signLink,
  }) async {
    try {
      final templateParams = {
        'to_email': recipientEmail,
        'sender': senderName,
        'document': documentName,
        'link': signLink,
      };

      final response = await emailjs.send(
        serviceId,
        templateId,
        templateParams,
        emailjs.Options(publicKey: publicKey),
      );

      if (response.status == 200) {
        print('✅ Email sent successfully');
      } else {
        print('❌ Failed to send email: ${response.text}');
      }
    } catch (e) {
      print('❌ Error sending email: $e');
    }
  }
}
