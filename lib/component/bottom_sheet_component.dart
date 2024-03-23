import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../styles/color_styles.dart';
import '../styles/font_styles.dart';

class BottomSheetComponent extends StatelessWidget {
  final Widget content;
  final String title;

  const BottomSheetComponent({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: Colors.white,
      width: double.infinity,
      child: Wrap(
        children: [
          Column(
            children: [
              FractionallySizedBox(
                widthFactor: 0.25,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                  child: Container(
                    height: 5.0,
                    decoration: const BoxDecoration(
                      color: kLineStroke,
                      borderRadius: BorderRadius.all(Radius.circular(2.5)),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      color: kMutedGray,
                      size: 24.0,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    title,
                    style: kBodyBold16,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              content,
              const SizedBox(height: 16.0),
            ],
          ),
        ],
      ),
    );
  }
}
