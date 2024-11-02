import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krish_portfolio/Screen/AboutUsSection.dart';
import 'package:krish_portfolio/Screen/ContactUsScreen.dart';
import 'package:krish_portfolio/Screen/EducationAndWork.dart';
import 'package:krish_portfolio/Screen/FooterSection.dart';
import 'package:krish_portfolio/Screen/HomeScreen.dart';
import 'package:krish_portfolio/Screen/ProjectSection.dart';
import 'package:krish_portfolio/Screen/ServicesSection.dart';
import 'package:krish_portfolio/Screen/SkillSection.dart';
import 'package:krish_portfolio/utils/colors.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;

  HomePage({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutUsKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _contactUsKey = GlobalKey();
  final GlobalKey _projectKey = GlobalKey();

  bool isHoveringHome = false;
  bool isHoveringAboutUs = false;
  bool isHoveringServices = false;
  bool isHoveringContactUs = false;
  bool isHoveringProjects = false;

  late AnimationController _fabController;
  late Animation<double> _fabScaleAnimation;



  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabScaleAnimation =
        Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
          parent: _fabController,
          curve: Curves.easeInBack,
        ));
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    bool isMobile = MediaQuery.of(context).size.width < 600;
    bool isTablet = MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1200;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      appBar: isMobile || isTablet
          ? AppBar(
        elevation: 4,
        backgroundColor: AppColors.surfaceDark,
        title: Text(
          "Krish",
          style: GoogleFonts.updock(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: AppColors.textOnPrimary,
              letterSpacing: 5
          ),
        ),

      )
          : PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: _buildDesktopNavBar(screenWidth),
      ),
      drawer: isMobile || isTablet ? _buildDrawer() : null,
      body: screenWidth < 600
          ? _buildMobileBody()
          : _buildDesktopBody(screenWidth),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildDesktopNavBar(double screenWidth) {
    return Container(
      color: AppColors.surfaceDark,
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Krish",
            style: GoogleFonts.updock(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: AppColors.textOnPrimary,
              letterSpacing: 5
            ),
          ),
          Row(
            children: [
              _buildNavBarItem("Home", _homeKey, isHoveringHome, () {
                setState(() {
                  isHoveringHome = !isHoveringHome;
                });
              }),
              _buildNavBarItem("About Us", _aboutUsKey, isHoveringAboutUs, () {
                setState(() {
                  isHoveringAboutUs = !isHoveringAboutUs;
                });
              }),
              _buildNavBarItem("Services", _servicesKey, isHoveringServices,
                      () {
                    setState(() {
                      isHoveringServices = !isHoveringServices;
                    });
                  }),
              _buildNavBarItem("Projects", _projectKey, isHoveringProjects, () {
                setState(() {
                  isHoveringProjects = !isHoveringProjects;
                });

              }),
              _buildNavBarItem("Contact Us", _contactUsKey, isHoveringContactUs, () {
                setState(() {
                  isHoveringContactUs = !isHoveringContactUs;
                });

              }),
              IconButton(
                onPressed: widget.toggleTheme,
                icon: Icon(
                  Theme.of(context).brightness == Brightness.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  color: AppColors.textOnPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(
      String text, GlobalKey key, bool isHovering, Function() onHover) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => onHover(),
      onExit: (event) => onHover(),
      child: GestureDetector(
        onTap: () {
          Scrollable.ensureVisible(
            key.currentContext!,
            duration: const Duration(milliseconds: 500),
          );
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Text(
                text,
                style: GoogleFonts.lora(
                  fontSize: 18,
                  color: isHovering ? AppColors.hoverEffect : AppColors.textOnPrimary,
                  fontWeight: isHovering ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isHovering)
              Container(
                height: 2,
                width: 20,
                color: AppColors.hoverEffect,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: AppColors.surfaceDark,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primary,
                image: DecorationImage(
                  image: AssetImage('assets/images/profile_pic.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Krish Soni',
                  style: GoogleFonts.lora(fontSize: 24, color: AppColors.textOnPrimary),
                ),
              ),
            ),
            _buildDrawerItem("Home", _homeKey, Icons.home),
            _buildDrawerItem("About Us", _aboutUsKey, Icons.info),
            _buildDrawerItem("Services", _servicesKey, Icons.design_services),
            _buildDrawerItem("Projects", _projectKey, Icons.work),
            _buildDrawerItem("Contact Us", _contactUsKey, Icons.contact_mail),
            Divider(color: AppColors.textOnPrimary),
            ListTile(
              title: Text(
                "Toggle Theme",
                style: GoogleFonts.lora(color: AppColors.textOnPrimary),
              ),
              trailing: Switch(
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (value) {
                  widget.toggleTheme();
                },
                activeColor: AppColors.accent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String text, GlobalKey key, IconData icon) {
    bool isHovered = false;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: ListTile(
        leading: Icon(
          icon,
          color: isHovered ? AppColors.hoverEffect : AppColors.textOnPrimary,
        ),
        title: Text(
          text,
          style: GoogleFonts.lora(
            color: isHovered ? AppColors.hoverEffect : AppColors.textOnPrimary,
          ),
        ),
        onTap: () {
          Scrollable.ensureVisible(
            key.currentContext!,
            duration: const Duration(milliseconds: 500),
          );
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildMobileBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeSection(key: _homeKey),
          AboutUsSection(key: _aboutUsKey),
          SkillSection(),
          EducationAndWorkSection(),
          ServicesSection(key: _servicesKey),
          ProjectSection(key: _projectKey),
          ContactUsScreen(key: _contactUsKey),
          FooterSection(),
        ],
      ),
    );
  }

  Widget _buildDesktopBody(double screenWidth) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeSection(key: _homeKey),
          AboutUsSection(key: _aboutUsKey),
          SkillSection(),
          EducationAndWorkSection(),
          ServicesSection(key: _servicesKey),
          ProjectSection(key: _projectKey),
          ContactUsScreen(key: _contactUsKey),
          FooterSection(),
        ],
      ),
    );
  }


  Widget _buildFloatingActionButton() {
    return MouseRegion(
      onEnter: (_) => _fabController.forward(),
      onExit: (_) => _fabController.reverse(),

      child: ScaleTransition(
        scale: _fabScaleAnimation,
        child: FloatingActionButton(
          onPressed: () {
            Scrollable.ensureVisible(
              _homeKey.currentContext!,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },

          child: const Icon(Icons.arrow_upward, color: AppColors.textOnPrimary),
          backgroundColor: AppColors.accent,
        ),
      ),
    );
  }
}
