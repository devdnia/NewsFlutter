import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:news/src/models/category_model.dart';

import 'package:news/src/models/news_models.dart';

final _urlNews = 'https://newsapi.org/v2';
final _apiKey   = '4c0f16384b2b4571a9ff90dea021632a';

class NewsService extends ChangeNotifier{

  List<Article> headlines = [];

  String _selectedCategory = 'business';

  List<Category> categories = [
    Category( FontAwesomeIcons.building, 'business'),
    Category( FontAwesomeIcons.tv, 'entertainment'),
    Category( FontAwesomeIcons.addressCard, 'general'),
    Category( FontAwesomeIcons.headSideVirus, 'health'),
    Category( FontAwesomeIcons.vials, 'science'),
    Category( FontAwesomeIcons.volleyballBall, 'sports'),
    Category( FontAwesomeIcons.memory, 'technology')
  ];


  Map<String, List<Article>> categoryArticles ={};
  

  NewsService(){
    this.getToHeadlines();
    
    categories.forEach(( item) { 
      this.categoryArticles[ item.name ] = [];
    });

  }
  
  String get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor ){
    this._selectedCategory = valor;

    this.getArticlesByCategory( valor );

    notifyListeners();
  }

List<Article>? get getArticulosCategoriaSeleccionada => this.categoryArticles[ this.selectedCategory ];

  getToHeadlines() async {
    
    final url  = '$_urlNews/top-headlines?apiKey=$_apiKey&country=ar';
    final resp = await http.get( Uri.parse( url ) );

    final newsResponse = newsResponseFromJson( resp.body );

    this.headlines.addAll( newsResponse.articles );
    notifyListeners();
  }

  getArticlesByCategory( String category ) async{

    // No insertar duplicados devuelvo ya el listado
    if ( this.categoryArticles[ category ]!.length > 0){
      return this.categoryArticles[ category ];
    }

    final url  = '$_urlNews/top-headlines?apiKey=$_apiKey&country=ar&category=$category';
    final resp = await http.get( Uri.parse( url ) );

    final newsResponse = newsResponseFromJson( resp.body );

    this.categoryArticles[category]!.addAll( newsResponse.articles );

    notifyListeners();
  }


}