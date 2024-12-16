import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:krish_portfolio/Screen/ContactUsScreen.dart';
import 'package:krish_portfolio/utils/colors.dart';
import 'package:sidebarx/sidebarx.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // SidebarXController to manage state for selected index
  final SidebarXController _controller = SidebarXController(selectedIndex: 0);

  // ScrollController to manage scrolling
  final ScrollController _scrollController = ScrollController();

  // GlobalKeys to identify each section for scrolling
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _aboutMeKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  // List of titles and content for each page
  final List<String> _titles = [
    'Home',
    'Projects',
    'About Me',
    'Skills',
    'Contact',
  ];

  // List of global keys for each section
  final List<GlobalKey> _sectionKeys = [];

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    // Initialize the pages and associate them with their corresponding GlobalKey
    _pages.addAll([
      _buildPage(_homeKey, 'Welcome to the Home page!'),
      _buildPage(_projectsKey, 'Here are some of my projects.'),
      _buildPage(_aboutMeKey, 'About me section.'),
      _buildPage(_skillsKey, 'My Skills.'),
      const ContactUsScreen(), // Use ContactUsScreen for the contact section
    ]);

    // Add keys to the list for easier access
    _sectionKeys.addAll([
      _homeKey,
      _projectsKey,
      _aboutMeKey,
      _skillsKey,
      _contactKey,
    ]);
  }

  // Function to build each section with a GlobalKey
  Widget _buildPage(GlobalKey key, String text) {
    return Center(
      key: key,
      child: Text(text, style: GoogleFonts.lora(fontSize: 20)),
    );
  }

  // Function to scroll to the selected section when an item is clicked
  void _scrollToSection(int index) {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // SidebarX widget with customization
          SidebarX(
            controller: _controller,
            theme: SidebarXTheme(
              decoration: BoxDecoration(
                color: AppColors.darkBackground,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              textStyle: GoogleFonts.lora(color: Colors.white, fontSize: 16),
              selectedTextStyle: GoogleFonts.lora(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              itemTextPadding: const EdgeInsets.only(left: 20),
              selectedItemTextPadding: const EdgeInsets.only(left: 20),
              itemDecoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
              ),
              selectedItemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withOpacity(0.37)),
                color: Colors.white.withOpacity(0.15),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
                size: 22,
              ),
              selectedIconTheme: const IconThemeData(
                color: Colors.white,
                size: 22,
              ),
            ),
            extendedTheme: SidebarXTheme(
              width: 200,
            ),
            items: const [
              SidebarXItem(icon: Icons.home, label: 'Home'),
              SidebarXItem(icon: Icons.work, label: 'Projects'),
              SidebarXItem(icon: Icons.person, label: 'About Me'),
              SidebarXItem(icon: Icons.code, label: 'Skills'),
              SidebarXItem(icon: Icons.contact_mail, label: 'Contact'),
            ],
          ),


          Expanded(
            child: AnimatedBuilder(
              animation: _controller, // Listen to the controller
              builder: (context, _) {
                // Scroll to the selected section when index changes
                _scrollToSection(_controller.selectedIndex);

                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      _titles[_controller.selectedIndex],
                      style: GoogleFonts.lora(color: Colors.white, fontSize: 20),
                    ),
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                  ),
                  body: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.lightBackground, Colors.blueGrey.shade50],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: SingleChildScrollView(
                      controller: _scrollController, // Attach scroll controller
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: List.generate(_pages.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: _pages[index],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

