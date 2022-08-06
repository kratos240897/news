import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:provider_news/app/helpers/utils.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../models/news_response.dart';
import '../../routes/router.dart';
import '../../widgets/bordered_box_button.dart';
import '../../widgets/news_list.dart';
import 'home_provider.dart';

class HomeView extends StatefulWidget {
  final VoidCallback openDrawer;
  const HomeView({Key? key, required this.openDrawer}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late HomeProvider provider;
  late TabController _tabController;
  final List<ScrollController> scrollControllerList = [];
  double appBarHeight = 60.0;
  final scaffoldKey = GlobalKey();
  final keyOne = GlobalKey();
  final keyTwo = GlobalKey();
  final keyThree = GlobalKey();

  List<Widget> getTabBarViews() {
    final List<NewsList> tabBarViews = [];
    for (String i in provider.topics) {
      final scrollController = ScrollController();
      scrollController.addListener(() => scrollListener(scrollController));
      scrollControllerList.add(scrollController);
      final newsListWidget = NewsList(
          articles: provider.categoriesMap[i]!, controller: scrollController);
      tabBarViews.add(newsListWidget);
    }
    return tabBarViews;
  }

  @override
  void initState() {
    provider = Provider.of<HomeProvider>(context, listen: false);
    _tabController = TabController(length: provider.topics.length, vsync: this);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      provider.getNews();
      ShowCaseWidget.of(context)?.startShowCase([keyOne, keyTwo, keyThree]);
    });
    super.initState();
  }

  void scrollListener(ScrollController scrollController) {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        appBarHeight = 0.0;
      });
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        appBarHeight = 60.0;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (var controller in scrollControllerList) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Consumer<HomeProvider>(builder: (_, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  appBarHeight: appBarHeight,
                  key1: keyOne,
                  key2: keyTwo,
                  openDrawer: widget.openDrawer,
                ),
                CustomShowCase(
                  globalKey: keyThree,
                  title: 'Browse',
                  description: 'Different topics around you',
                  isCircleBorder: false,
                  child: TopicsTabBar(
                      tabController: _tabController,
                      topics: provider.topics,
                      provider: provider),
                ),
                NewsSectionsTabBarView(
                    tabController: _tabController,
                    tabBarViews: getTabBarViews())
              ],
            );
          }),
        ));
  }
}

class CustomShowCase extends StatelessWidget {
  final GlobalKey globalKey;
  final String title;
  final String description;
  final Widget child;
  final bool isCircleBorder;
  const CustomShowCase(
      {Key? key,
      required this.globalKey,
      required this.title,
      required this.description,
      required this.child,
      required this.isCircleBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: globalKey,
      title: title,
      description: description,
      shapeBorder: isCircleBorder
          ? const CircleBorder()
          : RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      contentPadding: const EdgeInsets.all(15.0),
      titleTextStyle:
          GoogleFonts.spartan(fontWeight: FontWeight.w600, fontSize: 20.0),
      descTextStyle: GoogleFonts.quicksand(
          letterSpacing: 1.2,
          fontSize: 18.0,
          color: Colors.black87,
          fontWeight: FontWeight.w400),
      child: child,
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final VoidCallback openDrawer;
  final GlobalKey key1;
  final GlobalKey key2;
  const CustomAppBar(
      {Key? key,
      required this.appBarHeight,
      required this.key1,
      required this.key2,
      required this.openDrawer})
      : super(key: key);

  final double appBarHeight;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(top: 4.0),
      height: appBarHeight,
      curve: Curves.linearToEaseOut,
      duration: const Duration(milliseconds: 300),
      child: Visibility(
          visible: appBarHeight != 0.0,
          child: HeaderAppBar(key1: key1, key2: key2, openDrawer: openDrawer)),
    );
  }
}

class NewsSectionsTabBarView extends StatelessWidget {
  const NewsSectionsTabBarView({
    Key? key,
    required TabController tabController,
    required this.tabBarViews,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final List<Widget> tabBarViews;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TabBarView(controller: _tabController, children: tabBarViews));
  }
}

class TopicsTabBar extends StatelessWidget {
  final HomeProvider provider;
  final List<String> topics;
  const TopicsTabBar({
    Key? key,
    required TabController tabController,
    required this.topics,
    required this.provider,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 5.0),
        child: TabBar(
          onTap: (value) {
            provider.search(value);
          },
          isScrollable: true,
          indicatorColor: Colors.black,
          controller: _tabController,
          labelColor: Styles.primaryColor,
          indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(color: Styles.primaryColor, width: 2.0),
              insets: EdgeInsets.only(right: 30.0, left: 20.0)),
          unselectedLabelColor: Colors.black38,
          labelStyle: GoogleFonts.nunito(fontSize: 20.0),
          tabs: topics.map((e) {
            return Tab(text: e);
          }).toList(),
        ));
  }
}

class HeaderAppBar extends StatelessWidget {
  final GlobalKey key1;
  final GlobalKey key2;
  final VoidCallback openDrawer;
  const HeaderAppBar(
      {Key? key,
      required this.key1,
      required this.key2,
      required this.openDrawer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomShowCase(
            globalKey: key1,
            title: 'Tap here',
            description: 'To access menu',
            isCircleBorder: true,
            child: BorderedBoxButton(
              icon: Icons.menu,
              onTap: () {
                openDrawer();
              },
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.mapMarkerAlt,
                  color: Styles.primaryColor,
                  size: 18.0,
                ),
                const SizedBox(width: 4.0),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    'Chennai,',
                    style: GoogleFonts.spartan(
                        fontSize: 16.0,
                        color: Styles.primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 4.0),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'India.',
                    style: GoogleFonts.spartan(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomShowCase(
            globalKey: key2,
            title: 'Tap here',
            description: 'to search some news',
            isCircleBorder: true,
            child: BorderedBoxButton(
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.SEARCH);
                },
                icon: Icons.search),
          )
        ],
      ),
    );
  }
}

class NewsList extends StatefulWidget {
  final ScrollController controller;
  final List<Articles> articles;
  const NewsList({Key? key, required this.articles, required this.controller})
      : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
        controller: widget.controller,
        padding: const EdgeInsets.all(5.0),
        itemCount: widget.articles.length,
        itemBuilder: ((_, index) {
          return NewsCard(articles: widget.articles[index]);
        }));
  }

  @override
  bool get wantKeepAlive => true;
}

