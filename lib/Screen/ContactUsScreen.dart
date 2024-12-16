import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:krish_portfolio/utils/colors.dart';
import 'package:krish_portfolio/utils/link.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  IconData? _hoveredIcon; // Keep track of hovered icon

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  double _getResponsiveFontSize(double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    return baseSize * (screenWidth / 600).clamp(0.8, 1.5);
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    bool isTablet = MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1200;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final cardColor = isDarkMode ? AppColors.darkSurface : AppColors.lightSurface;
    final iconColor = isDarkMode ? AppColors.lightAccent : AppColors.darkAccent;
    final titleTextColor = isDarkMode ? AppColors.lightPrimary : AppColors.darkPrimary;
    final descriptionTextColor = isDarkMode ? AppColors.darkSubText : AppColors.lightText;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (isTablet ? 80 : 150),
        vertical: 50,
      ),
      child: SingleChildScrollView(
        child: isMobile
            ? _buildMobileLayout(cardColor, titleTextColor, descriptionTextColor, iconColor)
            : _buildDesktopLayout(cardColor, titleTextColor, descriptionTextColor, iconColor),
      ),
    );
  }

  Widget _buildMobileLayout(Color cardColor, Color titleTextColor, Color descriptionTextColor, Color iconColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        Text(
          'Get in Touch!',
          style: GoogleFonts.lora(
            fontSize: _getResponsiveFontSize(24),
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        Text(
          'If you want to avail my service, you can contact me at the links below.',
          style: GoogleFonts.lora(
            fontSize: _getResponsiveFontSize(16),
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        Card(
          elevation: 4,
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let's try my service now!",
                      style: GoogleFonts.lora(
                        fontSize: _getResponsiveFontSize(20),
                        fontWeight: FontWeight.bold,
                        color: titleTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Let's work together and make everything super cute and super useful.",
                      style: GoogleFonts.lora(
                        fontSize: _getResponsiveFontSize(16),
                        color: descriptionTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    _launchURL('mailto:your-email@example.com');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.textOnPrimary,
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Contact Me',
                    style: GoogleFonts.lora(fontSize: _getResponsiveFontSize(16)),
                  ),
                ),
                const SizedBox(height: 30),
                Divider(color: iconColor),
                const SizedBox(height: 20),
                // Social Media Icons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIcon(
                      FontAwesomeIcons.linkedin,
                      Links.linkedinUrl,
                      AppColors.primary,
                    ),
                    const SizedBox(width: 20),
                    _buildSocialIcon(
                      FontAwesomeIcons.github,
                      Links.githubUrl,
                      AppColors.primary,
                    ),
                    const SizedBox(width: 20),
                    _buildSocialIcon(
                      FontAwesomeIcons.whatsapp,
                      Links.whatsappUrl,
                      AppColors.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(Color cardColor, Color titleTextColor, Color descriptionTextColor, Color iconColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        Text(
          'Get in Touch!',
          style: GoogleFonts.lora(
            fontSize: _getResponsiveFontSize(24),
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        Text(
          'If you want to avail my service, you can contact me at the links below.',
          style: GoogleFonts.lora(
            fontSize: _getResponsiveFontSize(16),
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 30),
        Card(
          elevation: 4,
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 50),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Let's try my service now!",
                            style: GoogleFonts.lora(
                              fontSize: _getResponsiveFontSize(20),
                              fontWeight: FontWeight.bold,
                              color: titleTextColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Let's work together and make everything super cute and super useful.",
                            style: GoogleFonts.lora(
                              fontSize: _getResponsiveFontSize(16),
                              color: descriptionTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          _launchURL(Links.emailUrl);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.textOnPrimary,
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Contact Me',
                          style: GoogleFonts.lora(fontSize: _getResponsiveFontSize(16)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Divider(color: iconColor),
                const SizedBox(height: 20),
                // Social Media Icons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIcon(
                      FontAwesomeIcons.linkedin,
                      Links.linkedinUrl,
                      AppColors.primary,
                    ),
                    const SizedBox(width: 20),
                    _buildSocialIcon(
                      FontAwesomeIcons.github,
                      Links.githubUrl,
                      AppColors.primary,
                    ),
                    const SizedBox(width: 20),
                    _buildSocialIcon(
                      FontAwesomeIcons.whatsapp,
                      Links.whatsappUrl,
                      AppColors.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String url, Color color) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIcon = icon),
      onExit: (_) => setState(() => _hoveredIcon = null),
      child: GestureDetector(
        onTap: () => _launchURL(url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hoveredIcon == icon ? AppColors.primary : Colors.transparent,
            border: Border.all(color: color),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: _hoveredIcon == icon ? Colors.white : color,
            size: 30,
          ),
        ),
      ),
    );
  }
}
