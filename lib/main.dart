// Importation des packages nécessaires
import 'package:flutter/material.dart'; // Composants UI Flutter
import 'package:provider/provider.dart'; // Package pour la gestion d’état avec Provider

// Importation de notre contrôleur pour la gestion du thème (clair/sombre)
import 'controllers/theme_controller.dart';

// Importation de la page d'accueil (vue principale)
import 'views/home_page.dart';

// Point d'entrée de l'application
void main() {
  runApp(
    // Fournit le ThemeController à toute l'application grâce à Provider
    ChangeNotifierProvider(
      create: (context) => ThemeController(), // Initialise le contrôleur de thème
      child: const MyApp(), // L'application démarre avec le widget MyApp
    ),
  );
}

// Widget principal de l'application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Accès au contrôleur de thème depuis le contexte (Provider)
    final themeController = Provider.of<ThemeController>(context);

    return MaterialApp(
      title: 'Flutter MVC', // Titre de l'application

      // Thème clair par défaut
      theme: ThemeData.light(),

      // Thème sombre alternatif
      darkTheme: ThemeData.dark(),

      // Choix du thème en fonction de l'état dans ThemeController
      themeMode: themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      debugShowCheckedModeBanner: false, // Enlève le bandeau "debug" en haut à droite

      // Page affichée au lancement de l'application
      home: const HomePage(),
    );
  }
}
