import 'package:bsign/extensions/datetime_extensions.dart';
import 'package:bsign/providers/document_provider.dart';
import 'package:bsign/services/auth_service.dart';
import 'package:bsign/view/pages/document/document_list_page.dart';
import 'package:bsign/view/pages/ai_bot/chat_bot.dart';
import 'package:bsign/view/pages/home/widget/abbar.dart';
import 'package:bsign/view/pages/home/widget/activity_tile.dart';
import 'package:bsign/view/pages/home/widget/recen_tIte.dart';
import 'package:bsign/view/widgets/custom_bottom_nav.dart';
import 'package:bsign/view/widgets/drwer.dart';
import 'package:bsign/view/widgets/my_bg.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _actionRequiredCount = 0;
  int _waitingForOthersCount = 0;
  bool _loadingStats = true;

  @override
  void initState() {
    super.initState();
    final userId = AuthService().currentUser;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userId != null) {
        Provider.of<DocumentProvider>(context, listen: false).loadDocuments(userId.id);
        _loadStats();
      }
    });
  }

  Future<void> _loadStats() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    final userEmail = Supabase.instance.client.auth.currentUser?.email;
    
    if (userId == null || userEmail == null) return;

    try {
      // Get action required count (documents assigned to me that need signing)
      final actionRequiredResponse = await Supabase.instance.client
          .from('signature_fields')
          .select('id')
          .eq('recipients_uid', userEmail)
          .eq('is_signed', false);

      // Get waiting for others count (my documents waiting for others to sign)
      final waitingResponse = await Supabase.instance.client
          .from('doc_status')
          .select('id')
          .eq('created_by', userId)
          .inFilter('status', ['sent', 'in_progress']);

      setState(() {
        _actionRequiredCount = actionRequiredResponse.length;
        _waitingForOthersCount = waitingResponse.length;
        _loadingStats = false;
      });
    } catch (e) {
      setState(() => _loadingStats = false);
      debugPrint('Error loading stats: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final docProvider = Provider.of<DocumentProvider>(context);

    return MyBackground(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.bottomToTop,
                alignment: Alignment.bottomCenter,
                child: const ChatBotPage(),
                duration: Duration(milliseconds: 250),
              ),
            );
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            HugeIcons.strokeRoundedChatBot,
            color: Colors.white,
            size: 30,
          ),
        ),
        drawer: const AppDrawer(),
        appBar: HomeAppBar(
          onNotificationTap: () {},
          onProfileTap: () => AuthService().signOut(),
          profileImageUrl:
              'https://i.pinimg.com/736x/2a/07/36/2a0736b064272c56efdd8b482448964e.jpg',
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Activity tiles with stats
              Row(
                children: [
                  Expanded(
                    child: ActivityTile(
                      count: _loadingStats ? "..." : "$_actionRequiredCount",
                      title: "Action Required",
                      description: "Documents waiting for your signature",
                      icon: HugeIcons.strokeRoundedInbox,
                    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.3, end: 0),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ActivityTile(
                          count: _loadingStats ? "..." : "$_waitingForOthersCount",
                          title: "Waiting for Others",
                          description: "Documents sent to others",
                          icon: HugeIcons.strokeRoundedUserTime01,
                        )
                        .animate()
                        .fadeIn(duration: 700.ms)
                        .slideY(begin: 0.3, end: 0),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Recent Documents section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recent Documents",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),
                  if (docProvider.documents.isNotEmpty)
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DocumentListPage(),
                          ),
                        );
                      },
                      child: const Text('View All'),
                    ).animate().fadeIn(duration: 900.ms),
                ],
              ),
              const SizedBox(height: 12),

              // Documents list or empty state
              if (docProvider.isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (docProvider.documents.isEmpty)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        HugeIcons.strokeRoundedFileEmpty01,
                        size: 48,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'No documents yet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Upload your first document to get started',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 500.ms)
              else ...[
                // Show recent documents with enhanced display
                ...docProvider.documents.take(3).map(
                  (doc) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: docProvider.getDocumentPage(doc),
                          duration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                    child: _buildEnhancedDocumentCard(doc)
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slideY(begin: 0.3, end: 0),
                  ),
                ),
                
                // Show count if more documents exist
                if (docProvider.documents.length > 3)
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          HugeIcons.strokeRoundedFile01,
                          size: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${docProvider.documents.length - 3} more documents',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms),
              ],
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: CustomBottomNav(currentIndex: 0, onTap: (index) {}),
        ),
      ),
    );
  }

  Widget _buildEnhancedDocumentCard(doc) {
    // Determine document status and styling
    String statusText = 'Draft';
    Color statusColor = Colors.grey;
    IconData statusIcon = HugeIcons.strokeRoundedEdit01;
    
    // You can enhance this with actual status from document_status table
    if (doc.uploaded_at != null) {
      final daysSinceUpload = DateTime.now().difference(doc.uploaded_at!).inDays;
      if (daysSinceUpload < 1) {
        statusText = 'New';
        statusColor = Colors.green;
        statusIcon = HugeIcons.strokeRoundedSparkles;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.3)),
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Document icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              HugeIcons.strokeRoundedPdf01,
              color: Colors.red,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          
          // Document info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      HugeIcons.strokeRoundedFile01,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${doc.pages} pages',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      HugeIcons.strokeRoundedClock01,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      doc.uploaded_at?.relativeTime ?? 'Unknown',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 12, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        statusText,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Arrow icon
          Icon(
            HugeIcons.strokeRoundedArrowRight01,
            color: Colors.grey[400],
            size: 16,
          ),
        ],
      ),
    );
  }
}
