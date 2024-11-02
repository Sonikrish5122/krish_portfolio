import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krish_portfolio/utils/colors.dart'; // Custom colors
import 'package:krish_portfolio/utils/link.dart'; // Custom link
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:particles_fly/particles_fly.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({Key? key}) : super(key: key);

  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          final isTablet = constraints.maxWidth < 900;
          final size = MediaQuery.of(context).size;

          return Container(
            height: size.height,
            child: Stack(
              children: [
                ParticlesFly(
                  height: size.height,
                  width: size.width,
                  connectDots: true,
                  numberOfParticles: isMobile
                      ? 20
                      : isTablet
                          ? 80
                          : 100,
                  isRandomColor: true,
                  lineColor: AppColors.textPrimary,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile
                        ? 20
                        : isTablet
                            ? 50
                            : 150,
                    vertical: 50,
                  ),
                  child: isMobile
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTextContent(context, isMobile),
                            const SizedBox(height: 30),
                            _buildImageContent(isMobile),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: _buildTextContent(context, isTablet)),
                            const SizedBox(width: 50),
                            _buildImageContent(isMobile),
                          ],
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextContent(BuildContext context, bool isSmallScreen) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textPrimary =
        isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary;
    final accentColor =
        isDarkMode ? AppColors.darkAccent : AppColors.lightAccent;
    final textColor = isDarkMode ? AppColors.darkText : AppColors.lightText;

    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(seconds: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'WELCOME TO MY PORTFOLIO',
            style: GoogleFonts.lora(
              fontSize: isSmallScreen ? 24 : 30,
              fontWeight: FontWeight.bold,
              color: accentColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Hello, I'm",
            style: GoogleFonts.lora(
              fontSize: isSmallScreen ? 28 : 36,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Krish Soni',
            style: GoogleFonts.lora(
              fontSize: isSmallScreen ? 22 : 28,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                'I\'m',
                style: GoogleFonts.lora(
                  fontSize: isSmallScreen ? 22 : 26,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Android Application Developer',
                        textStyle: GoogleFonts.lora(
                          fontSize: isSmallScreen ? 20 : 22,
                          color: textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        'Flutter Developer',
                        textStyle: GoogleFonts.lora(
                          fontSize: isSmallScreen ? 20 : 22,
                          color: textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    repeatForever: true,
                    pause: const Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDownloadCvButton(context, isSmallScreen),
        ],
      ),
    );
  }

  Widget _buildImageContent(bool isMobile) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: const Duration(seconds: 2),
            child: AnimatedGradientBorder(
              borderSize: 2,
              glowSize: 10,
              gradientColors: [
                Colors.purple.shade50,
                Colors.purple.shade100,
                Colors.purple.shade200,
                Colors.purple.shade400,
              ],
              borderRadius: const BorderRadius.all(Radius.circular(999)),
              child: CircleAvatar(
                radius: isMobile ? 70 : 120, // Adjusted size for better scaling
                backgroundImage: const AssetImage('images/profile_pic.JPG'),
                backgroundColor: Colors.transparent,
                // Adding a soft shadow effect
                child: ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDownloadCvButton(BuildContext context, bool isSmallScreen) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..scale(_isHovered ? 1.05 : 1.0), // Slightly increase size on hover
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
          ),
          borderRadius: BorderRadius.circular(50),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: PrettySlideIconButton(
          onPressed: () async {
            if (await canLaunch(Links.cvUrl)) {
              await launch(Links.cvUrl);
            } else {
              throw 'Could not launch ${Links.cvUrl}';
            }
          },
          slidePosition: SlidePosition.right  ,
          icon: Icons.download,
          label: 'Download CV',
          foregroundColor: Colors.white,
          labelStyle: GoogleFonts.lora(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(
            vertical: isSmallScreen ? 10 : 15,
            horizontal: isSmallScreen ? 20 : 30,
          ),
        ),
      ),
    );
  }
}
