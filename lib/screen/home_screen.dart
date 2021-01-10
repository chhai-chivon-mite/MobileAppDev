import 'dart:convert';

import 'package:ecom/model/home_response.dart';
import 'package:ecom/model/product.dart';
import 'package:ecom/screen/check_out_screen.dart';
import 'package:ecom/screen/product_detail_screen.dart';
import 'package:ecom/screen/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<HomeScreen> {
  Future<HomeResponse> loadHomeDataTask;

  @override
  void initState() {
    super.initState();

    loadHomeDataTask = loadHomeDataFromServer();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadHomeDataTask,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // Show error UI
            return Center(child: Text('Error while loading data from server.'));
          } else {
            // Build home UI
            return buildHomeUi(snapshot.data);
          }
        } else {
          // Show loading
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildHomeUi(HomeResponse homeResponse) {
    final topIconsWidget = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.message),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            // Move to CheckOutSummaryScreen
            final checkOutScreenWidget = CheckOutScreen();
            final route =
                MaterialPageRoute(builder: (context) => checkOutScreenWidget);
            Navigator.of(context).push(route);
          },
        )
      ],
    );
    final searchWidget = Row(
      children: [
        Flexible(
          child: TextField(
            decoration: InputDecoration(hintText: 'Search for products'),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.camera_alt),
          backgroundColor: Colors.orange,
        ),
      ],
    );

    final slideImageUrl = homeResponse.slides.first;
    final slideShowWidget = Image.network(slideImageUrl);

    final categoriesListView = SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: homeResponse.categories.map((category) {
          return categoryItemWidget(FontAwesomeIcons.book, category.name);
        }).toList(),
      ),
    );

    final deal1 = homeResponse.thisWeekDeals[0];
    final deal2 = homeResponse.thisWeekDeals[1];
    final thisWeekDealsWidget =
        productsRowWidget(productItemWidget(deal1), productItemWidget(deal2));

    final best1 = homeResponse.bestSellings[0];
    final best2 = homeResponse.bestSellings[1];
    final bestSellingsWidget =
        productsRowWidget(productItemWidget(best1), productItemWidget(best2));

    return SafeArea(
        child: ListView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      children: [
        topIconsWidget,
        searchWidget,
        verticalMargin(16),
        slideShowWidget,
        verticalMargin(16),
        Text('Categories', style: TextStyle(fontWeight: FontWeight.bold)),
        categoriesListView,
        sectionTitleWidget('This Week\s Deals'),
        verticalMargin(16),
        thisWeekDealsWidget,
        verticalMargin(16),
        sectionTitleWidget('Best Selling'),
        verticalMargin(16),
        bestSellingsWidget
      ],
    ));
  }

  /*@override
  Widget build(BuildContext context) {
    final product3 = Product(
        3,
        'Kids\' Messi 16.3 J',
        'Addidas',
        'https://rupp-ite.s3-ap-southeast-1.amazonaws.com/soccer-shoe.jpg',
        49.99);
    final product4 = Product(
        4,
        'Hardside Expandable Luggage',
        'Tag Heuer',
        'https://rupp-ite.s3-ap-southeast-1.amazonaws.com/SpinnerLuggage.jpg',
        25);

    final topIconsWidget = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.message),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            // Move to CheckOutSummaryScreen
            final checkOutScreenWidget = CheckOutScreen();
            final route =
                MaterialPageRoute(builder: (context) => checkOutScreenWidget);
            Navigator.of(context).push(route);
          },
        )
      ],
    );
    final searchWidget = Row(
      children: [
        Flexible(
          child: TextField(
            decoration: InputDecoration(hintText: 'Search for products'),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.camera_alt),
          backgroundColor: Colors.orange,
        ),
      ],
    );

    final slideShowWidget = Image.asset('images/ite_banner.jpg');

    final categoriesListView = SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          categoryItemWidget(FontAwesomeIcons.book, 'Book'),
          categoryItemWidget(FontAwesomeIcons.elementor, 'Electronic'),
          categoryItemWidget(FontAwesomeIcons.accessibleIcon, 'Kitchens'),
          categoryItemWidget(FontAwesomeIcons.creativeCommonsNcEu, 'Cosmetics'),
          categoryItemWidget(FontAwesomeIcons.bicycle, 'Vehicle'),
        ],
      ),
    );

    final thisWeekDealTitleWidget = sectionTitleWidget('This week\'s deals');

    /*final thisWeekDealContentWidget = isLoading
        ? Center(child: CircularProgressIndicator())
        : productsRowWidget(
            productItemWidget(product1), productItemWidget(product2));*/
    final thisWeekDealContentWidget = FutureBuilder(
      future: loadProductTask,
      builder: (context, snapshot) {
        print('builder');
        if (snapshot.connectionState == ConnectionState.done) {
          // Completed
          if (snapshot.hasError) {
            return Text('Error while loading data from server.');
          } else {
            final product1 = snapshot.data[0];
            final product2 = snapshot.data[1];
            return productsRowWidget(
                productItemWidget(product1), productItemWidget(product2));
          }
        } else {
          // Uncompleted
          return Center(child: CircularProgressIndicator());
        }
      },
    );

    /*Widget thisWeekDealContentWidget;
    if(isLoading){
      thisWeekDealContentWidget = Center(child: CircularProgressIndicator());
    } else {
      thisWeekDealContentWidget = productsRowWidget(
          productItemWidget('BeoPlay Speaker', 'Bang and Olufsen', 755),
          productItemWidget('Leather Wristwatch', 'Tag Heuer', 450));

    }*/

    final bestSellingTitleWidget = sectionTitleWidget('Best Selling');

    final bestSellingContentWidget = productsRowWidget(
        productItemWidget(product3), productItemWidget(product4));

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
            child: ListView(
          children: [
            topIconsWidget,
            searchWidget,
            verticalMargin(16),
            slideShowWidget,
            verticalMargin(16),
            Text('Categories', style: TextStyle(fontWeight: FontWeight.bold)),
            categoriesListView,
            thisWeekDealTitleWidget,
            verticalMargin(16),
            thisWeekDealContentWidget,
            verticalMargin(16),
            bestSellingTitleWidget,
            verticalMargin(16),
            bestSellingContentWidget
          ],
        )));
  }*/

  Widget verticalMargin(double value) {
    return SizedBox(
      height: value,
    );
  }

  Widget horizontalMargin(double value) {
    return SizedBox(
      width: value,
    );
  }

  Widget categoryItemWidget(IconData iconData, String name) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Icon(
              iconData,
              color: Colors.orange,
            ),
          ),
          Text(name)
        ],
      ),
    );
  }

  Widget sectionTitleWidget(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        GestureDetector(
          child: Text('See all'),
          onTap: () {
            final route =
                MaterialPageRoute(builder: (context) => ProductListScreen());
            Navigator.push(context, route);
          },
        )
      ],
    );
  }

  Widget productsRowWidget(Widget p1, Widget p2) {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: 200,
          child: p1,
        )),
        horizontalMargin(16),
        Expanded(child: Container(height: 200, child: p2)),
      ],
    );
  }

  Widget productItemWidget(Product product) {
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

  Future<List<Product>> loadProductsFromServer() async {
    print('loadProductsFromServer');
    final response =
        await get('http://localhost/test/ruppmad-api/products.php');
    if (response.statusCode == 200) {
      print('Success: ' + response.body);
      List<dynamic> jsonArray = jsonDecode(response.body);

      // Using Java style
      /*List<Product> products = List<Product>();
      for (int i = 0; i < jsonArray.length; i++) {
        print('i=$i');
        Map<String, dynamic> jsonObject = jsonArray[i];
        Product product = Product.fromJson(jsonObject);
        products.add(product);
      }
      return products;*/

      // Using dart style
      return jsonArray
          .map((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } else {
      print('Error: ' + response.toString());
      throw Exception();
    }
  }

  Future<HomeResponse> loadHomeDataFromServer() async {
    print('loadHomeDataFromServer');
    await Future.delayed(Duration(seconds: 3));
    try {
      final response = await get('http://localhost/test/ruppmad-api/home.php');
      if (response.statusCode != 200) {
        throw Exception('loadHomeDataFromServer error');
      }

      Map<String, dynamic> responseJson = jsonDecode(response.body);
      return HomeResponse.fromJson(responseJson);
    } catch (ex) {
      print('Error: $ex');
      throw ex;
    }
  }
}
