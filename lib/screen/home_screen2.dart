import 'package:ecom/model/product.dart';
import 'package:ecom/screen/check_out_screen.dart';
import 'package:ecom/screen/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<HomeScreen2> {
  bool isLoading = true;
  Product product1;
  Product product2;

  @override
  void initState() {
    super.initState();

    loadProductsFromServer().then((products) {
      print('Load products completed');
      setState(() {
        product1 = products[0];
        product2 = products[1];
        isLoading = false;
      });
    });
  }

  @override
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

    final thisWeekDealContentWidget = isLoading
        ? Center(child: CircularProgressIndicator())
        : productsRowWidget(
            productItemWidget(product1), productItemWidget(product2));

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
  }

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
        Text('See all')
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
    //TMP: fake load data from server

    final delayDuration = Duration(seconds: 3);
    await Future.delayed(delayDuration);

    final product1 = Product(
        1,
        'BeoPlay Speaker',
        'Bang and Olufsen',
        'https://rupp-ite.s3-ap-southeast-1.amazonaws.com/acer-monitor.jpg',
        30.5);
    final product2 = Product(
        2,
        'Leather Wristwatch',
        'Tag Heuer',
        'https://rupp-ite.s3-ap-southeast-1.amazonaws.com/too-much-never-enough.jpg',
        100);

    print('Return products');
    return [product1, product2];
  }
}
