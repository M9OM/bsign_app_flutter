import 'package:flutter/material.dart';

/// Application-wide constants
class AppConstants {
  // Private constructor to prevent instantiation
  const AppConstants._();
  
  // Navigation constants
  static const int navActionButtonIndex = 1;
  static const double navActionButtonSize = 35.0;
  static const Color navSelectedColor = Colors.black;
  static const Color navUnselectedColor = Colors.grey;
  static const Color primaryColor = Colors.deepPurple;
  
  // Dialog constants
  static const Duration dialogTransitionDuration = Duration(milliseconds: 200);
  static const double blurSigma = 10.0;
  static const double blurBackgroundOpacity = 0.3;
  
  // Button constants
  static const double actionButtonBorderRadius = 32.0;
  static const EdgeInsets actionButtonPadding = 
      EdgeInsets.symmetric(horizontal: 24, vertical: 12);
  
  // Spacing constants
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 40.0;

    static const String appName = 'DocuSign Clone';
  static const String appVersion = '1.0.0';
  
  // Storage keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  
  // Supabase tables
  static const String usersTable = 'profiles';
  static const String documentsTable = 'documents';
  static const String signaturesTable = 'signatures';
  static const String signatureRequestsTable = 'signature_requests';
  
  // Document status
  static const String statusDraft = 'draft';
  static const String statusPendingSignature = 'pending_signature';
  static const String statusCompleted = 'completed';
  static const String statusExpired = 'expired';
  static const String statusCancelled = 'cancelled';
  
  // Signature request status
  static const String requestStatusPending = 'pending';
  static const String requestStatusSigned = 'signed';
  static const String requestStatusDeclined = 'declined';
  static const String requestStatusExpired = 'expired';
  
  // Document types
  static const String typeContract = 'contract';
  static const String typeAgreement = 'agreement';
  static const String typeNDA = 'nda';
  static const String typeInvoice = 'invoice';
  static const String typeOther = 'other';
  
  // Cache directories
  static const String documentsCacheDir = 'documents';
  static const String signaturesCacheDir = 'signatures';
  
  // Animation durations
  static const int shortAnimationDuration = 150; // milliseconds
  static const int mediumAnimationDuration = 300; // milliseconds
  static const int longAnimationDuration = 500; // milliseconds
  
  // Pagination
  static const int defaultPageSize = 20;
  
  // Timeouts
  static const int connectionTimeout = 30; // seconds
  static const int defaultSignatureExpiryDays = 7;

}