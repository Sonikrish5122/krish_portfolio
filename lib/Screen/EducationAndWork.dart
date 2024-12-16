import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krish_portfolio/utils/colors.dart';

class EducationAndWorkSection extends StatefulWidget {
  const EducationAndWorkSection({super.key});

  @override
  State<EducationAndWorkSection> createState() =>
      _EducationAndWorkSectionState();
}

class _EducationAndWorkSectionState extends State<EducationAndWorkSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isEducationSelected = true;
  bool isMobile = false;
  bool isTablet = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _isEducationSelected = _tabController.index == 0;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenWidth = MediaQuery.of(context).size.width;
    isMobile = screenWidth < 600;
    isTablet = screenWidth >= 600 && screenWidth < 900;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (isTablet ? 50 : 150),
        vertical: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Education & Experience', isDarkMode),
          const SizedBox(height: 20),
          Column(
            children: [
              TabBar(
                controller: _tabController,
                indicatorColor:
                    isDarkMode ? AppColors.darkAccent : AppColors.lightAccent,
                labelStyle: GoogleFonts.lora(

                    fontSize: isMobile ? 14 : (isTablet ? 16 : 18)),
                dividerColor: AppColors.lightAccent,
                labelColor: AppColors.primary,

                tabs: const [
                  Tab(text: 'Education',),
                  Tab(text: 'Experience'),
                ],
              ),
              const SizedBox(height: 20),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  key: ValueKey(_isEducationSelected),
                  height:
                      isMobile ? 500 : 600, // Adjusted height for better fit
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildEducationCard(isDarkMode),
                      _buildExperienceCard(isDarkMode),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.lora(
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppColors.primary : AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildEducationCard(bool isDarkMode) {
    return _buildCard(
      children: [
        _buildTimelineItem(
          title: 'Bachelor’s Degree in Information Technology',
          institution: 'U.V. Patel College of Engineering',
          years: '2020 - 2024',
          description: 'CGPA: 6.87',
          isDarkMode: isDarkMode,
        ),
        const SizedBox(height: 20),
        _buildTimelineItem(
          title: 'Class 12th HSC Board',
          institution: 'Glorious Public School',
          years: '2019 - 2020',
          description: 'Percentage: 48.62%',
          isDarkMode: isDarkMode,
        ),
        const SizedBox(height: 20),
        _buildTimelineItem(
          title: 'Class 10th SSC Board',
          institution: 'Glorious Public School',
          years: '2017 - 2018',
          description: 'Percentage: 69.69%',
          isDarkMode: isDarkMode,
        ),
      ],
      isDarkMode: isDarkMode,
    );
  }

  Widget _buildExperienceCard(bool isDarkMode) {
    return _buildCard(
      children: [
        _buildTimelineItem(
          title: 'Flutter Developer Intern',
          institution: 'iTechNotion',
          years: 'January 2024 - May 2024',
          description:
              'Developed a teleconsultation app with real-time communication, e-prescriptions, and video conferencing.',
          isDarkMode: isDarkMode,
        ),
      ],
      isDarkMode: isDarkMode,
    );
  }

  Widget _buildCard(
      {required List<Widget> children, required bool isDarkMode}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String institution,
    required String years,
    required String description,
    required bool isDarkMode,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTimelineIcon(isDarkMode),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.lora(
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color:
                      isDarkMode ? AppColors.darkText : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                institution,
                style: GoogleFonts.lora(
                  fontSize: isMobile ? 14 : 16,
                  color: isDarkMode
                      ? AppColors.darkSubText
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                years,
                style: GoogleFonts.lora(
                  fontSize: isMobile ? 12 : 14,
                  color: isDarkMode
                      ? AppColors.darkSubText
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: GoogleFonts.lora(
                  fontSize: isMobile ? 12 : 14,
                  color: isDarkMode
                      ? AppColors.darkSubText
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineIcon(bool isDarkMode) {
    return Column(
      children: [
        Icon(
          Icons.circle,
          color: isDarkMode ? AppColors.darkAccent : AppColors.lightAccent,
          size: 16,
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 3,
          height: 60,
          color: isDarkMode ? AppColors.darkAccent : AppColors.textSecondary,
        ),
      ],
    );
  }
}
