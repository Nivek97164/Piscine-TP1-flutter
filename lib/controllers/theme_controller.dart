// Importation des packages nécessaires
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Classe qui gère le thème clair / sombre de l'application
class ThemeController extends ChangeNotifier {
  // Variable privée pour savoir si le mode sombre est activé
  bool _isDarkMode = false;

  // Getter pour accéder à la valeur depuis l'extérieur
  bool get isDarkMode => _isDarkMode;

  // Constructeur : charge le thème depuis le stockage local au démarrage
  ThemeController() {
    _loadTheme();
  }

  // Fonction pour charger l'état du thème (clair/sombre) depuis SharedPreferences
  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Si aucune valeur enregistrée, le thème reste par défaut (clair)
    _isDarkMode = prefs.getBool('darkMode') ?? false;

    // Notifie les widgets que l'état a changé
    notifyListeners();
  }

  // Fonction appelée lorsqu'on clique sur "Changer de thème"
  void toggleTheme() async {
    // Inverse la valeur du thème
    _isDarkMode = !_isDarkMode;

    // Enregistre la nouvelle valeur dans SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', _isDarkMode);

    // Notifie les widgets pour appliquer le nouveau thème
    notifyListeners();
  }
}
