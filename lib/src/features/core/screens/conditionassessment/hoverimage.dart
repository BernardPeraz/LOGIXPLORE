import 'package:flutter/material.dart';

class HoverImage extends StatefulWidget {
  final String image;
  final double width;

  const HoverImage({super.key, required this.image, required this.width});

  @override
  State<HoverImage> createState() => _HoverImageState();
}

class _HoverImageState extends State<HoverImage> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Image(image: AssetImage(widget.image), width: widget.width),
      ),
    );
  }
}
