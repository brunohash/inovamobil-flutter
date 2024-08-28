import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() {
    _markers.addAll([
      Marker(
        markerId: MarkerId('point1'),
        position: LatLng(37.7749, -122.4194), // Exemplo: San Francisco
        infoWindow: InfoWindow(title: 'Ponto 1'),
        onTap: () => _showModal(
          context,
          title: 'Ponto 1',
          imageUrl: 'assets/images/point1.jpg',
          description: 'Descrição do Ponto 1.',
        ),
      ),
      Marker(
        markerId: MarkerId('point2'),
        position: LatLng(34.0522, -118.2437), // Exemplo: Los Angeles
        infoWindow: InfoWindow(title: 'Ponto 2'),
        onTap: () => _showModal(
          context,
          title: 'Ponto 2',
          imageUrl: 'assets/images/point2.jpg',
          description: 'Descrição do Ponto 2.',
        ),
      ),
      // Adicione mais marcadores conforme necessário
    ]);
  }

  void _showModal(BuildContext context, {required String title, required String imageUrl, required String description}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8.0),
              Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),
              const SizedBox(height: 8.0),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Adicione aqui a lógica de reserva
                },
                child: const Text('Reservar'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.7749, -122.4194), // Posição inicial do mapa
          zoom: 10,
        ),
        markers: _markers,
      ),
    );
  }
}
