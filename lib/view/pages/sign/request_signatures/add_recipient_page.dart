import 'package:bsign/models/recipient/recipient_model.dart';
import 'package:bsign/view/pages/document/SignatureScreenLogic.dart';
import 'package:bsign/view/pages/document/signature_screen.dart';
import 'package:bsign/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

class AddRecipientScreen extends StatefulWidget {
  const AddRecipientScreen({super.key});

  @override
  State<AddRecipientScreen> createState() => _AddRecipientScreenState();
}

class _AddRecipientScreenState extends State<AddRecipientScreen> {
  RecipientRole selectedRole = RecipientRole.NEEDS_TO_SIGN;
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  List<Recipient> recipients = [];

  Widget buildRoleCard(
    RecipientRole role,
    String title,
    String subtitle,
    IconData icon,
  ) {
    final isSelected = selectedRole == role;

    return GestureDetector(
      onTap: () => setState(() => selectedRole = role),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).primaryColor.withOpacity(0.08),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Theme.of(context).primaryColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }

  void addRecipient() {
    final prvider = Provider.of<SignatureScreenProvider>(
      context,
      listen: false,
    );

    final name = nameController.text.trim();
    final email = emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter name and email')),
      );
      return;
    }

    setState(() {
      prvider.addRecipientLocally(
        Recipient(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: name,
          user_email: email,
          role: selectedRole, document_id: '',
        ),
      );
      nameController.clear();
      emailController.clear();
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final signatureProvider = Provider.of<SignatureScreenProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipient'),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select a Role",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            buildRoleCard(
              RecipientRole.NEEDS_TO_SIGN,
              "Needs to Sign",
              "Must complete required signature fields",
              HugeIcons.strokeRoundedEdit01,
            ),
            buildRoleCard(
              RecipientRole.RECEIVES_COPY,
              "Receives a Copy",
              "Anyone who only needs a completed copy",
              HugeIcons.strokeRoundedCopy01,
            ),
            const SizedBox(height: 24),
            const Text(
              "Add Recipient",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Recipient Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Recipient Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 2),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: addRecipient,
                icon: Icon(
                  HugeIcons.strokeRoundedUserAdd01,
                  color: Theme.of(context).primaryColor,
                ),
                label: Text(
                  "Add Recipient",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(
                    context,
                  ).primaryColor.withOpacity(0.1),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (signatureProvider.recipients.isNotEmpty)
              const Text(
                "Recipients List",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            const SizedBox(height: 12),
            ...signatureProvider.recipients.map((recipient) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text(recipient.name[0].toUpperCase()),
                ),
                title: Text(recipient.name),
                subtitle: Text(recipient.user_email),
              );
            }),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: CustomButton(
              onPressed: () {
                final signatureProvider = Provider.of<SignatureScreenProvider>(
                  context,
                  listen: false,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => ChangeNotifierProvider.value(
                          value:
                              signatureProvider, // ✅ مرر المزود الحالي بدل إنشاء جديد
                          child: const SignatureScreen(),
                        ),
                  ),
                );
              },
              label: 'Next',
              color: Theme.of(context).primaryColor,
              isLoading: false,
            ),
          ),
        ),
      ),
    );
  }
}
