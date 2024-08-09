import 'package:flutter_bloc/flutter_bloc.dart';
import 'news_event.dart';
import 'news_state.dart';
import '../repositories/news_repository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc(this.newsRepository) : super(NewsLoading()) {

    on<LoadNews>((event, emit) async {
      try {
        final news = newsRepository.getNewsByCategory(event.categoryId);
        emit(NewsLoaded(news));
      } catch (_) {
        emit(NewsError());
      }
    });

    add(const LoadNews('latest'));

    on<AddNews>((event, emit) async {
      try {
        newsRepository.addNews(event.news);
        final news = newsRepository.getNewsByCategory('latest');
        emit(NewsLoaded(news));
      } catch (_) {
        emit(NewsError());
      }
    });

    on<UpdateNews>((event, emit) async {
      try {
        newsRepository.updateNews(event.news, event.newNews);
        final news = newsRepository.getNewsByCategory('latest');
        emit(NewsLoaded(news));
      } catch (_) {
        emit(NewsError());
      }
    });

    on<DeleteNews>((event, emit) async {
      try {
        newsRepository.deleteNews(event.news);
        final news = newsRepository.getNewsByCategory('latest');
        emit(NewsLoaded(news));
      } catch (_) {
        emit(NewsError());
      }
    });

    on<SearchNews>((event, emit) async {
      try {
        final allNews = newsRepository.getNewsByCategory('latest');
        final filteredNews = allNews
            .where((news) => news.title.contains(event.query) || news.description.contains(event.query))
            .toList();
        emit(NewsLoaded(filteredNews));
      } catch (_) {
        emit(NewsError());
      }
    });

    

  }
}
