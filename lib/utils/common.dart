import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

String getSvgPath(String name) {
    Map<String, String> socialIcons = {
      "GitHub": "assets/svg/github-dark.svg",
      "LinkedIn": "assets/svg/linkedin-dark.svg",
      "Twitter": "assets/svg/twitter-dark.svg",
      "Instagram": "assets/svg/instagram-dark.svg",
    };

    return socialIcons[name] ??
        "assets/svg/default.svg"; // Default icon fallback
}

Future<void> openURL(String uri) async {
  final Uri url = Uri.parse(uri);

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw "Could not launch $url";
  }
}

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.black87, // Customize color if needed
      duration: const Duration(seconds: 3),
    ),
  );
}

