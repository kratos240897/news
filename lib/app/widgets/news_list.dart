import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/news_response.dart';
import '../routes/router.dart';

class NewList extends StatelessWidget {
  final List<Articles> articles;
  const NewList({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(5.0),
        itemCount: articles.length,
        itemBuilder: ((_, index) {
          return NewsCard(articles: articles[index]);
        }));
  }
}

class NewsCard extends StatelessWidget {
  final Articles articles;
  const NewsCard({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() =>
          Navigator.pushNamed(context, AppRouter.DETAIL, arguments: articles)),
      child: Hero(
        tag: articles.hashCode,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          elevation: 4.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                            errorWidget: (context, url, error) {
                              return CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      'https://i.pinimg.com/originals/64/a9/1a/64a91a7a4c519e20dab92de9cf1d4447.jpg');
                            },
                            fit: BoxFit.cover,
                            imageUrl: articles.urlToImage != null
                                ? articles.urlToImage.toString()
                                : 'https://i.pinimg.com/originals/64/a9/1a/64a91a7a4c519e20dab92de9cf1d4447.jpg'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Column(
                        children: [
                          Text(
                            articles.title,
                            style: GoogleFonts.quicksand(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            articles.description != null
                                ? articles.description.toString()
                                : 'No Description found for this news.',
                            maxLines: 4,
                            style: GoogleFonts.raleway(
                                wordSpacing: 1.8,
                                fontSize: 14.0,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
