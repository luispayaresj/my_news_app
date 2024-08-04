import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/news_bloc.dart';
import '../../blocs/news_event.dart';
import '../../models/category.dart';

class CategorySelector extends StatelessWidget {
  final List<Category> categories;

  CategorySelector({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<NewsBloc>(context)
                    .add(LoadNews(categories[index].id));
              },
              child: Text(categories[index].name),
            ),
          );
        },
      ),
    );
  }
}
