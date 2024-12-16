class Technology {
  final String title;
  final String iconPath;

  Technology({
    required this.title,
    required this.iconPath,
  });
}

class Project {
  final String title;
  final String description;
  final List<String> imageUrls; // List of project images
  final List<Technology> technologies; // List of technology objects
  final String url;

  Project({
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.technologies,
    required this.url,
  });
}

List<Project> projectDetails = [

  Project(
    title: "Portfolio Website",
    description: "A personal portfolio website built with Flutter Web to showcase projects, skills, and experiences. It features a responsive design, modern animations, and smooth navigation to enhance user engagement. The portfolio website is structured to display project details, an about section, contact information, and links to social profiles.",
    imageUrls: [
      "assets/Portfolio/image1.png",
      "assets/Portfolio/image2.png",
      "assets/Portfolio/image3.png",
      "assets/Portfolio/image4.png",
      "assets/Portfolio/image5.png",
      "assets/Portfolio/image6.png",
      "assets/Portfolio/image7.png",

    ],
    technologies: [
      Technology(title: "Flutter", iconPath: "icons/flutter.svg"),
      Technology(title: "Dart", iconPath: "icons/dart.svg"),

    ],
    url: "https://github.com/Sonikrish5122/portfolio_website",
  ),

  Project(
    title: "News App",
    description: "Developed a news application that allows users to view the latest articles fetched from a comprehensive news API. Users can filter articles by category and save their favorite news for easy access.",
    imageUrls: [
      "assets/NewsApp/image1.png",
      "assets/NewsApp/image2.png",
      "assets/NewsApp/image3.png",
      "assets/NewsApp/image4.png",
      "assets/NewsApp/image5.png",
    ],
    technologies: [
      Technology(title: "Flutter", iconPath: "icons/flutter.svg"),
      Technology(title: "Dart", iconPath: "icons/dart.svg"),
      Technology(title: "News API", iconPath: "icons/newsapi.svg"),
    ],
    url: "https://github.com/Sonikrish5122/news_app",
  ),
  Project(
    title: "Food Recipes App",
    description: "This Flutter-based Food Recipe App allows users to explore a variety of recipes, search for specific dishes, and navigate through different categories. It integrates with the Edamam API to provide users with a vast collection of recipes, allowing them to filter by ingredients or dietary preferences, view detailed cooking instructions, and save their favorite recipes.",
    imageUrls: [
      "assets/FoodRecipeApp/image1.png",
      "assets/FoodRecipeApp/image2.png",
      "assets/FoodRecipeApp/image3.png",
      "assets/FoodRecipeApp/image4.png",
    ],
    technologies: [
      Technology(title: "Flutter", iconPath: "icons/flutter.svg"),
      Technology(title: "Dart", iconPath: "icons/dart.svg"),
      Technology(title: "Edamam API", iconPath: "icons/edamam.svg"),

    ],
    url: "https://github.com/Sonikrish5122/food_recipe_app",
  ),
  Project(
    title: "Blog App",
    description: "A dynamic blog application built using Flutter and Firebase. It enables users to create, read, update, and delete blog posts. The app includes user authentication, allowing users to manage their posts easily and securely. It leverages Firebase's real-time database for efficient data storage and retrieval.",
    imageUrls: [
      "assets/BlogApp/image1.png",
      "assets/BlogApp/image2.png",
      "assets/BlogApp/image3.png",
      "assets/BlogApp/image4.png",
      "assets/BlogApp/image5.png",
    ],
    technologies: [
      Technology(title: "Flutter", iconPath: "icons/flutter.svg"),
      Technology(title: "Dart", iconPath: "icons/dart.svg"),
      Technology(title: "Firebase", iconPath: "icons/firebase.svg"),

    ],
    url: "https://github.com/Sonikrish5122/blog_app",
  ),
  Project(
    title: "Car Rental System",
    description: "A comprehensive Car Rental System developed using PHP and MySQL, designed to manage car rental operations efficiently. This system includes features such as vehicle management, booking management, user authentication, and an intuitive user interface to provide a seamless experience for both administrators and customers. The front-end is developed using Bootstrap for responsive design.",
    imageUrls: [
      "assets/CRS/image1.png",
      "assets/CRS/image2.png",
      "assets/CRS/image3.png",
      "assets/CRS/image4.png",
      "assets/CRS/image5.png",
      "assets/CRS/image6.png",
    ],
    technologies: [
      Technology(title: "PHP", iconPath: "icons/php.svg"),
      Technology(title: "MySQL", iconPath: "icons/mysql.svg"),
      Technology(title: "Bootstrap", iconPath: "icons/bootstrap.svg"),
      Technology(title: "HTML", iconPath: "icons/html.svg"),
      Technology(title: "CSS", iconPath: "icons/css.svg"),
      Technology(title: "JavaScript", iconPath: "icons/javascript.svg"),
    ],
    url: "https://github.com/Sonikrish5122/CRS",
  ),
];
