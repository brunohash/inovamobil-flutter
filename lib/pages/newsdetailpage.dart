import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Notícia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildArticle(
                context,
                title: 'Monociclos e o Meio Ambiente',
                imageUrl: 'assets/images/monociclo-ageless.avif',
                content:
                    'O uso de monociclos tem crescido significativamente nos últimos anos. Além de ser uma forma prática e divertida de transporte, o monociclo tem vários benefícios para o meio ambiente. Por exemplo, ele reduz a necessidade de veículos motorizados, o que diminui a emissão de gases poluentes. O monociclo também é mais eficiente em termos de consumo de energia e pode ser usado em uma variedade de terrenos, tornando-o uma opção sustentável para viagens curtas e médias.',
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildArticle(BuildContext context,
    {required String title,
    required String imageUrl,
    required String content}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        title,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      const SizedBox(height: 8.0),
      SizedBox(
        width: double.infinity,
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(height: 8.0),
      Text(
        content,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    ],
  );
}
