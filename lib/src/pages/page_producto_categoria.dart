import 'package:flutter/material.dart';

import 'package:vazel/model/producto_model.dart';
import 'package:vazel/providers/producto_provider.dart';
import 'package:vazel/src/pages/search.dart';

import 'package:vazel/src/utils/colors.dart';

import 'package:vazel/src/widgets/box_producto_home.dart';

class ProductoCategoria extends StatefulWidget {
  @override
  _ProductoCategoria createState() => _ProductoCategoria();
}

class _ProductoCategoria extends State<ProductoCategoria> {
  List productos = [];
  final api = ProductosApi();

  @override
  Widget build(BuildContext context) {
    Map argumentos = ModalRoute.of(context).settings.arguments;

    if (argumentos == null) {
      argumentos = {};
    }
    //var json = jsonDecode(text);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: verdeVazel,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Productos",
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'NeoMedium',
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        color: verdeVazel,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 26,
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
    String producto = "Productos";
    List<Producto> data = productos.toList();
    if (argumentos['ruta'] != null) {
      final categorias = argumentos["categoria"];
      producto = categorias;

      if (categorias != null) {
        data = data
            .where((data) => (data.categoria.contains(categorias)))
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
            producto,
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
}
