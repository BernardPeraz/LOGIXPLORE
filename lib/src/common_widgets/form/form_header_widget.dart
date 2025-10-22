import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    super.key,
    this.imageColor,
    this.heightBetween,

    required this.image,
    required this.title,
    required this.subTitle,

    this.imageHeight = 0.2,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.textAlign,
  });

  final Color? imageColor;
  final double? heightBetween;

  final String image, title, subTitle;

  final double imageHeight;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: AssetImage(image), height: size.height * imageHeight),
        SizedBox(height: heightBetween),
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        Text(
          subTitle,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
