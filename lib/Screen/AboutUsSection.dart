import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krish_portfolio/utils/colors.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:krish_portfolio/utils/link.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsSection extends StatefulWidget {
  const AboutUsSection({super.key});

  @override
  _AboutUsSectionState createState() => _AboutUsSectionState();
}

class _AboutUsSectionState extends State<AboutUsSection>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  double _getFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return baseSize * 0.9; // Mobile size
    } else if (screenWidth < 1200) {
      return baseSize; // Tablet size
    } else {
      return baseSize * 1.2; // Desktop size
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet =
            constraints.maxWidth < 1200 && constraints.maxWidth >= 600;

        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : (isTablet ? 80 : 150), vertical: 50),
          child: isMobile || isTablet
              ? Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              _buildTitle(context, "About Us"),
              const SizedBox(height: 20),
              _buildTextContent(context),
              const SizedBox(height: 30),
              _buildImageContent(isMobile),
            ],
          )
              : Column(
                children: [
                  Text(
                    "About Us",
                    style: GoogleFonts.lora(
                      fontSize: isMobile ? 24 : isTablet ? 32 : 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                  _buildImageContent(isMobile),
                  const SizedBox(width: 50),
                  Expanded(child: _buildTextContent(context)),
                              ],
                            ),
                ],
              ),
        );
      },
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.lora(
        fontSize: _getFontSize(context, 36),
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textPrimary =
    isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary;
    final textColor = isDarkMode ? AppColors.darkText : AppColors.lightText;

    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(seconds: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          _buildDescriptionText(
            "I'm Krish Soni",
            textColor,
            context,
            fontSize: _getFontSize(context, 36),
            fontWeight: FontWeight.w700,
            color: AppColors.accent,
          ),
          const SizedBox(height: 12),
          _buildDescriptionText(
            "Flutter Developer (Fresher)",
            AppColors.primary,
            context,
            fontSize: _getFontSize(context, 24),
            fontWeight: FontWeight.w700,
            italic: true,
          ),
          const SizedBox(height: 20),
          _buildDescriptionText(
            "As a passionate Flutter developer starting my career, I am dedicated "
                "to learning and growing my skills in mobile app development. I have a solid "
                "foundation in Flutter and Dart, and I am excited to create user-friendly "
                "and responsive applications.",
            textColor,
            context,
          ),
          const SizedBox(height: 20),
          _buildDescriptionText(
            "I enjoy exploring new technologies and staying up-to-date with the latest "
                "trends in app development. My goal is to contribute to projects where I can "
                "apply my skills and gain valuable experience as I transition into a professional developer.",
            textColor,
            context,
          ),
          const SizedBox(height: 20),
          _buildDescriptionText(
            "Find Me On",
            textPrimary,
            context,
            fontSize: _getFontSize(context, 24),
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 12),
          _buildSocialMediaButtons(),
        ],
      ),
    );
  }

  Widget _buildDescriptionText(String text, Color textColor, BuildContext context, {
    double? fontSize,
    FontWeight fontWeight = FontWeight.w400,
    bool italic = false,
    Color? color
  }) {
    return Text(
      text,
      style: GoogleFonts.lora(
        fontSize: fontSize ?? _getFontSize(context, 18),
        fontWeight: fontWeight,
        color: color ?? textColor,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        height: 1.5,
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildSocialMediaButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildSocialButton(
          url: Links.githubUrl,
          buttonType: ButtonType.github,
        ),
        const SizedBox(width: 10),
        _buildSocialButton(
          url: Links.linkedinUrl,
          buttonType: ButtonType.linkedin,
        ),
        const SizedBox(width: 10),
        _buildSocialButton(
          url: Links.whatsappUrl,
          buttonType: ButtonType.whatsapp,
        ),
      ],
    );
  }

  Widget _buildSocialButton(
      {required String url, required ButtonType buttonType}) {
    return FlutterSocialButton(
      onTap: () {
        _launchURL(url);
      },
      mini: true,
      buttonType: buttonType,
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildImageContent(bool isMobile) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(seconds: 1),
      child: AnimatedGradientBorder(
        borderSize: 2,
        glowSize: 10,
        gradientColors: [
          Colors.purple.shade50,
          Colors.purple.shade100,
          Colors.purple.shade200,
          Colors.purple.shade400,
        ],
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Container(
          width: isMobile ? 300 : 400,
          height: isMobile ? 300 : 400,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('images/profile_pic.JPG'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
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
    );
  }
}
