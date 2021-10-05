import 'package:flutter/material.dart';
import 'package:news/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'package:news/src/services/news_service.dart';

class Tab1Page extends StatefulWidget {
    
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

// Para que el scroll se mantenga al pasar de página
class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {
  
  @override
  Widget build(BuildContext context) {

    final headlines = Provider.of<NewsService>(context).headlines;

    // ListaNoticias( headlines )

    return Scaffold(
      body: ( headlines.length == 0) 
      ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center( child: CircularProgressIndicator( )),
          SizedBox( height: 20),
          Text( 'Cargando ....', style: TextStyle( fontSize: 20) )
        ],
      )
      : ListaNoticias( headlines )
    );
  }

  // Para que el scroll se mantenga al pasar de página
  @override
  bool get wantKeepAlive => true;
}