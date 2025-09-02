import 'package:flutter/material.dart';

class NavItem extends StatefulWidget {
  final int index;
  final void Function()? onTap;
  final String? label;
  final Widget icon;
  final double widthFactor;

  const NavItem({
    super.key,
    required this.index,
    required this.icon,
    required this.onTap,
    this.label,
    this.widthFactor = 1,
  });

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _iconTap(widget.onTap),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * widget.widthFactor,
        child: _buildNavItemContent(label: widget.label, icon: widget.icon),
      ),
    );
  }

  Widget _buildNavItemContent({required Widget icon, String? label}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [icon, if (label != null) _buildLabel(label)],
    );
  }

  void _iconTap(void Function()? onTap) {
    if (onTap != null) {
      onTap();
    }
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontSize: 10),
    );
  }
}
