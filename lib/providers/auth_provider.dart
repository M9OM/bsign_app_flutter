import 'package:bsign/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? get user => _authService.currentUser;

  AppUser? _userModel;
  AppUser? get userModel => _userModel;

  // تحميل بيانات المستخدم من جدول users
  Future<void> loadUserModel() async {
    _userModel = await _authService.getUserModel();
    notifyListeners();
  }

  // إرسال OTP للبريد
  Future<String?> sendOtp(String email) async {
    _isLoading = true;
    notifyListeners();

    final error = await _authService.sendOtp(email);

    _isLoading = false;
    notifyListeners();

    return error;
  }

  // التحقق من OTP وتحميل بيانات المستخدم
  Future<String?> verifyOtp(String email, String token) async {
    _isLoading = true;
    notifyListeners();

    final error = await _authService.verifyOtp(email, token);
    if (error == null) {
      await loadUserModel();
    }

    _isLoading = false;
    notifyListeners();

    return error;
  }

  // تسجيل الخروج
  Future<void> logout() async {
    await _authService.signOut();
    _userModel = null;
    notifyListeners();
  }
}
