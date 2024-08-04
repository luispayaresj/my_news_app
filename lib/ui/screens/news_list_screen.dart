import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/news_bloc.dart';
//import '../../blocs/news_event.dart';
import '../../blocs/news_state.dart';
import '../widgets/news_card.dart';
import '../widgets/category_selector.dart';
import '../../repositories/news_repository.dart';

class NewsListScreen extends StatelessWidget {
  final NewsRepository newsRepository = NewsRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: NewsSearch(newsRepository));
            },
          )
        ],
      ),
      body: Column(
        children: [
          CategorySelector(categories: newsRepository.getCategories()),
          Expanded(
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is NewsLoaded) {
                  return ListView.builder(
                    itemCount: state.news.length,
                    itemBuilder: (context, index) {
                      return NewsCard(news: state.news[index]);
                    },
                  );
                } else {
                  return Center(child: Text('Failed to fetch news'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NewsSearch extends SearchDelegate {
  final NewsRepository newsRepository;

  NewsSearch(this.newsRepository);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoaded) {
          final results = state.news
              .where((news) => news.title.toLowerCase().contains(query.toLowerCase()) || news.description.toLowerCase().contains(query.toLowerCase()))
              .toList();

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return NewsCard(news: results[index]);
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
