import 'package:equatable/equatable.dart';
import 'package:my_news_app/models/news.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class LoadNews extends NewsEvent {
  final String categoryId;

  const LoadNews(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class SearchNews extends NewsEvent {
  final String query;

  const SearchNews(this.query);

  @override
  List<Object> get props => [query];
}

class AddNews extends NewsEvent {
  final News news;
  const AddNews(this.news);
}

class UpdateNews extends NewsEvent {
  final News news;
  const UpdateNews(this.news);
}

class DeleteNews extends NewsEvent {
  final News news;
  const DeleteNews(this.news);
}