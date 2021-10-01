import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vazel/src/pages/cart.dart';
import 'package:vazel/src/pages/filter.dart';
import 'package:vazel/src/pages/json.dart';
import 'package:vazel/src/pages/page_producto_categoria.dart';
import 'package:vazel/src/pages/pages.dart';
import 'package:vazel/src/pages/producto_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Notes SQLite';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vazel - Sellos Mecanicos',
        theme: ThemeData.light(),
        initialRoute: 'pages',
        routes: {
          'pages': (BuildContext context) => Pages(),
          'producto_page': (BuildContext context) => ProductoPage(),
          'cart': (BuildContext context) => Cart(),
          'filter': (BuildContext context) => Filter(),
          'json': (BuildContext context) => JsonPage(),
          'producto_categoria': (BuildContext context) => ProductoCategoria(),
        },
      );
}
