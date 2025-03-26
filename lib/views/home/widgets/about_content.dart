import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../data/models/config.dart';
import '../../../utils/constants.dart';
import '../../../widgets/title_header.dart';

class AboutContentWidget extends StatelessWidget {
  final About about;
  final About skills;
  final Function(String)? scrollToSection;

  const AboutContentWidget({
    super.key,
    required this.about,
    required this.skills,
    required this.scrollToSection,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isMobile = screenWidth < 900; // Define breakpoint for mobile layout

    return Stack(
      children: [
        /// 🌟 **Responsive Background**
        Positioned.fill(
          child: SvgPicture.asset(
            "assets/svg/about-bg.svg",
            fit: isMobile ? BoxFit.contain : BoxFit.cover,
          ),
        ),

        /// 🌟 **Content with Semi-Transparent Background**
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 32, // Adjust padding for mobile
            vertical: isMobile ? 20 : 40,
          ),
          color: Colors.white60,
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.1),

              /// 🌟 **Title & Description**
              const TitleHeader(
                title: "ABOUT ME",
                content:
                    "Here you will find more information about me, what I do, and my current skills mostly in terms\n of programming and technology",
              ),

              const SizedBox(height: kH20 * 2),

              /// 🌟 **Responsive Layout**
              LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      if (isMobile)
                        /// **Single Column Layout for Mobile**
                        Column(
                          children: [
                            _buildAboutSection(context, about, true),
                            const SizedBox(height: kH20 * 2),
                            _buildSkillsSection(context, skills, true),
                          ],
                        )
                      else
                        /// **Two-Column Layout for Desktop**
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildAboutSection(context, about, false)),
                            Expanded(child: _buildSkillsSection(context, skills, false)),
                          ],
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// **Helper Function for About Section**
  Widget _buildAboutSection(BuildContext context, About about, bool isMobile) {
    return Padding(
      padding: EdgeInsets.all(isMobile ? padding * 2 : padding * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            about.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: isMobile ? 22 : 26,
                ),
          ),
          const SizedBox(height: kH20 * 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: about.items.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: padding),
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: isMobile ? 14 : 16,
                      ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: kH20 * 2),

          /// **Contact Button**
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (scrollToSection != null) {
                  scrollToSection!("contact");
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(isMobile ? 160 : 180, isMobile ? 50 : 60),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 20,
                  vertical: isMobile ? 12 : 15,
                ),
              ),
              child: Text(
                "CONTACT",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: isMobile ? 14 : 16,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// **Helper Function for Skills Section**
  Widget _buildSkillsSection(BuildContext context, About skills, bool isMobile) {
    return Padding(
      padding: EdgeInsets.all(isMobile ? padding * 2 : padding * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            skills.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: isMobile ? 22 : 26,
                ),
          ),
          const SizedBox(height: kH20 * 2),

          /// **Skills Grid (Wrap for Responsiveness)**
          Wrap(
            spacing: 12.0, // Space between items horizontally
            runSpacing: 12.0, // Space between items vertically
            children: skills.items.map((item) {
              return Container(
                padding: const EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: isMobile ? 14 : 16,
                      ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
