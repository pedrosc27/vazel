import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vazel/src/utils/colors.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<String> categorias;
  int defaultCategoriaIndex;
  List<String> caraRotativa;
  int defaultCaraRotativaIndex;
  List<String> asientos;
  int defaultAsientosIndex;
  List<String> pulgadas;
  int defaultPulgadasIndex;
  List<String> milimetros;
  int defaultMilimetrosIndex;
  List<String> elastomeros;
  int defaultElastomerosIndex;
  List<String> partesMetalicas;
  int defaultPartesMetalicasIndex;

  @override
  void initState() {
    super.initState();
    defaultCategoriaIndex = 0;
    defaultCaraRotativaIndex = 0;
    defaultAsientosIndex = 0;
    defaultPulgadasIndex = 0;
    defaultMilimetrosIndex = 0;
    defaultElastomerosIndex = 0;
    defaultPartesMetalicasIndex = 0;
    categorias = [
      "Sellos de Monoresorte",
      "Sellos de Semi-Proceso",
      "Sellos de Proceso",
      "Asientos"
    ];
    caraRotativa = [
      "Carbón Grafito",
      "Carburo de Silicio",
      "Carburo de Tungsteno",
      "PTE/Fibra de vidrio",
      "Carbón Grafito FDA",
      "Carbón Fenólico",
      "Acero inoxidable 316"
    ];
    asientos = [
      "Cerámica",
      "Carburo de Silicio",
      "Carburo de Tungsteno",
      "Acero Inoxidable",
      "Ni-Resist"
    ];
    pulgadas = [
      "1/2",
      "5/8",
      "6/8",
      "7/8",
      "15/16",
      "1",
      "1 1/8",
      "1 1/4",
      "1 3/8",
      "1 2/4",
      "1 5/8",
      "1 3/4",
      "1 7/8",
      "2",
      "2 1/8",
      "2 1/4",
      "2 3/8",
      "2 2/4",
      "2 5/8",
      "2 3/4",
      "2 7/8",
      "3",
      "3 1/8",
      "3 1/4",
      "3 3/8",
      "3 2/4",
      "3 5/8",
      "3 3/4",
      "3 7/8",
      "4"
    ];
    milimetros = [
      "10",
      "12",
      "14",
      "15",
      "16",
      "18",
      "19",
      "20",
      "22",
      "24",
      "25",
      "28",
      "30",
      "32",
      "33",
      "35",
      "38",
      "40",
      "42",
      "43",
      "45",
      "48",
      "50",
      "53",
      "55",
      "58",
      "60",
      "65",
      "68",
      "70",
      "75",
      "80",
      "85",
      "90",
      "95",
      "100"
    ];
    elastomeros = [
      "Buna",
      "NBR (Nitrilo®)",
      "FKM (Vitón®)",
      "CR (Neopreno®)",
      "E.P.R (EPDM)",
      "Creavey (PTFE/FKM)",
      "Silicón (VMQ)",
      "Teflón (PTFE)",
      "Aflas (TFE/P)",
      "Kalrez (FFKM)",
      "Grafito exfoliado (Grafoil)",
    ];
    partesMetalicas = [
      "Hastelloy C",
      "Acero inoxidable 304",
      "Acero Inoxidable 316",
      "Aleación AM-350",
      "Latón"
    ];
  }

  @override
  Widget build(BuildContext context) {
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
          "Filtros",
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'NeoMedium',
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Categorias",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  _categorias(categorias),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Cara rotativa",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  _caraRotativa(caraRotativa),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Elastómeros ",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  _elastomeros(elastomeros),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Asientos",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  _asientos(asientos),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Partes Metálicas",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  _partesMetalicas(partesMetalicas),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Pulgadas",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  _pulgadas(pulgadas),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Milímetros ",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  _milimetros(milimetros),
                  SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: Container(
                      width: 380, // <-- match_parent
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          primary: verdeVazel,
                          onPrimary: Colors.white,
                          onSurface: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          "Aplicar Filtros",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'NeoRegular',
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          var cat1;
                          var cara1;
                          var asientos1;
                          var pulgadas1;
                          var milimetros1;
                          var elastomeros1;
                          var partesMetalicas1;

                          if (defaultCategoriaIndex == 0) {
                            cat1 = null;
                          } else {
                            final pruebaCat = defaultCategoriaIndex - 1;
                            cat1 = categorias[pruebaCat];
                          }

                          if (defaultCaraRotativaIndex == 0) {
                            cara1 = null;
                          } else {
                            final pruebaCara = defaultCaraRotativaIndex - 1;
                            cara1 = caraRotativa[pruebaCara];
                          }

                          if (defaultAsientosIndex == 0) {
                            asientos1 = null;
                          } else {
                            final pruebaAsientos = defaultAsientosIndex - 1;
                            asientos1 = asientos[pruebaAsientos];
                          }

                          if (defaultPulgadasIndex == 0) {
                            pulgadas1 = null;
                          } else {
                            final pruebaPulgadas = defaultPulgadasIndex - 1;
                            pulgadas1 = pulgadas[pruebaPulgadas];
                          }

                          if (defaultMilimetrosIndex == 0) {
                            milimetros1 = null;
                          } else {
                            final pruebaMilimetros = defaultMilimetrosIndex - 1;
                            milimetros1 = milimetros[pruebaMilimetros];
                          }

                          if (defaultElastomerosIndex == 0) {
                            elastomeros1 = null;
                          } else {
                            final pruebaElastomeros =
                                defaultElastomerosIndex - 1;
                            elastomeros1 = elastomeros[pruebaElastomeros];
                          }

                          if (defaultPartesMetalicasIndex == 0) {
                            partesMetalicas1 = null;
                          } else {
                            final pruebaPartesMetalicas =
                                defaultPartesMetalicasIndex - 1;
                            partesMetalicas1 =
                                partesMetalicas[pruebaPartesMetalicas];
                          }

                          Navigator.pushNamed(context, 'pages', arguments: {
                            'categoria': cat1,
                            'caraRotativa': cara1,
                            'asientos': asientos1,
                            'pulgadas': pulgadas1,
                            'milimetros': milimetros1,
                            'elastomeros': elastomeros1,
                            'partesMetalicas': partesMetalicas1,
                            'ruta': 'filter',
                          });
                        },
                        // onPressed: () => Navigator.pushNamed(context, 'pages'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _categorias(List<String> categorias) => Container(
        height: 45,
        width: double.infinity,
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categorias.length,
          itemBuilder: (context, index) {
            final producto = categorias[index];
            final _index = index + 1;
            return Container(
              margin: EdgeInsets.only(right: 5),
              child: ChoiceChip(
                label: Text(
                  producto,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                selected: defaultCategoriaIndex == _index,
                selectedColor: verdeVazel,
                onSelected: (bool selected) {
                  setState(() {
                    defaultCategoriaIndex = selected ? _index : 0;
                  });
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: grisVazel, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                    fontSize: 16,
                    color: defaultCategoriaIndex == _index
                        ? Colors.white
                        : Colors.black,
                    fontFamily: 'NeoRegular',
                    fontWeight: FontWeight.w400),
              ),
            );
          },
        ),
      );

  Widget _caraRotativa(List<String> caraRotativa) => Container(
        height: 45,
        width: double.infinity,
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: caraRotativa.length,
          itemBuilder: (context, index) {
            final producto = caraRotativa[index];
            final _index = index + 1;
            return Container(
              margin: EdgeInsets.only(right: 5),
              child: ChoiceChip(
                label: Text(
                  producto,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                selected: defaultCaraRotativaIndex == _index,
                selectedColor: verdeVazel,
                onSelected: (bool selected) {
                  setState(() {
                    defaultCaraRotativaIndex = selected ? _index : 0;
                  });
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: grisVazel, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                    fontSize: 16,
                    color: defaultCaraRotativaIndex == _index
                        ? Colors.white
                        : Colors.black,
                    fontFamily: 'NeoRegular',
                    fontWeight: FontWeight.w400),
              ),
            );
          },
        ),
      );

  Widget _elastomeros(List<String> elastomeros) => Container(
        height: 45,
        width: double.infinity,
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: elastomeros.length,
          itemBuilder: (context, index) {
            final producto = elastomeros[index];
            final _index = index + 1;
            return Container(
              margin: EdgeInsets.only(right: 5),
              child: ChoiceChip(
                label: Text(
                  producto,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                selected: defaultElastomerosIndex == _index,
                selectedColor: verdeVazel,
                onSelected: (bool selected) {
                  setState(() {
                    defaultElastomerosIndex = selected ? _index : 0;
                  });
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: grisVazel, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                    fontSize: 16,
                    color: defaultElastomerosIndex == _index
                        ? Colors.white
                        : Colors.black,
                    fontFamily: 'NeoRegular',
                    fontWeight: FontWeight.w400),
              ),
            );
          },
        ),
      );

  Widget _asientos(List<String> asientos) => Container(
        height: 45,
        width: double.infinity,
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: asientos.length,
          itemBuilder: (context, index) {
            final producto = asientos[index];
            final _index = index + 1;
            return Container(
              margin: EdgeInsets.only(right: 5),
              child: ChoiceChip(
                label: Text(
                  producto,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                selected: defaultAsientosIndex == _index,
                selectedColor: verdeVazel,
                onSelected: (bool selected) {
                  setState(() {
                    defaultAsientosIndex = selected ? _index : 0;
                  });
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: grisVazel, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                    fontSize: 16,
                    color: defaultAsientosIndex == _index
                        ? Colors.white
                        : Colors.black,
                    fontFamily: 'NeoRegular',
                    fontWeight: FontWeight.w400),
              ),
            );
          },
        ),
      );
  Widget _partesMetalicas(List<String> partesMetalicas) => Container(
        height: 45,
        width: double.infinity,
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: partesMetalicas.length,
          itemBuilder: (context, index) {
            final producto = partesMetalicas[index];
            final _index = index + 1;
            return Container(
              margin: EdgeInsets.only(right: 5),
              child: ChoiceChip(
                label: Text(
                  producto,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                selected: defaultPartesMetalicasIndex == _index,
                selectedColor: verdeVazel,
                onSelected: (bool selected) {
                  setState(() {
                    defaultPartesMetalicasIndex = selected ? _index : 0;
                  });
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: grisVazel, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                    fontSize: 16,
                    color: defaultPartesMetalicasIndex == _index
                        ? Colors.white
                        : Colors.black,
                    fontFamily: 'NeoRegular',
                    fontWeight: FontWeight.w400),
              ),
            );
          },
        ),
      );

  Widget _pulgadas(List<String> pulgadas) => Container(
        height: 45,
        width: double.infinity,
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: pulgadas.length,
          itemBuilder: (context, index) {
            final producto = pulgadas[index];
            final _index = index + 1;
            return Container(
              margin: EdgeInsets.only(right: 5),
              child: ChoiceChip(
                label: Text(
                  producto,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                selected: defaultPulgadasIndex == _index,
                selectedColor: verdeVazel,
                onSelected: (bool selected) {
                  setState(() {
                    defaultPulgadasIndex = selected ? _index : 0;
                  });
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: grisVazel, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                    fontSize: 16,
                    color: defaultPulgadasIndex == _index
                        ? Colors.white
                        : Colors.black,
                    fontFamily: 'NeoRegular',
                    fontWeight: FontWeight.w400),
              ),
            );
          },
        ),
      );
  Widget _milimetros(List<String> milimetros) => Container(
        height: 45,
        width: double.infinity,
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: milimetros.length,
          itemBuilder: (context, index) {
            final producto = milimetros[index];
            final _index = index + 1;
            return Container(
              margin: EdgeInsets.only(right: 5),
              child: ChoiceChip(
                label: Text(
                  producto,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                selected: defaultMilimetrosIndex == _index,
                selectedColor: verdeVazel,
                onSelected: (bool selected) {
                  setState(() {
                    defaultMilimetrosIndex = selected ? _index : 0;
                  });
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: grisVazel, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                    fontSize: 16,
                    color: defaultMilimetrosIndex == _index
                        ? Colors.white
                        : Colors.black,
                    fontFamily: 'NeoRegular',
                    fontWeight: FontWeight.w400),
              ),
            );
          },
        ),
      );
}
