import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrlHelper(String url, {Uri? launchUri}) async {
  final Uri uri = launchUri ?? Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}
