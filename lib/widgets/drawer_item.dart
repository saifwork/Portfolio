import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/utils/app_router.dart';
import 'package:portfolio/utils/constants.dart';

/// **Helper for Drawer Items**
class DrawerItem extends StatefulWidget {
  final String title;
  final String section;
  final IconData icon;
  final Function(String)? scrollToSection;

  const DrawerItem({
    super.key,
    required this.title,
    required this.section,
    required this.icon,
    this.scrollToSection,
  });

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Close drawer
          if (widget.scrollToSection != null) {
            widget.scrollToSection!(widget.section);
          } else {
            AppRouter.ctx.go("/home?scrollTo=${widget.section}");
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: kW10),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.white24 : Colors.transparent, // Background change
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: _isHovered ? Colors.white : Colors.white70,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: _isHovered ? Colors.white : Colors.white70,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}