import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/data/models/config.dart';
import 'package:portfolio/utils/constants.dart';
import 'package:timelines/timelines.dart';
import '../../../widgets/title_header.dart';

class ExperiencesContent extends StatelessWidget {
  final List<Experience> experiences;
  const ExperiencesContent({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isMobile = screenWidth < 900; // Mobile breakpoint

    return Stack(
      children: [
        /// 🌟 **Responsive Background**
        Positioned.fill(
          child: SvgPicture.asset(
            "assets/svg/bg3.svg",
            fit: BoxFit.cover,
          ),
        ),

        /// 🌟 **Main Content**
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 32, // Adjust padding
            vertical: isMobile ? 20 : 40,
          ),
          color: Colors.white60,
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.1),

              /// **Title & Description**
              const TitleHeader(
                title: "EXPERIENCES",
                content:
                    "Here you will find details about my professional journey, including my roles, responsibilities, and the technologies\n I have worked with across different companies and projects.",
              ),

              const SizedBox(height: kH20 * 2),

              /// **Responsive Timeline**
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: isMobile ? 8.0 : 32.0),
                child: FixedTimeline(
                  theme: TimelineThemeData(
                    nodePosition:
                        isMobile ? 0.0 : 0.1, // Center nodes on mobile
                    connectorTheme: ConnectorThemeData(
                      color: Colors.grey[400]!,
                      thickness: isMobile ? 2.0 : 2.5,
                    ),
                  ),
                  children: experiences.map((experience) {
                    return TimelineTile(
                      oppositeContents: isMobile
                          ? null // Remove duration on mobile
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                experience.duration,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w100,
                                      color: Colors.black54,
                                    ),
                              ),
                            ),
                      contents:
                          _buildExperienceCard(context, experience, isMobile),
                      node: const TimelineNode(
                        indicator: DotIndicator(),
                        startConnector: SolidLineConnector(),
                        endConnector: SolidLineConnector(),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// **Responsive Experience Card**
  Widget _buildExperienceCard(
      BuildContext context, Experience experience, bool isMobile) {
    return Padding(
      padding: EdgeInsets.all(isMobile ? padding / 1.5 : padding / 2),
      child: Card(
        color: Colors.black12,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Title**
              Text(
                experience.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: isMobile ? 18 : 20,
                    ),
              ),
              const SizedBox(height: 4),

              /// **Company**
              Text(
                experience.company,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[700],
                      fontSize: isMobile ? 14 : 16,
                    ),
              ),
              const SizedBox(height: 2),
              if (isMobile)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    experience.duration,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w100,
                          color: Colors.black54,
                        ),
                  ),
                ),
              const SizedBox(height: 4),

              /// **Location**
              Text(
                "• ${experience.location}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: isMobile ? 12 : 14,
                    ),
              ),
              const SizedBox(height: 8),

              /// **Responsibilities**
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: experience.responsibilities.map((task) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.arrow_right,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            task,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: isMobile ? 14 : 16,
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
