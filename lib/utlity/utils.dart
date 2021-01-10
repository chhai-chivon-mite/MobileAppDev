import 'package:ecom/model/product.dart';
import 'package:ecom/screen/product_detail_screen.dart';
import 'package:flutter/material.dart';

class Utils {
  static Widget actionButton(String title, {bool hasBackground = false}) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          border: Border.all(color: Colors.blueGrey),
          color: hasBackground ? Colors.blueGrey : Colors.white),
      child: Center(
        child: Text(title),
      ),
    );
  }

  static Widget progressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  static Widget productItemWidget(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        //Navigator.of(context).pushNamed('/productDetail', arguments: title);
        final productDetailScreen = ProductDetailScreen(product);
        final route =
            MaterialPageRoute(builder: (context) => productDetailScreen);
        Navigator.of(context).push(route);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product.imageUrl, height: 140),
          Text(
            product.name,
            textAlign: TextAlign.left,
            maxLines: 1,
          ),
          Text(product.brand),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(product.formattedPrice), Icon(Icons.star)],
          )
        ],
      ),
    );
  }
}
