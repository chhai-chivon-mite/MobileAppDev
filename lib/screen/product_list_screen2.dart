import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/model/product.dart';
import 'package:ecom/utlity/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductListScreen2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<ProductListScreen2> {
  List<Product> products;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Load one-time data from Firestore
    /*final firestore = FirebaseFirestore.instance;
    firestore.collection('products').get().then((querySnapshot){
      final products = querySnapshot.docs.map((queryDocumentSnapshot) {
        return Product.fromJson(queryDocumentSnapshot.data());
      }).toList();
      setState(() {
        this.products = products;
        isLoading = false;
      });
    });*/

    // Load realtime data from Firestore
    final firestore = FirebaseFirestore.instance;
    firestore.collection('products').snapshots().listen((querySnapshot) {
      print('Products changed');
      final products = querySnapshot.docs.map((queryDocumentSnapshot) {
        return Product.fromJson(queryDocumentSnapshot.data());
      }).toList();
      setState(() {
        this.products = products;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: body(),
    );
  }

  Widget body() {
    if (isLoading) {
      return Utils.progressIndicator();
    }

    if (products == null) {
      return Center(
        child: Text('Error while loading data from server.'),
      );
    }

    if (products.isEmpty) {
      return Center(
        child: Text('Empty'),
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      children: products.map((product) {
        return Utils.productItemWidget(context, product);
      }).toList(),
    );
  }
}
