import 'package:flutter/material.dart';

import 'package:vazel/db/vazel_db.dart';
import 'package:vazel/models/scan_model.dart';

import 'package:vazel/src/utils/colors.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String nombre;
  String telefono;
  String correo;
  String comentario;
  final myNotifier = ValueNotifier<bool>(false);

  void _onPressed() {
    myNotifier.value = true;
  }

  List<ScanModel> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
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
          "Carrito",
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'NeoMedium',
              fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: verdeVazel,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        icon: Icon(Icons.shopping_cart),
        onPressed: () {
          _modalCorreo(context);
        },
        label: Text(
          "Cotizar Productos",
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      key: _scaffoldKey,
      body: Container(
        color: verdeVazel,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : notes.isEmpty
                      ? Container()
                      : _carrito(),
            ),
          ),
        )),
      ),
    );
  }

  _carrito() {
    double alto = 20;
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: notes.length,
            itemBuilder: (_, i) {
              final _scan = notes[i];

              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  padding: EdgeInsets.only(left: 10),
                  color: Colors.red,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                onDismissed: (DismissDirection direction) async {
                  final respuesta = await NotesDatabase.instance.delete(
                    _scan.id,
                  );
                  _mostrarSnackbar('Producto eliminado del Carrito');
                  refreshNotes();
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          width: 100,
                          height: 100,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: grisVazel,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(_scan.imagen),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              _scan.nombre,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontFamily: 'NeoMedium',
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            _tipoDeSello(_scan),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Container(
                                    width: 36,
                                    height: 36,
                                    padding: EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                      color: grisVazel,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: IconButton(
                                        iconSize: 14,
                                        icon: Icon(Icons.remove),
                                        onPressed: () async {
                                          final n =
                                              num.tryParse(_scan.cantidad);
                                          if (n > 1) {
                                            final n2 = n - 1;
                                            _scan.cantidad = n2.toString();
                                            final respuesta =
                                                await NotesDatabase.instance
                                                    .update(
                                              _scan,
                                            );
                                            setState(() {
                                              _scan.cantidad = n2.toString();
                                            });
                                          }
                                        })),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(_scan.cantidad,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'NeoMedium',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                    width: 36,
                                    height: 36,
                                    padding: EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                      color: verdeVazel,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: IconButton(
                                        color: Colors.white,
                                        iconSize: 14,
                                        icon: Icon(Icons.add),
                                        onPressed: () async {
                                          final n =
                                              num.tryParse(_scan.cantidad);
                                          final int n2 = n + 1;
                                          _scan.cantidad = n2.toString();
                                          final respuesta = await NotesDatabase
                                              .instance
                                              .update(
                                            _scan,
                                          );
                                          setState(() {
                                            _scan.cantidad = n2.toString();
                                          });
                                        })),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: alto,
          ),
          SizedBox(
            height: 44,
          )
        ],
      ),
    );
  }

  Widget _tipoDeSello(ScanModel scanModel) {
    if (scanModel.cara == "No aplica") {
      return Container(
        constraints: BoxConstraints(maxWidth: 230),
        child: Text(
            '${scanModel.asientos}, ${scanModel.elastomeros}, ${scanModel.dimensiones}',
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'NeoMedium',
                color: Color(0xFF8F8F8F),
                fontWeight: FontWeight.w400)),
      );
    } else {
      return Container(
        constraints: BoxConstraints(maxWidth: 230),
        child: Text(
            '${scanModel.cara}, ${scanModel.asientos}, ${scanModel.elastomeros},',
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'NeoMedium',
                color: Color(0xFF8F8F8F),
                fontWeight: FontWeight.w400)),
      );
    }
  }

  _modalCorreo(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        builder: (BuildContext bc) {
          return StatefulBuilder(// this is new
              builder: (BuildContext context, StateSetter setState) {
            return ListView(
              children: [
                new Container(
                  color: Color(0xFF737373),

                  //could change this to Color(0xFF737373),
                  //so you don't have to change MaterialApp canvasColor
                  child: Container(
                    decoration: new BoxDecoration(
                        color: Color(0XFFEFF1F3),
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(15.0),
                            topRight: const Radius.circular(15.0))),
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text('NOMBRE: ',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'NeoMedium',
                                color: Color(0xFF8F8F8F),
                                fontWeight: FontWeight.w400)),
                        SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _crearNombreProyecto(),
                              SizedBox(
                                height: 25,
                              ),
                              Text('CORREO: ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'NeoMedium',
                                      color: Color(0xFF8F8F8F),
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                height: 10,
                              ),
                              _crearCorreo(),
                              SizedBox(
                                height: 25,
                              ),
                              Text('TELEFONO: ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'NeoMedium',
                                      color: Color(0xFF8F8F8F),
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                height: 10,
                              ),
                              _crearTelefono(),
                              SizedBox(
                                height: 25,
                              ),
                              Text('COMENTARIO: ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'NeoMedium',
                                      color: Color(0xFF8F8F8F),
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                height: 10,
                              ),
                              _crearComentario(),
                              SizedBox(
                                height: 25,
                              ),
                              Center(
                                  child: Container(
                                width: 300, // <-- match_parent
                                child: ValueListenableBuilder<bool>(
                                    valueListenable: myNotifier,
                                    builder: (context, value, child) {
                                      return ElevatedButton(
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
                                        child: Text(
                                          value
                                              ? "Cotización solicitada"
                                              : "Enviar",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        onPressed: (value) ? null : _submit,
                                      );
                                    }),
                              )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }

  Widget _crearNombreProyecto() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 3, bottom: 3),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onSaved: (value) => nombre = value,
        validator: (value) {
          if (value.isEmpty) {
            return 'Este campo no puede estar vacío ';
          }
          return null;
        },
      ),
    );
  }

  Widget _crearCorreo() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 3, bottom: 3),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onSaved: (value) => correo = value,
        validator: (value) {
          if (value.isEmpty) {
            return 'Este campo no puede estar vacío ';
          }
          return null;
        },
      ),
    );
  }

  Widget _crearTelefono() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 3, bottom: 3),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onSaved: (value) => telefono = value,
        validator: (value) {
          if (value.isEmpty) {
            return 'Este campo no puede estar vacío ';
          }
          return null;
        },
      ),
    );
  }

  Widget _crearComentario() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 3, bottom: 3),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        maxLines: 9,
        minLines: 7,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onSaved: (value) => comentario = value,
      ),
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    //_onPressed();
    Navigator.pop(context);
    _mostrarSnackbar('Se solícito la cotización correctamente');
  }

  void _mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 2000),
    );

    _scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
