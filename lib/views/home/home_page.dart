import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/providers/portfolio_provider.dart';
import 'package:portfolio/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/animation.dart';

import '../../widgets/appbar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/footer.dart';
import 'widgets/about_content.dart';
import 'widgets/contact_content.dart';
import 'widgets/experiences_content.dart';
import 'widgets/home_content.dart';
import 'widgets/projects_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final msgC = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  /// Define GlobalKeys for each section
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey experiencesKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  /// 🔹 Function to scroll based on section name
  void scrollToSection(String section) {
    GlobalKey? targetKey;

    switch (section) {
      case "home":
        targetKey = homeKey;
        break;
      case "about":
        targetKey = aboutKey;
        break;
      case "experiences":
        targetKey = experiencesKey;
        break;
      case "projects":
        targetKey = projectsKey;
        break;
      case "contact":
        targetKey = contactKey;
        break;
      default:
        return;
    }

    Scrollable.ensureVisible(
      targetKey.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1), // Slightly below
      end: const Offset(0, 0), // Normal position
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PortfolioProvider>(context, listen: false).getTConfig();
      _controller.forward(); // Start animation when page loads
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context, scrollToSection),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.arrow_upward, color: Colors.white),
      ),
      appBar: customAppBar(context, scrollToSection),
      body: Consumer<PortfolioProvider>(
        builder: (context, provider, child) {
          if (provider.config == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                /// **Home Section with Animation**
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: HomeContentWidget(
                    key: homeKey,
                    home: provider.config!.home,
                    social: provider.config!.social,
                    scrollToSection: scrollToSection,
                  ),
                ),

                /// **About Section**
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: AboutContentWidget(
                    key: aboutKey,
                    about: provider.config!.about,
                    skills: provider.config!.skills,
                    scrollToSection: scrollToSection,
                  ),
                ),

                /// **Experiences Section**
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: ExperiencesContent(
                    key: experiencesKey,
                    experiences: provider.config!.experiences,
                  ),
                ),

                /// **Projects Section**
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: ProjectsContentWidget(
                    key: projectsKey,
                    projects: provider.config!.projects,
                  ),
                ),

                /// **Contact Section**
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: ContactContentWidget(
                    key: contactKey,
                    nameC: nameC,
                    emailC: emailC,
                    msgC: msgC,
                  ),
                ),

                /// **Footer Section (No Animation Needed)**
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
