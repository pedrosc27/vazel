import 'package:flutter/material.dart';
import 'package:vazel/model/producto_model.dart';
import 'package:vazel/providers/producto_provider.dart';
import 'package:vazel/src/utils/colors.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';

  final peliculasProvider = new ProductosApi();

  final peliculas = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam',
    'Ironman',
    'Capitan America',
    'Ironman 2',
    'Superman '
  ];
  final peliculasRecientes = ['Spiderman', 'Capitan America'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestra Appbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izqiuerda del Appbar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crear los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  String get searchFieldLabel => 'Buscar...';

  @override
  TextStyle get searchFieldStyle => TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontFamily: 'NeoRegular',
      fontWeight: FontWeight.w600);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: verdeVazel,
      primaryIconTheme: IconThemeData(
        color: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle:
            Theme.of(context).textTheme.title.copyWith(color: Colors.white),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: 'NeoRegular',
            fontWeight: FontWeight.w600),
      ),
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Son las sugerencias que aparecen cuando la persona escribe

  //   final listaSugerida = (query.isEmpty
  //       ? peliculasRecientes
  //       : peliculas
  //           .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
  //           .toList());
  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[i]),
  //         onTap: () {
  //           seleccion = listaSugerida[i];
  //           showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarSello(query),
      builder: (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
              children: peliculas.map((pelicula) {
            return ListTile(
              leading: Image.asset(
                pelicula.imagen,
                width: 50,
              ),
              title: Text(pelicula.nombre,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'NeoRegular',
                      fontWeight: FontWeight.w600)),
              //subtitle: Text(pelicula.originalTitle),
              onTap: () {
                Navigator.pushNamed(context, 'producto_page', arguments: {
                  'nombre': pelicula.nombre,
                  'imagen': pelicula.imagen,
                  'descripcion': pelicula.descripcion,
                  'cara_rotativa': pelicula.caraRotativa,
                  'elastomeros': pelicula.elastomeros,
                  'partes_metalicas': pelicula.partesMetalicas,
                  'asientos': pelicula.asientos,
                  'dimensiones': pelicula.dimensiones,
                  'tipo_medida': pelicula.tipoMedida,
                  'velocidad': pelicula.velocidad,
                  'presion': pelicula.presion,
                  'tempMin': pelicula.tempMin,
                  'temmMax': pelicula.temmMax,
                  'categoria': pelicula.categoria,
                  'imagenPlano': pelicula.imagenPlano,
                  'imagenDimensiones': pelicula.imagenMedidas,
                  'ficha': pelicula.ficha,
                });
              },
            );
          }).toList());
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
