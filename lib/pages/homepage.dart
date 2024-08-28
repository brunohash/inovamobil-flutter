import 'package:flutter/material.dart';
import 'package:flutter_inovamobil/pages/mappage.dart';
import 'package:flutter_inovamobil/pages/settingpage.dart';
import 'package:flutter_inovamobil/pages/newsdetailpage.dart'; // Certifique-se de que este caminho está correto

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navegar para a página correspondente
    switch (index) {
      case 0:
        // Atualiza a tela atual em vez de empurrar uma nova
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MapPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Inicial'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Card(
            elevation: 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Imagem do lado esquerdo
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4, // Ajuste a largura conforme necessário
                  child: Image.asset(
                    'assets/images/monociclo-ageless.avif',
                    fit: BoxFit.cover,
                  ),
                ),
                // Texto do lado direito
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Monociclos e o Meio Ambiente',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Como o uso de monociclos pode beneficiar a natureza',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8.0),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NewsDetailPage(),
                              ),
                            );
                          },
                          child: const Text('Leia mais'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
