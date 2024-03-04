// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bnews/const/style_custom.dart';
import 'package:flutter/material.dart';

class DetailedNews extends StatelessWidget {
  DetailedNews({
    Key? key,
    this.sourceId,
    this.sourceName,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  }) : super(key: key);

  final String? sourceId;
  final String? sourceName;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(urlToImage.toString()))),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black.withOpacity(.3),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title.toString(),
                            style: MyStyle.textStyleBold().copyWith(
                              fontSize: 22,
                              color: Colors.white,
                              shadows: [
                                const Shadow(
                                  color: Colors.black,
                                  offset: Offset(2, 3),
                                  blurRadius: 5,
                                ),
                              ],
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Text(
                            publishedAt.toString(),
                            style: MyStyle.textStyleBold().copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sourceId.toString().toUpperCase(),
                          style: MyStyle.textStyleBold()
                              .copyWith(color: Colors.redAccent),
                        ),
                        Text(
                          author == null ? "" : author.toString().toUpperCase(),
                          style: MyStyle.textStyleBold().copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      "${description.toString()} \n\n ${content.toString()}",
                      style: MyStyle.textStyleBold().copyWith(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "News Source \n${url}",
                      style: const TextStyle(
                        color: Colors.blueAccent,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
