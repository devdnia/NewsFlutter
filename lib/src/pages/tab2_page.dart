import 'package:flutter/material.dart';
import 'package:news/src/models/category_model.dart';
import 'package:news/src/theme/tema.dart';
import 'package:news/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'package:news/src/services/news_service.dart';

class Tab2Page extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
      
            _ListaCategorias(),

            Expanded(
              child: ListaNoticias( newsService.getArticulosCategoriaSeleccionada! )
            )

          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 90,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {

          final cName = categories[index].name;

          return Container(
            margin: EdgeInsets.only( top: 10, left: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _CategoryButton( categories[index] ),
                  SizedBox( height: 5),
                  Text('${ cName[0].toUpperCase() }${ cName.substring(1) }'),
                ],
              )
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {

  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>( context );

    return GestureDetector(
      onTap: () {
        //print('Pulsando en ${categoria.name}');
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric( horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          categoria.icon,
          color: ( newsService.selectedCategory == this.categoria.name )
          ? miTema.accentColor
          : Colors.black54 ),
      ),
    );
  }
}