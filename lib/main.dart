import 'package:ecom/screen/main_screen.dart';
import 'package:ecom/screen/product_detail_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  // Using route object for navigation
  final app = MaterialApp(
    theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary)),
    home: MainScreen(),
  );

  // Using route name for navigation
  /*final app = MaterialApp(
    routes: {
      '/': (context) => MainScreen(),
      '/checkOutSummarry': (context) => CheckOutSummaryScreen(),
      '/productDetail': (context) => ProductDetailScreen()
    },
    initialRoute: '/',
  );*/

  runApp(app);
}
