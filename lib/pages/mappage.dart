import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MonociclosPage extends StatefulWidget {
  const MonociclosPage({super.key});

  @override
  _MonociclosPageState createState() => _MonociclosPageState();
}

class Product {
  final String uuid;
  final String title;
  final String status;
  final int batery;
  final String image;

  Product({
    required this.uuid,
    required this.title,
    required this.status,
    required this.batery,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      uuid: json['uuid'] != null ? json['uuid'] as String : '',
      title: json['name'] != null ? json['name'] as String : 'Nome não disponível',
      status: json['status'] != null ? json['status'] as String : 'Status não disponível',
      batery: json['batery'] != null ? int.tryParse(json['batery']) ?? 0 : 0,
      image: json['image'] != null ? json['image'] as String : '',
    );
  }
}

class _MonociclosPageState extends State<MonociclosPage> {
  List<Product> _products = [];
  bool _isLoading = true;

  // Mocked client ID for now
  final String _mockedClientId = 'mocked-client-id-123';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('https://localhost:7050/Product'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonProducts = json.decode(response.body);
        setState(() {
          _products = jsonProducts.map((json) => Product.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Falha ao carregar produtos');
      }
    } catch (e) {
      _showErrorDialog('Erro ao buscar produtos: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erro'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _reserveProduct(Product product) {
    // Realizar a reserva sem solicitar o ID do cliente e do produto
    _createSale(_mockedClientId, product.uuid);
  }

  Future<void> _createSale(String clientId, String productId) async {
    final url = Uri.parse('https://localhost:7050/sales');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id_client': clientId,
          'id_product': productId,
        }),
      );

      if (response.statusCode == 200) {
        _showPaymentForm();
      } else {
        // Extrair mensagem de erro do JSON retornado
        final Map<String, dynamic> errorResponse = json.decode(response.body);
        final errorMessage = errorResponse['message'] ?? 'Erro desconhecido';
        _showErrorDialog(errorMessage);
      }
    } catch (e) {
      _showErrorDialog('Erro ao criar a venda: $e');
    }
  }

  void _showPaymentForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController cardNumberController = TextEditingController();
        TextEditingController expirationController = TextEditingController();
        TextEditingController cvvController = TextEditingController();

        return AlertDialog(
          title: const Text('Pagamento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cardNumberController,
                decoration: const InputDecoration(labelText: 'Número do Cartão'),
              ),
              TextField(
                controller: expirationController,
                decoration: const InputDecoration(labelText: 'Data de Expiração'),
              ),
              TextField(
                controller: cvvController,
                decoration: const InputDecoration(labelText: 'CVV'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _processPayment(cardNumberController.text, expirationController.text, cvvController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Pagar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _processPayment(String cardNumber, String expiration, String cvv) async {
    // Simula processamento de pagamento
    await Future.delayed(const Duration(seconds: 2)); // Simulando processamento

    // Navega para a tela de sucesso após o pagamento
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SuccessScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monociclos Disponíveis'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('Status: ${product.status}'),
                        const SizedBox(height: 8),
                        Text('Nível de Bateria: ${product.batery}%'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _reserveProduct(product),
                          child: const Text('Reservar'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sucesso'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Reserva concluída com sucesso!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
