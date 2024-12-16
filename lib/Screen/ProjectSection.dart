import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krish_portfolio/Model/ProjectDetails.dart';
import 'package:krish_portfolio/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProjectSection extends StatelessWidget {
  ProjectSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth < 600 ? 20 : screenWidth < 1024 ? 80 : 150,
        vertical: 50,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Projects",
              style: GoogleFonts.lora(
                fontSize: screenWidth < 600 ? 24 : screenWidth < 1024 ? 32 : 36,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            DefaultTabController(
              length: projectDetails.length,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: AppColors.primary,
                    tabs: projectDetails.map((project) => Tab(text: project.title)).toList(),
                  ),
                  const SizedBox(height: 20),
                  // Adjusted height based on screen height
                  SizedBox(
                    height: screenHeight * 0.4,
                    child: TabBarView(
                      children: projectDetails.map((project) {
                        return _buildProjectCard(context, project, screenWidth);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project, double screenWidth) {
    final bool isMobile = screenWidth < 600;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? AppColors.darkSurface : AppColors.lightSurface;

    final screenHeight = MediaQuery.of(context).size.height;

    final cardHeight = isMobile
        ? screenHeight * 0.40
        : screenWidth < 1024
        ? screenHeight * 0.60
        : screenHeight * 0.50; // Adjusted for desktop

    return Container(
      height: cardHeight,
      child: Card(
        color: cardColor,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: isMobile
                ? _buildMobileView(context, project)
                : screenWidth < 1024
                ? _buildTabletView(context, project)
                : _buildDesktopView(context, project),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileView(BuildContext context, Project project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProjectImageCarousel(project, 150),
        const SizedBox(height: 10),
        _buildProjectDetails(context, project, isMobile: true),
      ],
    );
  }

  Widget _buildTabletView(BuildContext context, Project project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProjectImageCarousel(project, 200),
        const SizedBox(height: 10),
        _buildProjectDetails(context, project),
      ],
    );
  }

  Widget _buildDesktopView(BuildContext context, Project project) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildProjectImageCarousel(project, 250),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: _buildProjectDetails(context, project),
        ),
      ],
    );
  }

  Widget _buildProjectImageCarousel(Project project, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CarouselSlider(
        options: CarouselOptions(
          height: height,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
        ),
        items: project.imageUrls.map((imageUrl) {
          return Image.network(
            imageUrl,
            fit: BoxFit.cover, // Changed to cover for better aspect ratio
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.broken_image,
              size: 100,
              color: Colors.grey[300],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProjectDetails(BuildContext context, Project project, {bool isMobile = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                project.title,
                style: GoogleFonts.lora(
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  if (await canLaunch(project.url)) {
                    await launch(project.url);
                  } else {
                    throw 'Could not launch ${project.url}';
                  }
                },
                child: SvgPicture.asset(
                  "assets/icons/github.svg",
                  height: isMobile ? 24 : 25,
                  width: isMobile ? 24 : 25,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          project.description,
          style: GoogleFonts.lora(
            fontSize: isMobile ? 12 : 14,
            color: Colors.grey[700],
            height: 1.5,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.technologies.map((tech) {
            return Chip(
              backgroundColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              avatar: SvgPicture.asset(
                tech.iconPath,
                height: isMobile ? 18 : 24,
                width: isMobile ? 18 : 24,
              ),
              label: Text(
                tech.title,
                style: GoogleFonts.lora(
                  fontSize: isMobile ? 10 : 12,
                  color: Colors.grey[800],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
