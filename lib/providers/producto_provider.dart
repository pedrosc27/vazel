import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:vazel/model/producto_model.dart';

class ProductosApi {
  Future<List<Producto>> readJson() async {
    final response = await rootBundle.loadString('assets/data.json');
    final data = json.decode(response);

    List<Producto> mapa =
        data.map<Producto>((s) => Producto.fromJson(s)).toList();

    mapa = data.map<Producto>((s) => Producto.fromJson(s)).toList();

    return mapa;
  }

  Future<List<Producto>> buscarSello(String query) async {
    final response = await rootBundle.loadString('assets/data.json');
    final data = json.decode(response);
    // print("Data $data");
    List<Producto> mapa =
        data.map<Producto>((s) => Producto.fromJson(s)).toList();
    //print("Mapa $mapa");

    mapa = mapa
        .where(
            (mapa) => (mapa.nombre.toLowerCase().contains(query.toLowerCase())))
        .toList();
    return mapa;
  }
}
