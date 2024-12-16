import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krish_portfolio/utils/colors.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Adjust the multiplier based on your design preferences
    return baseSize * (screenWidth / 600).clamp(0.8, 1.5);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final Color textColor = AppColors.textOnPrimary;
    final Color footerColor = isDarkMode ? AppColors.darkSurface : AppColors.textPrimary; // Footer background color
  
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: MediaQuery.of(context).size.width * 0.1,
      ),
      color: footerColor, // Set footer background color
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Copyright Information
          Text(
            '© 2024 Krish Soni. All rights reserved.',
            style: GoogleFonts.lora(
              color: textColor, // Set text color based on theme
              fontSize: _getResponsiveFontSize(context, 16), // Responsive font size
              fontWeight: FontWeight.w500, // Slightly bolder text
            ),
            textAlign: TextAlign.center, // Center the text
          ),
          const SizedBox(height: 5), // Spacer
          Text(
            'Built with Flutter',
            style: GoogleFonts.lora(
              color: textColor, // Set text color based on theme
              fontSize: _getResponsiveFontSize(context, 14), // Responsive font size
              fontWeight: FontWeight.w400, // Regular text weight
            ),
            textAlign: TextAlign.center, // Center the text
          ),
        ],
      ),
    );
  }
}
