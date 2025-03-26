import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/providers/portfolio_provider.dart';
import 'package:portfolio/utils/app_router.dart';
import 'package:portfolio/utils/common.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import 'drawer_item.dart';

PreferredSizeWidget customAppBar(
    BuildContext context, Function(String)? scrollToSection) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(80),
    child: LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 900;

        return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 4,
          flexibleSpace: SizedBox.expand(
            child: Container(
              height: 80,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? kH20 : kH20 * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// **Logo & Title**
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/book-dark.svg",
                          width: isMobile ? 30 : 40,
                          height: isMobile ? 30 : 40,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "MD SAIF",
                          style: isMobile
                              ? Theme.of(context).textTheme.titleMedium
                              : Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),

                    /// **Navigation for Larger Screens**
                    if (!isMobile)
                      Row(
                        children: [
                          _buildNavButton(
                              context, "Home", scrollToSection, "home"),
                          _buildNavButton(
                              context, "About", scrollToSection, "about"),
                          _buildNavButton(context, "Experiences",
                              scrollToSection, "experiences"),
                          _buildNavButton(
                              context, "Projects", scrollToSection, "projects"),
                          _buildNavButton(
                              context, "Contact", scrollToSection, "contact"),
                          resumeBtn(context),
                          const SizedBox(width: 10),
                        ],
                      )
                    else

                      /// **Hamburger Menu for Mobile**
                      Builder(
                        builder: (context) {
                          return IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

/// **Hamburger Drawer**
Drawer buildDrawer(BuildContext context, Function(String)? scrollToSection) {
  return Drawer(
    backgroundColor: Colors.black,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 20, horizontal: 16), // Adjust spacing
              child: Text(
                "MD SAIF",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
            DrawerItem(
                title: "Home",
                section: "home",
                icon: Icons.home,
                scrollToSection: scrollToSection),
            DrawerItem(
                title: "About",
                section: "about",
                icon: Icons.person,
                scrollToSection: scrollToSection),
            DrawerItem(
                title: "Experiences",
                section: "experiences",
                icon: Icons.work,
                scrollToSection: scrollToSection),
            DrawerItem(
                title: "Projects",
                section: "projects",
                icon: Icons.folder,
                scrollToSection: scrollToSection),
            DrawerItem(
                title: "Contact",
                section: "contact",
                icon: Icons.mail,
                scrollToSection: scrollToSection),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: resumeBtn(context),
        ),
      ],
    ),
  );
}

/// **Resume Button**
Widget resumeBtn(BuildContext context) {
  bool isMobile = MediaQuery.of(context).size.width < 900;

  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF6200EA), Color(0xFFD9279B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: ElevatedButton(
      onPressed: () {
        openURL(
          Provider.of<PortfolioProvider>(context, listen: false)
              .config!
              .resume
              .content,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 20,
          vertical: isMobile ? 10 : 15,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        "RESUME",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: isMobile ? 12 : 16,
            ),
      ),
    ),
  );
}

/// **Navigation Button Helper**
Widget _buildNavButton(BuildContext context, String title,
    Function(String)? scrollToSection, String section) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: kW5),
    child: TextButton(
      onPressed: () {
        if (scrollToSection != null) {
          scrollToSection(section);
        } else {
          AppRouter.ctx.go("/home?scrollTo=$section");
        }
      },
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w400),
      ),
    ),
  );
}
