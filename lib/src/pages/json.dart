import 'package:flutter/material.dart';

import 'package:vazel/model/producto_model.dart';
import 'package:vazel/providers/producto_provider.dart';

class JsonPage extends StatefulWidget {
  @override
  _JsonPage createState() => _JsonPage();
}

class _JsonPage extends State<JsonPage> {
  final api = ProductosApi();

  Widget build(BuildContext context) => Scaffold(
        body: Container(
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
                    return buildUsers(_productos);
                  }
              }
            },
          ),
        ),
      );

  Widget buildUsers(List<Producto> productos) => ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final producto = productos[index];

          return ListTile(
            title: Text(producto.id),
            subtitle: Text(producto.nombre),
          );
        },
      );
}
