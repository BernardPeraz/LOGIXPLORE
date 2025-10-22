import 'package:flutter/material.dart';

class buildBlock extends StatelessWidget {
  buildBlock({
    super.key,
    required this.width,
    this.color,
    required this.image,
    required this.text,
  });

  final double width;
  Color? color;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width - (width * 0.08),
      color: color,
      padding: EdgeInsets.all(9),

      child: Column(
        children: [
          Image(image: AssetImage(image), width: width),
          Container(height: width * 0.04),

          Row(
            children: [
              Container(
                height: width * 0.1,
                width: 100,
                color: Colors.white,
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
