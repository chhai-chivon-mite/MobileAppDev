import 'package:ecom/model/product.dart';
import 'package:ecom/utlity/utils.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen(this.product);

  @override
  Widget build(BuildContext context) {
    final imageSlideShowWidget = Image.network(product.imageUrl, height: 200);

    final productContentWidget = ListView(children: [
      imageSlideShowWidget,
      Text(
        product.name,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      Text(product.formattedPrice)
    ]);
    final productActionsWidget = SafeArea(
        child: Row(
      children: [
        Expanded(
          child: Utils.actionButton('Add to Cart'),
        ),
        Expanded(child: Utils.actionButton('Buy Now', hasBackground: true)),
      ],
    ));

    final body = Column(
      children: [Expanded(child: productContentWidget), productActionsWidget],
    );

    return Scaffold(body: body);
  }
}
