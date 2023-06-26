import 'package:flutter/material.dart';
import 'package:onboard_animation/Utils/app_colors.dart';

class LandingContent extends StatelessWidget {
  const LandingContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            "Find Your verified Home",
            style: TextStyle(
              color: AppColors.appgreen,
              fontWeight: FontWeight.bold,
              fontSize: 42,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Apka apna ASSAN Ghar.",
            style: TextStyle(fontSize: 24, color: AppColors.litegreen),
          )
        ],
      ),
    );
  }
}
