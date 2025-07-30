import 'package:bsign/models/recipient/recipient_model.dart';
import 'package:bsign/view/pages/document/SignatureScreenLogic.dart';
import 'package:bsign/view/pages/document/enhanced_signature_screen.dart';
import 'package:bsign/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

class EnhancedAddRecipientScreen extends StatefulWidget {
  const EnhancedAddRecipientScreen({super.key});

  @override
  State<EnhancedAddRecipientScreen> createState() => _EnhancedAddRecipientScreenState();
}

class _EnhancedAddRecipientScreenState extends State<EnhancedAddRecipientScreen> {
  RecipientRole selectedRole = RecipientRole.NEEDS_TO_SIGN;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signatureProvider = Provider.of<SignatureScreenProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipients'),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRoleSelection(),
              const SizedBox(height: 24),
              _buildRecipientForm(),
              const SizedBox(height: 24),
              _buildRecipientsList(signatureProvider),
              const SizedBox(height: 24),
              _buildCustomMessage(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (signatureProvider.recipients.isEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(HugeIcons.strokeRoundedInformationCircle, color: Colors.orange),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Add at least one recipient to continue',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  onPressed: () {
                    if (signatureProvider.recipients.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please add at least one recipient first'),
                          backgroundColor: Colors.orange,
                        ),
                      );
                      return;
                    }
                    
