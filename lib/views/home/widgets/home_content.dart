import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/utils/responsive.dart';
import '../../../data/models/config.dart';
import '../../../utils/constants.dart';
import '../social_links.dart';

class HomeContentWidget extends StatelessWidget {
  final Home home;
  final Social social;
  final Function(String)? scrollToSection;

  const HomeContentWidget({
    super.key,
    required this.home,
    required this.social,
    required this.scrollToSection,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 900;

    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.88,
      child: Stack(
        children: [
          /// **Responsive Background**
          const HomeBgWidget(),

          /// **Social Links Positioned Responsively**
          if (!isMobile)
            Positioned(
              left: 0,
              top: screenHeight * 0.35,
              child: SocialLinks(social: social),
            ),

          /// **Main Content (Title, Text, Button)**
          Align(
            alignment: Alignment.center,
            child: ResponsiveWidget(
              maxWidth: isMobile ? screenWidth * 0.85 : 580,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// **Title (Adjust Size for Mobile)**
                  Text(
                    home.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: isMobile ? 28 : 42, // Adjust for mobile
                        ),
                  ),

                  const SizedBox(height: kH20 * 2.5),

                  /// **Content Text**
                  Text(
                    home.content,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w100,
                          fontSize: isMobile ? 14 : 18, // Adjust font size
                        ),
                  ),

                  const SizedBox(height: kH20 * 2.5),

                  /// **Button (Scales for Mobile)**
                  ElevatedButton(
                    onPressed: () {
                      if (scrollToSection != null) {
                        scrollToSection!("projects");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(isMobile ? 150 : 200, isMobile ? 50 : 60),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16 : 20,
                        vertical: isMobile ? 12 : 15,
                      ),
                    ),
                    child: Text(
                      "PROJECTS",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: isMobile ? 14 : 16,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeBgWidget extends StatelessWidget {
  const HomeBgWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 800;

    return Row(
      children: [
        /// **Make Background Flexible Instead of Fixed Expanded**
        Flexible(
          flex: isMobile ? 1 : 2, // Use fewer columns on mobile
          child: SvgPicture.asset(
            "assets/svg/bg1.svg",
            fit: BoxFit.cover,
          ),
        ),
        if (!isMobile) // Hide extra backgrounds on mobile
          Flexible(
            flex: 2,
            child: SvgPicture.asset(
              "assets/svg/bg1.svg",
              fit: BoxFit.cover,
            ),
          ),
        if (!isMobile)
          Flexible(
            flex: 2,
            child: SvgPicture.asset(
              "assets/svg/bg1.svg",
              fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }
}
