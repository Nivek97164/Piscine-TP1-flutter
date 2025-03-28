// Importation du package Flutter pour les widgets UI
import 'package:flutter/material.dart';

// Page qui affiche les détails d’un article sélectionné
class ArticleDetailPage extends StatelessWidget {
  // On reçoit l’article sous forme de Map (avec un titre et un corps)
  final Map article;

  // Constructeur avec paramètre obligatoire
  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre d’app avec le titre de l’article en haut
      appBar: AppBar(title: Text(article['title'])),

      // Contenu de la page avec un peu de padding
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligne les éléments à gauche
          children: [
            // Affiche le titre de l’article avec une taille plus grande et en gras
            Text(
              article['title'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10), // Espace entre le titre et le contenu

            // Affiche le contenu (corps) de l’article
            Text(
              article['body'],
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
