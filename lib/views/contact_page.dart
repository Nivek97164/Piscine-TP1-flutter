// Importation des packages nécessaires
import 'package:flutter/material.dart';
// SharedPreferences permet de sauvegarder des données localement
import 'package:shared_preferences/shared_preferences.dart';

// Déclaration du widget d'état pour la page de contact (formulaire)
class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  // Clé utilisée pour valider le formulaire
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs pour récupérer le contenu des champs du formulaire
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Fonction appelée au clic sur le bouton "Enregistrer"
  void _saveMessage() async {
    // Vérifie que tous les champs sont valides
    if (_formKey.currentState!.validate()) {
      // Récupère l'instance de SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Charge les messages existants, ou crée une nouvelle liste si vide
      List<String> messages = prefs.getStringList('messages') ?? [];

      // Ajoute le nouveau message à la liste
      messages.add(
        '${_nameController.text} - ${_emailController.text} : ${_messageController.text}',
      );

      // Sauvegarde la liste mise à jour
      prefs.setStringList('messages', messages);

      // Affiche une notification SnackBar pour confirmer l'enregistrement
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message enregistré !')),
      );

      // Réinitialise les champs du formulaire
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Titre de la page
      appBar: AppBar(title: const Text('Contact')),

      // Contenu de la page avec du padding
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Lien avec la clé de validation du formulaire
          child: Column(
            children: [
              // Champ Nom
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (value) =>
                    value!.isEmpty ? 'Veuillez entrer votre nom' : null,
              ),

              // Champ Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.contains('@') ? null : 'Veuillez entrer un email valide',
              ),

              // Champ Message
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(labelText: 'Message'),
                maxLines: 4,
                validator: (value) =>
                    value!.isEmpty ? 'Veuillez entrer un message' : null,
              ),

              const SizedBox(height: 20),

              // Bouton d'enregistrement
              ElevatedButton(
                onPressed: _saveMessage,
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
