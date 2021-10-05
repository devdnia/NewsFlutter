import 'package:flutter/material.dart';
import 'package:news/src/theme/tema.dart';
import 'package:provider/provider.dart';

import 'package:news/src/pages/pages.dart';


class TabsPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    //Instancia al provider
    return ChangeNotifierProvider(
      create: ( _ ) => new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      // Opción seleccionada
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      selectedItemColor: miTema.accentColor,
      items: [
 
       BottomNavigationBarItem(icon: Icon( Icons.home ) , label: 'Home' ),
       BottomNavigationBarItem(icon: Icon( Icons.public ) , label: 'Categorias' ),
       
      ]
    );
  }
}

class _Paginas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      // Eliminar corbatura final Android
      // physics: BouncingScrollPhysics(),
      // Bloquear el deslizamiento latereal
      physics: NeverScrollableScrollPhysics(),
      children: [
        
        Tab1Page(),

        Tab2Page()
      ],
    );
  }
}

class _NavegacionModel extends ChangeNotifier{

  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;
  
  set paginaActual( int valor ){
    this._paginaActual = valor;
    _pageController.animateToPage(
      valor, duration: Duration( milliseconds: 350 ), curve: Curves.easeOut );

    notifyListeners();
  }

  PageController get pageController => this._pageController;

}