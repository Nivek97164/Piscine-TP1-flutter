// Importation des packages nécessaires
import 'package:flutter/material.dart';
import 'about_page.dart'; // Importation de la page À propos
import 'contact_page.dart'; // Importation de la page de contact
import 'articles_page.dart'; // Importation de la page d'articles
import 'message_history_page.dart'; // Importation de la page d'historique des messages
import 'package:provider/provider.dart'; // Pour gérer le thème
import '../controllers/theme_controller.dart'; // Contrôleur du thème

// Déclaration de la page d'accueil (HomePage)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre de navigation principale en haut
      appBar: AppBar(title: const Text('Accueil')),

      // Menu latéral (Drawer)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // En-tête du menu
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),

            // Lien vers la page À propos
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('À Propos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),

            // Lien vers la page Contact
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('Contact'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactPage()),
                );
              },
            ),

            // Lien vers la page Articles (API)
            ListTile(
              leading: const Icon(Icons.article),
              title: const Text('Articles'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ArticlesPage()),
                );
              },
            ),

            // Lien vers l'historique des messages enregistrés localement
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Historique des Messages'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MessageHistoryPage()),
                );
              },
            ),

            // Séparateur visuel
            const Divider(),

            // Bouton pour changer le thème clair/sombre
            ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text('Changer de thème'),
              onTap: () {
                // Appelle la méthode toggleTheme() depuis ThemeController
                Provider.of<ThemeController>(context, listen: false).toggleTheme();
              },
            ),
          ],
        ),
      ),

      // Corps de la page d'accueil
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Flutter affiché au centre
            Image.asset('logos/flutter_logo.png', height: 250),

            const SizedBox(height: 20),

            // Message d'accueil
            const Text(
              'Bienvenue sur la page d\'accueil',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
