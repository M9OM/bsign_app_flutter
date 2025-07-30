import 'package:url_launcher/url_launcher.dart';

extension URLExtension on Uri {
  Future<void> launchUrl_() async {
    if (!await launchUrl(this, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $this');
    }
  }
}
