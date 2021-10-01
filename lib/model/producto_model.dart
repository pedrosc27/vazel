// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Producto productoFromJson(String str) => Producto.fromJson(json.decode(str));

String productoToJson(Producto data) => json.encode(data.toJson());

class Producto {
  Producto({
    this.id,
    this.nombre,
    this.imagen,
    this.imagenPlano,
    this.imagenMedidas,
    this.descripcion,
    this.tipoMedida,
    this.velocidad,
    this.presion,
    this.tempMin,
    this.temmMax,
    this.ficha,
    this.categoria,
    this.dimensiones,
    this.caraRotativa,
    this.elastomeros,
    this.partesMetalicas,
    this.asientos,
  });

  String id;
  String nombre;
  String imagen;
  String imagenPlano;
  String imagenMedidas;
  String descripcion;
  String tipoMedida;
  int velocidad;
  int presion;
  int tempMin;
  int temmMax;
  String ficha;
  String categoria;
  List<String> dimensiones;
  List<String> caraRotativa;
  List<String> elastomeros;
  List<String> partesMetalicas;
  List<String> asientos;

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json["id"],
        nombre: json["nombre"],
        imagen: json["imagen"],
        imagenPlano: json["imagenPlano"],
        imagenMedidas: json["imagenMedidas"],
        descripcion: json["descripcion"],
        tipoMedida: json["tipoMedida"],
        velocidad: json["velocidad"],
        presion: json["presion"],
        tempMin: json["tempMin"],
        temmMax: json["temmMax"],
        ficha: json["ficha"],
        categoria: json["categoria"],
        dimensiones: List<String>.from(json["dimensiones"].map((x) => x)),
        caraRotativa: List<String>.from(json["caraRotativa"].map((x) => x)),
        elastomeros: List<String>.from(json["elastomeros"].map((x) => x)),
        partesMetalicas:
            List<String>.from(json["partesMetalicas"].map((x) => x)),
        asientos: List<String>.from(json["asientos"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "imagen": imagen,
        "imagenPlano": imagenPlano,
        "imagenMedidas": imagenMedidas,
        "descripcion": descripcion,
        "tipoMedida": tipoMedida,
        "velocidad": velocidad,
        "presion": presion,
        "tempMin": tempMin,
        "temmMax": temmMax,
        "ficha": ficha,
        "categoria": categoria,
        "dimensiones": List<dynamic>.from(dimensiones.map((x) => x)),
        "caraRotativa": List<dynamic>.from(caraRotativa.map((x) => x)),
        "elastomeros": List<dynamic>.from(elastomeros.map((x) => x)),
        "partesMetalicas": List<dynamic>.from(partesMetalicas.map((x) => x)),
        "asientos": List<dynamic>.from(asientos.map((x) => x)),
      };
}
