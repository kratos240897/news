import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:provider_news/app/helpers/utils.dart';
import 'package:provider_news/app/models/news_response.dart';
import 'package:provider_news/app/routes/router.dart';
import 'package:provider_news/app/screens/search/search_provider.dart';
import 'package:provider_news/app/widgets/bordered_box_button.dart';

import '../../widgets/news_list.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late SearchProvider provider;
  late List<Articles> articles;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    provider = Provider.of<SearchProvider>(context, listen: false);
    articles = provider.articles;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Consumer<SearchProvider>(
          builder: (_, provider, child) {
            return Column(
              children: [
                SearchAppBar(
                    provider: provider, searchController: searchController),
                TrendingSearches(
                    provider: provider, searchController: searchController),
                SearchResults(provider: provider, articles: articles)
              ],
            );
          },
        ),
      ),
    );
  }
}

class SearchResults extends StatelessWidget {
  final SearchProvider provider;
  final List<Articles> articles;
  const SearchResults(
      {Key? key, required this.provider, required this.articles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return provider.isLoading == true
        ? const Expanded(
            child: Center(child: CircularProgressIndicator.adaptive()),
          )
        : Expanded(child: NewList(articles: articles));
  }
}

class TrendingSearches extends StatelessWidget {
  final SearchProvider provider;
  final TextEditingController searchController;
  final List<String> trendingTopics = [
    'Apple',
    'War',
    'Tech',
    'Sports',
    'Crypto',
    'Gossips'
  ];
  TrendingSearches(
      {Key? key, required this.provider, required this.searchController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 10.0,
        runSpacing: 5.0,
        verticalDirection: VerticalDirection.down,
        alignment: WrapAlignment.start,
        children: trendingTopics.map((e) {
          return ElevatedButton.icon(
              icon: const Icon(
                Icons.moving,
                color: Styles.primaryColor,
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 4.0,
                  primary: Colors.white,
                  shape: const StadiumBorder()),
              onPressed: () {
                searchController.text = e;
                provider.search(e);
              },
              label: Text(
                e,
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600, color: Styles.primaryColor),
              ));
        }).toList(),
      ),
    );
  }
}

class SearchAppBar extends StatelessWidget {
  final SearchProvider provider;
  final TextEditingController searchController;
  const SearchAppBar(
      {Key? key, required this.provider, required this.searchController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Row(
        children: [
          BorderedBoxButton(
              icon: CupertinoIcons.back,
              onTap: () {
                Navigator.of(context).pop();
              }),
          const SizedBox(width: 5.0),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        autocorrect: false,
                        onSubmitted: (_) {
                          if (searchController.text.toString().isEmpty) {
                            return;
                          } else {
                            provider.search(searchController.text.toString());
                          }
                        },
                        style: GoogleFonts.lato(
                            fontSize: 16.0, color: Colors.black),
                        decoration: InputDecoration(
                            hintStyle:
                                GoogleFonts.openSans(color: Colors.black87),
                            hintText: 'Starting searching news',
                            border: InputBorder.none),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20.0),
                      splashColor: Colors.green,
                      onTap: () {
                        if (searchController.text.toString().isEmpty) {
                          return;
                        } else {
                          provider.search(searchController.text.toString());
                        }
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.globeAsia,
                        color: Styles.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


