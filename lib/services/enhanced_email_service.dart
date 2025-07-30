import 'package:bsign/models/document_status/document_status_model.dart';
import 'package:bsign/services/document_status_service.dart';
import 'package:bsign/services/audit_service.dart';
import 'package:bsign/models/audit_log/audit_log_model.dart';
import 'package:emailjs/emailjs.dart' as emailjs;
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class EnhancedEmailService {
  static const String serviceId = 'service_kpp9efr';
  static const String templateId = 'template_j460yxo';
  static const String publicKey = 'N3Qh-Rnday_LBqJyB';

  final DocumentStatusService _statusService = DocumentStatusService();
  final AuditService _auditService = AuditService();
  final _uuid = const Uuid();

  String _generateSecureToken(String documentId, String recipientEmail) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final data = '$documentId:$recipientEmail:$timestamp';
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> sendSigningInvitation({
    required String documentId,
    required String documentName,
    required String senderName,
    required String senderEmail,
    required List<String> recipientEmails,
    required List<String> recipientNames,
    String? customMessage,
    DateTime? expiresAt,
  }) async {
    try {
      // Generate secure tokens and create recipient statuses
      for (int i = 0; i < recipientEmails.length; i++) {
        final recipientEmail = recipientEmails[i];
        final recipientName = recipientNames.length > i ? recipientNames[i] : recipientEmail;
        
        final accessToken = _generateSecureToken(documentId, recipientEmail);
        final tokenExpiresAt = expiresAt ?? DateTime.now().add(const Duration(days: 30));
        
        // Create recipient status
        await _statusService.createRecipientStatus(
          documentId: documentId,
          recipientEmail: recipientEmail,
          recipientName: recipientName,
          accessToken: accessToken,
          tokenExpiresAt: tokenExpiresAt,
        );

        // Generate signing link
        final signLink = _generateSigningLink(documentId, recipientEmail, accessToken);

        // Send email
        await _sendEmail(
          recipientEmail: recipientEmail,
          recipientName: recipientName,
          senderName: senderName,
          documentName: documentName,
          signLink: signLink,
          customMessage: customMessage,
        );

        // Log audit trail
        await _auditService.logAction(
          documentId: documentId,
          action: AuditAction.email_sent,
          userId: senderEmail,
          recipientEmail: recipientEmail,
          metadata: {
            'documentName': documentName,
            'expiresAt': tokenExpiresAt.toIso8601String(),
          },
        );
      }

      // Update document status to sent
      await _statusService.updateDocumentStatus(
        documentId: documentId,
        status: DocumentStatus.sent,
        sentAt: DateTime.now().toUtc(),
      );

      // Update recipient counts
      await _statusService.updateDocumentCounts(documentId);

    } catch (e) {
      print('❌ Error sending signing invitations: $e');
      rethrow;
    }
  }

  String _generateSigningLink(String documentId, String recipientEmail, String accessToken) {
    // In a real app, this would be your app's deep link or web URL
    final encodedEmail = Uri.encodeComponent(recipientEmail);
    return 'https://yourapp.com/sign?doc=$documentId&email=$encodedEmail&token=$accessToken';
  }

  Future<void> _sendEmail({
    required String recipientEmail,
    required String recipientName,
    required String senderName,
    required String documentName,
    required String signLink,
    String? customMessage,
  }) async {
    final templateParams = {
      'to_email': recipientEmail,
      'to_name': recipientName,
      'sender': senderName,
      'document': documentName,
      'link': signLink,
      'message': customMessage ?? 'Please review and sign the attached document.',
      'expires_in': '30 days',
    };

    final response = await emailjs.send(
      serviceId,
      templateId,
      templateParams,
      emailjs.Options(publicKey: publicKey),
    );

    if (response.status != 200) {
      throw Exception('Failed to send email: ${response.text}');
    }
  }

  Future<void> sendCompletionNotification({
    required String documentId,
    required String documentName,
    required String senderEmail,
    required String senderName,
    required List<String> allParticipants,
  }) async {
    for (final email in allParticipants) {
      final templateParams = {
        'to_email': email,
        'sender': senderName,
        'document': documentName,
        'message': 'The document "$documentName" has been completed by all parties.',
        'completion_date': DateTime.now().toString(),
      };

      await emailjs.send(
        serviceId,
        'template_completion', // You'd need to create this template
        templateParams,
        emailjs.Options(publicKey: publicKey),
      );
    }
  }

  Future<void> sendReminderEmail({
    required String documentId,
    required String recipientEmail,
    required String recipientName,
    required String senderName,
    required String documentName,
  }) async {
    // Get recipient status to get the access token
    final recipientStatus = await _statusService.getRecipientStatus(
      documentId: documentId,
      recipientEmail: recipientEmail,
    );

    if (recipientStatus == null || recipientStatus.accessToken == null) {
      throw Exception('Recipient status not found');
    }

    final signLink = _generateSigningLink(
      documentId,
      recipientEmail,
      recipientStatus.accessToken!,
    );

    final templateParams = {
      'to_email': recipientEmail,
      'to_name': recipientName,
      'sender': senderName,
      'document': documentName,
      'link': signLink,
      'message': 'This is a reminder to sign the document "$documentName".',
      'is_reminder': true,
    };

    await emailjs.send(
      serviceId,
      templateId,
      templateParams,
      emailjs.Options(publicKey: publicKey),
    );

    // Log reminder sent
    await _auditService.logAction(
      documentId: documentId,
      action: AuditAction.email_sent,
      userId: senderName,
      recipientEmail: recipientEmail,
      metadata: {
        'type': 'reminder',
        'documentName': documentName,
      },
    );
  }
}