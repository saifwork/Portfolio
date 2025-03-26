import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../data/models/config.dart';
import '../../../providers/portfolio_provider.dart';
import '../../../utils/constants.dart';
import '../../../widgets/title_header.dart';

class ProjectsContentWidget extends StatelessWidget {
  final List<Project> projects;
  const ProjectsContentWidget({
    super.key,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isMobile = screenWidth < 900; // Define breakpoint for mobile layout

    return Stack(
      children: [
        /// 🌟 **Background SVG**
        Positioned(
          right: 0,
          top: 0,
          child: Transform.rotate(
            angle: 50 * (3.141592653589793 / 180), // Convert degrees to radians
            child: SvgPicture.asset(
              "assets/svg/nnneon.svg",
              width: isMobile ? 150 : 300,
              height: isMobile ? 150 : 300,
            ),
          ),
        ),
        Positioned(
          right: isMobile ? 150 : 300,
          top: 0,
          child: Transform.rotate(
            angle: 80 * (3.141592653589793 / 180),
            child: SvgPicture.asset(
              "assets/svg/nnneon.svg",
              width: isMobile ? 150 : 300,
              height: isMobile ? 150 : 300,
            ),
          ),
        ),

        /// **Main Content**
        Column(
          children: [
            SizedBox(height: screenHeight * 0.1),

            /// **Title & Description**
            const TitleHeader(
              title: "PROJECTS",
              content:
                  "Here you will find some of the personal and clients projects that I created with each project\n containing its own case study",
            ),

            const SizedBox(height: kH20 * 2),

            /// **Project List**
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: projects.map((project) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: padding),
                  child: isMobile
                      ? _buildMobileProjectCard(context, project)
                      : _buildDesktopProjectCard(context, project),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }

  /// **Mobile Project Card (Single Column)**
  Widget _buildMobileProjectCard(BuildContext context, Project project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (project.images != null && project.images!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                project.images!.first,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(padding * 2),
          child: _buildProjectDetails(context, project),
        ),
      ],
    );
  }

  /// **Desktop Project Card (Two Columns)**
  Widget _buildDesktopProjectCard(BuildContext context, Project project) {
    bool hasImage = project.images != null && project.images!.isNotEmpty;

    return Row(
      mainAxisAlignment:
          hasImage ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        /// **Show Image Only If Available**
        if (hasImage)
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  project.images!.first,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

        /// **Content Section (Centered if No Image)**
        Expanded(
          flex: 1,
          child: Padding(
              padding: const EdgeInsets.all(padding * 3),
              child: _buildProjectDetails(context, project)),
        ),
      ],
    );
  }

  /// **Helper Function for Project Details**
  Widget _buildProjectDetails(BuildContext context, Project project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// **Project Title**
        Text(
          project.title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: MediaQuery.of(context).size.width < 800 ? 20 : 24,
              ),
        ),
        const SizedBox(height: kH20 * 2),

        /// **Short Description**
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: project.contents.take(2).map((data) {
            return Padding(
              padding: const EdgeInsets.only(bottom: kH10),
              child: Text(
                data,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize:
                          MediaQuery.of(context).size.width < 800 ? 14 : 16,
                    ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: kH20 * 2),

        /// **Case Study Button**
        ElevatedButton(
          onPressed: () {
            Provider.of<PortfolioProvider>(context, listen: false)
                .selectProject(project);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(
                MediaQuery.of(context).size.width < 800 ? 150 : 180,
                MediaQuery.of(context).size.width < 800 ? 50 : 60),
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width < 800 ? 16 : 20,
              vertical: MediaQuery.of(context).size.width < 800 ? 12 : 15,
            ),
          ),
          child: Text(
            "CASE STUDY",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width < 800 ? 14 : 16,
                ),
          ),
        ),
      ],
    );
  }
}
