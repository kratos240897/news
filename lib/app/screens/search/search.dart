import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:provider_news/app/models/news_response.dart';
import 'package:provider_news/app/routes/router.dart';
import 'package:provider_news/app/screens/search/search_provider.dart';
import 'package:provider_news/app/widgets/bordered_box_button.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late SearchProvider provider;
  late List<Articles> articles;
  final TextEditingController searchController = TextEditingController();
  final List<String> trendingTopics = [
    'Apple',
    'War',
    'Tech',
    'Sports',
    'Crypto',
    'Gossips'
  ];

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: TextField(
                              controller: searchController,
                              autocorrect: false,
                              style: GoogleFonts.lato(
                                  fontSize: 16.0, color: Colors.black),
                              decoration: InputDecoration(
                                  hintStyle: GoogleFonts.openSans(
                                      color: Colors.black87),
                                  hintText: 'Starting searching news',
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      BorderedBoxButton(
                          icon: Icons.search,
                          onTap: () async {
                            if (searchController.text.toString().isEmpty) {
                              return;
                            } else {
                              provider.search(searchController.text.toString());
                            }
                          })
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                  child: Wrap(
                    spacing: 15.0,
                    alignment: WrapAlignment.start,
                    children: trendingTopics.map((e) {
                      return ElevatedButton.icon(
                          icon: const Icon(
                            Icons.moving,
                            color: Colors.amber,
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
                                fontWeight: FontWeight.w600),
                          ));
                    }).toList(),
                  ),
                ),
                provider.isLoading == true
                    ? const Expanded(
                        child:
                            Center(child: CircularProgressIndicator.adaptive()),
                      )
                    : Expanded(child: NewList(articles: articles))
              ],
            );
          },
        ),
      ),
    );
  }
}

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
      onTap: () {
        Navigator.pushNamed(context, AppRouter.DETAIL, arguments: articles);
      },
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
                        style: GoogleFonts.raleway(
                            fontSize: 14.0, color: Colors.black),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
