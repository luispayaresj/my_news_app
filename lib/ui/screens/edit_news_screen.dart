import 'package:flutter/material.dart';
import 'package:my_news_app/models/news.dart';
import 'package:my_news_app/ui/widgets/news_Form.dart';

class EditNewsScreen extends StatelessWidget {
  const EditNewsScreen({super.key, required this.news});
  final News news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit News'),
      ),
      body: NewsForm(news: news,),
    );
  }
}