import 'package:flutter/material.dart';
import 'package:my_news_app/ui/widgets/news_Form.dart';

class AddNewsPage extends StatelessWidget {
  const AddNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add News'),
      ),
      body: NewsForm(),
    );
  }
}