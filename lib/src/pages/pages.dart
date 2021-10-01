import 'package:flutter/material.dart';
import 'package:vazel/src/pages/cart.dart';
import 'package:vazel/src/pages/cotizacion.dart';
import 'package:vazel/src/pages/home.dart';
import 'package:vazel/src/utils/colors.dart';

import 'qr.dart';
// Import the firebase_core and cloud_firestore plugin

class Pages extends StatefulWidget {
  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  final formKey = GlobalKey<FormState>();
  int currentTab = 0;
  String categeoria;
  String cara;
  String asientos;
  String pulgadas;
  String milimetros;
  String elastomeros;
  String partesMetalicas;
  String ruta;

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    Map argumentos = ModalRoute.of(context).settings.arguments;

    if (argumentos != null) {
      categeoria = argumentos["categoria"];
      cara = argumentos["caraRotativa"];
      asientos = argumentos["asientos"];
      pulgadas = argumentos["pulgadas"];
      milimetros = argumentos["milimetros"];
      elastomeros = argumentos["elastomeros"];
      partesMetalicas = argumentos["partesMetalicas"];
      ruta = argumentos["ruta"];
    }

    Widget currentScreen = Home(categeoria, cara, asientos, pulgadas,
        milimetros, elastomeros, partesMetalicas, ruta);

    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: verdeVazel,
        child: Icon(
          Icons.qr_code_scanner_outlined,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                minWidth: 150,
                onPressed: () {
                  setState(() {
                    currentScreen = Home(categeoria, cara, asientos, pulgadas,
                        milimetros, elastomeros, partesMetalicas, ruta);
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      color: currentTab == 0 ? verdeVazel : Colors.grey,
                    ),
                  ],
                ),
              ),
              //Right Tab Bar Icons
              MaterialButton(
                minWidth: 150,
                onPressed: () {
                  // setState(() {
                  //   currentScreen = Cart();
                  //   currentTab = 3;
                  // });
                  Navigator.pushNamed(context, 'cart');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: currentTab == 3 ? verdeVazel : Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
