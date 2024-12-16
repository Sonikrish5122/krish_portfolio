import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krish_portfolio/utils/colors.dart';

class SkillSection extends StatefulWidget {
  const SkillSection({super.key});

  @override
  _SkillSectionState createState() => _SkillSectionState();
}

class _SkillSectionState extends State<SkillSection> {
  List<bool> _hovering = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary;
    final cardBackground = isDarkMode ? Colors.grey[850] : Colors.white;
    final cardShadowColor = isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.4);

    final skills = [
      {'icon': 'icons/flutter.svg', 'title': 'Flutter'},
      {'icon': 'icons/dart.svg', 'title': 'Dart'},
      {'icon': 'icons/firebase.svg', 'title': 'Firebase'},
      {'icon': 'icons/html.svg', 'title': 'HTML'},
      {'icon': 'icons/css.svg', 'title': 'CSS'},
      {'icon': 'icons/bootstrap.svg', 'title': 'Bootstrap'},
      {'icon': 'icons/kotlin.svg', 'title': 'Kotlin'},
      {'icon': 'icons/mysql.svg', 'title': 'MySQL'},
      {'icon': 'icons/php.svg', 'title': 'PHP'},
      {'icon': 'icons/github.svg', 'title': 'GitHub'},
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 900;

    double titleFontSize = _getResponsiveFontSize(isMobile, isTablet, 24, 28, 32);
    double skillTitleFontSize = _getResponsiveFontSize(isMobile, isTablet, 14, 15, 16);
    double iconSize = _getResponsiveFontSize(isMobile, isTablet, 50, 60, 70);
    double horizontalPadding = isMobile ? 20 : isTablet ? 50 : 150;
    final cardColor = isDarkMode ? AppColors.darkSurface : AppColors.lightSurface;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Skills",
            style: GoogleFonts.lora(fontSize: titleFontSize, fontWeight: FontWeight.bold, color: textPrimary),
          ),
          const SizedBox(height: 40),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              viewportFraction: isMobile ? 0.54 : isTablet ? 0.36 : 0.18,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
            ),
            items: skills.asMap().entries.map((entry) {
              return SkillCard(
                icon: entry.value['icon'] as String,
                title: entry.value['title'] as String,
                isHovering: _hovering[entry.key],
                onHover: (hovering) {
                  setState(() {
                    _hovering[entry.key] = hovering;
                  });
                },
                cardBackground: cardColor,
                cardShadowColor: cardShadowColor,
                iconSize: iconSize,
                textPrimary: textPrimary,
                skillTitleFontSize: skillTitleFontSize,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  double _getResponsiveFontSize(bool isMobile, bool isTablet, double mobileSize, double tabletSize, double desktopSize) {
    if (isMobile) {
      return mobileSize;
    } else if (isTablet) {
      return tabletSize;
    } else {
      return desktopSize;
    }
  }
}

class SkillCard extends StatelessWidget {
  final String icon;
  final String title;
  final bool isHovering;
  final Function(bool) onHover;
  final Color cardBackground;
  final Color cardShadowColor;
  final double iconSize;
  final Color textPrimary;
  final double skillTitleFontSize;

  const SkillCard({
    required this.icon,
    required this.title,
    required this.isHovering,
    required this.onHover,
    required this.cardBackground,
    required this.cardShadowColor,
    required this.iconSize,
    required this.textPrimary,
    required this.skillTitleFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: SizedBox(
        width: 160,
        child: Card(
          color: cardBackground,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: isHovering ? 10 : 6,
          shadowColor: cardShadowColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    color: AppColors.lightPrimary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    icon,
                    fit: BoxFit.contain,
                    width: iconSize - 24,
                    height: iconSize - 24,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: GoogleFonts.lora(
                    fontSize: skillTitleFontSize,
                    fontWeight: FontWeight.w600,
                    color: textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
