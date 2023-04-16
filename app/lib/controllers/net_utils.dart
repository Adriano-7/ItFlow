import 'package:url_launcher/url_launcher.dart';

launchURL(String url) async {
  final Uri _url = Uri.parse(url);
  if (await canLaunchUrl(_url)) {
    await launchUrl(_url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
