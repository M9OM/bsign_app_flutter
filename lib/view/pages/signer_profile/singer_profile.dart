import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class SignerProfilePage extends StatefulWidget {
  final String avatarUrl;
  final String username;
  final String email;
  final int documentsSigned;
  final DateTime? lastSignedAt;

  const SignerProfilePage({
    super.key,
    required this.avatarUrl,
    required this.username,
    required this.email,
    required this.documentsSigned,
    this.lastSignedAt,
  });

  @override
  State<SignerProfilePage> createState() => _SignerProfilePageState();
}

class _SignerProfilePageState extends State<SignerProfilePage>
    with SingleTickerProviderStateMixin {
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    // بدء الأنيميشن بعد تأخير بسيط
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(HugeIcons.strokeRoundedPen01),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Start signing...')),
              );
            },
          ),
        ],
      ),
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _animate ? 1.0 : 0.0,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 500),
          offset: _animate ? Offset.zero : const Offset(0, 0.1),
          curve: Curves.easeOut,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(widget.avatarUrl),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.username,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(widget.email,
                              style: const TextStyle(color: Colors.grey)),
                          const SizedBox(height: 4),
                          const Text(
                            'Trusted signer in your workspace',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatCard('Signed Docs',
                        widget.documentsSigned.toString(), context),
                    _buildStatCard(
                        'Last Signed',
                        widget.lastSignedAt != null
                            ? '${widget.lastSignedAt!.day}/${widget.lastSignedAt!.month}/${widget.lastSignedAt!.year}'
                            : 'Never',
                        context),
                  ],
                ),
                const SizedBox(height: 16),
                _buildProgressCard(
                    'Level Progress', '32', '1,421 XP', 0.6, context),
                const SizedBox(height: 16),
                _buildTaskCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

Widget _buildProgressCard(
    String title, String level, String xp, double progress, BuildContext context) {
  // حساب النسبة المئوية
  final percentage = (progress * 100).toStringAsFixed(0);

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 8),
        Text(
          'Documents Signed',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          color: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          minHeight: 6,
        ),
        const SizedBox(height: 4),
        Text('$percentage%', style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    ),
  );
}


Widget _buildTaskCard(BuildContext context) {
  // بيانات وهمية: قائمة من الخرائط (Map)
  final signedDocuments = [
    {'file': 'contract1.pdf', 'date': '10/06/2025'},
    {'file': 'nda2.pdf', 'date': '08/06/2025'},
        {'file': 'nda2.pdf', 'date': '08/06/2025'},
    {'file': 'nda2.pdf', 'date': '08/06/2025'},
    {'file': 'nda2.pdf', 'date': '08/06/2025'},

    {'file': 'offer_letter3.pdf', 'date': '01/06/2025'},
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Documents History',
            style: TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 8),
        // نعرض كل مستند بالتاريخ
        for (var doc in signedDocuments)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                const Icon(HugeIcons.strokeRoundedFile01, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    doc['file']!,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Text(
                  doc['date']!,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

}
