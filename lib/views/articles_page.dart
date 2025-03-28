// Importation des packages nécessaires
import 'package:flutter/material.dart';
import 'dart:convert'; // Pour décoder les réponses JSON
import 'package:http/http.dart' as http; // Pour les appels API HTTP
import 'article_detail_page.dart'; // Page de détails d’un article

// Widget Stateful car on modifie dynamiquement l’état (liste + chargement)
class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  // Liste des articles chargés
  List articles = [];

  // Numéro de page (pour la pagination)
  int page = 0;

  // Indique si on est en train de charger des données
  bool isLoading = false;

  // Contrôleur de scroll pour détecter quand on arrive en bas
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchArticles(); // Charge les premiers articles
    _scrollController.addListener(_scrollListener); // Active la pagination automatique
  }

  // Fonction pour récupérer des articles depuis l’API
  Future<void> fetchArticles() async {
    // Si on est déjà en train de charger, on ne fait rien
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    // Appel API avec pagination : 10 articles par page
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts?_start=${page * 10}&_limit=10'),
    );

    // Si la réponse est correcte (200 OK)
    if (response.statusCode == 200) {
      // On décode la réponse JSON et on ajoute les nouveaux articles à la liste existante
      List newArticles = json.decode(response.body);
      setState(() {
        articles.addAll(newArticles);
        page++; // On passe à la page suivante pour la prochaine requête
        isLoading = false;
      });
    } else {
      // Si erreur, on affiche une exception
      throw Exception('Échec du chargement des articles');
    }
  }

  // Fonction appelée à chaque scroll
  void _scrollListener() {
    // Si on est arrivé en bas de la page, on charge plus d’articles
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      fetchArticles();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Titre de la page
      appBar: AppBar(title: const Text('Articles')),

      // Corps de la page
      body: articles.isEmpty && isLoading
          // Si on n'a encore rien chargé, on affiche un loader au centre
          ? const Center(child: CircularProgressIndicator())

          // Sinon, on affiche la liste des articles
          : ListView.builder(
              controller: _scrollController, // Permet de détecter le scroll
              itemCount: articles.length + (isLoading ? 1 : 0), // +1 si on est en train de charger
              itemBuilder: (context, index) {
                // Si on est à la fin de la liste et qu’on charge encore
                if (index == articles.length) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Affiche un article dans une tuile (ListTile)
                return ListTile(
                  title: Text(articles[index]['title']), // Titre de l’article
                  subtitle: Text(
                    articles[index]['body'], // Corps de l’article
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis, // Tronque le texte si trop long
                  ),
                  onTap: () {
                    // Navigue vers la page de détails en passant l’article sélectionné
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ArticleDetailPage(article: articles[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
