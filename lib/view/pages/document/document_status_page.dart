import 'package:bsign/models/audit_log/audit_log_model.dart';
import 'package:bsign/models/document_status/document_status_model.dart';
import 'package:bsign/services/audit_service.dart';
import 'package:bsign/services/document_status_service.dart';
import 'package:bsign/services/enhanced_email_service.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

class DocumentStatusPage extends StatefulWidget {
  final String documentId;
  final String documentName;

  const DocumentStatusPage({
    super.key,
    required this.documentId,
    required this.documentName,
  });

  @override
  State<DocumentStatusPage> createState() => _DocumentStatusPageState();
}

class _DocumentStatusPageState extends State<DocumentStatusPage> {
  final DocumentStatusService _statusService = DocumentStatusService();
  final AuditService _auditService = AuditService();
  final EnhancedEmailService _emailService = EnhancedEmailService();

  DocumentStatusModel? _documentStatus;
  List<RecipientStatus> _recipientStatuses = [];
  List<AuditLog> _auditLogs = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final futures = await Future.wait([
        _statusService.getDocumentStatus(widget.documentId),
        _statusService.getDocumentRecipientStatuses(widget.documentId),
        _auditService.getDocumentAuditTrail(widget.documentId),
      ]);

      setState(() {
        _documentStatus = futures[0] as DocumentStatusModel?;
        _recipientStatuses = futures[1] as List<RecipientStatus>;
        _auditLogs = futures[2] as List<AuditLog>;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
    }
  }

