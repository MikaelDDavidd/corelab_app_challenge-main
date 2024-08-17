import 'package:corelab_app_challenge/app/data/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class OfferContainer extends StatelessWidget {
  final double height;
  final double width;
  final String text;

  const OfferContainer({
    super.key,
    required this.height,
    required this.width,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.secondaryTextColor,
          fontWeight: FontWeight.w700
        ),
      ),
    );
  }
}
