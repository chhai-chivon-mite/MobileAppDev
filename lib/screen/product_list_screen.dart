import 'dart:convert';

import 'package:ecom/model/product.dart';
import 'package:ecom/utlity/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<ProductListScreen> {
  List<Product> products;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadProductList().then((products) {
      setState(() {
        this.products = products;
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
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

  Future<List<Product>> loadProductList() async {
    final url = 'http://localhost/test/ruppmad-api/products.php';
    final response = await get(url);
    if (response.statusCode != 200) {
      return null;
    }

    final jsonArray = jsonDecode(response.body);
    return (jsonArray as List).map((jsonObject) {
      return Product.fromJson(jsonObject);
    }).toList();
  }
}
