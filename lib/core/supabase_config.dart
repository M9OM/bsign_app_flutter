import 'package:bsign/core/config/apis.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: Apis.supabaseUrl,
      anonKey:Apis.supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
