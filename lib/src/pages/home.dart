import 'package:flutter/material.dart';

import 'package:vazel/model/producto_model.dart';
import 'package:vazel/providers/producto_provider.dart';
import 'package:vazel/src/pages/search.dart';

import 'package:vazel/src/utils/colors.dart';

import 'package:vazel/src/widgets/box_producto_home.dart';

class Home extends StatefulWidget {
  final String categeoria;
  final String cara;
  final String asientos;
  final String pulgadas;
  final String milimetros;
  final String elastomeros;
  final String partesMetalicas;
  final String ruta;

  const Home(this.categeoria, this.cara, this.asientos, this.pulgadas,
      this.milimetros, this.elastomeros, this.partesMetalicas, this.ruta);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List productos = [];
  final api = ProductosApi();

  @override
  Widget build(BuildContext context) {
    final Map argumentos = {
      "categoria": widget.categeoria,
      "caraRotativa": widget.cara,
      "asientos": widget.asientos,
      "pulgadas": widget.pulgadas,
      "milimetros": widget.milimetros,
      "elastomeros": widget.elastomeros,
      "partesMetalicas": widget.partesMetalicas,
      "filter": widget.ruta,
    };

    //var json = jsonDecode(text);
    return Scaffold(
      body: Container(
        color: verdeVazel,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Widget de Texto de Bienvenida y Boton de Menu
                  _cabecera(),

                  //Widget de busqueda y boton de filtros
                  _buscar(),
                  SizedBox(
                    height: 26,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      "Categorías",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'NeoMedium',
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _categoriasPrincipales(),
                  SizedBox(
                    height: 25,
                  ),
                  _productosJson(argumentos),
                  SizedBox(
                    height: 24,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _cabecera() {
    return Container(
      padding: EdgeInsets.only(top: 16, bottom: 26, right: 16, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'assets/images/vazel-logo-215x81.png',
            width: 120,
          ),
          GestureDetector(
              onTap: () {
                print('Drawer Tapped!');
              },
              child: Icon(
                Icons.menu,
                color: Colors.black,
                size: 40,
              )),
        ],
      ),
    );
  }

  _buscar() {
    return InkWell(
      onTap: () {
        showSearch(
          context: context, delegate: DataSearch(),
          //query: 'hola'
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Container(
              height: 65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 8),
                    width: 280,
                    height: 65,
                    decoration: BoxDecoration(
                        color: grisVazel,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(15)),
                          child: Icon(
                            Icons.search,
                            color: gris,
                            size: 25,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 0,
                            ),
                            Text(
                              "Buscar sello mecanico",
                              style: TextStyle(
                                  fontFamily: 'NeoRegular',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: gris),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'filter');
                    },
                    child: Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                          color: verdeVazel,
                          borderRadius: BorderRadius.circular(15)),
                      padding: EdgeInsets.all(8),
                      child: IconButton(
                        icon: Image.asset('assets/images/filter.png'),
                        iconSize: 90,
                        onPressed: () {
                          Navigator.pushNamed(context, 'filter');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _productosJson(Map argumentos) {
    return Container(
      child: FutureBuilder<List<Producto>>(
        future: api.readJson(),
        builder: (context, snapshot) {
          final _productos = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Some error occurred!'));
              } else {
                return _homeProductos(_productos, argumentos);
              }
          }
        },
      ),
    );
  }

  _homeProductos(List<Producto> productos, Map argumentos) {
    double fullWidth = MediaQuery.of(context).size.width;

    List<Producto> data = productos.toList();

    if (argumentos['filter'] != null) {
      final categorias = argumentos["categoria"];
      final caraRotativa = argumentos["caraRotativa"];
      final asientos = argumentos["asientos"];
      final pulgadas = argumentos["pulgadas"];
      final milimetros = argumentos["milimetros"];
      final elastomeros = argumentos["elastomeros"];
      final partesMetalicas = argumentos["partesMetalicas"];

      if (categorias != null) {
        data = data
            .where((data) => (data.categoria.contains(categorias)))
            .toList();
      }
      if (caraRotativa != null) {
        data = data
            .where((data) => (data.caraRotativa.contains(caraRotativa)))
            .toList();
      }
      if (asientos != null) {
        data =
            data.where((data) => (data.asientos.contains(asientos))).toList();
      }
      if (pulgadas != null) {
        data = data
            .where((data) => (data.dimensiones.contains(pulgadas)))
            .toList();
      }
      if (milimetros != null) {
        data = data
            .where((data) => (data.dimensiones.contains(milimetros)))
            .toList();
      }
      if (elastomeros != null) {
        data = data
            .where((data) => (data.elastomeros.contains(elastomeros)))
            .toList();
      }
      if (partesMetalicas != null) {
        data = data
            .where((data) => (data.partesMetalicas.contains(partesMetalicas)))
            .toList();
      }
    }

    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      width: fullWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Productos",
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontFamily: 'NeoMedium',
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 25,
          ),
          GridView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 350,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            children: data
                .map((item) => BoxProductoHome(
                    item.id,
                    item.nombre,
                    item.imagen,
                    item.descripcion,
                    item.caraRotativa,
                    item.elastomeros,
                    item.partesMetalicas,
                    item.asientos,
                    item.dimensiones,
                    item.tipoMedida,
                    item.velocidad,
                    item.presion,
                    item.tempMin,
                    item.temmMax,
                    item.categoria,
                    item.imagenMedidas,
                    item.imagenPlano,
                    item.ficha))
                .toList(),
          ),
        ],
      ),
    );
  }

  _categoriasPrincipales() {
    double fullWidth = MediaQuery.of(context).size.width;
    return Container(
        width: fullWidth,
        height: 150,
        padding: EdgeInsets.only(left: 16, right: 16),
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'producto_categoria', arguments: {
                  'categoria': "Sellos de Monoresorte",
                  'caraRotativa': null,
                  'asientos': null,
                  'pulgadas': null,
                  'milimetros': null,
                  'elastomeros': null,
                  'partesMetalicas': null,
                  'ruta': 'categorias',
                });
              },
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                    color: grisVazel, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/sellos/armados/monoresorte-armado.png",
                      width: 100,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Monoresorte",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'NeoRegular',
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 11,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'producto_categoria', arguments: {
                  'categoria': "Sellos de Semi-Proceso",
                  'caraRotativa': null,
                  'asientos': null,
                  'pulgadas': null,
                  'milimetros': null,
                  'elastomeros': null,
                  'partesMetalicas': null,
                  'ruta': 'categorias',
                });
              },
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                    color: grisVazel, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/sellos/armados/semiproceso-armado.png",
                      width: 100,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Semi-Proceso",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'NeoRegular',
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 11,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'producto_categoria', arguments: {
                  'categoria': "Sellos de Proceso",
                  'caraRotativa': null,
                  'asientos': null,
                  'pulgadas': null,
                  'milimetros': null,
                  'elastomeros': null,
                  'partesMetalicas': null,
                  'ruta': 'categorias',
                });
              },
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                    color: grisVazel, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        "assets/sellos/armados/proceso-armado.png",
                        width: 100,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Proceso",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'NeoRegular',
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 11,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'producto_categoria', arguments: {
                  'categoria': "Asientos",
                  'caraRotativa': null,
                  'asientos': null,
                  'pulgadas': null,
                  'milimetros': null,
                  'elastomeros': null,
                  'partesMetalicas': null,
                  'ruta': 'categorias',
                });
              },
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                    color: grisVazel, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        "assets/sellos/armados/asientos-armado.png",
                        width: 100,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Asientos",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'NeoRegular',
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
