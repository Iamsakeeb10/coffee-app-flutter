import 'package:flutter/material.dart';
import 'package:my_app/data/onboarding_data.dart';
import 'package:my_app/widgets/glass_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: _onPageChanged,
            itemCount: onboardingPages.length,
            itemBuilder: (_, index) {
              final page = onboardingPages[index];

              return Container(
                width: screenSize.width,
                height: screenSize.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(page.image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: Container(
                    padding: EdgeInsets.only(top: insets.top + 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          page.title,
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: screenSize.width * 0.7,
                          child: Text(
                            page.description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              height: 1.25,
                              letterSpacing: 1.0,
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  offset: Offset(0.5, 0.5),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          if (_currentPage < onboardingPages.length - 1)
            Positioned(
              top: insets.top,
              right: 20,
              child: GlassButton(label: 'Skip', borderRadius: 7, onTap: _skip),
            ),

          Positioned(
            bottom: insets.bottom,
            right: 20,
            left: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  IconButton(
                    onPressed: _goToPreviousPage,
                    // onPressed: () {},
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  )
                else
                  SizedBox(width: 48),

                SmoothPageIndicator(
                  controller: _controller,
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

                _currentPage == onboardingPages.length - 1
                    ? Positioned(
                        bottom: insets.bottom,
                        right: 20,
                        child: TextButton(
                          onPressed: () {
                            // Handle "Get Started" action here
                          },
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
                        ),
                      )
                    : IconButton(
                        onPressed: _goToNextPage,
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
