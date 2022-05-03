import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider_news/app/widgets/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String newsUrl;
  const WebViewScreen({Key? key, required this.newsUrl}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  _launchUrl() async => await canLaunchUrl(Uri.parse(widget.newsUrl))
      ? await launchUrl(Uri.parse(widget.newsUrl))
      : throw 'could not launch ${widget.newsUrl}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
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
                    icon: FontAwesomeIcons.safari),
              ),
              const SizedBox(height: 12.0),
              Expanded(child: WebView(initialUrl: widget.newsUrl)),
            ],
          ),
        ));
  }
}
