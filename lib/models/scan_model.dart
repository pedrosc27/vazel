import 'dart:convert';

import 'package:meta/meta.dart';

final String tableNotes = 'carrito';
ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  ScanModel(
      {this.nombre,
      this.cara,
      this.asientos,
      this.elastomeros,
      this.partesMetalicas,
      this.dimensiones,
      this.cantidad,
      this.id,
      this.imagen});

  String nombre;
  String cara;
  String asientos;
  String elastomeros;
  String partesMetalicas;
  String dimensiones;
  String cantidad;
  int id;
  String imagen;

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
      nombre: json["nombre"],
      cara: json["cara"],
      asientos: json["asientos"],
      elastomeros: json["elastomeros"],
      partesMetalicas: json["partesMetalicas"],
      dimensiones: json["dimensiones"],
      cantidad: json["cantidad"],
      id: json["id"],
      imagen: json["imagen"]);

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "cara": cara,
        "asientos": asientos,
        "elastomeros": elastomeros,
        "partesMetalicas": partesMetalicas,
        "dimensiones": dimensiones,
        "cantidad": cantidad,
        "id": id,
        "imagen": imagen
      };
}
