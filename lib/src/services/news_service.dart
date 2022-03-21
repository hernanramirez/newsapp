import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_models.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const _UrlNews = 'https://newsapi.org/v2';
const _ApiKey = '0e942241dfac4b5a9a619872c6ef016a';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, "business"),
    Category(FontAwesomeIcons.tv, "entertainment"),
    Category(FontAwesomeIcons.addressCard, "general"),
    Category(FontAwesomeIcons.headSideVirus, "health"),
    Category(FontAwesomeIcons.vials, "science"),
    Category(FontAwesomeIcons.volleyball, "sports"),
    Category(FontAwesomeIcons.memory, "technology"),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();

    categories.forEach((element) {
      this.categoryArticles[element.name] = [];
    });
  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;
    this.getArticleByCategory(value);
    notifyListeners();
  }

  List<Article>? get getArticlesByCategorySelected =>
      categoryArticles[selectedCategory];

  getTopHeadlines() async {
    final apiEndpoint = "$_UrlNews/top-headlines?apiKey=$_ApiKey&country=us";
    final Uri url = Uri.parse(apiEndpoint);
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);

    notifyListeners();
  }

  getArticleByCategory(category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }

    final apiEndpoint =
        "$_UrlNews/top-headlines?apiKey=$_ApiKey&country=us&category=$category";
    final Uri url = Uri.parse(apiEndpoint);
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);

    categoryArticles[category]?.addAll(newsResponse.articles);

    _selectedCategory = category;

    notifyListeners();
  }
}
