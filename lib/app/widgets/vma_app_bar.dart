import 'package:flutter/material.dart';

class VMAAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final Color? titleColor;
  final double elevation;

  const VMAAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.titleColor,
    this.elevation = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: actions,
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: Theme.of(context).colorScheme.primaryFixed,
      elevation: elevation,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(60),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(height: 20),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