  Future<void> _sendReminder(RecipientStatus recipient) async {
    try {
      await _emailService.sendReminderEmail(
        documentId: widget.documentId,
        recipientEmail: recipient.recipientEmail,
        recipientName: recipient.recipientName,
        senderName: 'You', // Get from current user
        documentName: widget.documentName,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reminder sent to ${recipient.recipientName}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending reminder: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.documentName),
        actions: [
          IconButton(
            icon: const Icon(HugeIcons.strokeRoundedRefresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusCard(),
            const SizedBox(height: 20),
            _buildRecipientsSection(),
            const SizedBox(height: 20),
            _buildAuditTrailSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    final status = _documentStatus;
    if (status == null) return const SizedBox();

    Color statusColor;
    IconData statusIcon;
    
    switch (status.status) {
      case DocumentStatus.draft:
        statusColor = Colors.grey;
        statusIcon = HugeIcons.strokeRoundedEdit01;
        break;
      case DocumentStatus.sent:
        statusColor = Colors.blue;
        statusIcon = HugeIcons.strokeRoundedTelegram;
        break;
      case DocumentStatus.in_progress:
        statusColor = Colors.orange;
        statusIcon = HugeIcons.strokeRoundedClock01;
        break;
      case DocumentStatus.completed:
        statusColor = Colors.green;
        statusIcon = HugeIcons.strokeRoundedCheckmarkCircle01;
        break;
      case DocumentStatus.expired:
        statusColor = Colors.red;
        statusIcon = HugeIcons.strokeRoundedAlarmClock;
        break;
      case DocumentStatus.cancelled:
        statusColor = Colors.red;
        statusIcon = HugeIcons.strokeRoundedCancel01;
        break;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(statusIcon, color: statusColor),
                const SizedBox(width: 8),
                Text(
                  status.status.name.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatusItem(
                    'Total Recipients',
                    '${status.totalRecipients ?? 0}',
                    HugeIcons.strokeRoundedUserGroup,
                  ),
                ),
                Expanded(
                  child: _buildStatusItem(
                    'Signed',
                    '${status.signedCount ?? 0}',
                    HugeIcons.strokeRoundedCheckmarkCircle01,
                  ),
                ),
                Expanded(
                  child: _buildStatusItem(
                    'Pending',
                    '${status.pendingCount ?? 0}',
                    HugeIcons.strokeRoundedClock01,
                  ),
                ),
              ],
            ),
            if (status.sentAt != null) ...[
              const SizedBox(height: 8),
              Text(
                'Sent: ${DateFormat('MMM dd, yyyy at HH:mm').format(status.sentAt!)}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
            if (status.expiresAt != null) ...[
              const SizedBox(height: 4),
              Text(
                'Expires: ${DateFormat('MMM dd, yyyy at HH:mm').format(status.expiresAt!)}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.grey),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRecipientsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recipients',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ..._recipientStatuses.map((recipient) => _buildRecipientCard(recipient)),
      ],
    );
  }

  Widget _buildRecipientCard(RecipientStatus recipient) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (recipient.status) {
      case SigningStatus.pending:
        statusColor = Colors.orange;
        statusIcon = HugeIcons.strokeRoundedClock01;
        statusText = 'Pending';
        break;
      case SigningStatus.viewed:
        statusColor = Colors.blue;
        statusIcon = HugeIcons.strokeRoundedView;
        statusText = 'Viewed';
        break;
      case SigningStatus.signed:
        statusColor = Colors.green;
        statusIcon = HugeIcons.strokeRoundedCheckmarkCircle01;
        statusText = 'Signed';
        break;
      case SigningStatus.declined:
        statusColor = Colors.red;
        statusIcon = HugeIcons.strokeRoundedCancel01;
        statusText = 'Declined';
        break;
      case SigningStatus.expired:
        statusColor = Colors.red;
        statusIcon = HugeIcons.strokeRoundedAlarmClock;
        statusText = 'Expired';
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.1),
          child: Icon(statusIcon, color: statusColor),
        ),
        title: Text(recipient.recipientName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(recipient.recipientEmail),
            if (recipient.viewedAt != null)
              Text(
                'Viewed: ${DateFormat('MMM dd, HH:mm').format(recipient.viewedAt!)}',
                style: const TextStyle(fontSize: 12),
              ),
            if (recipient.signedAt != null)
              Text(
                'Signed: ${DateFormat('MMM dd, HH:mm').format(recipient.signedAt!)}',
                style: const TextStyle(fontSize: 12),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                statusText,
                style: TextStyle(color: statusColor, fontSize: 12),
              ),
            ),
            if (recipient.status == SigningStatus.pending ||
                recipient.status == SigningStatus.viewed)
              IconButton(
                icon: const Icon(HugeIcons.strokeRoundedNotification02),
                onPressed: () => _sendReminder(recipient),
                tooltip: 'Send Reminder',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuditTrailSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Activity Timeline',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ..._auditLogs.map((log) => _buildAuditLogItem(log)),
      ],
    );
  }

  Widget _buildAuditLogItem(AuditLog log) {
    IconData icon;
    Color color;
    String description;

    switch (log.action) {
      case AuditAction.document_uploaded:
        icon = HugeIcons.strokeRoundedUpload01;
        color = Colors.blue;
        description = 'Document uploaded';
        break;
      case AuditAction.document_sent:
        icon = HugeIcons.strokeRoundedTelegram;
        color = Colors.green;
        description = 'Document sent for signing';
        break;
      case AuditAction.document_viewed:
        icon = HugeIcons.strokeRoundedView;
        color = Colors.blue;
        description = 'Document viewed';
        break;
      case AuditAction.document_signed:
        icon = HugeIcons.strokeRoundedEdit01;
        color = Colors.green;
        description = 'Document signed';
        break;
      case AuditAction.document_completed:
        icon = HugeIcons.strokeRoundedCheckmarkCircle01;
        color = Colors.green;
        description = 'Document completed';
        break;
      case AuditAction.email_sent:
        icon = HugeIcons.strokeRoundedMail01;
        color = Colors.orange;
        description = 'Email notification sent';
        break;
      default:
        icon = HugeIcons.strokeRoundedInformationCircle;
        color = Colors.grey;
        description = log.action.name.replaceAll('_', ' ');
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                if (log.recipientEmail != null)
                  Text(
                    'Recipient: ${log.recipientEmail}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                Text(
                  DateFormat('MMM dd, yyyy at HH:mm').format(log.timestamp),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}