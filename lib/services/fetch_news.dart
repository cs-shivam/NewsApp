import 'package:dio/dio.dart';
import 'package:news_app/data/models/news_api_model.dart';

class NewsApiServices {
  static String _apiKey = "969c5ed7ab73478dbee54721d73c021c";
  String _url = "https://newsapi.org/v2/everything?q=apple&pageSize=5&page=";
  Dio _dio;

  NewsApiServices() {
    _dio = Dio();
  }
  Future<List<Article>> fetchNewsArticle(int pageNo) async {
    try {
      Response response = await _dio.get(_url + pageNo.toString() + "&apiKey=$_apiKey");
      NewsAPIResponse newsResponse = NewsAPIResponse.fromJson(response.data);
      return newsResponse.articles;
    } on DioError catch (e) {
      print("Error $e");
      return null;
    }
  }
}