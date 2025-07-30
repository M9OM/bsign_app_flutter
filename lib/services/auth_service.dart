import 'package:bsign/core/supabase_config.dart';
import 'package:bsign/models/user/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = SupabaseConfig.client;

  // إرسال كود OTP للبريد
  Future<String?> sendOtp(String email) async {
    try {
      await _client.auth.signInWithOtp(
        email: email,
        shouldCreateUser: true,
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // التحقق من الكود وإنشاء المستخدم في جدول users إذا ما كان موجود
  Future<String?> verifyOtp(String email, String token) async {
    try {
      await _client.auth.verifyOTP(
        type: OtpType.email,
        email: email,
        token: token,
      );

      final user = _client.auth.currentUser;
      if (user == null) return "فشل تسجيل الدخول";

      // تحقق إذا المستخدم موجود في جدول users
      final existingUser = await _client
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      // إذا ما موجود، أنشئ المستخدم
      if (existingUser == null) {
        await _client.from('users').insert({
          'id': user.id,
          'email': user.email,
          'full_name':user.email,
          'created_at': DateTime.now().toIso8601String(), // حسب جدولك
          // أضف أي بيانات ثانية حسب جدول users
        });
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // جلب بيانات المستخدم من جدول users
  Future<AppUser?> getUserModel() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final response = await _client
        .from('users')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (response == null) return null;

    return AppUser.fromJson(response);
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  User? get currentUser => _client.auth.currentUser;
}
