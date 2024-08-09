import 'dart:developer';

import '../models/news.dart';
import '../models/category.dart';

class NewsRepository {
  List<News> allNews = [
    News(
      title: "Flutter 3.0 Released",
      description: "Flutter 3.0 has been released with amazing new features.",
      date: DateTime.now(),
      imageUrl:
          "https://img.freepik.com/foto-gratis/personaje-3d-emergiendo-telefono-inteligente_23-2151336536.jpg?w=740&t=st=1722815015~exp=1722815615~hmac=f962df7a0c9f0b478cae644a1004155ecd7cdfe76e3f2bae24a6b288545f52dc",
      categoryId: "technology",
    ),
    News(
      title: "Elections 2024",
      description: "Key points about the upcoming elections.",
      date: DateTime.now().subtract(Duration(days: 1)),
      imageUrl:
          "https://img.freepik.com/foto-gratis/hombre-poniendo-boleta-primer-plano-caja_23-2148265571.jpg?t=st=1722815253~exp=1722818853~hmac=868a3b4993e071ecc290c85f6a2b5de04dd0540011b8330230c1db5606b97a37&w=1380",
      categoryId: "politics",
    ),
    News(
      title: "New Tax Policies",
      description: "A review of the new tax policies in the economy sector.",
      date: DateTime.now().subtract(Duration(days: 2)),
      imageUrl:
          "https://img.freepik.com/foto-gratis/monedas-billetes-mexicanos-alto-angulo_23-2149540082.jpg?t=st=1722815326~exp=1722818926~hmac=e6316b8901c1d85f0efe8796772c43c6333f07392dd87960cde6e000b6a486d4&w=1380",
      categoryId: "economy",
    ),
    News(
      title: "Sports Championship",
      description: "The latest results from the sports championship.",
      date: DateTime.now().subtract(Duration(days: 3)),
      imageUrl:
          "https://img.freepik.com/foto-gratis/herramientas-deportivas_53876-138077.jpg?t=st=1722815418~exp=1722819018~hmac=d07d67d491131ee0558d911f09620ce9b7e7094f842c4e92dee9acc4988c4ada&w=1380",
      categoryId: "sports",
    ),
  ];

  List<Category> getCategories() {
    List<Category> categories = [
      Category(id: 'latest', name: 'Latest News'),
      Category(id: 'politics', name: 'Politics'),
      Category(id: 'economy', name: 'Economy'),
      Category(id: 'sports', name: 'Sports'),
      Category(id: 'technology', name: 'Technology'),
    ];

    return categories;
  }

  List<News> getNewsByCategory(String categoryId) {
    if (categoryId == "" || categoryId == "latest") {
      return allNews;
    } else {
      return allNews.where((news) => news.categoryId == categoryId).toList();
    }
  }

  void addNews(News news) {
    allNews.add(news);
  }

  void updateNews(News news, News newNews) {
    for (var i = 0; i < allNews.length; i++) {
      if (allNews[i] == news) {
        allNews[i] = newNews;
      }
    }
  }

  void deleteNews(News news) {
    allNews.remove(news);
    print(allNews);
  }


  
}
