import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/data/onboarding_data.dart';
import 'package:my_app/widgets/glass_button.dart';
import 'package:my_app/widgets/onboarding_footer.dart';
import 'package:my_app/widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _goToNextPage() {
    if (_currentPage < onboardingPages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skip() {
    _controller.jumpToPage(onboardingPages.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final insets = MediaQuery.of(context).padding;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              onPageChanged: _onPageChanged,
              itemCount: onboardingPages.length,
              itemBuilder: (_, index) {
                final page = onboardingPages[index];

                return OnboardingPage(
                  page: page,
                  insets: insets,
                  screenSize: screenSize,
                );
              },
            ),

            if (_currentPage < onboardingPages.length - 1)
              Positioned(
                top: insets.top,
                right: 20,
                child: GlassButton(
                  label: 'Skip',
                  borderRadius: 7,
                  onTap: _skip,
                ),
              ),

            OnboardingFooter(
              currentPage: _currentPage,
              onNext: _goToNextPage,
              onPrevious: _goToPreviousPage,
              onGetStarted: _skip,
              controller: _controller,
              insets: insets,
            ),
          ],
        ),
      ),
    );
  }
}
