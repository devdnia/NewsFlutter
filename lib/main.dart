import 'package:flutter/material.dart';

import 'package:news/src/pages/pages.dart';
import 'package:news/src/services/news_service.dart';
import 'package:news/src/theme/tema.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ( _ ) => new NewsService()
        )
      ],
      child: MaterialApp(
        title: 'News App',
        theme: miTema,
        debugShowCheckedModeBanner: false,
        home: TabsPage()
      ),
    );
  }
}