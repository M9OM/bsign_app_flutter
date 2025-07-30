import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:bsign/core/config/constants.dart';
import 'package:bsign/view/widgets/dialogs/enhanced_attachment_list.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
class EnhancedBlurActionSheet {
  static void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: AppConstants.dialogTransitionDuration,
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: AppConstants.blurSigma,
              sigmaY: AppConstants.blurSigma,
            ),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                color: Colors.black.withOpacity(
                  AppConstants.blurBackgroundOpacity,
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header text
                          FadeInUp(
                            duration: const Duration(milliseconds: 400),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
          color: Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                  ),
                                  child: const Text(
                                    'What would you like to do?',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Action buttons
                          FadeInUp(
                            duration: const Duration(milliseconds: 500),
                            child: _buildActionButton(
                              icon: HugeIcons.strokeRoundedUserGroup,
                              label: "Request Signatures",
                              subtitle: "Send documents to others for signing",
                              color: Colors.blue,
                              onTap: () {
                                Navigator.pop(context);
                                showEnhancedAttachmentOptions(context, "request");
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          FadeInUp(
                            duration: const Duration(milliseconds: 570),
                            child: _buildActionButton(
                              icon: HugeIcons.strokeRoundedEdit02,
                              label: "Sign Document",
                              subtitle: "Add your signature to a document",
                              color: Colors.green,
                              onTap: () {
                                Navigator.pop(context);
                                showEnhancedAttachmentOptions(context, "sign");
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          _buildCloseButton(context),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildActionButton({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
          color: Colors.grey.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          width: 280,
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildCloseButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        padding: const EdgeInsets.all(16),
        child: const Icon(
          Icons.close,
          size: 24,
        ),
      ),
    );
  }
}