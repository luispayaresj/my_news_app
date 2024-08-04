import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/news_bloc.dart';
import 'repositories/news_repository.dart';
import './ui/screens/news_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NewsRepository>(
          create: (context) => NewsRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NewsBloc>(
            create: (context) => NewsBloc(
              RepositoryProvider.of<NewsRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'News App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: NewsListScreen(),
        ),
      ),
    );
  }
}
