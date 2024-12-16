import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:krish_portfolio/utils/colors.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({Key? key}) : super(key: key);

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth <= 1024;

    // Define colors based on light or dark mode
    final backgroundColor =
        isDarkMode ? AppColors.darkBackground : AppColors.lightBackground;
    final cardColor =
        isDarkMode ? AppColors.darkSurface : AppColors.lightSurface;
    final iconColor = isDarkMode ? AppColors.lightAccent : AppColors.darkAccent;
    final titleTextColor =
        isDarkMode ? AppColors.lightPrimary : AppColors.darkPrimary;
    final descriptionTextColor =
        isDarkMode ? AppColors.darkSubText : AppColors.lightText;

    // Define horizontal padding and card size based on screen size
    final horizontalPadding = isMobile
        ? 20.0
        : isTablet
            ? 80.0
            : 150.0;
    final cardWidth = isMobile
        ? screenWidth - 40
        : (screenWidth - horizontalPadding * 2) / (isTablet ? 2 : 3);
    final cardHeight = screenHeight * 0.45;

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 50),
      child: Container(
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Section title
            Text(
              'Our Services',
              style: GoogleFonts.lora(
                fontSize: isMobile
                    ? 24
                    : isTablet
                        ? 32
                        : 36,
                fontWeight: FontWeight.bold,
                color: titleTextColor,
              ),
            ),
            const SizedBox(height: 40),

            // Responsive service cards grid
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = isMobile
                    ? 1
                    : isTablet
                        ? 2
                        : 3;

                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: cardWidth / cardHeight,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: _buildServiceCards(
                    cardColor,
                    iconColor,
                    titleTextColor,
                    descriptionTextColor,
                    cardWidth,
                    cardHeight,
                    isMobile, // Pass isMobile
                    isTablet, // Pass isTablet
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Function to build the service cards
  List<Widget> _buildServiceCards(
    Color cardColor,
    Color iconColor,
    Color titleTextColor,
    Color descriptionTextColor,
    double cardWidth,
    double cardHeight,
    bool isMobile, // Accept isMobile as parameter
    bool isTablet, // Accept isTablet as parameter
  ) {
    return [
      _buildServiceCard(
        FontAwesomeIcons.code,
        'Web Development',
        'We craft modern, responsive websites with the latest technologies.',
        cardColor,
        iconColor,
        titleTextColor,
        descriptionTextColor,
        cardWidth,
        cardHeight,
        isMobile, // Pass isMobile
        isTablet, // Pass isTablet
      ),
      _buildServiceCard(
        FontAwesomeIcons.mobileAlt,
        'Mobile Development',
        'Native and cross-platform mobile app development for iOS and Android.',
        cardColor,
        iconColor,
        titleTextColor,
        descriptionTextColor,
        cardWidth,
        cardHeight,
        isMobile, // Pass isMobile
        isTablet, // Pass isTablet
      ),
      _buildServiceCard(
        FontAwesomeIcons.pencilRuler,
        'UI/UX Design',
        'Creating beautiful, intuitive user experiences and interfaces.',
        cardColor,
        iconColor,
        titleTextColor,
        descriptionTextColor,
        cardWidth,
        cardHeight,
        isMobile, // Pass isMobile
        isTablet, // Pass isTablet
      ),
    ];
  }

  // Function to build individual service cards
  Widget _buildServiceCard(
    IconData icon,
    String title,
    String description,
    Color cardColor,
    Color iconColor,
    Color titleTextColor,
    Color descriptionTextColor,
    double cardWidth,
    double cardHeight,
    bool isMobile, // Accept isMobile as parameter
    bool isTablet, // Accept isTablet as parameter
  ) {
    return Container(
      width: cardWidth,
      height: cardHeight,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                child: Icon(icon, size: 40, color: iconColor),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                title,
                style: GoogleFonts.lora(
                  fontSize: isMobile
                      ? 16
                      : isTablet
                          ? 18
                          : 20,
                  fontWeight: FontWeight.bold,
                  color: titleTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Description
              Text(
                description,
                style: GoogleFonts.lora(
                  fontSize: isMobile
                      ? 12
                      : isTablet
                          ? 14
                          : 16,
                  color: descriptionTextColor,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
