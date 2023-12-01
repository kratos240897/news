import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider_news/app/widgets/custom_app_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String newsUrl;
  const WebViewScreen({Key? key, required this.newsUrl}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.newsUrl));
  }

  _launchUrl() async => await canLaunchUrl(Uri.parse(widget.newsUrl))
      ? await launchUrl(Uri.parse(widget.newsUrl))
      : throw 'could not launch ${widget.newsUrl}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
                child: CustomAppBar(
                    onTapLeft: () {
                      Navigator.pop(context);
                    },
                    onTapRight: () {
                      _launchUrl();
                    },
                    onTapShare: () async {
                      await Share.share(
                          'Check out this article ' + widget.newsUrl);
                    },
                    icon: FontAwesomeIcons.chrome),
              ),
              const SizedBox(height: 12.0),
              Expanded(child: WebViewWidget(controller: controller)),
            ],
          ),
        ));
  }
}
