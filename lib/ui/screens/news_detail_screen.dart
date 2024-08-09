import 'package:flutter/material.dart';
import '../../models/news.dart';

class NewsDetailScreen extends StatelessWidget {
  final News news;

  NewsDetailScreen({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.delete))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(news.imageUrl),
              SizedBox(height: 8),
              Text(news.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(news.description),
              SizedBox(height: 8),
              Text('Published on: ${news.date.toLocal()}'),
              Text('Category: ${news.categoryId}'),
            ],
          ),
        ),
      ),
    );
  }
}
