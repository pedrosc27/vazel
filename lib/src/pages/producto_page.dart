import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vazel/db/vazel_db.dart';
import 'package:vazel/models/scan_model.dart';

import 'package:vazel/src/utils/colors.dart';

import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List cotizaciones = [];
  final _formKey = GlobalKey<FormState>();
  int defaultCategoriaIndex;
  int defaultElastomerosIndex;
  int defaultPartesMetalicasIndex;
  int defaultAsientosIndex;
  int defaultDimensionesIndex;
  String cantidad;
  String nombre;
  String imagen;
  String descripcion;
  String tipoMedida;
  String categoria;
  int velocidad;
  int presion;
  int tempMin;
  int temmMax;
  List<String> caraRotativa;
  List<String> elastomeros;
  List<String> partesMetalicas;
  List<String> asientos;
  List<String> dimensiones;
  String imagenMedidas;
  String imagenPlano;
  String imagenActual;
  bool imagenBool = false;
  String ficha;
  String alligator;
  @override
  void initState() {
    super.initState();
    imagenActual = "";
    defaultCategoriaIndex = 0;
    defaultElastomerosIndex = 0;
    defaultPartesMetalicasIndex = 0;
    defaultAsientosIndex = 0;
    defaultDimensionesIndex = 0;
    caraRotativa = [];
    elastomeros = [];
    partesMetalicas = [];
    asientos = [];
    dimensiones = [];
  }

  @override
  Widget build(BuildContext context) {
    cantidad = "1";
    Map argumentos = ModalRoute.of(context).settings.arguments;
    nombre = argumentos['nombre'];
    imagen = argumentos['imagen'];
    descripcion = argumentos['descripcion'];

    dimensiones = argumentos['dimensiones'];
    tipoMedida = argumentos['tipo_medida'];
    velocidad = argumentos['velocidad'];
    presion = argumentos['presion'];
    tempMin = argumentos['tempMin'];
    temmMax = argumentos['temmMax'];
    categoria = argumentos['categoria'];
    imagenMedidas = argumentos['imagenDimensiones'];
    imagenPlano = argumentos['imagenPlano'];
    if (imagenBool == false) {
      imagenActual = imagen;
    }
    ficha = argumentos['ficha'];
    alligator = "hola";

    caraRotativa = argumentos['cara_rotativa'];
    elastomeros = argumentos['elastomeros'];
    partesMetalicas = argumentos['partes_metalicas'];
    asientos = argumentos['asientos'];

    double fullWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: verdeVazel,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: grisVazel,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: verdeVazel,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              size: 20,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            share(context, ficha);
                          },
                          child: Container(
                              child: Icon(
                            Icons.share,
                            color: Colors.black,
                          )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: fullWidth,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: InteractiveViewer(
                            child: Image.asset(
                              imagenActual,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Container(
                            width: fullWidth * 0.8,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        imagenActual = imagen;
                                        imagenBool = true;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 15),
                                      width: 48,
                                      height: 48,
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(
                                        imagen,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        imagenActual = imagenPlano;
                                        imagenBool = true;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 15),
                                      width: 48,
                                      height: 48,
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(imagenPlano),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        imagenActual = imagenMedidas;
                                        imagenBool = true;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 15),
                                      width: 48,
                                      height: 48,
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(imagenMedidas),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      width: fullWidth,
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(25.0),
                            topRight: const Radius.circular(25.0),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24,
                          ),
                          Text(categoria,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: verdeVazel,
                                  fontFamily: 'NeoRegular',
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  nombre,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontFamily: 'NeoMedium',
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              InkWell(
                                onTap: () => launch(ficha),
                                child: Row(
                                  children: [
                                    Text("Descargar Ficha Técnica: ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: verdeVazel,
                                            fontFamily: 'NeoRegular',
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                        'assets/images/download-pdf.png',
                                        width: 26,
                                        height: 26,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            descripcion,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'NeoRegular',
                                fontWeight: FontWeight.w400),
                          ),
                          _ifCara(caraRotativa.length),
                          _ifElastomeros(elastomeros.length),
                          _ifPartesMetalicas(partesMetalicas.length),
                          _ifAsientos(asientos.length),
                          SizedBox(
                            height: 10,
                          ),
                          Text(tipoMedida,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'NeoRegular',
                                  color: Color(0xFF8F8F8F),
                                  fontWeight: FontWeight.w400)),
                          _dimensiones(dimensiones),
                          SizedBox(
                            height: 24,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: grisVazel,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.asset(
                                            'assets/images/delay.png'),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Velocidad',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'NeoRegular',
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            velocidad.toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'NeoRegular',
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: grisVazel,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.asset(
                                            'assets/images/pressure-gauge.png'),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Presión',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'NeoRegular',
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            '${presion.toString()} PSI',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'NeoRegular',
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: grisVazel,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.asset(
                                            'assets/images/thermometer.png'),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Temperatura',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'NeoRegular',
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            '${tempMin.toString()}° a ${temmMax.toString()}°',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'NeoRegular',
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: grisVazel),
                                      shape: BoxShape.rectangle,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        initialValue: cantidad,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontFamily: 'NeoRegular',
                                            fontWeight: FontWeight.w400),
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                        onSaved: (value) => cantidad = value,
                                        validator: numberValidator,
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(15),
                                      primary: verdeVazel,
                                      onPrimary: Colors.white,
                                      onSurface: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.shopping_cart),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Añadir a la Cotización ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    onPressed: () async {
                                      _submit();
                                    }

                                    //Navigator.pushNamed(context, 'home'),
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String numberValidator(String value) {
    if (value == null) {
      return null;
    }
    final n = num.tryParse(value);
    if (n == null) {
      _mostrarSnackbar('Por favor ingresa una cantidad valida (solo numeros)');
      return '';
    }
    return null;
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    // print(cantidad);

    String _cara;
    String _asientos;
    String _elastomeros;
    String _partesMetalicas;
    String _dimensiones = dimensiones[defaultDimensionesIndex];

    if (caraRotativa.isEmpty) {
      _cara = "No aplica";
    } else {
      _cara = caraRotativa[defaultCategoriaIndex];
    }

    if (asientos.isEmpty) {
      _asientos = "No aplica";
    } else {
      _asientos = asientos[defaultAsientosIndex];
    }

    if (elastomeros.isEmpty) {
      _elastomeros = "No aplica";
    } else {
      _elastomeros = elastomeros[defaultElastomerosIndex];
    }

    if (partesMetalicas.isEmpty) {
      _partesMetalicas = "No aplica";
    } else {
      _partesMetalicas = partesMetalicas[defaultPartesMetalicasIndex];
    }

    final note = ScanModel(
        nombre: nombre,
        cara: _cara,
        asientos: _asientos,
        elastomeros: _elastomeros,
        partesMetalicas: _partesMetalicas,
        dimensiones: _dimensiones,
        cantidad: cantidad,
        imagen: imagen);

    final respuesta = await NotesDatabase.instance.create(note);

    _mostrarSnackbar('Se añadió correctamente al Carrito');
  }

  void _mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 3500),
    );

    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _ifCara(int valor) {
    if (valor == 0) {
      return Container();
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text('Cara rotativa: ',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'NeoRegular',
                  color: Color(0xFF8F8F8F),
                  fontWeight: FontWeight.w400)),
          _caraRotativa(caraRotativa),
        ],
      );
    }
  }

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
                selected: defaultCategoriaIndex == index,
                selectedColor: verdeVazel,
                onSelected: (bool selected) {
                  setState(() {
                    defaultCategoriaIndex = selected ? index : 0;
                  });
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: grisVazel, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                    fontSize: 16,
                    color: defaultCategoriaIndex == index
                        ? Colors.white
                        : Colors.black,
                    fontFamily: 'NeoRegular',
                    fontWeight: FontWeight.w400),
              ),
            );
          },
        ),
      );

  Widget _ifElastomeros(int valor) {
    if (valor == 0) {
      return Container();
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text('Elastómeros: ',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'NeoRegular',
                  color: Color(0xFF8F8F8F),
                  fontWeight: FontWeight.w400)),
          _elastomeros(elastomeros),
        ],
      );
    }
  }

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
                selected: defaultElastomerosIndex == index,
                selectedColor: verdeVazel,
                onSelected: (bool selected) {
                  setState(() {
                    defaultElastomerosIndex = selected ? index : 0;
                  });
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: grisVazel, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                    fontSize: 16,
                    color: defaultElastomerosIndex == index
                        ? Colors.white
                        : Colors.black,
                    fontFamily: 'NeoRegular',
                    fontWeight: FontWeight.w400),
              ),
            );
          },
        ),
      );

  Widget _ifPartesMetalicas(int valor) {
    print('Valor: $valor');
    if (valor == 0) {
      return Container();
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text('Partes Metalicas: ',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'NeoRegular',
                  color: Color(0xFF8F8F8F),
                  fontWeight: FontWeight.w400)),
          _partesMetalicas(partesMetalicas),
        ],
      );
    }
  }

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
                selected: defaultPartesMetalicasIndex == index,
                selectedColor: verdeVazel,
                onSelected: (bool selected) {
                  setState(() {
                    defaultPartesMetalicasIndex = selected ? index : 0;
                  });
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: grisVazel, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                    fontSize: 16,
                    color: defaultPartesMetalicasIndex == index
                        ? Colors.white
                        : Colors.black,
                    fontFamily: 'NeoRegular',
                    fontWeight: FontWeight.w400),
              ),
            );
          },
        ),
      );

  Widget _ifAsientos(int valor) {
    print('Valor: $valor');
    if (valor == 0) {
      return Container();
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text('Asientos: ',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'NeoRegular',
                  color: Color(0xFF8F8F8F),
                  fontWeight: FontWeight.w400)),
          _asientos(asientos),
        ],
      );
    }
  }

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
                selected: defaultAsientosIndex == index,
                selectedColor: verdeVazel,
                onSelected: (bool selected) {
                  setState(() {
                    defaultAsientosIndex = selected ? index : 0;
                  });
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: grisVazel, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                    fontSize: 16,
                    color: defaultAsientosIndex == index
                        ? Colors.white
                        : Colors.black,
                    fontFamily: 'NeoRegular',
                    fontWeight: FontWeight.w400),
              ),
            );
          },
        ),
      );

  Widget _dimensiones(List<String> dimensiones) => Container(
        height: 45,
        width: double.infinity,
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: dimensiones.length,
          itemBuilder: (context, index) {
            final producto = dimensiones[index];
            final _index = index + 1;
            return Container(
              margin: EdgeInsets.only(right: 5),
              child: ChoiceChip(
                label: Text(
                  producto,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                selected: defaultDimensionesIndex == index,
                selectedColor: verdeVazel,
                onSelected: (bool selected) {
                  setState(() {
                    defaultDimensionesIndex = selected ? index : 0;
                  });
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: grisVazel, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                    fontSize: 16,
                    color: defaultDimensionesIndex == index
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

void share(BuildContext context, alligator) {
  final RenderBox box = context.findRenderObject();
  final String text = alligator;
  Share.share(text,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}
