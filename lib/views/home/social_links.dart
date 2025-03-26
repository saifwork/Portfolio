import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/utils/constants.dart';
import '../../data/models/config.dart';
import '../../utils/common.dart';

class SocialLinks extends StatelessWidget {
  final Social social;

  const SocialLinks({super.key, required this.social});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding), // Adjust padding as needed
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Fit content height
        children: social.items.map((item) {
          final iconPath = getSvgPath(item.name);
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: padding / 2), // Spacing between icons
            child: InkWell(
              onTap: () {
                // Handle social media link tap
                // launch url
                openURL(item.url);
                print("Tapped on ${item.url}");
              },
              child: SvgPicture.asset(
                iconPath,
                width: 30,
                height: 30,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }  
}
