import 'package:bsign/extensions/datetime_extensions.dart';
import 'package:bsign/models/document/document_model.dart';
import 'package:bsign/models/document_status/document_status_model.dart';
import 'package:bsign/services/document_service.dart';
import 'package:bsign/services/document_status_service.dart';
import 'package:bsign/view/pages/document/document_status_page.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DocumentListPage extends StatefulWidget {
  const DocumentListPage({super.key});

  @override
  State<DocumentListPage> createState() => _DocumentListPageState();
}

class _DocumentListPageState extends State<DocumentListPage> {
  final DocumentService _documentService = DocumentService();
  final DocumentStatusService _statusService = DocumentStatusService();
  
  List<Document> _documents = [];
  Map<String, DocumentStatusModel> _documentStatuses = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

  Future<void> _loadDocuments() async {
    try {
      final currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser == null) return;

      final documents = await _documentService.fetchDocumentsByUser(currentUser.id);
      final Map<String, DocumentStatusModel> statuses = {};

      // Load status for each document
      for (final doc in documents) {
        if (doc.id != null) {
          final status = await _statusService.getDocumentStatus(doc.id!);
          if (status != null) {
            statuses[doc.id!] = status;
          }
        }
      }

      setState(() {
        _documents = documents;
        _documentStatuses = statuses;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading documents: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Documents'),
        actions: [
          IconButton(
            icon: const Icon(HugeIcons.strokeRoundedRefresh),
            onPressed: _loadDocuments,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _documents.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(HugeIcons.strokeRoundedFileEmpty01, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No documents yet',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Upload your first document to get started',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadDocuments,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _documents.length,
                    itemBuilder: (context, index) {
                      final document = _documents[index];
                      final status = _documentStatuses[document.id];
                      return _buildDocumentCard(document, status);
                    },
                  ),
                ),
    );
  }

  Widget _buildDocumentCard(Document document, DocumentStatusModel? status) {
    Color statusColor = Colors.grey;
    IconData statusIcon = HugeIcons.strokeRoundedFile01;
    String statusText = 'Draft';

    if (status != null) {
      switch (status.status) {
        case DocumentStatus.draft:
          statusColor = Colors.grey;
          statusIcon = HugeIcons.strokeRoundedEdit01;
          statusText = 'Draft';
          break;
        case DocumentStatus.sent:
          statusColor = Colors.blue;
          statusIcon = HugeIcons.strokeRoundedTelegram;
          statusText = 'Sent';
          break;
        case DocumentStatus.in_progress:
          statusColor = Colors.orange;
          statusIcon = HugeIcons.strokeRoundedClock01;
          statusText = 'In Progress';
          break;
        case DocumentStatus.completed:
          statusColor = Colors.green;
          statusIcon = HugeIcons.strokeRoundedCheckmarkCircle01;
          statusText = 'Completed';
          break;
        case DocumentStatus.expired:
          statusColor = Colors.red;
          statusIcon = HugeIcons.strokeRoundedAlarmClock;
          statusText = 'Expired';
          break;
        case DocumentStatus.cancelled:
          statusColor = Colors.red;
          statusIcon = HugeIcons.strokeRoundedCancel01;
          statusText = 'Cancelled';
          break;
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.1),
          child: Icon(statusIcon, color: statusColor),
        ),
        title: Text(
          document.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${document.pages} pages'),
            if (document.uploaded_at != null)
              Text(
                'Created ${document.uploaded_at!.relativeTime}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            if (status != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (status.totalRecipients != null && status.totalRecipients! > 0) ...[
                    const SizedBox(width: 8),
                    Text(
                      '${status.signedCount}/${status.totalRecipients} signed',
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          if (document.id != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DocumentStatusPage(
                  documentId: document.id!,
                  documentName: document.name,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}