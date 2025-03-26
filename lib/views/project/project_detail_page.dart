import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../providers/portfolio_provider.dart';
import '../../utils/common.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';
import '../../widgets/appbar.dart';
import '../../widgets/footer.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<PortfolioProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.6),
      appBar: customAppBar(context, null),
      body: Consumer<PortfolioProvider>(
        builder: (context, provider, child) {
          if (provider.config == null) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show loading if config is null
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                // HOME -------------------------------------------------
                const SelectedProjectMainContent(),

                // Overview ---------------------------------------------
                const ProjectOverviewContent(),

                // TOOLS USED ------------------------------------------
                const ToolsUsedContent(),

                // Live Links ------------------------------------------
                const LiveLinksContent(),

                // FOOTER -------------------------------------------------
                FooterWidget(
                  footer: provider.config!.footer,
                  social: provider.config!.social,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LiveLinksContent extends StatelessWidget {
  const LiveLinksContent({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PortfolioProvider>(context, listen: false);
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 900; // Define mobile breakpoint

    return ResponsiveWidget(
      bgColor: Colors.white60,
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Text(
            "See Live",
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: isMobile ? 20 : 24,
                ),
          ),
          const SizedBox(height: kH20 * 2),

          /// **Buttons**
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProjectButton(
                        context,
                        isMobile,
                        provider.selectedProject!.liveLink,
                        provider.selectedProject!.githubLink,
                        "PROJECT LINK"),
                    const SizedBox(height: kH20),
                    _buildBackButton(context, isMobile, provider),
                  ],
                )
              : Row(
                  mainAxisAlignment: isMobile
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    _buildProjectButton(
                        context,
                        isMobile,
                        provider.selectedProject!.liveLink,
                        provider.selectedProject!.githubLink,
                        "PROJECT LINK"),
                    const SizedBox(width: kH20),
                    _buildBackButton(context, isMobile, provider),
                  ],
                ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        ],
      ),
    );
  }

  /// **Helper Function for Project Button**
  Widget _buildProjectButton(BuildContext context, bool isMobile,
      String? liveLink, String? githubLink, String title) {
    String? url = liveLink?.isNotEmpty == true ? liveLink : githubLink;
    return ElevatedButton(
      onPressed: () {
        if (url != null && url.isNotEmpty) {
          openURL(url);
        } else {
          print("No valid link available");
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
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w400, color: Colors.white),
      ),
    );
  }

  /// **Helper Function for Back Button**
  Widget _buildBackButton(
      BuildContext context, bool isMobile, PortfolioProvider provider) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        provider.removeSelectedProject();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(isMobile ? 160 : 180, isMobile ? 50 : 60),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 20,
          vertical: isMobile ? 12 : 15,
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFFD9279B),
        shadowColor: Colors.transparent,
        side: const BorderSide(color: Color(0xFFD9279B), width: 2),
      ),
      child: Text(
        "GO BACK",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }
}

class ToolsUsedContent extends StatelessWidget {
  const ToolsUsedContent({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PortfolioProvider>(context, listen: false);
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 900;

    return ResponsiveWidget(
      bgColor: Colors.white60,
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Text(
            "Tools Used",
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: isMobile ? 20 : 24,
                ),
          ),
          const SizedBox(height: kH20 * 2),

          /// **Tools List**
          Align(
            alignment: isMobile ? Alignment.center : Alignment.centerLeft,
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              runSpacing: 12,
              children: provider.selectedProject!.technologies.map((item) {
                return Container(
                  padding: const EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    item,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectOverviewContent extends StatelessWidget {
  const ProjectOverviewContent({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PortfolioProvider>(context, listen: false);
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 900;

    return ResponsiveWidget(
      bgColor: Colors.white60,
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          Text(
            "Project Overview",
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: isMobile ? 20 : 24,
                ),
          ),
          const SizedBox(height: kH20 * 2),

          /// **Project Details**
          Column(
            crossAxisAlignment:
                isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: provider.selectedProject!.contents.map((data) {
              return Padding(
                padding: const EdgeInsets.only(bottom: kH10),
                child: Text(
                  data,
                  textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class SelectedProjectMainContent extends StatelessWidget {
  const SelectedProjectMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PortfolioProvider>(context, listen: false);
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 900;

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.88,
      child: Stack(
        children: [
          Container(color: const Color(0xFFF8F8F8)),
          SvgPicture.asset(
            width: double.infinity,
            "assets/svg/bg2.svg",
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.center,
            child: ResponsiveWidget(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.selectedProject!.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: isMobile ? 28 : 42, // Adjust for mobile
                        ),
                  ),
                  const SizedBox(height: kH20 * 2.5),
                  Text(
                    "This page contains the case study of ${provider.selectedProject!.title} Project which includes the Project Overview, Tools Used, and Live Links.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w100,
                          fontSize: isMobile ? 14 : 18, // Adjust font size
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
