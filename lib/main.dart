import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:loggy/loggy.dart';
import 'package:provider/provider.dart';

import 'app/repo/app_repo.dart';
import 'app/routes/router.dart';
import 'app/screens/home/home_provider.dart';
import 'app/screens/search/search_provider.dart';
import 'app/service/api_service.dart';

void main() {
  Loggy.initLoggy(
    logPrinter: const PrettyDeveloperPrinter(),
  );
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
  final AppRepository appRepository = AppRepo(apiService: ApiService());
  appRepository.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: ((context) => HomeProvider(appRepository: appRepository))),
    ChangeNotifierProvider(
        create: ((context) => SearchProvider(appRepository: appRepository)))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      onGenerateRoute: AppRouter().generateRoute,
    );
  }
}
