import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_router.dart';

class CustomDrawer extends StatelessWidget {
  final Function(String)? scrollToSection;
  const CustomDrawer({super.key, required this.scrollToSection});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6200EA), Color(0xFFD9279B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg/book-dark.svg",
                  width: 50,
                  height: 50,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                Text(
                  "MD SAIF!",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),

          _buildDrawerItem(context, "Home", scrollToSection, "home"),
          _buildDrawerItem(context, "About", scrollToSection, "about"),
          _buildDrawerItem(context, "Experiences", scrollToSection, "experiences"),
          _buildDrawerItem(context, "Projects", scrollToSection, "projects"),
          _buildDrawerItem(context, "Contact", scrollToSection, "contact"),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, Function(String)? scrollToSection, String section) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        if (scrollToSection != null) {
          scrollToSection(section);
        } else {
          AppRouter.ctx.go("/home?scrollTo=$section");
        }
      },
    );
  }
}