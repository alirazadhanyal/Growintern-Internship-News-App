import 'package:bnews/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/news_model.dart';

class SelectNewsProvider extends ChangeNotifier {
  String _source = "bbc-news";
  String _search = "";

  String get source => _source;

  String get search => _search;

  set source(String newSource) {
    _source = newSource;
    notifyListeners();
  }

  set search(String newSearch) {
    _search = newSearch;
    notifyListeners();
  }

  Future<List<NewsModel>> selectNews({String headline = "everything"}) {
    return FetchNewsData()
        .fetchNewsData(source, headlines: headline, search: _search);
  }

  Future<List<NewsModel>> brakingNews({String headline = "everything"}) {
    return FetchNewsData().fetchNewsData(source, headlines: headline);
  }

  Future<void> goToUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
    print(url);
    ChangeNotifier();
  }
}
