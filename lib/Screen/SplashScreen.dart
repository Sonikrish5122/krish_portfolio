import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krish_portfolio/Screen/HomePage.dart';
import 'package:krish_portfolio/utils/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback toggleTheme; // Callback for toggling theme

  const SplashScreen({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Bounce animation for the title
    _bounceAnimation = Tween<double>(begin: 0.8, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceInOut),
    );

    // Rotation animation for loading indicator
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    // Slide animation for subtitle
    _slideAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.repeat(reverse: true); // Start bounce animation

    // Navigate to HomePage after a delay
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(toggleTheme: widget.toggleTheme)),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery for screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final double fontSizeTitle = isSmallScreen ? 24 : 32;
    final double fontSizeSubtitle = isSmallScreen ? 16 : 20;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16.0 : 24.0), // Responsive padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title with bounce animation
              ScaleTransition(
                scale: _bounceAnimation,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [AppColors.primary, AppColors.accent],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds);
                  },
                  child: Text(
                    'Krish Soni',
                    style: GoogleFonts.lora(
                      fontSize: fontSizeTitle,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: isSmallScreen ? 12 : 24), // Responsive spacing

              // Loading animation with rotation effect
              RotationTransition(
                turns: _rotationAnimation,
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.accent,
                  size: isSmallScreen ? 40.0 : 50.0,
                ),
              ),
              SizedBox(height: isSmallScreen ? 12 : 24), // Responsive spacing

              // Subtitle with slide animation
              SlideTransition(
                position: _slideAnimation,
                child: Text(
                  'Flutter Developer Portfolio',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    fontSize: fontSizeSubtitle,
                    color: AppColors.lightText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
