// Importation des packages Flutter pour les widgets UI
import 'package:flutter/material.dart';

// Importation de SharedPreferences pour le stockage local de données simples
import 'package:shared_preferences/shared_preferences.dart';

// Déclaration de la classe de la page d'historique des messages (Vue)
class MessageHistoryPage extends StatefulWidget {
  const MessageHistoryPage({super.key});

  @override
  _MessageHistoryPageState createState() => _MessageHistoryPageState();
}

// État associé à la page MessageHistoryPage
class _MessageHistoryPageState extends State<MessageHistoryPage> {
  // Liste des messages enregistrés localement
  List<String> messages = [];

  // Méthode appelée automatiquement à l'ouverture de la page
  @override
  void initState() {
    super.initState();
    _loadMessages(); // On charge les messages enregistrés dans le téléphone
  }

  // Fonction asynchrone qui récupère les messages depuis SharedPreferences
  Future<void> _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance(); // Accès au stockage local
    setState(() {
      // On récupère la liste des messages ou une liste vide si aucune donnée n'existe
      messages = prefs.getStringList('messages') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre de titre en haut de la page
      appBar: AppBar(title: const Text('Historique des Messages')),

      // Corps de la page
      body: messages.isEmpty
          // Si aucun message : affichage d’un texte au centre
          ? const Center(child: Text('Aucun message enregistré'))

          // Sinon, on affiche les messages dans une liste déroulante
          : ListView.builder(
              itemCount: messages.length, // Nombre d’éléments dans la liste
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]), // Affiche chaque message
                );
              },
            ),
    );
  }
}
