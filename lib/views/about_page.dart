// Importation du package Flutter pour les widgets UI
import 'package:flutter/material.dart';

// Déclaration de la page À Propos, qui est une page statique (StatelessWidget)
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre de titre en haut de la page
      appBar: AppBar(title: const Text('À Propos')),

      // Corps de la page centré verticalement et horizontalement
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrage vertical
          children: [
            // Affichage d’une image située dans le dossier assets/images/
            Image.asset('images/about.png', height: 150),

            const SizedBox(height: 20), // Espace entre l’image et le texte

            // Texte de description de l’application
            const Text(
              'Ceci est une application Flutter en architecture MVC.',
              textAlign: TextAlign.center, // Centre le texte horizontalement
            ),
          ],
        ),
      ),
    );
  }
}
