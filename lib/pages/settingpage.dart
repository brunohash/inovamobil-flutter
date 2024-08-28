import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Variáveis para armazenar o estado das configurações
  bool _darkMode = false;
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            // Tema
            ListTile(
              title: const Text('Modo Escuro'),
              trailing: Switch(
                value: _darkMode,
                onChanged: (bool value) {
                  setState(() {
                    _darkMode = value;
                  });
                },
              ),
              onTap: () {
                setState(() {
                  _darkMode = !_darkMode;
                });
              },
            ),
            const Divider(),

            // Notificações
            ListTile(
              title: const Text('Notificações'),
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
              onTap: () {
                setState(() {
                  _notificationsEnabled = !_notificationsEnabled;
                });
              },
            ),
            const Divider(),

            // Outras configurações
            ListTile(
              title: const Text('Idioma'),
              subtitle: const Text('Selecione o idioma preferido'),
              onTap: () {
                // Navegar para a página de seleção de idioma
              },
            ),
            const Divider(),

            ListTile(
              title: const Text('Sobre'),
              subtitle: const Text('Informações sobre o aplicativo'),
              onTap: () {
                // Navegar para a página de informações sobre o aplicativo
              },
            ),
          ],
        ),
      ),
    );
  }
}
