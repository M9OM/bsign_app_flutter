import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:bsign/core/config/constants.dart';
import 'package:bsign/view/widgets/dialogs/attachment_list.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../buttons/action_button.dart';

class BlurActionSheet {
  /// Shows the blur action sheet dialog
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
                  onTap: () {}, // Prevent tap from propagating to dismiss
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FadeInUp(
                            duration: Duration(milliseconds: 500),
                            child: ActionButton(
                              icon: HugeIcons.strokeRoundedUser,
                              label: "Request Signatures",
                              onTap: () {

                                showAttachmentOptions(context, "request");


                                //   _handleActionTap(
                                //   context,
                                //   NavigationDestination.requestSignatures,
                                // );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          FadeInUp(
                            duration: Duration(milliseconds: 570),

                            child: ActionButton(
                              icon: HugeIcons.strokeRoundedEdit02,
                              label: "Sign Document",
                              onTap: () {
                                showAttachmentOptions(context, "sign");

                                //   _handleActionTap(
                                //   context,
                                //   NavigationDestination.signDocument,
                                // );
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

  static Widget _buildCloseButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          // يمكنك عرض رسالة أو تجاهل الضغط
          debugPrint("لا يمكن الرجوع، هذه هي الصفحة الأخيرة.");
        }
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        padding: const EdgeInsets.all(16),
        child: const Icon(Icons.close, color: Colors.white),
      ),
    );
  }

  static void _handleActionTap(
    BuildContext context,
    NavigationDestination destination,
  ) {
    Navigator.pop(context);
  }
}

/// Enum representing possible navigation destinations from the action sheet
enum NavigationDestination { requestSignatures, signDocument }
