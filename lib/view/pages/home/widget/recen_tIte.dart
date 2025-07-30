import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget buildRecentItem({
  required String title,
  required String date,
  required BuildContext context,
  String from = "",
  bool needsToSign = false,
  bool isDraft = false,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    
    decoration: BoxDecoration(
      border: Border.all(width: 1, color: Colors.grey.withOpacity(0.3)),
          color: Colors.grey.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),

    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 الأيقونة
        Icon(
          isDraft
              ? HugeIcons.strokeRoundedUserWarning01
              : HugeIcons.strokeRoundedEdit01,
          size: 28,
        ),
        const SizedBox(width: 12),

        /// 🔹 المحتوى النصي
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// العنوان
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600),

                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),

              /// المصدر
              if (from.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    "From: $from",
                    style: TextStyle(fontSize: 13),
                  ),
                ),

              /// الحالة
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: !needsToSign
                        ? Colors.red.withOpacity(0.1)
                        : Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isDraft
                        ? "Draft"
                        : (needsToSign ? "Needs to Sign" : ""),
                    style: TextStyle(
                      fontSize: 13,
                      color: !needsToSign
                          ? Colors.red[800]
                          : Colors.green[600],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        /// 🔹 التاريخ
        Text(
          date,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    ),
  );
}
