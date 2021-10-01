import 'package:flutter/material.dart';
import 'package:vazel/src/utils/colors.dart';

class BoxProductoHome extends StatelessWidget {
  final String id;
  final String nombre;
  final String imagen;

  final String descripcion;
  final String tipoMedida;
  final String categoria;
  final int velocidad;
  final int presion;
  final int tempMin;
  final int temmMax;
  final List<String> caraRotativa;
  final List<String> elastomeros;
  final List<String> partesMetalicas;
  final List<String> asientos;
  final List<String> dimensiones;
  final String imagenMedidas;
  final String imagenPlano;
  final String ficha;

  const BoxProductoHome(
      this.id,
      this.nombre,
      this.imagen,
      this.descripcion,
      this.caraRotativa,
      this.elastomeros,
      this.partesMetalicas,
      this.asientos,
      this.dimensiones,
      this.tipoMedida,
      this.velocidad,
      this.presion,
      this.tempMin,
      this.temmMax,
      this.categoria,
      this.imagenMedidas,
      this.imagenPlano,
      this.ficha);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'producto_page', arguments: {
          'nombre': nombre,
          'imagen': imagen,
          'descripcion': descripcion,
          'cara_rotativa': caraRotativa,
          'elastomeros': elastomeros,
          'partes_metalicas': partesMetalicas,
          'asientos': asientos,
          'dimensiones': dimensiones,
          'tipo_medida': tipoMedida,
          'velocidad': velocidad,
          'presion': presion,
          'tempMin': tempMin,
          'temmMax': temmMax,
          'categoria': categoria,
          'imagenPlano': imagenPlano,
          'imagenDimensiones': imagenMedidas,
          'ficha': ficha,
        });
      },
      child: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imagen,
                    width: 140,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    nombre,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            // Positioned(
            //   child: Container(
            //     padding: EdgeInsets.all(5),
            //     decoration: BoxDecoration(
            //         color: verdeVazel,
            //         borderRadius: BorderRadius.only(
            //             topLeft: const Radius.circular(5.0),
            //             topRight: const Radius.circular(5.0),
            //             bottomLeft: const Radius.circular(5.0),
            //             bottomRight: const Radius.circular(15.0))),
            //     child: Icon(
            //       Icons.add_shopping_cart_outlined,
            //       color: Colors.white,
            //       size: 20,
            //     ),
            //   ),
            //   bottom: 0.0,
            //   right: 0.0,
            // )
          ],
        ),
        decoration: BoxDecoration(
            color: grisVazel, borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