                    // Navigate to signature screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider.value(
                          value: signatureProvider,
                          child: const EnhancedSignatureScreen(),
                        ),
                      ),
                    );
                  },
                  label: signatureProvider.recipients.isEmpty 
                      ? 'Add Recipients First' 
                      : 'Continue to Add Fields (${signatureProvider.recipients.length})',
                  color: signatureProvider.recipients.isEmpty 
                      ? Colors.grey 
                      : Theme.of(context).primaryColor,
                  isLoading: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Recipient Role",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        _buildRoleCard(
          RecipientRole.NEEDS_TO_SIGN,
          "Needs to Sign",
          "Must complete required signature fields",
          HugeIcons.strokeRoundedEdit01,
          Colors.blue,
        ),
        _buildRoleCard(
          RecipientRole.IN_PERSON_SIGNER,
          "In-Person Signer", 
          "Will sign the document in person",
          HugeIcons.strokeRoundedChair01,
          Colors.green,
        ),
        _buildRoleCard(
          RecipientRole.RECEIVES_COPY,
          "Receives a Copy",
          "Gets a copy when document is completed",
          HugeIcons.strokeRoundedCopy01,
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildRoleCard(
    RecipientRole role,
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    final isSelected = selectedRole == role;

    return GestureDetector(
      onTap: () => setState(() => selectedRole = role),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: color.withOpacity(isSelected ? 0.1 : 0.05),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: color),
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
                      color: color,
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
              Icon(Icons.check_circle, color: color),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipientForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Add Recipient",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Full Name *',
            border: OutlineInputBorder(),
            prefixIcon: Icon(HugeIcons.strokeRoundedUser),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Name is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email Address *',
            border: OutlineInputBorder(),
            prefixIcon: Icon(HugeIcons.strokeRoundedMail01),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Email is required';
            }
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value.trim())) {
              return 'Enter a valid email address';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _addRecipient,
            icon: const Icon(HugeIcons.strokeRoundedUserAdd01),
            label: const Text("Add Recipient"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              foregroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecipientsList(SignatureScreenProvider provider) {
    if (provider.recipients.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recipients",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              '${provider.recipients.length} recipient${provider.recipients.length == 1 ? '' : 's'}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...provider.recipients.asMap().entries.map((entry) {
          final index = entry.key;
          final recipient = entry.value;
          return _buildRecipientListItem(recipient, index, provider);
        }),
      ],
    );
  }

  Widget _buildRecipientListItem(
    Recipient recipient,
    int index,
    SignatureScreenProvider provider,
  ) {
    Color roleColor;
    IconData roleIcon;
    
    switch (recipient.role) {
      case RecipientRole.NEEDS_TO_SIGN:
        roleColor = Colors.blue;
        roleIcon = HugeIcons.strokeRoundedEdit01;
        break;
      case RecipientRole.IN_PERSON_SIGNER:
        roleColor = Colors.green;
        roleIcon = HugeIcons.strokeRoundedUser;
        break;
      case RecipientRole.RECEIVES_COPY:
        roleColor = Colors.orange;
        roleIcon = HugeIcons.strokeRoundedCopy01;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: roleColor.withOpacity(0.1),
          child: Icon(roleIcon, color: roleColor),
        ),
        title: Text(recipient.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(recipient.user_email),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: roleColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                recipient.role.name.replaceAll('_', ' '),
                style: TextStyle(
                  color: roleColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(HugeIcons.strokeRoundedDelete01, color: Colors.red),
          onPressed: () {
            setState(() {
              // Remove from the provider's recipients list
              final recipientsList = List<Recipient>.from(provider.recipients);
              recipientsList.removeAt(index);
              provider.recipients.clear();
              provider.recipients.addAll(recipientsList);
            });
          },
        ),
      ),
    );
  }

  Widget _buildCustomMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Custom Message (Optional)",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: messageController,
          decoration: const InputDecoration(
            labelText: 'Add a personal message for recipients',
            border: OutlineInputBorder(),
            prefixIcon: Icon(HugeIcons.strokeRoundedMessage01),
          ),
          maxLines: 3,
          maxLength: 500,
        ),
      ],
    );
  }

  void _addRecipient() {
    if (!_formKey.currentState!.validate()) return;

    final provider = Provider.of<SignatureScreenProvider>(context, listen: false);
    final name = nameController.text.trim();
    final email = emailController.text.trim();

    // Check for duplicate emails
    if (provider.recipients.any((r) => r.user_email.toLowerCase() == email.toLowerCase())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This email is already added')),
      );
      return;
    }

    // Add recipient to provider
    provider.addRecipientLocally(
      Recipient(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        user_email: email,
        role: selectedRole,
        document_id: '',
      ),
    );

    // Clear form
    nameController.clear();
    emailController.clear();
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name added successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider.value(
                                value: signatureProvider,
                                child: const EnhancedSignatureScreen(),
                              ),
                            ),
                          );
                        },
                  label: 'Continue to Add Fields',
                  color: Theme.of(context).primaryColor,
                  isLoading: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Recipient Role",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        _buildRoleCard(
          RecipientRole.NEEDS_TO_SIGN,
          "Needs to Sign",
          "Must complete required signature fields",
          HugeIcons.strokeRoundedEdit01,
          Colors.blue,
        ),
        _buildRoleCard(
          RecipientRole.IN_PERSON_SIGNER,
          "In-Person Signer",
          "Will sign the document in person",
          HugeIcons.strokeRoundedChair01,
          Colors.green,
        ),
        _buildRoleCard(
          RecipientRole.RECEIVES_COPY,
          "Receives a Copy",
          "Gets a copy when document is completed",
          HugeIcons.strokeRoundedCopy01,
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildRoleCard(
    RecipientRole role,
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    final isSelected = selectedRole == role;

    return GestureDetector(
      onTap: () => setState(() => selectedRole = role),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: color.withOpacity(isSelected ? 0.1 : 0.05),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: color),
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
                      color: color,
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
              Icon(Icons.check_circle, color: color),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipientForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Add Recipient",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Full Name *',
            border: OutlineInputBorder(),
            prefixIcon: Icon(HugeIcons.strokeRoundedUser),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Name is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email Address *',
            border: OutlineInputBorder(),
            prefixIcon: Icon(HugeIcons.strokeRoundedMail01),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Email is required';
            }
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value.trim())) {
              return 'Enter a valid email address';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _addRecipient,
            icon: const Icon(HugeIcons.strokeRoundedUserAdd01),
            label: const Text("Add Recipient"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              foregroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecipientsList(SignatureScreenProvider provider) {
    if (provider.recipients.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recipients",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              '${provider.recipients.length} recipient${provider.recipients.length == 1 ? '' : 's'}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...provider.recipients.asMap().entries.map((entry) {
          final index = entry.key;
          final recipient = entry.value;
          return _buildRecipientListItem(recipient, index, provider);
        }),
      ],
    );
  }

  Widget _buildRecipientListItem(
    Recipient recipient,
    int index,
    SignatureScreenProvider provider,
  ) {
    Color roleColor;
    IconData roleIcon;
    
    switch (recipient.role) {
      case RecipientRole.NEEDS_TO_SIGN:
        roleColor = Colors.blue;
        roleIcon = HugeIcons.strokeRoundedEdit01;
        break;
      case RecipientRole.IN_PERSON_SIGNER:
        roleColor = Colors.green;
        roleIcon = HugeIcons.strokeRoundedUser;
        break;
      case RecipientRole.RECEIVES_COPY:
        roleColor = Colors.orange;
        roleIcon = HugeIcons.strokeRoundedCopy01;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: roleColor.withOpacity(0.1),
          child: Icon(roleIcon, color: roleColor),
        ),
        title: Text(recipient.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(recipient.user_email),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: roleColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                recipient.role.name.replaceAll('_', ' '),
                style: TextStyle(
                  color: roleColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(HugeIcons.strokeRoundedDelete01, color: Colors.red),
          onPressed: () {
            setState(() {
              provider.recipients.removeAt(index);
            });
          },
        ),
      ),
    );
  }

  Widget _buildCustomMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Custom Message (Optional)",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: messageController,
          decoration: const InputDecoration(
            labelText: 'Add a personal message for recipients',
            border: OutlineInputBorder(),
            prefixIcon: Icon(HugeIcons.strokeRoundedMessage01),
          ),
          maxLines: 3,
          maxLength: 500,
        ),
      ],
    );
  }

  void _addRecipient() {
    if (!_formKey.currentState!.validate()) return;

    final provider = Provider.of<SignatureScreenProvider>(context, listen: false);
    final name = nameController.text.trim();
    final email = emailController.text.trim();

    // Check for duplicate emails
    if (provider.recipients.any((r) => r.user_email.toLowerCase() == email.toLowerCase())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This email is already added')),
      );
      return;
    }

    setState(() {
      provider.addRecipientLocally(
        Recipient(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: name,
          user_email: email,
          role: selectedRole,
          document_id: '',
        ),
      );
      nameController.clear();
      emailController.clear();
      FocusScope.of(context).unfocus();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$name added successfully')),
    );
  }
}