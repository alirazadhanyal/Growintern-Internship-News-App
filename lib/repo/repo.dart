import 'package:dio/dio.dart';

import '../models/news_model.dart';

class FetchNewsData {
  final Dio _dio = Dio();
  final String _API_TOKEN = "3a073b973a004884bb527c38ab5b408d";

  Future<List<NewsModel>> fetchNewsData(String sources,
      {String headlines = "everything", String search = ""}) async {
    try {
      final response = await _dio.get(
          'https://newsapi.org/v2/$headlines?q=$search&sources=$sources&apiKey=$_API_TOKEN');

      if (response.statusCode == 200) {
        // Assuming the API response is a list of articles
        List<dynamic> articles = response.data['articles'];

        // Mapping the list to NewsModel objects
        List<NewsModel> newsList =
            articles.map((article) => NewsModel.fromJson(article)).toList();

        return newsList;
      } else {
        throw Exception('Failed to load news data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw e; // Re-throw the exception to handle it elsewhere if needed
    }
  }
}
