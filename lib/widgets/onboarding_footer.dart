import 'package:flutter/material.dart';
import 'package:my_app/data/onboarding_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingFooter extends StatelessWidget {
  final int currentPage;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onGetStarted;
  final PageController controller;
  final EdgeInsets insets;

  const OnboardingFooter({
    super.key,
    required this.currentPage,
    required this.onNext,
    required this.onPrevious,
    required this.onGetStarted,
    required this.controller,
    required this.insets,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: insets.bottom,
          left: 20,
          right: 20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentPage > 0
                      ? IconButton(
                          onPressed: onPrevious,
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        )
                      : const SizedBox(width: 48),
                  currentPage == onboardingPages.length - 1
                      ? TextButton(
                          onPressed: onGetStarted,
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : IconButton(
                          onPressed: onNext,
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),

        Positioned(
          bottom: insets.bottom + 18,
          left: 0,
          right: 0,
          child: Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: onboardingPages.length,
              effect: CustomizableEffect(
                activeDotDecoration: DotDecoration(
                  width: 26, // 👈 Wider active dot
                  height: 8,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                dotDecoration: DotDecoration(
                  width: 10, // 👈 Smaller inactive dots
                  height: 10,
                  color: const Color.fromARGB(142, 255, 255, 255),
                  borderRadius: BorderRadius.circular(100),
                ),
                spacing: 8.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
