import 'package:bsign/extensions/datetime_extensions.dart';
import 'package:bsign/providers/document_provider.dart';
import 'package:bsign/services/auth_service.dart';
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
  @override
  void initState() {
    super.initState();
    final userId = AuthService().currentUser; // أو حسب المستخدم الحالي
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DocumentProvider>(
        context,
        listen: false,
      ).loadDocuments(userId!.id);
    });
  }
Future<int> _getActionRequiredCount() async {
  final userId = Supabase.instance.client.auth.currentUser?.id;
  if (userId == null) return 0;

  final response = await Supabase.instance.client
      .from('signature_fields')
      .select('id')
      .eq('recipientsUid', userId)
      .eq('is_signed', false)
      .count(CountOption.exact);

  return response.count;
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
                type:
                    PageTransitionType
                        .bottomToTop, // تأثير التكبير من نقطة معينة
                alignment: Alignment.bottomCenter, // تظهر من اليسار
                child: ChatBotPage(),
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
        drawer: AppDrawer(),
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
              // 🔹 صف الأنشطة مع انيميشن fadeUp
              Row(
                children: [
Expanded(
  child: FutureBuilder<int>(
    future: _getActionRequiredCount(),
    builder: (context, snapshot) {
      final count = snapshot.data ?? 0;
      return ActivityTile(
        count: "$count",
        title: "Action Required",
        description: "Please provide your signature to continue",
        icon: HugeIcons.strokeRoundedInbox,
      ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.3, end: 0);
    },
  ),
),

                  const SizedBox(width: 12),
                  Expanded(
                    child: ActivityTile(
                          count: "0",
                          title: "Waiting for Others",
                          description: "",
                          icon: HugeIcons.strokeRoundedUserTime01,
                        )
                        .animate()
                        .fadeIn(duration: 700.ms)
                        .slideY(begin: 0.3, end: 0),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // عنوان Recent Documents مع انيميشن
              const Text(
                "Recent Documents",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),
              const SizedBox(height: 12),

              ...docProvider.documents.map(
                (doc) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType
                            .rightToLeft, // تأثير الانتقال من اليمين لليسار
                        child: docProvider.getDocumentPage(doc),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: buildRecentItem(
                    title: doc.name,
                    date: doc.uploadedAt!.relativeTime,
                    from: '',
                    context: context,
                    needsToSign:true,
                      
                    isDraft: true,
                  ).animate().fade(duration: 500.ms).slideY(begin: 0.3, end: 0),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: CustomBottomNav(currentIndex: 0, onTap: (index) {}),
        ),
      ),
    );
  }
}
