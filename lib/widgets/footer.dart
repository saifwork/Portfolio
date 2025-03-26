import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../data/models/config.dart';
import '../utils/common.dart';
import '../utils/constants.dart';

class FooterWidget extends StatelessWidget {
  final About footer;
  final Social social;
  const FooterWidget({
    super.key,
    required this.footer,
    required this.social,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 900; // Define mobile breakpoint

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? padding : padding * 2,
        horizontal: isMobile ? padding : padding * 2,
      ),
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// **🌟 Footer Content (Responsive Layout)**
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFooterSection(context, footer, true),
                    const SizedBox(height: kH20 * 2),
                    _buildSocialSection(context, social, true),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: _buildFooterSection(context, footer, false)),
                    const SizedBox(width: kW20 * 2),
                    Expanded(
                        child: _buildSocialSection(context, social, false)),
                  ],
                ),

          const Spacer(),

          /// **🌟 Divider**
          Divider(color: Theme.of(context).primaryColor),

          const Spacer(),

          /// **🌟 Copyright Text (Centered on all screens)**
          Align(
            alignment: Alignment.center,
            child: Text(
              textAlign: TextAlign.center,
              '@Copyright 2025 . Made by ${footer.title}',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Colors.white, fontSize: isMobile ? 10 : 12),
            ),
          ),
        ],
      ),
    );
  }

  /// **Footer Section (About Info)**
  Widget _buildFooterSection(
      BuildContext context, About footer, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          footer.title,
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
        ),
        const SizedBox(height: kH20),
        Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: footer.items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: padding / 2),
              child: Text(
                item,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                      fontSize: isMobile ? 12 : 14,
                    ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// **Social Section (Icons & Links)**
  Widget _buildSocialSection(
      BuildContext context, Social social, bool isMobile) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.end,
      children: [
        Text(
          social.title,
          textAlign: isMobile ? TextAlign.center : TextAlign.right,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
        ),
        const SizedBox(height: kH20),

        /// **Icons (Centered on mobile)**
        Wrap(
          alignment: isMobile ? WrapAlignment.start : WrapAlignment.end,
          spacing: 12.0, // Horizontal space between items
          runSpacing: 12.0, // Vertical space between lines
          children: social.items.map((item) {
            final iconPath = getSvgPath(item.name);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: padding / 2),
              child: InkWell(
                onTap: () {
                  openURL(item.url);
                  print("Tapped on ${item.url}");
                },
                child: SvgPicture.asset(
                  iconPath,
                  color: Colors.white,
                  width: isMobile ? 25 : 30,
                  height: isMobile ? 25 : 30,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
