import 'package:bnews/models/news_model.dart';
import 'package:bnews/provider/select_news.dart';
import 'package:bnews/provider/user_auth_provider.dart';
import 'package:bnews/repo/repo.dart';
import 'package:bnews/view/detailed_news.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/style_custom.dart';

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final FetchNewsData fetchNewsData = FetchNewsData();

  Widget customSearchBar = const Text('Latest Tech News');

  final List categoriesList = [
    "bbc-news",
    "abc-news-au",
    "al-jazeera-english",
    "ary-news",
    "bbc-sport",
    "bloomberg",
    "buzzfeed",
  ];

  String forYou = "For You";
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserAuthProvider>(context);
    final newsProvider = Provider.of<SelectNewsProvider>(context);
    final brakingNews = Provider.of<SelectNewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              provider.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
        title: Text(
          "B-News",
          style: MyStyle.textStyleBold(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchWidget(context, newsProvider),
            Text("Breaking News", style: MyStyle.textStyleBold()),
            const SizedBox(height: 10),
            BrakingNewsWidget(brakingNews: brakingNews),
            const SizedBox(height: 10),
            CategoriesList(newsProvider),
            const SizedBox(height: 10),
            Text(forYou.toUpperCase(), style: MyStyle.textStyleBold()),
            AllNewsList(newsProvider: newsProvider),
          ],
        ),
      ),
    );
  }

  Expanded CategoriesList(SelectNewsProvider newsProvider) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  newsProvider.source = categoriesList[index].toString();
                  forYou =
                      newsProvider.source = categoriesList[index].toString();
                },
                child: Text(
                  categoriesList[index].toString().toUpperCase(),
                  style: MyStyle.textStyleBold().copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding SearchWidget(BuildContext context, SelectNewsProvider newsProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  newsProvider.search = value.toString();
                  forYou = value;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search",
                    hintStyle: TextStyle(
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AllNewsList extends StatelessWidget {
  const AllNewsList({
    super.key,
    required this.newsProvider,
  });

  final SelectNewsProvider newsProvider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: FutureBuilder<List<NewsModel>>(
        future: newsProvider.selectNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No news data available.'),
            );
          } else {
            // Data is available, build your UI using the fetched newsList
            List<NewsModel> newsList = snapshot.data!;
            return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(2),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              newsList[index].urlToImage,
                            )),
                        color: Colors.black,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailedNews(
                                  urlToImage: newsList[index].urlToImage,
                                  title: newsList[index].title,
                                  description: newsList[index].description,
                                  publishedAt: newsList[index].publishedAt,
                                  sourceId: newsList[index].sourceId,
                                  sourceName: newsList[index].sourceName,
                                  content: newsList[index].content,
                                  url: newsList[index].url,
                                  author: newsList[index].author,
                                ),
                              ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(newsList[index].sourceId),
                            Text(
                              newsList[index].title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(newsList[index].sourceName),
                                  const SizedBox(width: 10),
                                  Text(
                                    newsList[index].publishedAt,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class BrakingNewsWidget extends StatelessWidget {
  const BrakingNewsWidget({
    super.key,
    required this.brakingNews,
  });

  final SelectNewsProvider brakingNews;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: FutureBuilder<List<NewsModel>>(
        future: brakingNews.brakingNews(
          headline: "top-headlines",
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No news data available.'),
            );
          }
          List<NewsModel> bannerList = snapshot.data!;
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: bannerList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      brakingNews.goToUrl(bannerList[index].url);
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(bannerList[index].urlToImage)),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.7),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                bannerList[index].title,
                                style: MyStyle.textStyleBold().copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
