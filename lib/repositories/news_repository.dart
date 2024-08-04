import '../models/news.dart';
import '../models/category.dart';

class NewsRepository {


  List<Category> getCategories(){
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
    // Datos "quemados" de ejemplo
    List<News> allNews = [
      News(
        title: "Flutter 3.0 Released",
        description: "Flutter 3.0 has been released with amazing new features.",
        date: DateTime.now(),
        imageUrl: "https://via.placeholder.com/150",
        categoryId: "technology",
      ),
      News(
        title: "Elections 2024",
        description: "Key points about the upcoming elections.",
        date: DateTime.now().subtract(Duration(days: 1)),
        imageUrl: "https://via.placeholder.com/150",
        categoryId: "politics",
      ),
      News(
        title: "New Tax Policies",
        description: "A review of the new tax policies in the economy sector.",
        date: DateTime.now().subtract(Duration(days: 2)),
        imageUrl: "https://via.placeholder.com/150",
        categoryId: "economy",
      ),
      News(
        title: "Sports Championship",
        description: "The latest results from the sports championship.",
        date: DateTime.now().subtract(Duration(days: 3)),
        imageUrl: "https://via.placeholder.com/150",
        categoryId: "sports",
      ),
    ];

    if(categoryId == ""){
      return allNews;
    }else {
      return allNews.where((news) => news.categoryId == categoryId).toList();
      }

  }
}
